//
//  SLQQMusicDetailViewController.m
//  SL_QQMusic
//
//  Created by 孙启双 on 2017/3/31.
//  Copyright © 2017年 孙启双. All rights reserved.
//

#import "SLQQMusicDetailViewController.h"

@interface SLQQMusicDetailViewController ()<UIScrollViewDelegate>


@property (weak, nonatomic) IBOutlet UILabel *musciNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *singerNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *startTimeLabel;

@property (weak, nonatomic) IBOutlet UILabel *endTimeLabel;

@property (weak, nonatomic) IBOutlet UISlider *progessSlider;

@property (weak, nonatomic) IBOutlet UIImageView *mainImageView;

@property (weak, nonatomic) IBOutlet UIScrollView *lrcScrollView;

@property (weak, nonatomic) IBOutlet SLLrcLabel *lrcLabel;

@property (weak, nonatomic) IBOutlet UIImageView *bgMainImageView;

@property (weak, nonatomic) IBOutlet UIButton *pauseButton;

/**  歌词VC */
@property (nonatomic, strong) SLLrcVC *lrcVC;

/**  多次刷新界面的timer */
@property (nonatomic, strong) NSTimer *updateTimer;

@property (nonatomic, strong) CADisplayLink *displayLink;






@end

@implementation SLQQMusicDetailViewController


- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupInit];



}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self setUpOnce];
    
    

    [self updateTimer];
    [self displayLink];
    
    
}


- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    
    
}


- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    
    self.lrcVC.tableView.frame = self.lrcScrollView.bounds;
    self.lrcVC.tableView.x = self.lrcScrollView.width;
    
    self.lrcScrollView.contentSize = CGSizeMake(self.lrcScrollView.width * 2, 0);
    
    self.mainImageView.layer.cornerRadius = self.mainImageView.width/2.0;
    self.mainImageView.layer.masksToBounds = YES;
}

#pragma mark -----------------------------------------------    只执行一次的代码



//只初始化一次
- (void)setupInit{
    [self.lrcScrollView addSubview:self.lrcVC.tableView];
    
    self.lrcScrollView.pagingEnabled = YES;
    self.lrcScrollView.showsHorizontalScrollIndicator = NO;
    self.lrcScrollView.delegate = self;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(nextMusic) name:kNotificationPlayFinish object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(phoneCall:) name:AVAudioSessionInterruptionNotification object:nil];
    
    
    
    
}



/**
 播放完一首音乐后,播放下一首
 */
- (void)nextMusic{
    [[SLMusicOperationTool sharedSLMusicOperationTool] nextMusic];
    
    [self setUpOnce];
}



/**
 来电话时,让音乐暂停,通话结束,音乐继续播放
 */
- (void)phoneCall:(NSNotification *)notify{
    
    NSString *type = [NSString stringWithFormat:@"%@",notify.userInfo[AVAudioSessionInterruptionTypeKey]];
    
    if ( [type isEqualToString:@"1"]) {
         //电话呼入,系统会自动暂停音乐播放,无须处理
    }else if ([type isEqualToString:@"0"]){
        //通话结束,或者通话关闭,需要手动开启音乐
        self.pauseButton.selected = NO;
        [self puaseButtonClick:self.pauseButton];
        
    }
    NSLog(@"收到通知电话....%@",
          notify.userInfo);
    
}

- (SLLrcVC *)lrcVC{
    if (!_lrcVC) {
        _lrcVC = [[SLLrcVC alloc] init];
        [self addChildViewController:_lrcVC];
    }
    return _lrcVC;
}


/**
 每次进入界面设置,或者播放新歌曲的时候设置
 */
- (void)setUpOnce{
    SLMusicMessageModel *messageModel = [SLMusicOperationTool sharedSLMusicOperationTool].messageModel;
    
    //大背景图
    self.bgMainImageView.image = [UIImage imageNamed:messageModel.model.icon];
    //歌曲icon
    self.mainImageView.image = [UIImage imageNamed:messageModel.model.icon];
    
    //在此处, 获取歌曲总时长, 并且转换成分秒格式: 00:00
    
    self.endTimeLabel.text = [SLTimeTool getTimeStringWithTimeinterval:messageModel.totalTime];

    //歌曲名称
    self.musciNameLabel.text = messageModel.model.name;
    //歌手姓名
    self.singerNameLabel.text = messageModel.model.singer;
    
    self.pauseButton.selected = YES;
    
    self.lrcVC.lrcMs = [SLLrcTool getLrcListWithFileName:messageModel.model.lrcname];
    
}


- (NSTimer *)updateTimer{
    if (!_updateTimer) {
        MJweakSelf
        _updateTimer = [NSTimer timerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
            
            SLMusicMessageModel *messageModel =  [SLMusicOperationTool sharedSLMusicOperationTool].messageModel;
            
            weakSelf.startTimeLabel.text = [SLTimeTool getTimeStringWithTimeinterval:messageModel.costTime];
            weakSelf.progessSlider.value = (float)(messageModel.costTime * 1.0)/messageModel.totalTime;
       
            weakSelf.pauseButton.selected = messageModel.isPlaying;
        }];
        
        [[NSRunLoop currentRunLoop] addTimer:_updateTimer forMode:NSRunLoopCommonModes];
        

    }
    return _updateTimer;
}


- (CADisplayLink *)displayLink{
    if (!_displayLink) {
        _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(displayLinkClick)];
    
        [_displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
        

    }
    return _displayLink;
}

#pragma mark -----------------------------------------------  执行多次的代码
- (void)displayLinkClick{
  
    SLMusicMessageModel *messageModel = [SLMusicOperationTool sharedSLMusicOperationTool].messageModel;
    
    NSInteger row = [SLLrcTool getCurrentRowWithTimeInterval:messageModel.costTime InLrcList:self.lrcVC.lrcMs];
    
    
    SLMusicLrcModel *lrcModel = self.lrcVC.lrcMs[row];
    
    
    _lrcLabel.text = lrcModel.lrcText;
    
    self.lrcLabel.progress = (float)((messageModel.costTime - lrcModel.beginTime) * 1.0)/(lrcModel.endTime - lrcModel.beginTime);
    
    
    //更新锁屏信息
    [[SLMusicOperationTool sharedSLMusicOperationTool] updateLockScreenMessage];
    
    _lrcVC.scrollRow = row;
    
    self.lrcVC.progress = self.lrcLabel.progress;
    
    
}




#pragma mark ----------------------------------------------- ButtonClick


- (IBAction)backButtonClick:(UIButton *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (IBAction)sandianButtonClick:(id)sender {
    
    
    
}


/**
 手指按下
 */
- (IBAction)touchDown:(id)sender {
    self.updateTimer = nil;
    [self.updateTimer invalidate];
    
}


- (IBAction)progressSliderChanged:(UISlider *)sender {
    
    NSTimeInterval time = sender.value * [SLMusicOperationTool sharedSLMusicOperationTool].messageModel.totalTime;

    self.startTimeLabel.text = [SLTimeTool getTimeStringWithTimeinterval:time];
    
    
    
}

/**
 手指离开
 */
- (IBAction)touchUp:(UISlider *)sender {
    NSTimeInterval time = sender.value * [SLMusicOperationTool sharedSLMusicOperationTool].messageModel.totalTime;
    
    [[SLMusicOperationTool sharedSLMusicOperationTool] seekToTimeInterval:time];
    
    [self updateTimer];
    
}



- (IBAction)lastMusicButtonClick:(UIButton *)sender {
    [[SLMusicOperationTool sharedSLMusicOperationTool] preMusic];
    
    [self setUpOnce];
}


- (IBAction)nextMusicButtonClick:(UIButton *)sender {
    
    [[SLMusicOperationTool sharedSLMusicOperationTool] nextMusic];
    
    [self setUpOnce];

}



- (IBAction)puaseButtonClick:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected) {
         //播放歌曲
        
        [[SLMusicOperationTool sharedSLMusicOperationTool] playCurrentMusic];
    }else{
        //暂停歌曲
        
         [[SLMusicOperationTool sharedSLMusicOperationTool] pauseCurrentMusic];
    }
    
    
}


#pragma mark ----------------------------------------------- UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 1. 获取透明度比例
    float radio = 1 - scrollView.contentOffset.x / scrollView.width;
    
    // 2. 设置透明度
    self.mainImageView.alpha = radio;
    self.lrcLabel.alpha = radio;
}

- (void)remoteControlReceivedWithEvent:(UIEvent *)event{
    switch (event.subtype) {
        case UIEventSubtypeRemoteControlPlay:
        {
            [[SLMusicOperationTool sharedSLMusicOperationTool] playCurrentMusic];
            break;
        }
        case UIEventSubtypeRemoteControlPause:
        {
            [[SLMusicOperationTool sharedSLMusicOperationTool] pauseCurrentMusic];
            break;
        }
        case UIEventSubtypeRemoteControlNextTrack:
        {
            [[SLMusicOperationTool sharedSLMusicOperationTool] nextMusic];
            break;
        }
        case UIEventSubtypeRemoteControlPreviousTrack:
        {
            [[SLMusicOperationTool sharedSLMusicOperationTool] preMusic];
            break;
        }
            
        default:
            break;
    }
    
    [self setUpOnce];
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event{
    [[SLMusicOperationTool sharedSLMusicOperationTool] nextMusic];
    
    [self setUpOnce];
}



@end
