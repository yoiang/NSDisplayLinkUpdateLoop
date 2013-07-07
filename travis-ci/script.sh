#!/bin/sh

set -e

xctool -workspace NSDisplayLinkUpdateLoopDemo.xcworkspace -scheme NSDisplayLinkUpdateLoopDemo build -sdk iphonesimulator

xctool -workspace NSDisplayLinkUpdateLoopDemo.xcworkspace -scheme Pods-NSDisplayLinkUpdateLoopTest_CommandLine build -sdk iphonesimulator
xctool -workspace NSDisplayLinkUpdateLoopDemo.xcworkspace -scheme NSDisplayLinkUpdateLoopTest_CommandLine build-tests run-tests -test-sdk iphonesimulator
#xcodebuild -workspace NSDisplayLinkUpdateLoopDemo.xcworkspace -scheme NSDisplayLinkUpdateLoopTest