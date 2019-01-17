//
//  sleepDetectorLib.h
//  sleepDetectorLib
//
//  Created by Aaron Bauman on 1/10/19.
//  Copyright © 2019 Aaron Bauman. All rights reserved.
//

#import <Foundation/Foundation.h>

extern void logIt(void);

@protocol SleepDetectorLib
- (void)logger;
@end

@interface SleepDetectorLib : NSObject {
}
- (void)logger;
@end
