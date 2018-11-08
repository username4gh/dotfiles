import subprocess
from threading import Thread
from queue import Queue
from time import time, sleep
import os

from denite import process

class AlteredProcess(process.Process):
    def __init__(self, commands, context, cwd):
        startupinfo = None
        if os.name == 'nt':
            startupinfo = subprocess.STARTUPINFO()
            startupinfo.dwFlags |= subprocess.STARTF_USESHOWWINDOW
        self._proc = subprocess.Popen(commands,
                                      stdin=subprocess.DEVNULL,
                                      stdout=subprocess.PIPE,
                                      stderr=subprocess.PIPE,
                                      startupinfo=startupinfo,
                                      shell=True,
                                      cwd=cwd)
        self._eof = False
        self._context = context
        self._queue_out = Queue()
        self._thread = Thread(target=self.enqueue_output)
        self._thread.start()



import shlex
from denite import util
from os.path import relpath

from .base import Base

def _candidate(result, path):
    return {
        'word': result[1],
        'abbr': '{0}'.format(
            result[0]),
        'action__path': result[0],
    }


class Source(Base):

    def __init__(self, vim):
        super().__init__(vim)

        self.name = 'command'# this has to be same with file name
        self.kind = 'file'
        self.vars = {
            'min_interactive_pattern': 3
        }
        self.matchers = ['matcher/ignore_globs', 'matcher/regexp']

    def on_init(self, context):
        context['__proc'] = None

        args = dict(enumerate(context['args']))

        # patterns
        context['__commands'] = self._init_commands(context, args)

    def on_close(self, context):
        if context['__proc']:
            context['__proc'].kill()
            context['__proc'] = None

    def gather_candidates(self, context):
        if context['event'] == 'interactive':
            # Update input, close previous instance if exists
            self.on_close(context)

            if (not context['input'] or
                    len(context['input']) <
                    self.vars['min_interactive_pattern']):
                return []

            context['__commands'] = [
                '.*'.join(util.split_input(context['input']))]

        if context['__proc']:
            return self._async_gather_candidates(
                context, context['async_timeout'])

        if not context['__commands']:
            return []

        args = context['__commands']

        context['__proc'] = AlteredProcess(args, context, context['path'])
        return self._async_gather_candidates(context, 0.5)

    def _async_gather_candidates(self, context, timeout):
        outs, errs = context['__proc'].communicate(timeout=timeout)
        if errs:
            self.error_message(context, errs)
        context['is_async'] = not context['__proc'].eof()
        if context['__proc'].eof():
            context['__proc'] = None

        candidates = []

        for line in outs:
            result = self._parse_jump_line(context['path'], line)
            if not result:
                continue
            path = line
            candidates.append(_candidate(result, path))
        return candidates

    def _parse_jump_line(self, path, line):
        """
        produce result according to _candidate()
        """
        splits = line.split(':')
        splits += path
        return splits

    def _init_paths(self, context, args):
        paths = []
        arg = args.get(0, [])
        if arg:
            if isinstance(arg, str):
                paths = [arg]
            elif not isinstance(arg, list):
                raise AttributeError(
                    '`args[0]` needs to be a `str` or `list`')
        elif context['path']:
            paths = [context['path']]
        return [util.abspath(self.vim, x) for x in paths]

    def _init_commands(self, context, args):
        patterns = []
        arg = args.get(2, [])
        if arg:
            if isinstance(arg, str):
                if arg == '!':
                    # Interactive mode
                    context['is_interactive'] = True
                    patterns = [context['input']]
                else:
                    patterns = [arg]
            elif not isinstance(arg, list):
                raise AttributeError(
                    '`args[2]` needs to be a `str` or `list`')
        elif context['input']:
            patterns = [context['input']]
        else:
            patterns = [util.input(self.vim, context, '[denite] command ')]
        return [x for x in patterns if x]
