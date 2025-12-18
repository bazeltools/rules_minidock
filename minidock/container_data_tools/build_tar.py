# Copyright 2015 The Bazel Authors. All rights reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
"""This tool build tar files from a list of inputs."""


### THIS IS TAKEN FROM RULES_DOCKER with only quite minor modifications to date.

from contextlib import contextmanager
import argparse
import functools
import gzip
import io
import json
import os
import os.path
import posixpath
import subprocess
import sys
import re
import tarfile
import tempfile






class TarFileWriter(object):
  """A wrapper to write tar files."""

  class Error(Exception):
    pass

  def __init__(self,
               name,
               compression='',
               gzip_compression_level=9,
               zstd_compression_level=3,
               zstd_path='zstd',
               root_directory='./',
               default_mtime=None,
               preserve_tar_mtimes=True):
    """TarFileWriter wraps tarfile.open().
    Args:
      name: the tar file name.
      compression: compression type: bzip2, bz2, gz, tgz, xz, lzma, zstd.
      gzip_compression_level: compression level for gzip (1-9).
      zstd_compression_level: compression level for zstd (1-22).
      zstd_path: path to the zstd executable.
      root_directory: virtual root to prepend to elements in the archive.
      default_mtime: default mtime to use for elements in the archive.
          May be an integer or the value 'portable' to use the date
          2000-01-01, which is compatible with non *nix OSes'.
      preserve_tar_mtimes: if true, keep file mtimes from input tar file.
    """
    if compression in ['bzip2', 'bz2']:
      mode = 'w:bz2'
    else:
      mode = 'w:'
    self.gz = compression in ['tgz', 'gz']
    # Support xz compression through xz... until we can use Py3
    self.xz = compression in ['xz', 'lzma']
    # Support zstd compression through zstd command line tool
    self.zstd = compression == 'zstd'
    self.zstd_compression_level = zstd_compression_level
    self.zstd_path = zstd_path
    self.name = name
    self.root_directory = root_directory.rstrip('/')
    self.preserve_mtime = preserve_tar_mtimes
    if default_mtime is None:
      self.default_mtime = 0
    elif default_mtime == 'portable':
      self.default_mtime = 946684800  # January 1, 2000, 00:00:00 UTC
    else:
      self.default_mtime = int(default_mtime)

    self.fileobj = None
    self._raw_file = None
    if self.gz:
      # The Tarfile class doesn't allow us to specify gzip's mtime attribute.
      # Instead, we manually re-implement gzopen from tarfile.py and set mtime.
      self.fileobj = gzip.GzipFile(
          filename=name, mode='w', compresslevel=gzip_compression_level, mtime=self.default_mtime)
    self.tar = tarfile.open(
      name=name,
      mode=mode,
      fileobj=self.fileobj,
      # https://github.com/bazelbuild/rules_docker/issues/1602
      format=tarfile.PAX_FORMAT)
    self.members = set([])
    self.directories = set([])

  def __enter__(self):
    return self

  def __exit__(self, t, v, traceback):
    self.close()

  def add_dir(self,
              name,
              path,
              uid=0,
              gid=0,
              uname='',
              gname='',
              mtime=None,
              mode=None,
              depth=100):
    """Recursively add a directory.
    Args:
      name: the destination path of the directory to add.
      path: the path of the directory to add.
      uid: owner user identifier.
      gid: owner group identifier.
      uname: owner user names.
      gname: owner group names.
      mtime: modification time to put in the archive.
      mode: unix permission mode of the file, default 0644 (0755).
      depth: maximum depth to recurse in to avoid infinite loops
             with cyclic mounts.
    Raises:
      TarFileWriter.Error: when the recursion depth has exceeded the
                           `depth` argument.
    """
    if not (name == self.root_directory or name.startswith('/') or
            name.startswith(self.root_directory + '/')):
      name = posixpath.join(self.root_directory, name)
    if mtime is None:
      mtime = self.default_mtime
    if posixpath.isdir(path):
      # Remove trailing '/' (index -1 => last character)
      if name[-1] == '/':
        name = name[:-1]
      # Add the x bit to directories to prevent non-traversable directories.
      # The x bit is set only to if the read bit is set.
      dirmode = (mode | ((0o444 & mode) >> 2)) if mode else mode
      self.add_file(name + '/',
                    tarfile.DIRTYPE,
                    uid=uid,
                    gid=gid,
                    uname=uname,
                    gname=gname,
                    mtime=mtime,
                    mode=dirmode)
      if depth <= 0:
        raise self.Error('Recursion depth exceeded, probably in '
                         'an infinite directory loop.')
      # Iterate over the sorted list of file so we get a deterministic result.
      filelist = os.listdir(path)
      filelist.sort()
      for f in filelist:
        new_name = posixpath.join(name, f)
        new_path = posixpath.join(path, f)
        self.add_dir(new_name, new_path, uid, gid, uname, gname, mtime, mode,
                     depth - 1)
    else:
      self.add_file(name,
                    tarfile.REGTYPE,
                    file_content=path,
                    uid=uid,
                    gid=gid,
                    uname=uname,
                    gname=gname,
                    mtime=mtime,
                    mode=mode)

  def _addfile(self, info, fileobj=None):
    """Add a file in the tar file if there is no conflict."""
    if not info.name.endswith('/') and info.type == tarfile.DIRTYPE:
      # Enforce the ending / for directories so we correctly deduplicate.
      info.name += '/'
    if info.name not in self.members:
      self.tar.addfile(info, fileobj)
      self.members.add(info.name)
    elif info.type != tarfile.DIRTYPE:
      print('Duplicate file in archive: %s, '
            'picking first occurrence' % info.name)

  def add_file(self,
               name,
               kind=tarfile.REGTYPE,
               content=None,
               link=None,
               file_content=None,
               uid=0,
               gid=0,
               uname='',
               gname='',
               mtime=None,
               mode=None):
    """Add a file to the current tar.
    Args:
      name: the name of the file to add.
      kind: the type of the file to add, see tarfile.*TYPE.
      content: a textual content to put in the file.
      link: if the file is a link, the destination of the link.
      file_content: file to read the content from. Provide either this
          one or `content` to specifies a content for the file.
      uid: owner user identifier.
      gid: owner group identifier.
      uname: owner user names.
      gname: owner group names.
      mtime: modification time to put in the archive.
      mode: unix permission mode of the file, default 0644 (0755).
    """
    if file_content and posixpath.isdir(file_content):
      # Recurse into directory
      self.add_dir(name, file_content, uid, gid, uname, gname, mtime, mode)
      return
    if not (name == self.root_directory or name.startswith('/') or
            name.startswith(self.root_directory + '/')):
      name = posixpath.join(self.root_directory, name)
    if kind == tarfile.DIRTYPE:
      name = name.rstrip('/')
      if name in self.directories:
        return
    if mtime is None:
      mtime = self.default_mtime

    components = name.rsplit('/', 1)
    if len(components) > 1:
      d = components[0]
      self.add_file(d,
                    tarfile.DIRTYPE,
                    uid=uid,
                    gid=gid,
                    uname=uname,
                    gname=gname,
                    mtime=mtime,
                    mode=0o755)
    tarinfo = tarfile.TarInfo(name)
    tarinfo.mtime = mtime
    tarinfo.uid = uid
    tarinfo.gid = gid
    tarinfo.uname = uname
    tarinfo.gname = gname
    tarinfo.type = kind
    if mode is None:
      tarinfo.mode = 0o644 if kind == tarfile.REGTYPE else 0o755
    else:
      tarinfo.mode = mode
    if link:
      tarinfo.linkname = link
    if content:
      content_bytes = content.encode('utf-8')
      tarinfo.size = len(content_bytes)
      self._addfile(tarinfo, io.BytesIO(content_bytes))
    elif file_content:
      with open(file_content, 'rb') as f:
        tarinfo.size = os.fstat(f.fileno()).st_size
        self._addfile(tarinfo, f)
    else:
      if kind == tarfile.DIRTYPE:
        self.directories.add(name)
      self._addfile(tarinfo)

  def add_tar(self,
              tar,
              rootuid=None,
              rootgid=None,
              numeric=False,
              name_filter=None,
              root=None):
    """Merge a tar content into the current tar, stripping timestamp.
    Args:
      tar: the name of tar to extract and put content into the current tar.
      rootuid: user id that we will pretend is root (replaced by uid 0).
      rootgid: group id that we will pretend is root (replaced by gid 0).
      numeric: set to true to strip out name of owners (and just use the
          numeric values).
      name_filter: filter out file by names. If not none, this method will be
          called for each file to add, given the name and should return true if
          the file is to be added to the final tar and false otherwise.
      root: place all non-absolute content under given root directory, if not
          None.
    Raises:
      TarFileWriter.Error: if an error happens when uncompressing the tar file.
    """
    if root and root[0] not in ['/', '.']:
      # Root prefix should start with a '/', adds it if missing
      root = '/' + root
    compression = posixpath.splitext(tar)[-1][1:]
    if compression == 'tgz':
      compression = 'gz'
    elif compression == 'bzip2':
      compression = 'bz2'
    elif compression == 'lzma':
      compression = 'xz'
    elif compression == 'zst':
      compression = 'zstd'
    elif compression not in ['gz', 'bz2', 'xz', 'zstd']:
      compression = ''
    if compression == 'xz':
      # Python 2 does not support lzma, our py3 support is terrible so let's
      # just hack around.
      # Note that we buffer the file in memory and it can have an important
      # memory footprint but it's probably fine as we don't use them for really
      # large files.
      # TODO(dmarting): once our py3 support gets better, compile this tools
      # with py3 for proper lzma support.
      if subprocess.call('which xzcat', shell=True, stdout=subprocess.PIPE):
        raise self.Error('Cannot handle .xz and .lzma compression: '
                         'xzcat not found.')
      p = subprocess.Popen('cat %s | xzcat' % tar,
                           shell=True,
                           stdout=subprocess.PIPE)
      f = io.BytesIO(p.stdout.read())
      p.wait()
      intar = tarfile.open(fileobj=f, mode='r:')
    elif compression == 'zstd':
      # Handle zstd compression through zstd command line tool
      # Note that we buffer the file in memory and it can have an important
      # memory footprint but it's probably fine as we don't use them for really
      # large files.
      if not os.path.exists(self.zstd_path):
        raise self.Error('Cannot handle .zstd compression: '
                         'zstd command not found at %s.' % self.zstd_path)
      p = subprocess.Popen('%s -dc %s' % (self.zstd_path, tar),
                           shell=True,
                           stdout=subprocess.PIPE)
      f = io.BytesIO(p.stdout.read())
      p.wait()
      intar = tarfile.open(fileobj=f, mode='r:')
    else:
      if compression in ['gz', 'bz2']:
        # prevent performance issues due to accidentally-introduced seeks
        # during intar traversal by opening in "streaming" mode. gz, bz2
        # are supported natively by python 2.7 and 3.x
        inmode = 'r|' + compression
      else:
        inmode = 'r:' + compression
      intar = tarfile.open(name=tar, mode=inmode)
    for tarinfo in intar:
      if name_filter is None or name_filter(tarinfo.name):
        if not self.preserve_mtime:
          tarinfo.mtime = self.default_mtime
        if rootuid is not None and tarinfo.uid == rootuid:
          tarinfo.uid = 0
          tarinfo.uname = 'root'
        if rootgid is not None and tarinfo.gid == rootgid:
          tarinfo.gid = 0
          tarinfo.gname = 'root'
        if numeric:
          tarinfo.uname = ''
          tarinfo.gname = ''

        name = tarinfo.name
        if (not name.startswith('/') and
            not name.startswith(self.root_directory)):
          name = posixpath.join(self.root_directory, name)
        if root is not None:
          if name.startswith('.'):
            name = '.' + root + name.lstrip('.')
            # Add root dir with same permissions if missing. Note that
            # add_file deduplicates directories and is safe to call here.
            self.add_file('.' + root,
                          tarfile.DIRTYPE,
                          uid=tarinfo.uid,
                          gid=tarinfo.gid,
                          uname=tarinfo.uname,
                          gname=tarinfo.gname,
                          mtime=tarinfo.mtime,
                          mode=0o755)
          # Relocate internal hardlinks as well to avoid breaking them.
          link = tarinfo.linkname
          if link.startswith('.') and tarinfo.type == tarfile.LNKTYPE:
            tarinfo.linkname = '.' + root + link.lstrip('.')
        tarinfo.name = name

        if 'path' in tarinfo.pax_headers:
          # Modify the TarInfo's PAX header for the path name. These headers are used to define "long" path names for
          # files within a tar file. This header is defined within this spec:
          #     https://en.wikipedia.org/wiki/Tar_(computing)#POSIX.1-2001/pax
          # When we read a tar file with this path type the tarfile module sets both the TarInfo.name and
          # pax_headers['path'] so we need to manually update both.
          tarinfo.pax_headers['path'] = name

        if tarinfo.isfile():
          # use extractfile(tarinfo) instead of tarinfo.name to preserve
          # seek position in intar
          self._addfile(tarinfo, intar.extractfile(tarinfo))
        else:
          self._addfile(tarinfo)
    intar.close()

  def close(self):
    """Close the output tar file.
    This class should not be used anymore after calling that method.
    Raises:
      TarFileWriter.Error: if an error happens when compressing the output file.
    """
    self.tar.close()
    # Close the gzip file object if necessary.
    if self.fileobj:
      self.fileobj.close()
    
    if self.zstd:
      # Support zstd compression through zstd command line tool
      # Following same pattern as xz to maintain no-external-dependencies principle
      if not os.path.exists(self.zstd_path):
        raise self.Error('Cannot handle .zstd compression: '
                         'zstd command not found at %s.' % self.zstd_path)
      subprocess.call(
          'mv {0} {0}.d && {2} -z -{1} {0}.d && mv {0}.d.zst {0}'.format(
              self.name, self.zstd_compression_level, self.zstd_path),
          shell=True,
          stdout=subprocess.PIPE)
    
    if self.xz:
      # Support xz compression through xz... until we can use Py3
      if subprocess.call('which xz', shell=True, stdout=subprocess.PIPE):
        raise self.Error('Cannot handle .xz and .lzma compression: '
                         'xz not found.')
      subprocess.call(
          'mv {0} {0}.d && xz -z {0}.d && mv {0}.d.xz {0}'.format(self.name),
          shell=True,
          stdout=subprocess.PIPE)



class TarFile(object):
  """A class to generates a Docker layer."""

  class DebError(Exception):
    pass

  PKG_NAME_RE = re.compile(r'Package:\s*(?P<pkg_name>\w+).*')
  DPKG_STATUS_DIR = '/var/lib/dpkg/status.d'
  PKG_METADATA_FILE = 'control'

  @staticmethod
  def parse_pkg_name(metadata, filename):
    pkg_name_match = TarFile.PKG_NAME_RE.match(metadata)
    if pkg_name_match:
      return pkg_name_match.group('pkg_name')
    else:
      return os.path.basename(os.path.splitext(filename)[0])

  def __init__(self, output, directory, root_directory,
               default_mtime, enable_mtime_preservation,
               force_posixpath, gzip_compression_level, zstd_compression_level=3, zstd_path='zstd', compression='gz'):
    self.directory = directory
    self.output = output
    self.compression = compression
    self.gzip_compression_level = gzip_compression_level
    self.zstd_compression_level = zstd_compression_level
    self.zstd_path = zstd_path
    self.root_directory = root_directory
    self.default_mtime = default_mtime
    self.enable_mtime_preservation = enable_mtime_preservation
    self.force_posixpath = force_posixpath

  def __enter__(self):
    self.tarfile = TarFileWriter(
        self.output,
        self.compression,
        self.gzip_compression_level,
        self.zstd_compression_level,
        self.zstd_path,
        self.root_directory,
        self.default_mtime,
        self.enable_mtime_preservation,
    )
    return self

  def __exit__(self, t, v, traceback):
    self.tarfile.close()

  def add_file(self, f, destfile, mode=None, ids=None, names=None):
    """Add a file to the tar file.

    Args:
       f: the file to add to the layer
       destfile: the name of the file in the layer
       mode: force to set the specified mode, by
          default the value from the source is taken.
       ids: (uid, gid) for the file to set ownership
       names: (username, groupname) for the file to set ownership.
    `f` will be copied to `self.directory/destfile` in the layer.
    """
    dest = destfile.lstrip('/')  # Remove leading slashes
    if self.directory and self.directory != '/':
      dest = self.directory.lstrip('/') + '/' + dest
    # If mode is unspecified, derive the mode from the file's mode.
    if mode is None:
      mode = 0o755 if os.access(f, os.X_OK) else 0o644
    if ids is None:
      ids = (0, 0)
    if names is None:
      names = ('', '')
    if self.force_posixpath:
        dest = posixpath.normpath(dest)
    else:
        dest = os.path.normpath(dest)
    self.tarfile.add_file(
        dest,
        file_content=f,
        mode=mode,
        uid=ids[0],
        gid=ids[1],
        uname=names[0],
        gname=names[1])

  def add_empty_file(self, destfile, mode=None, ids=None, names=None,
                     kind=tarfile.REGTYPE):
    """Add a file to the tar file.

    Args:
       destfile: the name of the file in the layer
       mode: force to set the specified mode, defaults to 644
       ids: (uid, gid) for the file to set ownership
       names: (username, groupname) for the file to set ownership.
       kind: type of the file. tarfile.DIRTYPE for directory.

    An empty file will be created as `destfile` in the layer.
    """
    dest = destfile.lstrip('/')  # Remove leading slashes
    # If mode is unspecified, assume read only
    if mode is None:
      mode = 0o644
    if ids is None:
      ids = (0, 0)
    if names is None:
      names = ('', '')
    if self.force_posixpath:
        dest = posixpath.normpath(dest)
    else:
        dest = os.path.normpath(dest)
    self.tarfile.add_file(
        dest,
        content='' if kind == tarfile.REGTYPE else None,
        kind=kind,
        mode=mode,
        uid=ids[0],
        gid=ids[1],
        uname=names[0],
        gname=names[1])

  def add_empty_dir(self, destpath, mode=None, ids=None, names=None):
    """Add a directory to the tar file.

    Args:
       destpath: the name of the directory in the layer
       mode: force to set the specified mode, defaults to 644
       ids: (uid, gid) for the file to set ownership
       names: (username, groupname) for the file to set ownership.

    An empty file will be created as `destfile` in the layer.
    """
    self.add_empty_file(destpath, mode=mode, ids=ids, names=names,
                        kind=tarfile.DIRTYPE)

  def add_empty_root_dir(self, destpath, mode=None, ids=None, names=None):
    """Add a directory to the root of the tar file.

    Args:
       destpath: the name of the directory in the layer
       mode: force to set the specified mode, defaults to 644
       ids: (uid, gid) for the file to set ownership
       names: (username, groupname) for the file to set ownership.

    An empty directory will be created as `destfile` in the root layer.
    """
    original_root_directory = self.tarfile.root_directory
    self.tarfile.root_directory = destpath
    self.add_empty_dir(
        destpath, mode=mode, ids=ids, names=names)
    self.tarfile.root_directory = original_root_directory

  def add_tar(self, tar):
    """Merge a tar file into the destination tar file.

    All files presents in that tar will be added to the output file
    under self.directory/path. No user name nor group name will be
    added to the output.

    Args:
      tar: the tar file to add
    """
    root = None
    if self.directory and self.directory != '/':
      root = self.directory
    self.tarfile.add_tar(tar, numeric=True, root=root)

  def add_link(self, symlink, destination):
    """Add a symbolic link pointing to `destination`.

    Args:
      symlink: the name of the symbolic link to add.
      destination: where the symbolic link point to.
    """
    if self.force_posixpath:
        symlink = posixpath.normpath(symlink)
    else:
        symlink = os.path.normpath(symlink)
    self.tarfile.add_file(symlink, tarfile.SYMTYPE, link=destination)

  @contextmanager
  def write_temp_file(self, data, suffix='tar', mode='wb'):
    # deb(5) states members may optionally be compressed with gzip or xz
    if suffix.endswith('.gz'):
      with gzip.GzipFile(fileobj=io.BytesIO(data)) as f:
        data = f.read()
      suffix = suffix[:-3]

    (_, tmpfile) = tempfile.mkstemp(suffix=suffix)
    try:
      with open(tmpfile, mode=mode) as f:
        f.write(data)
      yield tmpfile
    finally:
      os.remove(tmpfile)

  def add_pkg_metadata(self, metadata_tar, deb):
    try:
      with tarfile.open(metadata_tar) as tar:
        # Metadata is expected to be in a file.
        control_file_member = list(filter(lambda f: os.path.basename(f.name) == TarFile.PKG_METADATA_FILE, tar.getmembers()))
        if not control_file_member:
           raise self.DebError(deb + ' does not Metadata File!')
        control_file = tar.extractfile(control_file_member[0])
        metadata = b''.join(control_file.readlines())
        destination_file = os.path.join(TarFile.DPKG_STATUS_DIR,
                                        TarFile.parse_pkg_name(metadata.decode("utf-8"), deb))
        with self.write_temp_file(data=metadata) as metadata_file:
          self.add_file(metadata_file, destination_file)
    except (KeyError, TypeError) as e:
      raise self.DebError(deb + ' contains invalid Metadata! Exeception {0}'.format(e))
    except Exception as e:
      raise self.DebError('Unknown Exception {0}. Please report an issue at'
                          ' github.com/bazelbuild/rules_docker.'.format(e))

  def add_deb(self, deb):
    """Extract a debian package in the output tar.

    All files presents in that debian package will be added to the
    output tar under the same paths. No user name nor group names will
    be added to the output.

    Args:
      deb: the tar file to add

    Raises:
      DebError: if the format of the deb archive is incorrect.
    """
    pkg_data_found = False
    pkg_metadata_found = False
    with archive.SimpleArFile(deb) as arfile:
      current = arfile.next()
      while current:
        parts = current.filename.split(".")
        name = parts[0]
        ext = '.'.join(parts[1:])
        if name == 'data':
          pkg_data_found = True
          # Add pkg_data to image tar
          with self.write_temp_file(suffix=ext, data=current.data) as tmpfile:
            self.add_tar(tmpfile)
        elif name == 'control':
          pkg_metadata_found = True
          # Add metadata file to image tar
          with self.write_temp_file(suffix=ext, data=current.data) as tmpfile:
            self.add_pkg_metadata(metadata_tar=tmpfile, deb=deb)
        current = arfile.next()

    if not pkg_data_found:
      raise self.DebError(deb + ' does not contains a data file!')
    if not pkg_metadata_found:
      raise self.DebError(deb + ' does not contains a control file!')

def main(FLAGS):
  # Parse modes arguments
  default_mode = None
  if FLAGS.mode:
    # Convert from octal
    default_mode = int(FLAGS.mode, 8)

  mode_map = {}
  if FLAGS.modes:
    for filemode in FLAGS.modes:
      (f, mode) = filemode.split('=', 1)
      if f[0] == '/':
        f = f[1:]
      mode_map[f] = int(mode, 8)

  default_ownername = ('', '')
  if FLAGS.owner_name:
    default_ownername = FLAGS.owner_name.split('.', 1)
  names_map = {}
  if FLAGS.owner_names:
    for file_owner in FLAGS.owner_names:
      (f, owner) = file_owner.split('=', 1)
      (user, group) = owner.split('.', 1)
      if f[0] == '/':
        f = f[1:]
      names_map[f] = (user, group)

  default_ids = FLAGS.owner.split('.', 1)
  default_ids = (int(default_ids[0]), int(default_ids[1]))
  ids_map = {}
  if FLAGS.owners:
    for file_owner in FLAGS.owners:
      (f, owner) = file_owner.split('=', 1)
      (user, group) = owner.split('.', 1)
      if f[0] == '/':
        f = f[1:]
      ids_map[f] = (int(user), int(group))

  # Add objects to the tar file
  with TarFile(FLAGS.output, FLAGS.directory,
               FLAGS.root_directory, FLAGS.mtime,
               FLAGS.enable_mtime_preservation,
               FLAGS.force_posixpath, FLAGS.gzip_compression_level,
               FLAGS.zstd_compression_level, FLAGS.zstd_path, FLAGS.compression) as output:
    def file_attributes(filename):
      if filename.startswith('/'):
        filename = filename[1:]
      return {
          'mode': mode_map.get(filename, default_mode),
          'ids': ids_map.get(filename, default_ids),
          'names': names_map.get(filename, default_ownername),
      }

    if FLAGS.manifest:
      with open(FLAGS.manifest, 'r') as f:
        manifest = json.load(f)
        for f in manifest.get('files', []):
          output.add_file(f['src'], f['dst'], **file_attributes(f['dst']))
        for f in manifest.get('empty_files', []):
          output.add_empty_file(f, **file_attributes(f))
        for d in manifest.get('empty_dirs', []):
          output.add_empty_dir(d, **file_attributes(d))
        for d in manifest.get('empty_root_dirs', []):
          output.add_empty_root_dir(d, **file_attributes(d))
        for f in manifest.get('symlinks', []):
          output.add_link(f['linkname'], f['target'])
        for tar in manifest.get('tars', []):
          output.add_tar(tar)

    for f in FLAGS.file:
      (inf, tof) = f.split('=', 1)
      output.add_file(inf, tof, **file_attributes(tof))
    for f in FLAGS.empty_file:
      output.add_empty_file(f, **file_attributes(f))
    for f in FLAGS.empty_dir:
      output.add_empty_dir(f, **file_attributes(f))
    for tar in FLAGS.tar:
      output.add_tar(tar)
    for link in FLAGS.link:
      l = link.split(':', 1)
      output.add_link(l[0], l[1])


if __name__ == '__main__':
  parser = argparse.ArgumentParser()
  parser.add_argument('--output', type=str, required=True,
    help='The output file, mandatory')

  parser.add_argument('--file', default=[], type=str, action='append',
    help='A file to add to the layer')

  parser.add_argument('--manifest', type=str,
    help='JSON manifest of contents to add to the layer')

  parser.add_argument('--empty_file', type=str, default=[], action='append',
    help='An empty file to add to the layer')

  parser.add_argument('--empty_dir', type=str, default=[], action='append',
    help='An empty dir to add to the layer')

  parser.add_argument('--mode', type=str,
    help='Force the mode on the added files (in octal).')

  parser.add_argument('--mtime', type=str,
    help='Set mtime on tar file entries. May be an integer or the'
    ' value "portable", to get the value 2000-01-01, which is'
    ' usable with non *nix OSes.')

  parser.add_argument('--enable_mtime_preservation', type=bool, default=False,
    help='Preserve file mtimes from input tar file.')

  parser.add_argument('--tar', type=str, default=[], action='append',
    help='A tar file to add to the layer')

  def validate_link(l):
    if not all([value.find(':') > 0 for value in l]):
      raise argparse.ArgumentTypeError("Link must be in format 'source:target'")
    return l

  parser.add_argument('--link', type=validate_link, default=[], action='append',
    help='Add a symlink a inside the layer ponting to b if a:b is specified')

  parser.add_argument('--directory', type=str,
    help='Directory in which to store the file inside the layer')

  parser.add_argument('--modes', type=str, default=None, action='append',
    help='Specific mode to apply to specific file (from the file argument),'
    ' e.g., path/to/file=0o455.')

  parser.add_argument('--owners', type=str, default=None, action='append',
    help='Specific mode to apply to specific file (from the file argument),'
    ' e.g., path/to/file=0o455.')

  parser.add_argument('--owner', type=str, default='0.0',
    help='Specify the numeric default owner of all files, e.g., 0.0')

  parser.add_argument('--owner_name', type=str,
    help='Specify the owner name of all files, e.g. root.root.')

  parser.add_argument('--owner_names', type=str, default=None, action='append',
    help='Specify the owner names of individual files, e.g. path/to/file=root.root.')

  parser.add_argument('--root_directory', type=str, default='./',
    help='Default root directory is named "."'
    'Windows docker images require this be named "Files" instead of "."')

  parser.add_argument('--force_posixpath', type=bool, default=False,
    help='Force the use of posixpath when normalizing file paths. This is useful'
    'when building in a non-posix environment.')


  parser.add_argument('--gzip_compression_level', type=int, default=9,
    help='Set the gzip compression level to use.')

  parser.add_argument('--zstd_compression_level', type=int, default=3,
    help='Set the zstd compression level to use (1-22).')

  parser.add_argument('--zstd_path', type=str, default='zstd',
    help='Path to the zstd executable.')

  parser.add_argument('--compression', type=str, default='gz',
    help='Set the compression type: gz, bz2, xz, lzma, zstd, or empty string for no compression.')

  main(parser.parse_args())


