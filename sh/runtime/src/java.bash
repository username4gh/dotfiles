#! /usr/bin/env bash

if _is_linux;then
    export JDK_PATH="$(_autodetect_bin "jdk1\..*")"
    if [[ "${#JDK_PATH}" -eq 0 ]];then
        _sh_log "${BASH_SOURCE[0]}" "jdk has not been installed yet"
    else
        export JAVA_HOME="$JDK_PATH"
        export PATH="$JDK_PATH/bin:$PATH"
    fi
fi

if _is_darwin;then
    export JAVA_HOME="/Library/Java/JavaVirtualMachines/$(ls /Library/Java/JavaVirtualMachines/ | jdk_select)/Contents/Home"
    export JDK_PATH="$JDK_PATH"
fi

# javap completetion
_annotation_completion_write javap -help
_annotation_completion_write javap --help
_annotation_completion_write javap -?
_annotation_completion_write javap -version                
_annotation_completion_write javap -v
_annotation_completion_write javap -verbose            
_annotation_completion_write javap -l                      
_annotation_completion_write javap -public                 
_annotation_completion_write javap -protected
_annotation_completion_write javap -package
_annotation_completion_write javap -p
_annotation_completion_write javap -private            
_annotation_completion_write javap -c                      
_annotation_completion_write javap -s                      
_annotation_completion_write javap -sysinfo                
_annotation_completion_write javap -constants              
_annotation_completion_write javap -classpath
_annotation_completion_write javap -cp
_annotation_completion_write javap -bootclasspath

_completion_setup javap
