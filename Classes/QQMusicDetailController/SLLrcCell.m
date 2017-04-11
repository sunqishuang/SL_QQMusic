//
//  SLLrcCell.m
//  SL_QQMusic
//
//  Created by 孙启双 on 2017/4/10.
//  Copyright © 2017年 孙启双. All rights reserved.
//

#import "SLLrcCell.h"

@implementation SLLrcCell


+ (instancetype)cellInstanceForTableView:(UITableView *)tableView{
    static NSString *cellId = @"SLLrcCell";
    
    SLLrcCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if (!cell) {
        cell = [[SLLrcCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUpInit];
    }
    return self;
}

- (void)setUpInit{
    _label = [[SLLrcLabel alloc] init];
    _label.textAlignment = NSTextAlignmentCenter;
    _label.textColor = [UIColor whiteColor];
    [self.contentView addSubview:_label];
    
    _label.sd_layout.leftSpaceToView(self.contentView, 18).rightSpaceToView(self.contentView, 18)
    .topSpaceToView(self.contentView, 5).bottomSpaceToView(self.contentView, 5);
    
    self.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor clearColor];
    self.label.backgroundColor = [UIColor clearColor];
    
}





- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
