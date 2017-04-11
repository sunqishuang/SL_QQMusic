//
//  SLLrcTool.m
//  SL_QQMusic
//
//  Created by 孙启双 on 2017/3/31.
//  Copyright © 2017年 孙启双. All rights reserved.
//

#import "SLLrcTool.h"

@implementation SLLrcTool

+ (NSMutableArray <SLMusicLrcModel *> *)getLrcListWithFileName:(NSString *)lrcFilename{
    //获取歌词文件路径
    NSString *filePath = [[NSBundle mainBundle] pathForResource:lrcFilename ofType:nil];
    
    //获取歌词文件中的内容
    NSString *lrcDataSTring = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    
    //根据换行符对歌词分割
    NSArray *lrcArray = [lrcDataSTring componentsSeparatedByString:@"\n"];
    
    NSMutableArray *lrcTextList = [NSMutableArray array];
    
    
   for (int i = 0 ; i < lrcArray.count; i++) {
        NSString *string = lrcArray[i];
        
         if ([string containsString:@"[ti:]"] || [string containsString:@"[ar:]"] || [string containsString:@"[al:]"] || [string containsString:@""]) {
            continue;
        }
        
        //去掉文本中的中括号"["
        string =   [string stringByReplacingOccurrencesOfString:@"[" withString:@""];
        
        
        
        NSString *text = [[string componentsSeparatedByString:@"]"] lastObject];
        NSString *beginTimeString = [[string componentsSeparatedByString:@"]"] firstObject];
        
        
        

       
       
       SLMusicLrcModel *lrcModel = [SLMusicLrcModel new];
       
       lrcModel.lrcText = text;
       
       
       lrcModel.beginTime = [SLTimeTool getTimeWithTimeString:beginTimeString];
       
       [lrcTextList addObject:lrcModel];
       
        
    }
    
    
    for (int i = 0 ; i < lrcTextList.count; i++) {
        if (i ==  lrcTextList.count - 1) {
            break;
        }
        SLMusicLrcModel *model = lrcTextList[i];
        SLMusicLrcModel *nextModel = lrcTextList[i + 1];
        model.endTime = nextModel.beginTime;
    }
    
    return lrcTextList;
    
}





+ (NSInteger)getCurrentRowWithTimeInterval:(NSTimeInterval)timeInterval InLrcList:(NSMutableArray <SLMusicLrcModel *> *)lrcList{
    
    
    for (int i = 0 ; i < lrcList.count; i++ ) {
        SLMusicLrcModel *lrcModel = lrcList[i];
        
        if (timeInterval >= lrcModel.beginTime && timeInterval < lrcModel.endTime) {
            return i;
        }
    }
    
    return lrcList.count - 1;
    
}

@end
