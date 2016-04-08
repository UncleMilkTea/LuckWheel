//
//  LuckyView.h
//  网易彩票幸运转盘
//
//  Created by 侯玉昆 on 16/2/25.
//  Copyright © 2016年 侯玉昆. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LuckyView;

@protocol LuckyViewDelegate <NSObject>

- (void)didLuckWheelStopRotate:(LuckyView *)luckView;

@end


@interface LuckyView : UIView

@property(assign,nonatomic) id<LuckyViewDelegate> delegate;

//! 快速创建幸运转盘
+ (instancetype)loadLuckWheelView;

//! 开始旋转
- (void)startRotateWheel;

@end
