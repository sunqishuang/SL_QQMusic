//
//  SLMusicOperationTool.h
//  SL_QQMusic
//
//  Created by 孙启双 on 2017/4/4.
//  Copyright © 2017年 孙启双. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SLAudioTool.h"


@interface SLMusicOperationTool : NSObject


single_interface(SLMusicOperationTool)

/**  歌曲信息model */
@property (nonatomic, strong) SLMusicMessageModel *messageModel;

/** 歌曲模型数组 */
@property (nonatomic, strong) NSMutableArray *musicDataArray;

/** 根据歌曲model,播放这首歌曲 */
- (void)playMusic:(SLMusicModel *)musicM;

/** 播放当前歌曲 */
- (void)playCurrentMusic;

/** 暂停当前当去 */
- (void)pauseCurrentMusic;

/** 播放下一首歌曲 */
- (void)nextMusic;

/** 播放上一首歌曲 */
- (void)preMusic;



// 展示锁屏信息
- (void)updateLockScreenMessage;


- (void)seekToTimeInterval:(NSTimeInterval)timeInterval;



@end
