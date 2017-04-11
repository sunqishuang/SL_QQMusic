//
//  UIImage+Extension.m
//  QQ音乐
//
//  Created by 1 on 15/12/19.
//  Copyright © 2015年 小码哥. All rights reserved.
//

#import "UIImage+Extension.h"

@implementation UIImage (Extension)

- (UIImage *)createNewImageWithText:(NSString *)str
{
    // 1. 开启上下文
    UIGraphicsBeginImageContext(self.size);
    
    // 2. 绘制源图片
    [self drawInRect:CGRectMake(0, 0, self.size.width, self.size.height)];
    
    // 3. 绘制文字
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.alignment = NSTextAlignmentCenter;
    NSDictionary *dic = @{
                          NSForegroundColorAttributeName : [UIColor whiteColor],
                          NSFontAttributeName : [UIFont systemFontOfSize:26],
                          NSParagraphStyleAttributeName :  style
                          
                          };
    [str drawInRect:CGRectMake(0, 0, self.size.width, 30) withAttributes:dic];
    
    
    // 4. 生成一个新图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    
    // 5. 关闭上下文
    UIGraphicsEndImageContext();
    
    // 6. 返回新图片
    return image;
    
    
    
    
}


@end
