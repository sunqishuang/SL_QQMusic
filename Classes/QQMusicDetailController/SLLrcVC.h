//
//  SLLrcVC.h
//  SL_QQMusic
//
//  Created by 孙启双 on 2017/4/4.
//  Copyright © 2017年 孙启双. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SLLrcVC : UITableViewController

/** 当前这首歌的所有歌词数组 */
@property (nonatomic, strong) NSMutableArray <SLMusicLrcModel *>*lrcMs;


@property (nonatomic, assign) NSInteger scrollRow;


@property (nonatomic, assign) float progress;

@end
