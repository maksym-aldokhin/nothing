#!/bin/env python

from argparse import ArgumentParser
import os
import fnmatch
import shutil
import sys


def mkdir_abs(path):
    if not os.path.exists(path):
        os.makedirs(path, exist_ok=True)
        return

    if not os.path.isdir(path):
        raise RuntimeError("'{}' is not a directory".format(path))


def copy_with_extension(files, indir, outdir, extension):
    for file in fnmatch.filter(files, extension):
        from_path = os.path.join(indir, file)
        to_path = os.path.join(outdir, file)
        mkdir_abs(outdir)
        shutil.copy(from_path, to_path)
        print(" Copying '{}' to '{}'".format(file, outdir))
        pass
    pass


def copy(extensions, indir, outdir):
    abs_indir = os.path.abspath(indir)
    abs_outdir = os.path.abspath(outdir)

    print("Will copy to '{}' from '{}'".format(abs_outdir, abs_indir))

    for directory, subdirs, allfiles in os.walk(indir, topdown=True):
        abs_curdir = os.path.abspath(directory)
        rel_curdir = os.path.relpath(abs_curdir, abs_indir)
        abs_outsubdir = os.path.join(abs_outdir, rel_curdir)

        if abs_curdir.startswith(abs_outdir):
            print("Skipping", abs_outdir)
            subdirs[:] = []
            continue

        for ex in extensions:
             copy_with_extension(allfiles, abs_curdir, abs_outsubdir, ex)
    pass


def main():
    parser = ArgumentParser(description='Collect files')
    parser.add_argument('-t', '--types', metavar='types', type=str, nargs='+',
                        help='File extensions', dest='types')
    parser.add_argument('-d', '--destination', metavar='outdir', type=str,
                        help='Output directory', dest='outdir')
    parser.add_argument('-s', '--from', metavar='indir', type=str,
                        dest='indir', help='Source directory, current dir by default', default=os.curdir)
    args = parser.parse_args()

    outdir = args.outdir

    try:
        if not os.path.isabs(outdir):
            outdir = os.path.abspath(outdir)

        mkdir_abs(outdir)
        copy(args.types, args.indir, outdir)

        return 0

    except Exception as e:
        print(e)
        parser.print_help()
        return 1

if __name__ == "__main__":
    sys.exit(main())
