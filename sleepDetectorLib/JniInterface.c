#include <stdio.h>
#include <dlfcn.h>
#include <stdlib.h>
#include "JniInterface.h"

char *LOG_FUNCTION = "logIt";

void *openDynamicLib(void *libName) {
  void *libHandle = dlopen(libName, RTLD_LOCAL);
  if (libHandle) {
    printf("[%s] dlopen(\"%s\", RTLD_NOW): Successful\n", __FILE__, libName);
  } else {
    printf("[%s] Unable to open library: %s\n", __FILE__, dlerror());
    return NULL;
  }
  return libHandle;
}

void closeDynamicLib(void *libHandle) {
  if (dlclose(libHandle) == 0) {
    printf("[%s] dlclose(libHandle): Successful\n", __FILE__);
  } else {
    printf("[%s] Unable to close: %s\n", __FILE__, dlerror());
  }
}

void *linkToFunction(void *libHandle, char *nameOfFunction) {
  void *pointerToFunction = dlsym(libHandle, nameOfFunction);
  if (pointerToFunction) {
    printf("[%s] dlsym(libHandle, \"%s\"): Successful\n", __FILE__, nameOfFunction);
  } else {
    printf("[%s] Unable to get symbol for function \"%s\": %s\n", __FILE__, nameOfFunction, dlerror());
    return NULL;
  }
  return pointerToFunction;
}

JNIEXPORT void JNICALL
Java_JniInterface_log(JNIEnv *jniEnv, jobject callbackObject) {
  char libName[] = "./libsleepDetectorLib.dylib";
  void *libHandle = openDynamicLib(&libName);

  void (*log)(char *) = linkToFunction(libHandle, LOG_FUNCTION);

  if (log) {
    printf("[%s] established link to %s()\n", __FILE__, LOG_FUNCTION);
  } else {
    printf("[%s] did not establish link to %s()\n", __FILE__, LOG_FUNCTION);
  }

  char buf[1025];
  snprintf(buf, sizeof(buf), "%s %s", "JNI Interface finished loading library ", libName);

  log(buf);

  closeDynamicLib(libHandle);
}
