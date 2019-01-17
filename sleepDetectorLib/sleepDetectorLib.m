//
//  sleepDetectorLib.m
//  sleepDetectorLib
//
//  Created by Aaron Bauman on 1/10/19.
//  Copyright © 2019 Aaron Bauman. All rights reserved.
//

#import "sleepDetectorLib.h"
#import <objc/runtime.h>

SleepDetectorLib *refToSelf = NULL;

void loadSingleton(void) {
    if (refToSelf == NULL) {
        refToSelf = [[SleepDetectorLib alloc] init];
    }
}

void logIt(void) {
    loadSingleton();
    [refToSelf logger];
}

@implementation SleepDetectorLib
     - (id) init {
         self = [super init];
         return self;
     }
    
     - (void)logger {
        NSString *message = @"Hello world from Objective C library\n";
        
        NSLog(@"%@", message);
        
        [[NSFileManager defaultManager] createFileAtPath:@"./log" contents:nil attributes:nil];
        [message writeToFile:@"./log" atomically:YES encoding:NSUTF8StringEncoding error:nil];
    }
@end
