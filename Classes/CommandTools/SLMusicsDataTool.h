//
//  SLMusicsDataTool.h
//  SL_QQMusic
//
//  Created by 孙启双 on 2017/3/31.
//  Copyright © 2017年 孙启双. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SLMusicsDataTool : NSObject



/**
 从Musics.plist文件中拿到所有歌曲信息

 @return 所有的歌曲model数组
 */
+ (  NSMutableArray <SLMusicModel *> *) getAllMusicsData;

@end
