# http://stackoverflow.com/questions/675370/tab-completion-in-python-interpreter-in-os-x-terminal?lq=1
# try:
#     import readline
# except ImportError:
#     print("Module readline not available.")
# else:
#     import rlcompleter
#     readline.parse_and_bind("tab: complete")

# http://stackoverflow.com/questions/7116038/python-tab-completion-mac-osx-10-7-lion?lq=1
import readline
import rlcompleter
if 'libedit' in readline.__doc__:
    readline.parse_and_bind("bind ^I rl_complete")
else:
    readline.parse_and_bind("tab: complete")
