//
//  ViewController.m
//  网易彩票幸运转盘
//
//  Created by 侯玉昆 on 16/2/25.
//  Copyright © 2016年 侯玉昆. All rights reserved.
//

#import "ViewController.h"
#import "LuckyView.h"

@interface ViewController ()<LuckyViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    LuckyView *luckView = [LuckyView loadLuckWheelView];
    
    luckView.center = self.view.center;
    
    luckView.delegate = self;
    
    [self.view addSubview:luckView];
    
    [luckView startRotateWheel];
    
    
    
    
}

- (void)didLuckWheelStopRotate:(LuckyView *)luckView{
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"您的中奖号码为" message:@"1-2-3-4-5-6-7" preferredStyle:UIAlertControllerStyleAlert];
        
//        UIAlertAction *sure = [UIAlertAction actionWithTitle:@"" style:UIAlertActionStyleDefault handler:nil];
        
        UIAlertAction *canle = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
        
        
        [ac addAction:canle];
        
        [self presentViewController:ac animated:YES completion:^{
            
            
            luckView.userInteractionEnabled = YES;
            
            [luckView startRotateWheel];
            
        } ];      
        
    });
    
    
}

@end
