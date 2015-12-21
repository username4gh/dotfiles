# Guidelines
+ Don't put any lines in your config files that you don't understand!

+ Keep necessary notes
 1. <small>meaningfull name</small>
 2. <small>reference url</small>

+ Compatibility & LightWeight (so i had to ditch my beloved emacs)
 1. <small>support Darwin & ubuntu</small>
 2. <small>support zsh & bash</small>
 3. <small>both local & ssh</small>

# Pre-arrangement
+ internal -> path -> (function - alias) -> plugin -> custom
 1. <small>internal (shell-builtin command & pre-installed program(as less as i can, BSD vs GNU))</small>
 2. <small>path (package-manager specific & custom-defined 'PATH')</small>
 3. <small>plugin (least dependence between each other)</small>

+ functions with prefix '_' are used either internally or cautiously


# TODO & Question & Reference
+ backup shell-command-history to github with encryption
 1. <small>[How to write a new git protocol](https://rovaughn.github.io/2015-2-9.html)</small>

+ add security check for SCM(personal or other sensetive info)

+ backup browser history
 1. <small>easy to search</small>
 2. <small>pre or post process</small>

+ bootstrap-mechanism for the whole setup
 1. <small>more automation</small>
 2. <small>clean and easily use</small>
 3. <small>easily to extend</small>

+ command with the same name exist in alias/function/script, which one will actually response the call(predefined-order or depends on the source-sequence)?
 1. <small>[alias-vs-functions-vs-scripts](http://unix.stackexchange.com/questions/4023/aliases-vs-functions-vs-scripts)</small>

+ coding style
 1. <small>[cleansing code](http://bencane.com/2014/06/06/8-tips-for-creating-better-bash-scripts/)</small>

+ Legal-Stuff
