//
//  SLMusicListCell.h
//  SL_QQMusic
//
//  Created by 孙启双 on 2017/3/31.
//  Copyright © 2017年 孙启双. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SLMusicListCell : UITableViewCell

/** 歌曲Model  */
@property (nonatomic, strong) SLMusicModel *musicModel;


+ (instancetype)listCellInstanceWithTableView:(UITableView *)tableView;
@end
