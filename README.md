# Guidelines
+ Don't put any lines in your config files that you don't understand!

+ Keep necessary notes
 1. <small>meaningfull name</small>
 2. <small>comment & reference</small>

+ Compatibility & Light-weight (i had to ditch my beloved emacs) & less-dependency
 1. <small>darwin & ubuntu</small>
 2. <s><small>zsh & bash 4.x</small></s>(I'am really busy now and will stay the same for a long time, i just not able to continue doing this, and i'm only familiar with bash 4.x, so bash 4.x only)
 3. <small>local & ssh</small>
 4. <s><small>Prefer pre-installed software(intersection of OSX and Ubuntu)</small></s>(Same reason above, i'll remain trying, but i cann't guarantee)

    	- <small>use curl rather than wget(because as to OSX, wget is not a built-in command)</small>

 5. <small>deal with the difference between BSD & GNU program</small>

    - <small>use python script to replace some of these programs in order to reduce the impact causing by these differences (between go python ruby and javascript, only python is supported by both OS in default)</small>

# Pre-arrangement
+ PATH -- keep `/bin/` at the end of PATH sequence, so avoid using some old version of softwares like `/bin/bash` on macosx, to save energy.

+ bash script loading-sequence(also the dependency chain, frome left to right, each layer may or may not depends on the layer on its left side and may or may not be depended by the layer on its right side):

	> internal -> mechanism -> (path - runtime) -> (function - alias) -> module -> custom

 1. <small>internal (written with only then shell-builtin commands & some shared pre-installed programs on both the ubuntu and OSX)</small>
 2. <small>path (package-manager specific & custom-defined 'PATH')</small>
    	- <small>try Sub-Shell when ```export PATH``` is needed, only keep necessary 'PATH' exported(remember the [Global Variables Are Bad](http://c2.com/cgi/wiki?GlobalVariablesAreBad))</small>
 3. <small>mechanism (basic setup for downstream stuff)</small>
 4. <small>module (least dependence between each other, dependency autonomy)</small>
 5. <small>no external dependence for executable script</small>

+ naming convention:
 	- prefix '\_' for function only used internally

+ terminology
        - when I mention about module in comment/naming or something else, it means someting related to one module
        - when I mention about modules in comment/naming or something else, it means something related to all modules in a generic way
        - In another word, module or modules are like scope identifier

# TODO & Question & Reference
+ backup shell-command-history to github with encryption
 1. <small>[How to write a new git protocol](https://rovaughn.github.io/2015-2-9.html)</small>
 2. <small>[blackbox](https://github.com/StackExchange/blackbox)</small>

+ add security check for SCM(personal or other sensitive info)

+ backup browser history
 1. <small>easy to search</small>
 2. <small>pre or post process</small>

+ bootstrap-mechanism for the whole setup process
 1. <small>more automation</small>
 2. <small>clean and easy to use</small>
 3. <small>easy to extend</small>

+ performance
 1. lazy-loading like technique to reduce the 'sourcing' overhead

  		- prefer script over function, scripts does not directly effect the sourcing process -- also this will be good for debugging (every time you change a function you have to source again to see if it works)

 2. caching source-chain to boost later bootstrap process (reducing usage of function like '_load_sh_files')
 3. <s>global environment variable to avoid repeat-initialization while opening multiple-tab inside iterm2/terminal</s>(open a new tab inside iterm2/terminal will create a new bash process, i might have mis-conjectured something)

+ coding style
 1. <small>[cleansing code](http://bencane.com/2014/06/06/8-tips-for-creating-better-bash-scripts/)</small>

+ Legal-Stuff
