#! /usr/bin/env bash

_completion_register_write javap -help
_completion_register_write javap --help
_completion_register_write javap -?
_completion_register_write javap -version                
_completion_register_write javap -v
_completion_register_write javap -verbose            
_completion_register_write javap -l                      
_completion_register_write javap -public                 
_completion_register_write javap -protected
_completion_register_write javap -package
_completion_register_write javap -p
_completion_register_write javap -private            
_completion_register_write javap -c                      
_completion_register_write javap -s                      
_completion_register_write javap -sysinfo                
_completion_register_write javap -constants              
_completion_register_write javap -classpath
_completion_register_write javap -cp
_completion_register_write javap -bootclasspath

_completion_setup javap
