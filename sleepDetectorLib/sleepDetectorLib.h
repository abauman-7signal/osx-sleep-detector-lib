//
//  sleepDetectorLib.h
//  sleepDetectorLib
//
//  Created by Aaron Bauman on 1/10/19.
//  Copyright © 2019 Aaron Bauman. All rights reserved.
//

#import <Foundation/Foundation.h>

extern void logIt(char *);
extern int getScreenSaverState(void);

@protocol SleepDetectorLib
- (void)logger:(NSString *) message;
@end

@interface SleepDetectorLib : NSObject
- (void)logger:(NSString *) message;
@end
