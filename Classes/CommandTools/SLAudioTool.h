//
//  SLAudioTool.h
//  SL_QQMusic
//
//  Created by 孙启双 on 2017/4/4.
//  Copyright © 2017年 孙启双. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SLAudioTool : NSObject

@property (nonatomic, strong) AVAudioPlayer *audioPlay;

- (void)PlayAudioWithAudioName:(NSString *)audioName;

- (void)playAudio;

- (void)pauseAudio;

- (void)seekToTimeInterval:(NSTimeInterval)timeInterval;



@end
