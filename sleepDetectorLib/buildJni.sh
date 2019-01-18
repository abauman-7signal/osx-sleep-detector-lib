#!/bin/bash

function createHeaderForNativeInterface() {
  javah -jni JniInterface
}

function buildNativeLibrary() {
  gcc -I/System/Library/Frameworks/JavaVM.framework/Versions/Current/Headers/ -c JniInterface.c -o JniInterface.o
  gcc -dynamiclib -o libjniinterface.dylib JniInterface.o
}

function buildJniLibrary() {
  javac JniInterface.java
}

createHeaderForNativeInterface
buildNativeLibrary
buildJniLibrary
