//
//  ViewController.m
//  Demo03_UINavigationController_Code
//
//  Created by qingyun on 16/5/6.
//  Copyright © 2016年 QingYun. All rights reserved.
//

/** QLDEBUG Print | M:method, L:line, C:content*/
#ifndef QLLog
#ifdef DEBUG
#define QLLog(FORMAT, ...) fprintf(stderr,"M:%s|L:%d|C->%s\n", __FUNCTION__, __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String])
#else
#define QLLog(FORMAT, ...)
#endif
#endif

#import "ViewController.h"
#import "OneViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor orangeColor];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeContactAdd];
    button.center = self.view.center;
    [button addTarget:self action:@selector(tapAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)tapAction:(UIButton *)button {
    QLLog(@"%@", @"");
    OneViewController *vcOne = [OneViewController new];
    [self.navigationController pushViewController:vcOne animated:YES];
}

@end
