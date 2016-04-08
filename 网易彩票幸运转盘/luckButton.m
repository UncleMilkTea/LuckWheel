//
//  luckButton.m
//  网易彩票幸运转盘
//
//  Created by 侯玉昆 on 16/2/26.
//  Copyright © 2016年 侯玉昆. All rights reserved.
//

#import "luckButton.h"

@implementation luckButton
- (CGRect)imageRectForContentRect:(CGRect)contentRect{
    
    CGFloat width = 40;
    CGFloat heigth = 47;
    CGFloat x = (contentRect.size.width - width) * 0.5;
    CGFloat y = 20;
    
    return CGRectMake(x, y, width, heigth);
    
}

- (void)setHighlighted:(BOOL)highlighted{
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
