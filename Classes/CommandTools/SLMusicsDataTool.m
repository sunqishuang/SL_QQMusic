//
//  SLMusicsDataTool.m
//  SL_QQMusic
//
//  Created by 孙启双 on 2017/3/31.
//  Copyright © 2017年 孙启双. All rights reserved.
//

#import "SLMusicsDataTool.h"

@implementation SLMusicsDataTool

+ (  NSMutableArray <SLMusicModel *> *) getAllMusicsData{
    
   return  [SLMusicModel mj_objectArrayWithFilename:@"Musics.plist"];

}


@end
