//
//  ViewController.m
//  03-LayoutAnimation
//
//  Created by qingyun on 16/5/21.
//  Copyright © 2016年 QingYun. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topConstraint;         //视图顶部约束
@property (nonatomic)       BOOL isDown;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)move:(UIButton *)sender {
    if (_isDown) {
        //向上滚动
        [self changeConstraintWithValue:-220];
    }else{
        //向下滚动
        [self changeConstraintWithValue:0];
    }
    _isDown = !_isDown;
}

-(void)changeConstraintWithValue:(CGFloat)value{
    
    _topConstraint.constant = value;
    
    UIView *superView = self.view;
//    [UIView animateWithDuration:0.5 animations:^{
//        //强制更新约束
//        [superView layoutIfNeeded];
//    }];
    
    //阻尼动画
    //Damping:阻尼系数(0-1.0,越小弹簧效果越明显)
    //Velocity:动画初始速度(假如,动画总距离是200,每秒移动100,Velocity = 100 / 200)
    [UIView animateWithDuration:0.25 delay:0 usingSpringWithDamping:0.15 initialSpringVelocity:1.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        [superView layoutIfNeeded];
    } completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
