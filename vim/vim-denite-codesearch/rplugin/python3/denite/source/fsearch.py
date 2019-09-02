import shlex
import typing

from denite import util, process
from denite.base.source import Base
from denite.util import Nvim, UserContext, Candidates, Candidate

def _candidate(result: typing.List[typing.Any], path: str) -> Candidate:
    return {
        'word': result[0],
        'abbr': '{0}'.format(path),
        'action__path': result[0]
    }


class Source(Base):

    def __init__(self, vim: Nvim) -> None:
        super().__init__(vim)

        self.name = 'fsearch'# this has to be same with file name
        self.kind = 'file'
        self.vars = {
            'command': ['_fsearch'],
            'min_interactive_pattern': 3,
        }
        self.matchers = ['matcher/ignore_globs', 'matcher/regexp']

    def on_init(self, context: UserContext) -> None:
        context['__proc'] = None

        args = dict(enumerate(context['args']))

        # paths
        context['__paths'] = self._init_paths(context, args)

        # arguments
        context['__arguments'] = self._init_arguments(context, args)

        # patterns
        context['__patterns'] = self._init_patterns(context, args)

    def on_close(self, context: UserContext) -> None:
        if context['__proc']:
            context['__proc'].kill()
            context['__proc'] = None

    def gather_candidates(self, context: UserContext) -> None:
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
        #args += context['__arguments']
        args += context['__patterns']
        #if context['__paths']:
        #    args += context['__paths']

        self.print_message(context, args)

        context['__proc'] = process.Process(args, context, context['path'])
        return self._async_gather_candidates(context, 0.5)

    def _async_gather_candidates(self, context: UserContext, timeout: float) -> Candidates:
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

    def _parse_jump_line(self, path: str, line: str) -> typing.List[str]:
        """
        produce result according to _candidate()
        """
        return [line]

    def _init_paths(self, context: UserContext, args: typing.Dict[int, str]) -> typing.List[str]:
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

    def _init_arguments(self, context: UserContext, args: typing.Dict[int, str]) -> typing.List[str]:
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

    def _init_patterns(self, context: UserContext, args: typing.Dict[int, str]) -> typing.List[str]:
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
            patterns = [util.input(self.vim, context, '[denite] _fsearch ')]
        return [x for x in patterns if x]
