#! /usr/bin/env python3
# coding=UTF-8
# stolen from https://unix.stackexchange.com/questions/239898/listing-files-from-nested-zip-files-without-extracting
from __future__ import print_function

import argparse
import io
import os
import re
import sys
import zipfile

import multiprocessing_on_dill as mp

PY2 = sys.version_info[0] == 2
PY3 = sys.version_info[0] == 3

zip_file_pattern = re.compile(".*\\.(aar|jar|zip)$")


def verify_entry_depth(entry, max_depth):
    if max_depth != 0:
        if entry.rstrip('/').count('/') <= max_depth:
            return True
        else:
            return False
    else:
        return False


def traversal_zip(f, max_depth=0, parent=None):
    if parent is None:
        parent = []
    result = []

    try:
        zf = zipfile.ZipFile(f)
        for entry in zf.namelist():
            path = parent + [entry]
            if zip_file_pattern.match(entry.lower()):
                if verify_entry_depth(entry, max_depth):
                    result += traversal_zip(io.BytesIO(zf.open(entry).read()), max_depth, path)
            else:
                if verify_entry_depth(entry, max_depth):
                    result.append("/".join(path))
    except zipfile.BadZipFile:
        pass
    except IOError:
        pass

    return result


def process(path, file_name_pattern, max_depth=0, include_file_path=True):
    for line in traversal_zip(open(path, "rb"), max_depth):
        if file_name_pattern is None:
            if include_file_path:
                print("%s:%s" % (path, line))
            else:
                print("%s" % (line))
        else:
            if file_name_pattern in line:
                if include_file_path:
                    print("%s:%s" % (path, line))
                else:
                    print("%s" % (line))


def _parallel_process(directory, matcher):
    if PY2:
        from Queue import Empty
        import Queue as que

    if PY3:
        from queue import Empty
        import queue as que

    try:
        from scandir import scandir, walk
    except ImportError:
        from os import scandir, walk

    import threading

    def do_search_work(in_queue):
        while True:
            try:
                member = in_queue.get(True, 5)
                process(member, matcher)
                in_queue.task_done()
            except Empty:
                break
            except KeyboardInterrupt:
                pass

    def do_dir_list_work(list_work_queue, search_work_queue):
        process_queue = list_work_queue.get()
        while True:
            try:
                entity = process_queue.get(True, 1)
                for entry in scandir(entity['path']):
                    entry_ = {'is_dir': entry.is_dir(follow_symlinks=False), 'path': os.path.abspath(entry.path)}
                    try:
                        if entry_['is_dir']:
                            process_queue.put(entry_)
                        else:
                            if zip_file_pattern.match(entry_['path'].lower()):
                                search_work_queue.put(entry_['path'])
                    except OSError:
                        pass
                process_queue.task_done()
            except KeyboardInterrupt:
                pass
            except Empty:
                break
        list_work_queue.task_done()

    def process_file_path(process_queue):
        list_work_queue = que.Queue()
        search_work_queue = que.Queue()

        main_t = threading.Thread(target=do_dir_list_work, args=[list_work_queue, search_work_queue])
        main_t.daemon = True
        main_t.start()

        for _ in range(4):
            t = threading.Thread(target=do_search_work, args=[search_work_queue])
            t.daemon = True
            t.start()

        list_work_queue.put(process_queue)
        list_work_queue.join()
        search_work_queue.join()

    try:
        cores = mp.cpu_count()
        q = mp.JoinableQueue()
        q.put({'is_dir': True, 'path': os.path.abspath(directory)})
        processes = [mp.Process(target=process_file_path, args=(q,)) for i in range(0, cores)]
        for p in processes:
            p.daemon = True
            p.start()
        for p in processes:
            p.join()
    except KeyboardInterrupt:
        pass


def args_parsing():
    parser = argparse.ArgumentParser(argparse.PARSER, formatter_class=argparse.RawDescriptionHelpFormatter)
    parser.add_argument('-d', '--depth', dest='depth', action='store', type=int, default=50,
                        help='recursion depth, default is %(default)s')
    parser.add_argument('-p', '--path', dest='path', action='store', type=str, help='file path')
    parser.add_argument('-s', '--search', dest='search', action='store', type=str, help='search pattern')

    return parser, parser.parse_args()


def main(argv):
    parser, args = args_parsing()

    if not args.path:
        parser.print_help()
        return

    if not os.path.exists(args.path):
        print(args.path + " not exist")
        return

    if os.path.isdir(args.path):
        _parallel_process(args.path, args.search)
    else:
        process(args.path, args.search, args.depth, False)


if __name__ == "__main__":
    sys.exit(main(sys.argv))
