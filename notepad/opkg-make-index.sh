#!/usr/bin/python

import sys, os, posixpath
from glob import glob
import commands
import opkg
import getopt
import string
import re

verbose = 0

def usage():
     sys.stderr.write("%s [-h] [-s] [-m] [-l Packages.filelist] [-p Packages] [-r Packages.old] [-L localesdir] [-v] packagesdir\n" % (sys.argv[0],))
     sys.exit(-1)

def to_morgue(filename):
     morgue_dir = pkg_dir + "/morgue"
     if verbose:
          sys.stderr.write ("Moving " + filename + " to morgue\n")
     if not os.path.exists(morgue_dir):
          os.mkdir(morgue_dir)
     if os.path.exists(pkg_dir + "/" + filename):
          os.rename(pkg_dir + "/" + filename, morgue_dir + "/" + filename)
     if os.path.exists(pkg_dir + "/" + filename + ".asc"):
          os.rename(pkg_dir + "/" + filename + ".asc", morgue_dir + "/" + filename + ".asc")

locales_dir = None
def to_locale(filename, locale):
     locale_dir = pkg_dir + '/' + locales_dir + '/' + locale + "/"
     if verbose:
          sys.stderr.write ("Moving " + filename + " to " + locale_dir + "\n")
     if not os.path.exists(locale_dir):
          os.mkdir(locale_dir)
     os.rename(pkg_dir + "/" + filename, locale_dir + "/" + filename)
     if os.path.exists(pkg_dir + "/" + filename + ".asc"):
          os.rename(pkg_dir + "/" + filename + ".asc", locale_dir + "/" + filename + ".asc")

old_filename = None
packages_filename = None
filelist_filename = "Packages.filelist"
stamplist_filename = "Packages.stamps"
opt_s = 0
opt_m = 0
(opts, remaining_args) = getopt.getopt(sys.argv[1:], "hl:p:vsmr:L:")
for (optkey, optval) in opts:
     if optkey == '-h': 
          usage()
     if optkey == '-s': 
          opt_s = 1
     if optkey == '-p': 
          packages_filename = optval
          stamplist_filename = optval + ".stamps"
     if optkey == '-l':
          filelist_filename = optval
     if optkey == '-v':
          verbose = 1
     if optkey == '-m':
          opt_m = 1
     if optkey == '-r':
          old_filename = optval
     if optkey == '-L':
          locales_dir = optval

if ( not remaining_args ):
     usage()

pkg_dir=remaining_args[0]

packages = opkg.Packages()

old_pkg_hash = {}
if packages_filename and not old_filename and os.path.exists(packages_filename):
     old_filename = packages_filename

pkgsStamps = {}
if old_filename:
     if (verbose):
          sys.stderr.write("Reading package list from " + old_filename + "\n")
     old_packages = opkg.Packages()
     old_packages.read_packages_file(old_filename)
     for k in old_packages.packages.keys():
          p = old_packages.packages[k]
          old_pkg_hash[p.filename] = p
     try:
        f = open(stamplist_filename, "r")
        for l in f:
            l = l.strip()
            s, f = l.split(" ", 1)
            pkgsStamps[f] = int(s)
     except IOError:
        pass

if (verbose):
     sys.stderr.write("Reading in all the package info from %s\n" % (pkg_dir, ))
files=glob(pkg_dir + '/*.opk') + glob(pkg_dir + '/*.deb') + glob(pkg_dir + '/*.ipk')
files.sort()
for filename in files:
     basename = os.path.basename(filename)
     pkg = None
     fnameStat = os.stat(filename)
     if old_pkg_hash.has_key(basename):
          if pkgsStamps.has_key(basename) and fnameStat.st_mtime == pkgsStamps[basename]:
            if (verbose):
               sys.stderr.write("Found %s in Packages\n" % (filename,))
            pkg = old_pkg_hash[basename]
          else:
               sys.stderr.write("Found %s in Packages, but mtime differs - re-reading\n" % (filename,))

     if not pkg:
          if (verbose):
               sys.stderr.write("Reading info for package %s\n" % (filename,))
          pkg = opkg.Package(filename)
     pkg_key = ("%s:%s" % (pkg.package, pkg.architecture))
     if (packages.packages.has_key(pkg_key)):
          old_filename = packages.packages[pkg_key].filename
     else:
          old_filename = ""
     s = packages.add_package(pkg)
     pkgsStamps[basename] = fnameStat.st_mtime
     if s == 0:
          if old_filename:
               # old package was displaced by newer
               if opt_m:
                    to_morgue(old_filename)
               if opt_s:
                    print pkg_dir + "/" + old_filename
     else:
          if opt_m:
               to_morgue(basename)
          if opt_s:
               print filename

pkgsStampsFile = open(stamplist_filename, "w")
for f in pkgsStamps.keys():
    pkgsStampsFile.write("%d %s\n" % (pkgsStamps[f], f))
pkgsStampsFile.close()

if opt_s:
     sys.exit(0)

if verbose:
     sys.stderr.write("Generating Packages file\n")
if packages_filename:
     old_stdout = sys.stdout
     tmp_packages_filename = ("%s.%d" % (packages_filename, os.getpid()))
     sys.stdout = open(tmp_packages_filename, "w")
names = packages.packages.keys()
names.sort()
for name in names:
     pkg = packages.packages[name]
     if locales_dir and pkg.depends:
         depends = string.split(pkg.depends, ',')
         locale = None
         for d in depends:
              m = re.match('.*virtual-locale-([a-zA-Z]+).*', d)
              mp = re.match('locale-base-([a-zA-Z]+)([-+])?.*', pkg.package)
              if m:
                   locale = m.group(1)
              if mp:
                   locale = mp.group(1)
         if locale:
              to_locale(pkg.filename, locale)
              continue
     if (verbose):
          sys.stderr.write("Writing info for package %s\n" % (pkg.package,))
     print pkg
if packages_filename:
     sys.stdout.close()
     sys.stdout = old_stdout
     gzip_filename = ("%s.gz" % packages_filename)
     tmp_gzip_filename = ("%s.%d" % (gzip_filename, os.getpid()))
     gzip_cmd = "gzip -9c < %s > %s" % (tmp_packages_filename, tmp_gzip_filename)
     (rc, outtext) = commands.getstatusoutput(gzip_cmd)
     print outtext
     os.rename(tmp_packages_filename, packages_filename)
     os.rename(tmp_gzip_filename, gzip_filename)

if verbose:
     sys.stderr.write("Generate Packages.filelist file\n")
files = {}
names = packages.packages.keys()
names.sort()
for name in names:
     for fn in packages[name].get_file_list():
          (h,t) = os.path.split(fn)
          if not t: continue
          if not files.has_key(t): files[t] = name+':'+fn
          else: files[t] = files[t] + ',' + name+':'+fn

if filelist_filename:
     tmp_filelist_filename = ("%s.%d" % (filelist_filename, os.getpid()))
     sys.stdout = open(tmp_filelist_filename, "w")
     names = files.keys()
     names.sort()
     for name in names:
          print name,files[name]
     sys.stdout.close()
     if posixpath.exists(filelist_filename):
          os.unlink(filelist_filename)
     os.rename(tmp_filelist_filename, filelist_filename)