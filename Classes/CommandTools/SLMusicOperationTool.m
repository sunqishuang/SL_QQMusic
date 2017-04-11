//
//  SLMusicOperationTool.m
//  SL_QQMusic
//
//  Created by 孙启双 on 2017/4/4.
//  Copyright © 2017年 孙启双. All rights reserved.
//

#import "SLMusicOperationTool.h"

@interface SLMusicOperationTool ()
/** 音乐播放器 */
@property (nonatomic, strong)  SLAudioTool *audioTool;

@property (nonatomic, assign) NSInteger currentIndex;

@end

@implementation SLMusicOperationTool

single_implementation(SLMusicOperationTool)

- (SLAudioTool *)audioTool{
    if (!_audioTool) {
        _audioTool = [[SLAudioTool alloc] init];
    }
    return _audioTool;
}

- (SLMusicMessageModel *)messageModel{
    if (!_messageModel) {
        _messageModel = [[SLMusicMessageModel alloc] init];
    }
    
    //利用get方法更新当前歌曲的播放状态
    _messageModel.model = self.musicDataArray[self.currentIndex];
    _messageModel.costTime = self.audioTool.audioPlay.currentTime;
    _messageModel.totalTime = self.audioTool.audioPlay.duration;
    _messageModel.isPlaying = self.audioTool.audioPlay.isPlaying;
    
    return _messageModel;
    
    
}


- (void)playMusic:(SLMusicModel *)musicM{
    [self.audioTool PlayAudioWithAudioName:musicM.filename];
    
    _currentIndex = [self.musicDataArray indexOfObject:musicM];

    
    
}


/**
 播放下一首
 */
- (void)nextMusic{
    self.currentIndex ++;
    if (_currentIndex >= self.musicDataArray.count) {
        _currentIndex = 0;
    }
    SLMusicModel *musicM = self.musicDataArray[_currentIndex];
    
    
    [self playMusic:musicM];
}


-(void)preMusic
{
    self.currentIndex --;
    if (_currentIndex < 0) {
        _currentIndex = self.musicDataArray.count - 1;
    }
    SLMusicModel *musicM = self.musicDataArray[_currentIndex];
    [self playMusic:musicM];
}

- (void)playCurrentMusic
{
    [self.audioTool playAudio];
}

- (void)pauseCurrentMusic
{
    [self.audioTool pauseAudio];
}



- (void)updateLockScreenMessage{
    //获取锁屏中心
    MPNowPlayingInfoCenter *infoCenter = [MPNowPlayingInfoCenter defaultCenter];
    
    //创建锁屏的图片信息
    UIImage *image = [UIImage imageNamed:self.messageModel.model.icon];
    
    //根据歌词文件名称获取歌词数组
    NSMutableArray *lrcList = [SLLrcTool getLrcListWithFileName:self.messageModel.model.lrcname];
    
    //根据当前时间,获取歌词是在第几行
    NSInteger row = [SLLrcTool getCurrentRowWithTimeInterval:self.messageModel.costTime InLrcList:lrcList];
    
    //获取当前正在播放的那一首歌词
    SLMusicLrcModel *lrcModel = lrcList[row];
    NSString *lrcText = lrcModel.lrcText;
    
    MPMediaItemArtwork *artWork = [[MPMediaItemArtwork alloc] initWithImage:image];
    
    NSDictionary *dic = @{ MPMediaItemPropertyAlbumTitle : self.messageModel.model.name,
                           MPMediaItemPropertyArtist : self.messageModel.model.singer,
                           MPMediaItemPropertyPlaybackDuration : @(self.messageModel.totalTime),
                           MPNowPlayingInfoPropertyElapsedPlaybackTime : @(self.messageModel.costTime),
                           MPMediaItemPropertyArtwork : artWork
                           };
    
    [infoCenter setNowPlayingInfo:dic];
    
    
    //接受远程事件
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
}




- (void)seekToTimeInterval:(NSTimeInterval)timeInterval{
    [self.audioTool seekToTimeInterval:timeInterval];
}









@end
