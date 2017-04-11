//
//  SLLrcTool.h
//  SL_QQMusic
//
//  Created by 孙启双 on 2017/3/31.
//  Copyright © 2017年 孙启双. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SLLrcTool : NSObject


/**
 根据歌词文件名,将歌词整合成Model数组

 @param lrcFilename 歌词文件名
 @return 歌词数组
 */
+ (NSMutableArray <SLMusicLrcModel *> *)getLrcListWithFileName:(NSString *)lrcFilename;



/**
 根据数据和歌词数组获取当前是第几行

 @param timeInterval 时间
 @param lrcList 歌词数组
 @return 当前第几行
 */
+ (NSInteger)getCurrentRowWithTimeInterval:(NSTimeInterval)timeInterval InLrcList:(NSMutableArray <SLMusicLrcModel *> *)lrcList;

@end
