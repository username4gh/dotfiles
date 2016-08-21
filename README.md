# Guidelines
+ Don't put any lines in your config files that you don't understand!

+ Keep necessary notes
 1. <small>meaningfull name</small>
 2. <small>comment & reference</small>

+ Compatibility & Light-weight (So i had to ditch my beloved emacs) & less-dependency
 1. <small>darwin & ubuntu</small>
 2. <s><small>zsh & bash</small></s>(I'am really busy now and will stay the same for a long time, i just not able to continue doing this, so bash only)
 3. <small>local & ssh</small>
 4. <small>prefer pre-installed software(intersection of OSX and Ubuntu)</small>
 	
 		- <small>use curl rather than wget(because as to OSX, wget is not a built-in)</small>
 	
 5. <small>deal with the difference between BSD & GNU program</small>

      - <small>use python script to replace some of these programs in order to reduce the impact causing by these differences (between go python ruby and javascript, only python is supported by both OS in default)</small>

# Pre-arrangement
+ bash script loading-sequence(also the dependency chain): 

	> internal -> path -> mechanism -> (function - alias) -> module -> custom

 1. <small>internal (shell-builtin command & pre-installed program)</small>
 2. <small>path (package-manager specific & custom-defined 'PATH')</small>
    	- <small>try Sub-Shell when ```export PATH``` is needed, only keep necessary 'PATH' exported([Global Variables Are Bad](http://c2.com/cgi/wiki?GlobalVariablesAreBad))</small>
 3. <small>mechanism (basic setup for downstream stuff)</small>
 4. <small>module (least dependence between each other, dependency autonomy)</small>
 5. <small>no external dependence for executable script</small>

+ naming convention:
 	- prefix '\_' for function only used internally
	- prefix 'my\_' for function that needed to be exposed to the user

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
 1. lazy-loading like technique to reduce 'sourcing' overhead

  		- prefer script over function

 2. caching source-chain to boost later bootstrap process (reducing usage of function like '_load_sh_files')
 3. <s>global environment variable to avoid repeat-initialization while opening multiple-tab inside iterm2/terminal</s>(open a new tab inside iterm2/terminal will create a new bash process, i might have mis-conjectured something)

+ coding style
 1. <small>[cleansing code](http://bencane.com/2014/06/06/8-tips-for-creating-better-bash-scripts/)</small>

+ Legal-Stuff
