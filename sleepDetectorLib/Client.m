//
//  Client.m
//  sleepDetectorLib
//
//  Created by Aaron Bauman on 1/11/19.
//  Copyright © 2019 Aaron Bauman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import <dlfcn.h>
#import "sleepDetectorLib.h"

int main() {
    char *libName = "./libsleepDetectorLib.dylib";
    @autoreleasepool {
        void* lib_handle = dlopen(libName, RTLD_LOCAL);
        if (!lib_handle) {
            NSLog(@"[%s] main: Unable to open library: %s\n", __FILE__, dlerror());
            exit(EXIT_FAILURE);
        }
        
        Class SleepDetectorLib_class = objc_getClass("SleepDetectorLib");
        if (!SleepDetectorLib_class) {
            NSLog(@"[%s] main: Unable to get SleepDetectorLib class", __FILE__);
            exit(EXIT_FAILURE);
        }
        
        NSObject<SleepDetectorLib>* sleepDetectorLib = [SleepDetectorLib_class new];
        NSString *aMessage = @"Objective-C client finished loading library";
        [sleepDetectorLib logger:[NSString stringWithFormat:@"%@ %@", aMessage, @(libName)]];
        
        if (dlclose(lib_handle) != 0) {
            NSLog(@"[%s] Unable to close library; %s\n", __FILE__, dlerror());
            exit(EXIT_FAILURE);
        }
    }
    return(EXIT_SUCCESS);
}
