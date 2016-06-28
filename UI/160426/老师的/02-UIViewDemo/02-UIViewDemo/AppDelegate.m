//
//  AppDelegate.m
//  02-UIViewDemo
//
//  Created by qingyun on 16/4/26.
//  Copyright © 2016年 QingYun. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    UIWindow *window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    //背景颜色
    window.backgroundColor = [UIColor lightGrayColor];
    window.hidden = NO;
    _window = window;
    
    //设置window的根视图控制器
    UIViewController *vc = [[UIViewController alloc] init];
    vc.view.backgroundColor = [UIColor darkGrayColor];
    _window.rootViewController = vc;

    //添加viewA (green)
    UIView *viewA = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [_window addSubview:viewA];
    viewA.backgroundColor = [UIColor greenColor];
    
    //在viewA上添加viewB (红色)
    UIView *viewB = [[UIView alloc] initWithFrame:CGRectMake(50, 50, 300, 500)];
    [viewA addSubview:viewB];
    viewB.backgroundColor = [UIColor redColor];
    
    //viewA的透明度
    //viewA.alpha = 0.01;
    //hidden
    //viewA.hidden = YES;
    //viewB的父视图
    //NSLog(@"viewB.superview:%@",viewB.superview);
    //在指定的索引处插入视图viewC（蓝色）
    UIView *viewC = [[UIView alloc] initWithFrame:CGRectMake(20, 20, 250, 250)];
    [viewA insertSubview:viewC atIndex:0];
    viewC.backgroundColor = [UIColor blueColor];
    //交换viewB和viewC
    [viewA exchangeSubviewAtIndex:0 withSubviewAtIndex:1];
    //在viewC下方插入viewD(橙色)
    UIView *viewD = [[UIView alloc] initWithFrame:CGRectMake(10, 10, 300, 300)];
    [viewA insertSubview:viewD belowSubview:viewC];
    viewD.backgroundColor = [UIColor orangeColor];
    //在viewB上方插入viewE （紫色）
    UIView *viewE = [[UIView alloc] initWithFrame:CGRectMake(10, 5, 320, 320)];
    [viewA insertSubview:viewE aboveSubview:viewB];
    viewE.backgroundColor = [UIColor purpleColor];
    
    //把viewB置顶
    [viewA bringSubviewToFront:viewB];
    //把viewB置底
    [viewA sendSubviewToBack:viewB];
    
    //对viewB设置tag为101
    viewB.tag = 101;
    
    //把viewB从父视图中移除
    //[viewB removeFromSuperview];
    UIView *view101 = [viewA viewWithTag:101];
    [view101 removeFromSuperview];
    
    //在viewA上添加tap手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [viewA addGestureRecognizer:tap];
    //是否允许与用户交互
    viewA.userInteractionEnabled = NO;
    
    
    return YES;
}

-(void)tap:(UITapGestureRecognizer *)tap{
    NSLog(@"viewA.subviews:%@",tap.view.subviews);
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
