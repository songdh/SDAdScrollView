//
//  NSTimer+Addition.h
//  SDAdScrollView
//
//  Created by DHsong on 16/4/20.
//  Copyright © 2016年 DHsong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (Addition)
- (void)pauseTimer;
- (void)resumeTimer;
- (void)resumeTimerAfterTimeInterval:(NSTimeInterval)interval;
- (void)stopTimer;
@end
