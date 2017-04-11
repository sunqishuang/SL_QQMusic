//
//  SLTimeTool.h
//  SL_QQMusic
//
//  Created by 孙启双 on 2017/3/31.
//  Copyright © 2017年 孙启双. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SLTimeTool : NSObject


/** 将时间戳转成字符串 */
+ (NSString *)getTimeStringWithTimeinterval:(NSTimeInterval)timeinterval;

/** 将字符串转成时间戳 */
+ (NSTimeInterval)getTimeWithTimeString:(NSString *)timeString;



@end
