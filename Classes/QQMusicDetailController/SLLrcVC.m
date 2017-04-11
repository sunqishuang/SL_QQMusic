//
//  SLLrcVC.m
//  SL_QQMusic
//
//  Created by 孙启双 on 2017/4/4.
//  Copyright © 2017年 孙启双. All rights reserved.
//

#import "SLLrcVC.h"

#import "SLLrcCell.h"

@interface SLLrcVC ()

@end

@implementation SLLrcVC

- (void)viewDidLoad{
    [super viewDidLoad];
    
    [self setUpInit];
    
    
}

- (void)setUpInit{
    self.view.backgroundColor = [UIColor clearColor];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
}

- (void)setLrcMs:(NSMutableArray<SLMusicLrcModel *> *)lrcMs{
    _lrcMs = lrcMs;
    [self.tableView reloadData];
}

- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    
    
    self.tableView.contentInset = UIEdgeInsetsMake(self.tableView.height * 0.5, 0, self.tableView.height * 0.5, 0);
    
    
}

- (void)setScrollRow:(NSInteger)scrollRow{
    
    // 过滤垃圾数据
    if (scrollRow < 0 || scrollRow > self.lrcMs.count - 1) {
        return;
    }
    
    if (_scrollRow == scrollRow) {
        return;
    }
    
    _scrollRow = scrollRow;
    NSLog(@"%zd", scrollRow);
    
    
    // 刷新表格
    [self.tableView reloadRowsAtIndexPaths:[self.tableView indexPathsForVisibleRows] withRowAnimation:UITableViewRowAnimationFade];
    
    // 拿到需要滚动的行号, 控制tableview滚动
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:_scrollRow inSection:0];
    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionMiddle animated:YES];

}


-(void)setProgress:(float)progress
{
    _progress = progress;
    
    // 1. 获取已经滚动到的cell
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.scrollRow inSection:0];
    SLLrcCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    
    // 2. 设置进度
    cell.label.progress = progress;
    
    
    
}




- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.lrcMs.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    SLLrcCell *cell = [SLLrcCell cellInstanceForTableView:tableView];
    
    // 取出数据模型
    SLMusicLrcModel *lrcM = self.lrcMs[indexPath.row];
    
    // 赋值
    cell.label.text = lrcM.lrcText;
    
    if (indexPath.row == _scrollRow) {
        cell.label.progress = _progress;
    }else{
        cell.label.progress = 0;
    }
    
    return cell;
    
}



@end
