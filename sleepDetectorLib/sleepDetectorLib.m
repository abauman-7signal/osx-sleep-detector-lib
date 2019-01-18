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
int screenSaverSate = 0;

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

int getScreenSaverState(void) {
    loadSingleton();
    return screenSaverSate;
}

@implementation SleepDetectorLib
     - (id) init {
         self = [super init];
         NSDistributedNotificationCenter * center
         = [NSDistributedNotificationCenter defaultCenter];
         
         [center addObserver: self
                    selector: @selector(receive:)
                        name: @"com.apple.screensaver.didstart"
                      object: nil
          ];
         [center addObserver: self
                    selector: @selector(receive:)
                        name: @"com.apple.screensaver.didstop"
                      object: nil
          ];
         [center addObserver: self
                    selector: @selector(receive:)
                        name: @"com.apple.screenIsLocked"
                      object: nil
          ];
         [center addObserver: self
                    selector: @selector(receive:)
                        name: @"com.apple.screenIsUnlocked"
                      object: nil
          ];
//         printf("running loop... (^C to quit)");
//         [[NSRunLoop currentRunLoop] run];
//         printf("...ending loop");
         return self;
     }
    
    - (void) receive: (NSNotification*) notification {
        printf("%s\n", [[notification name] UTF8String] );
    }

    - (void)logger:(NSString *) message {
        NSLog(@"%@", message);
    }
@end
