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

void logIt(char *message) {
    loadSingleton();
    NSString *messageObjC = @(message);
    [refToSelf logger:messageObjC];
}

@implementation SleepDetectorLib
     - (id) init {
         self = [super init];
         return self;
     }
    
    - (void)logger:(NSString *) message {
        NSLog(@"%@", message);
    }
@end
