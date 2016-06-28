//
//  ViewController.m
//  Demo01_NavigationController
//
//  Created by qingyun on 16/5/9.
//  Copyright © 2016年 QingYun. All rights reserved.
//

#import "ViewController.h"
#import "OneViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    // 1.创建要跳转的控制器
    OneViewController *vcOne = [OneViewController new];
    [self.navigationController pushViewController:vcOne animated:YES];
}

@end
