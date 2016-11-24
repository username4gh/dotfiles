#! /usr/bin/env bash

GRADLE_PATH=$(_autodetect_bin 'gradle-.*')
if [[ "${#GRADLE_PATH}" -eq 0 ]];then
    _sh_log "${BASH_SOURCE[0]}" "gradle has not been installed yet"
else
    export PATH="$GRADLE_PATH/bin:$PATH"
fi

_completion_register_write gradle androidDependencies
_completion_register_write gradle signingReport
_completion_register_write gradle sourceSets

#Build tasks
#-----------
_completion_register_write gradle assemble
_completion_register_write gradle assembleAndroidTest
_completion_register_write gradle assembleDebug
_completion_register_write gradle assembleRelease
_completion_register_write gradle build
_completion_register_write gradle buildDependents
_completion_register_write gradle buildNeeded
_completion_register_write gradle clean
_completion_register_write gradle compileDebugAndroidTestSources
_completion_register_write gradle compileDebugSources
_completion_register_write gradle compileDebugUnitTestSources
_completion_register_write gradle compileReleaseSources
_completion_register_write gradle compileReleaseUnitTestSources
_completion_register_write gradle extractDebugAnnotations
_completion_register_write gradle extractReleaseAnnotations
_completion_register_write gradle mockableAndroidJar

#Build Setup tasks
#-----------------
_completion_register_write gradle init
_completion_register_write gradle wrapper

#Help tasks
#----------
_completion_register_write gradle buildEnvironment
_completion_register_write gradle components
_completion_register_write gradle dependencies
_completion_register_write gradle dependencyInsight
_completion_register_write gradle help
_completion_register_write gradle model
_completion_register_write gradle projects
_completion_register_write gradle properties
_completion_register_write gradle tasks

#Install tasks
#-------------
_completion_register_write gradle installDebug
_completion_register_write gradle installDebugAndroidTest
_completion_register_write gradle installRelease
_completion_register_write gradle uninstallAll
_completion_register_write gradle uninstallDebug
_completion_register_write gradle uninstallDebugAndroidTest
_completion_register_write gradle uninstallRelease

#Verification tasks
#------------------
_completion_register_write gradle check
_completion_register_write gradle connectedAndroidTest
_completion_register_write gradle connectedCheck
_completion_register_write gradle connectedDebugAndroidTest
_completion_register_write gradle deviceAndroidTest
_completion_register_write gradle deviceCheck
_completion_register_write gradle lint
_completion_register_write gradle lintDebug
_completion_register_write gradle lintRelease
_completion_register_write gradle test
_completion_register_write gradle testDebugUnitTest
_completion_register_write gradle testReleaseUnitTest

#Other tasks
#-----------
_completion_register_write gradle assembleDefault
_completion_register_write gradle bugtagsDeinstrumentTask
_completion_register_write gradle clean
_completion_register_write gradle jarDebugClasses
_completion_register_write gradle jarReleaseClasses
_completion_register_write gradle transformResourcesWithMergeJavaResForDebugUnitTest
_completion_register_write gradle transformResourcesWithMergeJavaResForReleaseUnitTest


_completion_setup gradle
