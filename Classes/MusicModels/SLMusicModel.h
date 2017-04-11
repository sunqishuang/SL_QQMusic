//
//  SLMusicModel.h
//  SL_QQMusic
//
//  Created by 孙启双 on 2017/3/31.
//  Copyright © 2017年 孙启双. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SLMusicModel : NSObject


/** 歌曲名称 */
@property (nonatomic, copy) NSString *name;

/** 歌曲文件名称 */
@property (nonatomic, copy) NSString * filename;

/** 歌词文件名称  */
@property (nonatomic, copy) NSString * lrcname;

/** 歌手名称 */
@property (nonatomic, copy) NSString * singer;

/** 歌手头像 */
@property (nonatomic, copy) NSString * singerIcon;

/** 歌曲主图 */
@property (nonatomic, copy) NSString * icon;

@end
