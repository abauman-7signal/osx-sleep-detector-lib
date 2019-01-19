//
//  sleepDetectorLib.m
//  sleepDetectorLib
//
//  Created by Aaron Bauman on 1/10/19.
//  Copyright © 2019 Aaron Bauman. All rights reserved.
//

#import "sleepDetectorLib.h"
#import <objc/runtime.h>

#define SCREENSAVER_STARTED 1
#define SCREENSAVER_LOCKED  2

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
NSString *screensaverDidStart = @"com.apple.screensaver.didstart";
NSString *screensaverDidStop = @"com.apple.screensaver.didstop";
NSString *screenIsLocked = @"com.apple.screenIsLocked";
NSString *screenIsUnlocked = @"com.apple.screenIsUnlocked";

     - (id) init {
         self = [super init];
         NSDistributedNotificationCenter * center
         = [NSDistributedNotificationCenter defaultCenter];
         
         [center addObserver: self
                    selector: @selector(receive:)
                        name: screensaverDidStart
                      object: nil
          ];
         [center addObserver: self
                    selector: @selector(receive:)
                        name: screensaverDidStop
                      object: nil
          ];
         [center addObserver: self
                    selector: @selector(receive:)
                        name: screenIsLocked
                      object: nil
          ];
         [center addObserver: self
                    selector: @selector(receive:)
                        name: screenIsUnlocked
                      object: nil
          ];
//         printf("running loop... (^C to quit)");
//         [[NSRunLoop currentRunLoop] run];
//         printf("...ending loop");
         return self;
     }
    
    - (void) receive: (NSNotification*) notification {
        NSString *message = [notification name];
        printf("%s\n", [message UTF8String] );
        if ([message isEqualToString:screensaverDidStart]) {
//            printf("%i\n", SCREENSAVER_STARTED);
            screenSaverSate = screenSaverSate | SCREENSAVER_STARTED;
        }
        if ([message isEqualToString:screensaverDidStop]) {
//            printf("%i\n", ~SCREENSAVER_STARTED);
            screenSaverSate = screenSaverSate & ~SCREENSAVER_STARTED;
        }
        if ([message isEqualToString:screenIsLocked]) {
//            printf("%i\n", SCREENSAVER_LOCKED);
            screenSaverSate = screenSaverSate | SCREENSAVER_LOCKED;
        }
        if ([message isEqualToString:screenIsUnlocked]) {
//            printf("%i\n", ~SCREENSAVER_LOCKED);
            screenSaverSate = screenSaverSate & ~SCREENSAVER_LOCKED;
        }
        printf("screenSaverState: %i\n", screenSaverSate);
    }

    - (void)logger:(NSString *) message {
        NSLog(@"%@", message);
    }
@end
