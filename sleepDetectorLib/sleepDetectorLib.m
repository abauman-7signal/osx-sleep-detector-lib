//
//  sleepDetectorLib.m
//  sleepDetectorLib
//
//  Created by Aaron Bauman on 1/10/19.
//  Copyright © 2019 Aaron Bauman. All rights reserved.
//

#import "sleepDetectorLib.h"
#import <objc/runtime.h>
#import <AppKit/Appkit.h>

#define SCREENSAVER_STARTED 1
#define SCREENSAVER_LOCKED  2
#define SCREEN_DID_SLEEP     4

SleepDetectorLib *refToSelf = NULL;
int screenSaverState = 0;

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
    return screenSaverState;
}

@implementation SleepDetectorLib
NSString *screensaverDidStart = @"com.apple.screensaver.didstart";
NSString *screensaverDidStop = @"com.apple.screensaver.didstop";
NSString *screenIsLocked = @"com.apple.screenIsLocked";
NSString *screenIsUnlocked = @"com.apple.screenIsUnlocked";

     - (id) init {
         self = [super init];
         NSWorkspace *workspaceCenter = [NSWorkspace sharedWorkspace];
         NSNotificationCenter *notificationCenter = workspaceCenter.notificationCenter;
         
         [notificationCenter addObserver:self
                                selector:@selector(screenDidSleep:)
                                    name:NSWorkspaceScreensDidSleepNotification
                                  object:nil];
         [notificationCenter addObserver:self
                                selector:@selector(screenDidWake:)
                                    name:NSWorkspaceScreensDidWakeNotification
                                  object:nil];

         
//         NSDistributedNotificationCenter * center
//         = [NSDistributedNotificationCenter defaultCenter];
//
//         [center addObserver: self
//                    selector: @selector(receive:)
//                        name: screensaverDidStart
//                      object: nil
//          ];
//         [center addObserver: self
//                    selector: @selector(receive:)
//                        name: screensaverDidStop
//                      object: nil
//          ];
//         [center addObserver: self
//                    selector: @selector(receive:)
//                        name: screenIsLocked
//                      object: nil
//          ];
//         [center addObserver: self
//                    selector: @selector(receive:)
//                        name: screenIsUnlocked
//                      object: nil
//          ];
//         printf("running loop... (^C to quit)");
//         [[NSRunLoop currentRunLoop] run];
//         printf("...ending loop");
         return self;
     }

    - (void) screenDidSleep: (NSNotification*) notification {
        NSString *message = [notification name];
        NSLog(@"%s\n", [message UTF8String]);
        screenSaverState = screenSaverState | SCREEN_DID_SLEEP;
        NSLog(@"screenSaverState: %i\n", screenSaverState);
    }

    - (void) screenDidWake: (NSNotification*) notification {
        NSString *message = [notification name];
        NSLog(@"%s\n", [message UTF8String]);
        screenSaverState = screenSaverState & ~SCREEN_DID_SLEEP;
        NSLog(@"screenSaverState: %i\n", screenSaverState);
    }

    - (void) receive: (NSNotification*) notification {
        NSString *message = [notification name];
        NSLog(@"%s\n", [message UTF8String] );
        if ([message isEqualToString:screensaverDidStart]) {
//            printf("%i\n", SCREENSAVER_STARTED);
            screenSaverState = screenSaverState | SCREENSAVER_STARTED;
        }
        if ([message isEqualToString:screensaverDidStop]) {
//            printf("%i\n", ~SCREENSAVER_STARTED);
            screenSaverState = screenSaverState & ~SCREENSAVER_STARTED;
        }
        if ([message isEqualToString:screenIsLocked]) {
//            printf("%i\n", SCREENSAVER_LOCKED);
            screenSaverState = screenSaverState | SCREENSAVER_LOCKED;
        }
        if ([message isEqualToString:screenIsUnlocked]) {
//            printf("%i\n", ~SCREENSAVER_LOCKED);
            screenSaverState = screenSaverState & ~SCREENSAVER_LOCKED;
        }
        NSLog(@"screenSaverState: %i\n", screenSaverState);
    }

    - (void)logger:(NSString *) message {
        NSLog(@"%@", message);
    }
@end
