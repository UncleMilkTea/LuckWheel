//
//  LuckyView.m
//  网易彩票幸运转盘
//
//  Created by 侯玉昆 on 16/2/25.
//  Copyright © 2016年 侯玉昆. All rights reserved.
//

#import "LuckyView.h"
#import "luckButton.h"

@interface LuckyView ()

@property (weak, nonatomic) IBOutlet UIButton *startButton;

@property (weak, nonatomic) IBOutlet UIImageView *luckWheeel;

@property(strong,nonatomic) UIButton *selectBtn;

@property(strong,nonatomic) CADisplayLink *link;

@end

@implementation LuckyView


+ (instancetype)loadLuckWheelView{

    return [[NSBundle mainBundle] loadNibNamed:@"LuckyView" owner:nil options:nil].lastObject;
}

//! 实例化控件
- (void)awakeFromNib {
    
    for (int i=0; i<12; i++) {
       
        
        luckButton *button = [luckButton buttonWithType:UIButtonTypeCustom];
        
        [button setBackgroundImage:[UIImage imageNamed:@"LuckyRototeSelected"] forState:UIControlStateSelected];
        
        [button setImage:[self clipImage:[UIImage imageNamed:@"LuckyAstrology"] andIndex:i] forState:UIControlStateNormal];
        
        [button setImage:[self clipImage:[UIImage imageNamed:@"LuckyAstrologyPressed"] andIndex:i] forState:UIControlStateSelected];

        [self.luckWheeel addSubview:button]; button.tag = i;
        
        [button addTarget:self action:@selector(changeSelect:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    
    
    
}

- (void)changeSelect:(UIButton *)sender{

    self.selectBtn.selected = NO;
    
    sender.selected = YES;
    
    self.selectBtn = sender;

}



- (UIImage *)clipImage:(UIImage *)image andIndex:(NSInteger)index{
    
    CGFloat w = image.size.width/12;
    
    CGFloat h = image.size.height;
    
    CGFloat x = w*index;
    
    CGFloat y = 0;
    
    w *= [UIScreen mainScreen].scale;
    h *= [UIScreen mainScreen].scale;
    x *= [UIScreen mainScreen].scale;
    y *= [UIScreen mainScreen].scale;
    
    CGImageRef cgImg = CGImageCreateWithImageInRect(image.CGImage, CGRectMake(x, y, w, h));
    
    UIImage *clipimg = [UIImage imageWithCGImage:cgImg];
    
    CGImageRelease(cgImg);
    
    return clipimg;
    
}

//! 布局控件
- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    CGFloat w = 68;
    
    CGFloat h = 143;
    
    CGFloat angle = M_PI *2 /12;
    
    NSLog(@"%zd",self.luckWheeel.subviews.count);
    
    [self.luckWheeel.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
//        obj.frame = CGRectMake(self.bounds.size.width/2, self.bounds.size.height/2, w, h);
        
        obj.center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
        
        obj.bounds = CGRectMake(0, 0, w, h);
        
        obj.layer.anchorPoint = CGPointMake(.5, 1);
        
        obj.transform = CGAffineTransformMakeRotation(angle*idx);
        
    }];
    
    
    
    
}










- (void)startRotateWheel {
    
    _link = [CADisplayLink displayLinkWithTarget:self selector:@selector(luckWheeelRotate)];
    
    [_link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)luckWheeelRotate{
    
    self.luckWheeel.transform = CGAffineTransformRotate(self.luckWheeel.transform, M_PI_4*0.01);
    
}

- (IBAction)clickStartButton:(UIButton *)sender {
    
    
    //停止转动
    
    [_link invalidate];
    
    _link= nil;
    
    self.userInteractionEnabled = NO;
    
    //创建核心动画
    CABasicAnimation *amin = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    //计算偏移角度
    CGFloat angle = _selectBtn.tag*(M_PI * 2/12);
    
    amin.toValue = @(7*2 *M_PI - angle);
    
    amin.duration = 3;
    
    amin.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    amin.delegate = self;
    //将核心动画加载
    
    [self.luckWheeel.layer addAnimation:amin forKey:nil];
    
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    
    
    CGFloat angle = self.selectBtn.tag *(M_PI*2/12);
    
    self.luckWheeel.transform = CGAffineTransformMakeRotation(-angle);
    
//    self.userInteractionEnabled = YES;
    
    
    if ([self.delegate respondsToSelector:@selector(didLuckWheelStopRotate:)]) {
        
        [self.delegate didLuckWheelStopRotate:self];
    }
    
    
    
    
    
    
    
    
    
}

@end
