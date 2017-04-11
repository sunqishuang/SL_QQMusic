//
//  SLMusicMessageModel.h
//  SL_QQMusic
//
//  Created by 孙启双 on 2017/4/4.
//  Copyright © 2017年 孙启双. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SLMusicMessageModel : NSObject


/**   */
@property (nonatomic, strong) SLMusicModel *model;

/** 已经播放时长 */
@property (nonatomic, assign) NSTimeInterval costTime;

/** 歌曲总时长 */
@property (nonatomic, assign) NSTimeInterval totalTime;

/** 是否正在播放 */
@property (nonatomic, assign) BOOL isPlaying;









@end
