import shlex

from denite import util, process
from os.path import relpath

from .base import Base


def _candidate(result, line):
    return {
        'word': line,
        'action__path': result[0],
        'action__line': result[1],
    }


class Source(Base):

    def __init__(self, vim):
        super().__init__(vim)

        self.name = 'csearch'# this has to be same with file name
        self.kind = 'file'
        self.vars = {
            'command': ['_csearch'],
            'min_interactive_pattern': 3,
        }
        self.matchers = ['matcher/regexp']

    def on_init(self, context):
        context['__proc'] = None

        args = dict(enumerate(context['args']))

        # paths
        context['__paths'] = self._init_paths(context, args)

        # arguments
        context['__arguments'] = self._init_arguments(context, args)

        # patterns
        context['__patterns'] = self._init_patterns(context, args)

    def on_close(self, context):
        if context['__proc']:
            context['__proc'].kill()
            context['__proc'] = None

    def gather_candidates(self, context):
        if context['event'] == 'interactive':
            # Update input
            self.on_close(context)

            if (not context['input'] or
                    len(context['input']) <
                    self.vars['min_interactive_pattern']):
                return []

            context['__patterns'] = [
                '.*'.join(util.split_input(context['input']))]

        if context['__proc']:
            return self._async_gather_candidates(
                context, context['async_timeout'])

        if not context['__patterns'] or not self.vars['command']:
            return []

        args = [util.expand(self.vars['command'][0])]
        args += self.vars['command'][1:]
        args += context['__patterns']

        context['__proc'] = process.Process(args, context, context['path'])
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
            result = util.parse_jump_line(context, line)
            if not result:
                continue
            candidates.append(_candidate(result, line))
        return candidates

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

    def _init_arguments(self, context, args):
        arguments = []
        arg = args.get(1, [])
        if arg:
            if isinstance(arg, str):
                if arg == '!':
                    arg = util.input(self.vim, context, 'Argument: ')
                arguments = shlex.split(arg)
            elif not isinstance(arg, list):
                raise AttributeError(
                    '`args[1]` needs to be a `str` or `list`')
        return arguments

    def _init_patterns(self, context, args):
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
            patterns = [util.input(self.vim, context, '[denite] _csearch ')]
        return [x for x in patterns if x]
