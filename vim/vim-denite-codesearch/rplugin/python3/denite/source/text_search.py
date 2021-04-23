import shlex
import typing
from os.path import relpath

from denite import util, process
from denite.base.source import Base
from denite.util import Nvim, UserContext, Candidates, Candidate


HEADER_SYNTAX = (
        'syntax match deniteSource_Header '
        r'/\v[^:]*:\d+(:\d+)? / '
        'contained keepend')
FILE_SYNTAX = (
        'syntax match deniteSource_File '
        r'/[^:]*:/ '
        'contained containedin=deniteSource_Header '
        'nextgroup=deniteSource_LineNR')
FILE_HIGHLIGHT = 'highlight default link deniteSource_File Comment'
LINE_SYNTAX = (
        'syntax match deniteSource_LineNR '
        r'/\d\+\(:\d\+\)\?/ '
        'contained containedin=deniteSource_Header')
LINE_HIGHLIGHT = 'highlight default link deniteSource_LineNR LineNR'
PATTERNS_HIGHLIGHT = 'highlight default link denitePatterns Function'

PLUGIN_NAME = 'text_search'


class BaseSource(Base):
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

    def _init_paths(self, context: UserContext, args: typing.Dict[int, str]) -> typing.List[str]:
        paths: typing.List[str] = []
        arg: typing.Union[str, typing.List[str]] = args.get(0, [])
        if arg:
            if isinstance(arg, str):
                paths = [arg]
            elif isinstance(arg, list):
                paths = arg[:]
            else:
                raise AttributeError(
                    '`args[0]` needs to be a `str` or `list`')
        elif context['path']:
            paths = [context['path']]
        return [util.abspath(self.vim, x) for x in paths]

    def _init_arguments(self, context: UserContext, args: typing.Dict[int, str]) -> typing.List[str]:
        arguments: typing.List[str] = []
        arg: typing.Union[str, typing.List[str]] = args.get(1, [])
        if arg:
            if isinstance(arg, str):
                if arg == '!':
                    arg = str(self.vim.call('denite#util#input',
                                            'Argument: '))
                arguments = shlex.split(arg)
            elif isinstance(arg, list):
                arguments = arg[:]
            else:
                raise AttributeError(
                    '`args[1]` needs to be a `str` or `list`')
        return arguments

    def _init_patterns(self, context: UserContext, args: typing.Dict[int, str]) -> typing.List[str]:
        patterns: typing.List[str] = []
        arg: typing.Union[str, typing.List[str]] = args.get(2, [])
        if arg:
            if isinstance(arg, str):
                if arg == '!':
                    # Interactive mode
                    context['is_interactive'] = True
                    patterns = [context['input']]
                else:
                    patterns = [arg]
            elif isinstance(arg, list):
                patterns = arg[:]
            else:
                raise AttributeError(
                    '`args[2]` needs to be a `str` or `list`')
        elif context['input']:
            patterns = [context['input']]
        else:
            patterns = [
                self.vim.call('denite#util#input', '%s: ' % PLUGIN_NAME)
            ]
        return [x for x in patterns if x]

    def highlight(self) -> None:
        self.vim.command(HEADER_SYNTAX)
        self.vim.command(FILE_SYNTAX)
        self.vim.command(FILE_HIGHLIGHT)
        self.vim.command(LINE_SYNTAX)
        self.vim.command(LINE_HIGHLIGHT)
        self.vim.command(PATTERNS_HIGHLIGHT)

    def define_syntax(self) -> None:
        self.vim.command(
            'syntax region ' + self.syntax_name + ' start=// end=/$/ '
            'contains=deniteSource_Header,deniteMatchedRange contained')
        if self.context['__patterns']:
            self.vim.command(
                'syntax match denitePatterns ' +
                r'/%s/ ' % r'\|'.join(
                    util.regex_convert_str_vim(pattern)
                    for pattern in self.context['__patterns']) +
                'contained containedin=' + self.syntax_name)

########################################################################################################################

def _candidate(result: typing.List[typing.Any], path: str) -> Candidate:
    return {
        'word': result[3],
        'abbr': '{}:{}{} {}'.format(
            path,
            result[1],
            (':' + result[2] if result[2] != '0' else ''),
            result[3]),
        'action__path': result[0],
        'action__line': result[1],
        'action__col': result[2],
        'action__text': result[3],
    }


class Source(BaseSource):
    def __init__(self, vim: Nvim) -> None:
        super().__init__(vim)
        self.name = PLUGIN_NAME # this has to be same with file name
        self.kind = 'file'
        self.vars = {
            'command': ['ts'],
            'min_interactive_pattern': 3,
        }
        self.matchers = ['matcher/regexp']
        self.is_volatile = True

    def gather_candidates(self, context: UserContext) -> Candidates:
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
            result = util.parse_jump_line(context['path'], line)
            if not result:
                continue
            path = relpath(result[0], start=context['path'])
            candidates.append(_candidate(result, path))
        return candidates
