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
#import "QYTabBar.h"

@interface ViewController () <QYTabBarDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 用在什么地方:
    //[button addTarget:<#(nullable id)#> action:<#(nonnull SEL)#> forControlEvents:<#(UIControlEvents)#>];
    
    self.view.backgroundColor = [UIColor orangeColor];
    
    // 创建要管理的控制器
    OneViewController *vcOne = [OneViewController new];
    [self viewController:vcOne title:@"首页" imageName:@"tabbar_home" selecedImageName:@"tabbar_home_selected"];
    
    TwoViewController *vcTwo = [TwoViewController new];
    [self viewController:vcTwo title:@"消息" imageName:@"tabbar_message_center" selecedImageName:@"tabbar_message_center_selected"];
    
    ThreeViewController *vcThree = [ThreeViewController new];
    [self viewController:vcThree title:@"发现" imageName:@"tabbar_discover" selecedImageName:@"tabbar_discover_selected"];
    
    FourViewController *vcFour = [FourViewController new];
    [self viewController:vcFour title:@"我" imageName:@"tabbar_profile" selecedImageName:@"tabbar_profile_selected"];
    
    // 修改TabBar子视图的位置
    
    QLLog(@"%@", self.tabBar);
    
    //self.tabBar = [QYTabBar new];
    QYTabBar *tabBar = [QYTabBar new];
    tabBar.clickDelegate = self;
    // KVC
    [self setValue:tabBar forKey:@"tabBar"];
    
    QLLog(@"%@", self.tabBar);
}

- (void)viewController:(UIViewController *)viewController title:(NSString *)title imageName:(NSString *)imageName selecedImageName:(NSString *)selecedImageName  {
    viewController.tabBarItem.title = title;
    viewController.tabBarItem.image = [UIImage imageNamed:imageName];
    viewController.tabBarItem.selectedImage = [UIImage imageNamed:selecedImageName];
    NSMutableDictionary *att = [NSMutableDictionary dictionary];
    [att setObject:[UIColor orangeColor] forKey:NSForegroundColorAttributeName];
    //[att setObject:[UIFont systemFontOfSize:17] forKey:NSFontAttributeName];
    [viewController.tabBarItem setTitleTextAttributes:att forState:UIControlStateSelected];
    // 添加到子控制器里
    [self addChildViewController:viewController];
    
    //UITabBarButton: 是一个私有的API
    
}

#pragma mark - QYTabBarDelegate
- (void)tabBarDidClickedMiddleButton:(QYTabBar *)tabBar {
    QLLog(@"%@", @"");
//    UIViewController *vc = [UIViewController new];
//    vc.view.backgroundColor = [UIColor orangeColor];
//    [self presentViewController:vc animated:YES completion:nil];
    UIDatePicker *picker = [UIDatePicker new];
    [self.view addSubview:picker];
    
}

@end
