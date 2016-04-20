//
//  NSTimer+Addition.m
//  SDAdScrollView
//
//  Created by DHsong on 16/4/20.
//  Copyright © 2016年 DHsong. All rights reserved.
//

#import "NSTimer+Addition.h"

@implementation NSTimer (Addition)
-(void)pauseTimer
{
    if (![self isValid]) {
        return ;
    }
    [self setFireDate:[NSDate distantFuture]];
}


-(void)resumeTimer
{
    if (![self isValid]) {
        return ;
    }
    [self setFireDate:[NSDate date]];
}

- (void)resumeTimerAfterTimeInterval:(NSTimeInterval)interval
{
    if (![self isValid]) {
        return ;
    }
    [self setFireDate:[NSDate dateWithTimeIntervalSinceNow:interval]];
}

- (void)stopTimer
{
    if ([self isValid]) {
        [self invalidate];
    }
}
@end
