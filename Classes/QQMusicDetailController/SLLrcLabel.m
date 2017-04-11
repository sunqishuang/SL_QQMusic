//
//  SLLrcLabel.m
//  SL_QQMusic
//
//  Created by 孙启双 on 2017/4/10.
//  Copyright © 2017年 孙启双. All rights reserved.
//

#import "SLLrcLabel.h"

@implementation SLLrcLabel

- (void)setProgress:(CGFloat)progress{
    _progress = progress;
    
    [self setNeedsDisplay];
}


- (void)drawRect:(CGRect)rect{
    
    [super drawRect:rect];
    
    [[UIColor greenColor] set];
    
    CGRect fillrect = CGRectMake(0, 0, self.bounds.size.width * _progress, self.bounds.size.height);
    
    UIRectFillUsingBlendMode(fillrect, kCGBlendModeSourceIn);
}

@end
