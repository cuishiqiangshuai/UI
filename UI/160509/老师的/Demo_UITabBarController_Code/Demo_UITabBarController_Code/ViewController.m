//
//  ViewController.m
//  Demo_UITabBarController_Code
//
//  Created by qingyun on 16/5/9.
//  Copyright © 2016年 QingYun. All rights reserved.
//

#define QYColor(R, G, B) [UIColor colorWithRed:(R)/255.0 green:(G)/255.0 blue:(B)/255.0 alpha:1.0]

#import "ViewController.h"
#import "OneViewController.h"
#import "TwoViewController.h"
#import "ThreeViewController.h"
#import "FourViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor orangeColor];
    
    // 颜色 0~255
    // 24色: RGB
    // 32色: ARGB
    
    // 创建要管理的控制器
    OneViewController *vcOne = [OneViewController new];
    [self viewController:vcOne title:@"首页" imageName:@"tabbar_home" selecedImageName:@"tabbar_home_selected"];
    
    TwoViewController *vcTwo = [TwoViewController new];
    [self viewController:vcTwo title:@"消息" imageName:@"tabbar_message_center" selecedImageName:@"tabbar_message_center_selected"];
    
    ThreeViewController *vcThree = [ThreeViewController new];
    [self viewController:vcThree title:@"发现" imageName:@"tabbar_discover" selecedImageName:@"tabbar_discover_selected"];
    
    FourViewController *vcFour = [FourViewController new];
    [self viewController:vcFour title:@"我" imageName:@"tabbar_profile" selecedImageName:@"tabbar_profile_selected"];
    
//    self.tabBar.alpha = 1.0;
//    self.tabBar.tintColor = [UIColor orangeColor];
    
    // 把创建好的控制器添加到TabBarController中管理
    // 1, 方式1
    //self.viewControllers = @[vcOne, vcTwo, vcThree, vcFour];
    // 2, 方式2
    //[self addChildViewController:vcOne];
    //[self addChildViewController:vcTwo];
    //[self addChildViewController:vcThree];
    //[self addChildViewController:vcFour];
}

- (void)viewController:(UIViewController *)viewController title:(NSString *)title imageName:(NSString *)imageName selecedImageName:(NSString *)selecedImageName  {
    viewController.tabBarItem.title = title;
    viewController.tabBarItem.image = [UIImage imageNamed:imageName];
    viewController.tabBarItem.selectedImage = [UIImage imageNamed:selecedImageName];
    NSMutableDictionary *att = [NSMutableDictionary dictionary];
    [att setObject:[UIColor orangeColor] forKey:NSForegroundColorAttributeName];
    //[att setObject:[UIFont systemFontOfSize:17] forKey:NSFontAttributeName];
    [viewController.tabBarItem setTitleTextAttributes:att forState:UIControlStateSelected];
    [self addChildViewController:viewController];
}

@end
