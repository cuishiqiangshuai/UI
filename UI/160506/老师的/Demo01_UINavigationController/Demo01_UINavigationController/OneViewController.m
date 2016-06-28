//
//  OneViewController.m
//  Demo01_UINavigationController
//
//  Created by qingyun on 16/5/6.
//  Copyright © 2016年 QingYun. All rights reserved.
//

#import "OneViewController.h"

@interface OneViewController ()

@end

@implementation OneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //    UINavigationBar
    //    UIBarButtonItem
    //    UINavigationItem
    //    self.navigationItem.leftBarButtonItem
    //    self.navigationItem.rightBarButtonItem
    //    self.navigationItem.titleView (title)
    
    // 简单的字符串
    UIBarButtonItem *itemLeft1 = [[UIBarButtonItem alloc] initWithTitle:@"点我" style:UIBarButtonItemStylePlain target:self action:@selector(tapAction:)];
    
    // 利用系统自带图标
    UIBarButtonItem *itemLeft2 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCompose target:self action:@selector(composeAction:)];
    
    // 利用简单的图片
    UIBarButtonItem *itemRight1 = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"162U5G14-20"] style:UIBarButtonItemStylePlain target:self action:@selector(tapAction:)];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeContactAdd];
    [button addTarget:self action:@selector(addAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *itemRight2 = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    //self.navigationItem.leftBarButtonItem = itemLeft1;
    self.navigationItem.leftBarButtonItems = @[itemLeft1, itemLeft2];
    self.navigationItem.rightBarButtonItems = @[itemRight1, itemRight2];
}

- (void)tapAction:(UIBarButtonItem *)item {
    NSLog(@"点了- %p", item);
}

- (void)composeAction:(UIBarButtonItem *)item {
    NSLog(@"点了- %p", item);
}

- (void)addAction:(UIButton *)button {
    NSLog(@"addAction- %p", button);
}

@end
