//
//  SLMusicListCell.m
//  SL_QQMusic
//
//  Created by 孙启双 on 2017/3/31.
//  Copyright © 2017年 孙启双. All rights reserved.
//

#import "SLMusicListCell.h"

@interface SLMusicListCell ()

@property (nonatomic, strong) UIImageView *iconImageView;

@property (nonatomic, strong) UILabel *musicNameLabel;

@property (nonatomic, strong) UILabel *singerNameLabel;

@end

@implementation SLMusicListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}



+ (instancetype)listCellInstanceWithTableView:(UITableView *)tableView{
    static NSString *identify = @"listCell";
    SLMusicListCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.contentView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0];
        cell.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0];
    }
    
    return cell;
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initUI];
    }
    return self;
}



- (void)initUI{
    self.iconImageView = [UIImageView new];
    self.musicNameLabel = [UILabel new];
    self.singerNameLabel = [UILabel new];
    [self.contentView addSubview:self.iconImageView];
    [self.contentView addSubview:self.musicNameLabel];
    [self.contentView addSubview:self.singerNameLabel];
    
    
    self.iconImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.iconImageView.layer.cornerRadius = 30;
    self.iconImageView.clipsToBounds = YES;
    self.musicNameLabel.textColor = [UIColor whiteColor];
    self.singerNameLabel.textColor = [UIColor whiteColor];
    
    
    self.iconImageView.sd_layout.leftSpaceToView(self.contentView, 18).bottomSpaceToView(self.contentView, 5).topSpaceToView(self.contentView, 5).widthEqualToHeight();
    
    self.musicNameLabel.sd_layout.leftSpaceToView(self.iconImageView, 8).topEqualToView(self.iconImageView).rightSpaceToView(self.contentView, 18).heightIs(20);
    
    self.singerNameLabel.sd_layout.leftEqualToView(self.musicNameLabel).bottomEqualToView(self.iconImageView).rightEqualToView(self.musicNameLabel).heightIs(20);
    
}




- (void)setMusicModel:(SLMusicModel *)musicModel{
    _musicModel = musicModel;
    
    self.iconImageView.image = [UIImage imageNamed:musicModel.singerIcon];
    self.musicNameLabel.text = musicModel.name;
    self.singerNameLabel.text = musicModel.singer;
    
    
}


@end
