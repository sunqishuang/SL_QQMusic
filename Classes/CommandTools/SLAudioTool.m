//
//  SLAudioTool.m
//  SL_QQMusic
//
//  Created by 孙启双 on 2017/4/4.
//  Copyright © 2017年 孙启双. All rights reserved.
//

#import "SLAudioTool.h"

@interface SLAudioTool ()<AVAudioPlayerDelegate>

@end

@implementation SLAudioTool



- (instancetype)init{
    self = [super init];
    if (self) {
        [self playBack];
    }
    return self;
    
}

- (void)playBack{
    //获取音频会话
    AVAudioSession *session = [AVAudioSession sharedInstance];
    
    //2.设置回话类别为后台播放
    [session setCategory:AVAudioSessionCategoryPlayback error:nil];
    
    //3. 激活回话
    [session setActive:YES error:nil];
    
}


- (void)PlayAudioWithAudioName:(NSString *)audioName{
    NSURL *url = [[NSBundle mainBundle] URLForResource:audioName withExtension:nil];
    
    // 容错处理
    if (url == nil) {
        return;
    }
    
    if ([self.audioPlay.url isEqual:url]) {
        [self.audioPlay play];
        return;
    }
    
    
    _audioPlay = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    _audioPlay.delegate = self;
    [self.audioPlay prepareToPlay];
    [self.audioPlay play];
}

- (void)playAudio{
    [self.audioPlay play];
    
}

- (void)pauseAudio{
    [self.audioPlay pause];
}

- (void)seekToTimeInterval:(NSTimeInterval)timeInterval{
    self.audioPlay.currentTime = timeInterval;
}




#pragma mark - 歌曲播放器代理方法

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    if(flag)
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationPlayFinish object:nil];
    }
}




@end
