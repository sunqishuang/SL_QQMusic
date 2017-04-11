//
//  SLQQMusicListViewController.m
//  SL_QQMusic
//
//  Created by 孙启双 on 2017/3/31.
//  Copyright © 2017年 孙启双. All rights reserved.
//

#import "SLQQMusicListViewController.h"
#import "SLMusicListCell.h"
#import "SLQQMusicDetailViewController.h"

@interface SLQQMusicListViewController ()<UITableViewDelegate,UITableViewDataSource>

/** 表 */
@property (nonatomic, strong) UITableView *tableView;

/** 数据源数组 */
@property (nonatomic, strong) NSMutableArray <SLMusicModel *> *dataArray;

@end

@implementation SLQQMusicListViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initUIWithMusicListVC];


}


#pragma mark ----------------------------------------------- 创建子视图
- (void)initUIWithMusicListVC{
    self.navigationController.navigationBarHidden = YES;
    [self.view addSubview:self.tableView];
    
}


- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, K_Width, K_Height) style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.rowHeight = 70;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        UIImageView *imgView =   [[UIImageView alloc] initWithFrame:self.view.bounds];
        imgView.image = [UIImage imageNamed:@"QQListBack"];
        _tableView.backgroundView = imgView;
    }
    return _tableView;
}

- (NSMutableArray<SLMusicModel *> *)dataArray{
    if (!_dataArray) {
        _dataArray = [SLMusicsDataTool getAllMusicsData];
        [SLMusicOperationTool sharedSLMusicOperationTool].musicDataArray = _dataArray;
    }
    return _dataArray;
}


- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SLMusicListCell *cell = [SLMusicListCell listCellInstanceWithTableView:tableView];
    cell.musicModel = self.dataArray[indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //点击播放歌曲
    SLMusicModel *musicModel = self.dataArray[indexPath.row];
    
    [[SLMusicOperationTool sharedSLMusicOperationTool] playMusic:musicModel];
    
    [self.navigationController pushViewController:[[SLQQMusicDetailViewController alloc] init] animated:YES];

    
}










@end
