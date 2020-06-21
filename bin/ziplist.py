#! /usr/bin/env python3
# coding=UTF-8
# stolen from https://unix.stackexchange.com/questions/239898/listing-files-from-nested-zip-files-without-extracting
from __future__ import print_function


import zipfile
import io
import os
import re
import sys

PY2 = sys.version_info[0] == 2
PY3 = sys.version_info[0] == 3

zip_file_pattern = re.compile(".*\\.(aar|jar|rar|zip)$")


def travesal_zip(f, parent=None):
    if parent is None:
        parent = []
    result = []
    try:
        zf = zipfile.ZipFile(f)
        for e in zf.namelist():
            path = parent + [e]
            if zip_file_pattern.match(e.lower()):
                result += travesal_zip(io.BytesIO(zf.open(e).read()), path)
            else:
                result.append("/".join(path))
    except zipfile.BadZipFile:
        pass
    except IOError:
        pass

    return result


def process(path, file_name_pattern):
    for line in travesal_zip(open(path, "rb")):
        if file_name_pattern is None:
            print("%s:%s" % (path, line))
        else:
            if file_name_pattern in line:
                print("%s:%s" % (path, line))


def _parallel_process(directory, matcher):
    import multiprocessing as mp

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
                    entry_ = {'is_dir': entry.is_dir(follow_symlinks=False),
                              'path': os.path.abspath(entry.path)}
                    try:
                        if entry_['is_dir']:
                            process_queue.put(entry_)
                        else:
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


def main(argv):
    path = os.path.abspath(argv[1])
    if len(argv) > 2:
        file_name_pattern = argv[2]
    else:
        file_name_pattern = None

    if not os.path.exists(path):
        print(path + " not exist")
        return

    if os.path.isdir(path):
        _parallel_process(path, file_name_pattern)
    else:
        process(path, file_name_pattern)


if __name__ == "__main__":
    sys.exit(main(sys.argv))

