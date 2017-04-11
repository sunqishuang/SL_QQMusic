//
//  SLTimeTool.m
//  SL_QQMusic
//
//  Created by 孙启双 on 2017/3/31.
//  Copyright © 2017年 孙启双. All rights reserved.
//

#import "SLTimeTool.h"

@implementation SLTimeTool


/** 将时间戳转成字符串 */
+ (NSString *)getTimeStringWithTimeinterval:(NSTimeInterval)timeinterval{
    
    
    NSInteger min = timeinterval /60;
    NSInteger sec = (NSInteger)timeinterval % 60;
    
    return [NSString stringWithFormat:@"%02zd:%02zd",min,sec];
    
    
}

/** 将字符串转成时间戳 */
+ (NSTimeInterval)getTimeWithTimeString:(NSString *)timeString{
    
    
    NSArray *minAndSec = [timeString componentsSeparatedByString:@":"];
    
    NSInteger min = [[minAndSec firstObject] integerValue];
    double sec = [[minAndSec lastObject] doubleValue];
    
    
    return (min * 60 + sec);
}

@end
