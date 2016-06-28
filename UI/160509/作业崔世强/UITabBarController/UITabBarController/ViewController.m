//
//  ViewController.m
//  UITabBarController
//
//  Created by qingyun on 16/5/9.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "ViewController.h"
#import "OneViewController.h"
#import "TwoViewController.h"
#import "ThreeViewController.h"
#import "FourViewController.h"
#import "XCTabBar.h"

@interface ViewController ()<XCTabBarDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor greenColor];
    OneViewController *oneTC=[[OneViewController alloc] init];
    [self viewController:oneTC title:@"首页" imageName:@"tabbar_home" selectedName:@"tabbar_home_selected"];
    
    TwoViewController *twoTC=[[TwoViewController alloc] init];
    [self viewController:twoTC title:@"消息" imageName:@"tabbar_message_center" selectedName:@"tabbar_message_center_selected"];
    
    ThreeViewController *threeTC=[[ThreeViewController alloc] init];
    [self viewController:threeTC title:@"发现" imageName:@"tabbar_discover" selectedName:@"tabbar_discover_selected"];
    
    FourViewController *fourTC=[[FourViewController alloc] init];
    [self viewController:fourTC title:@"我" imageName:@"tabbar_profile" selectedName:@"tabbar_profile_selected"];
    
    
    XCTabBar *tabBar=[XCTabBar new];
    tabBar.clickDelegate=self;
    [self setValue:tabBar forKey:@"tabBar"];
}
-(void)viewController:(UIViewController *)viewController title:(NSString *)title imageName:(NSString *)imageName selectedName:(NSString *)selectedName{
    viewController.tabBarItem.title=title;
    viewController.tabBarItem.image=[UIImage imageNamed:imageName];
    viewController.tabBarItem.selectedImage=[UIImage imageNamed:selectedName];
    NSMutableDictionary *dict=[NSMutableDictionary dictionary];
    [dict setObject:[UIColor orangeColor] forKey:NSForegroundColorAttributeName];
    [dict setObject:[UIFont systemFontOfSize:25] forKey:NSFontAttributeName];
    [viewController.tabBarItem setTitleTextAttributes:dict forState:UIControlStateSelected];
    [self addChildViewController:viewController];
}

- (void)tabBarDidClickedMiddleButton:(XCTabBar *)tabBar {
   
    UIDatePicker *picker = [UIDatePicker new];
    [self.view addSubview:picker];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
