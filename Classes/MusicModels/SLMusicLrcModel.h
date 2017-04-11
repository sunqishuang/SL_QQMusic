//
//  SLMusicLrcModel.h
//  SL_QQMusic
//
//  Created by 孙启双 on 2017/3/31.
//  Copyright © 2017年 孙启双. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SLMusicLrcModel : NSObject


/** 一行的歌词 */
@property (nonatomic, copy) NSString * lrcText;

/** 开始时间 */
@property (nonatomic, assign) NSTimeInterval beginTime;

/** 结束时间 */
@property (nonatomic, assign) NSTimeInterval endTime;


@end
