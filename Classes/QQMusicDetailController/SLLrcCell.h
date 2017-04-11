//
//  SLLrcCell.h
//  SL_QQMusic
//
//  Created by 孙启双 on 2017/4/10.
//  Copyright © 2017年 孙启双. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SLLrcCell : UITableViewCell

/**   */
@property (nonatomic, strong) SLLrcLabel *label;

+ (instancetype)cellInstanceForTableView:(UITableView *)tableView;

@end
