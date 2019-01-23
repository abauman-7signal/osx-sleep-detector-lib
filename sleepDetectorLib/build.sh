#!/bin/bash

function buildObjectiveCLibrary() {
  # clang -v -framework Foundation -dynamiclib sleepDetectorLib.m -exported_symbols_list export_list -o libsleepDetectorLib.dylib
  # clang -framework Foundation -dynamiclib sleepDetectorLib.m -o libsleepDetectorLib.dylib
  pushd ..
  xcodebuild -scheme sleepDetectorLib -configuration Debug -derivedDataPath build
  popd
  cp ../build/Build/Products/Debug/libsleepDetectorLib.dylib .
}

function buildObjectiveCTestClient() {
  clang -framework Foundation Client.m -o client
}

function runObjectiveCTestClient() {
  ./client
}

function buildCTestClient() {
  gcc C-Client.c
}

function runCTestClient() {
  ./a.out
}

function buildAndRunForCTestClient() {
  buildObjectiveCLibrary
  buildCTestClient
  runCTestClient
}

function buildAndRunForObjectiveCTestClient() {
  buildObjectiveCLibrary
  buildObjectiveCTestClient
  runObjectiveCTestClient
}

buildAndRunForCTestClient
# buildAndRunForObjectiveCTestClient
