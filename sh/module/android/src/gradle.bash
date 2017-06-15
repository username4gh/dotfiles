#! /usr/bin/env bash

GRADLE_PATH=$(_autodetect_bin 'gradle-.*')
if [[ "${#GRADLE_PATH}" -eq 0 ]];then
    _sh_log "${BASH_SOURCE[0]}" "gradle has not been installed yet"
else
    export PATH="$GRADLE_PATH/bin:$PATH"
fi

_annotation_completion_write gradle androidDependencies
_annotation_completion_write gradle signingReport
_annotation_completion_write gradle sourceSets

#Build tasks
#-----------
_annotation_completion_write gradle assemble
_annotation_completion_write gradle assembleAndroidTest
_annotation_completion_write gradle assembleDebug
_annotation_completion_write gradle assembleRelease
_annotation_completion_write gradle build
_annotation_completion_write gradle buildDependents
_annotation_completion_write gradle buildNeeded
_annotation_completion_write gradle clean
_annotation_completion_write gradle compileDebugAndroidTestSources
_annotation_completion_write gradle compileDebugSources
_annotation_completion_write gradle compileDebugUnitTestSources
_annotation_completion_write gradle compileReleaseSources
_annotation_completion_write gradle compileReleaseUnitTestSources
_annotation_completion_write gradle extractDebugAnnotations
_annotation_completion_write gradle extractReleaseAnnotations
_annotation_completion_write gradle mockableAndroidJar

#Build Setup tasks
#-----------------
_annotation_completion_write gradle init
_annotation_completion_write gradle wrapper

#Help tasks
#----------
_annotation_completion_write gradle buildEnvironment
_annotation_completion_write gradle components
_annotation_completion_write gradle dependencies
_annotation_completion_write gradle dependencyInsight
_annotation_completion_write gradle help
_annotation_completion_write gradle model
_annotation_completion_write gradle projects
_annotation_completion_write gradle properties
_annotation_completion_write gradle tasks

#Install tasks
#-------------
_annotation_completion_write gradle installDebug
_annotation_completion_write gradle installDebugAndroidTest
_annotation_completion_write gradle installRelease
_annotation_completion_write gradle uninstallAll
_annotation_completion_write gradle uninstallDebug
_annotation_completion_write gradle uninstallDebugAndroidTest
_annotation_completion_write gradle uninstallRelease

#Verification tasks
#------------------
_annotation_completion_write gradle check
_annotation_completion_write gradle connectedAndroidTest
_annotation_completion_write gradle connectedCheck
_annotation_completion_write gradle connectedDebugAndroidTest
_annotation_completion_write gradle deviceAndroidTest
_annotation_completion_write gradle deviceCheck
_annotation_completion_write gradle lint
_annotation_completion_write gradle lintDebug
_annotation_completion_write gradle lintRelease
_annotation_completion_write gradle test
_annotation_completion_write gradle testDebugUnitTest
_annotation_completion_write gradle testReleaseUnitTest

#Other tasks
#-----------
_annotation_completion_write gradle assembleDefault
_annotation_completion_write gradle bugtagsDeinstrumentTask
_annotation_completion_write gradle clean
_annotation_completion_write gradle jarDebugClasses
_annotation_completion_write gradle jarReleaseClasses
_annotation_completion_write gradle transformResourcesWithMergeJavaResForDebugUnitTest
_annotation_completion_write gradle transformResourcesWithMergeJavaResForReleaseUnitTest


_completion_setup gradle
