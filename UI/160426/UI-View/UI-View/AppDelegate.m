//
//  AppDelegate.m
//  UI-View
//
//  Created by qingyun on 16/4/26.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // Override point for customization after application launch.
    UIWindow *window=[[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];//获取屏幕的大小赋值给window
    //背景颜色
    window.backgroundColor=[UIColor lightGrayColor];
    window.hidden=NO;
    _window=window;
    //设置window的根视图控制器
    UIViewController *vc=[[UIViewController alloc] init];
    vc.view.backgroundColor=[UIColor darkGrayColor];
    _window.rootViewController=vc;
    
    //添加view1(green)
    UIView *view1=[[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [_window addSubview:view1];
    view1.backgroundColor=[UIColor greenColor];
    //在view1上添加view2(red)
    UIView *view2=[[UIView alloc] initWithFrame:CGRectMake(50,50, 300, 500)];
    [view1 addSubview:view2];
    view2.backgroundColor=[UIColor redColor];
    //view1的透明度
    view1.alpha=0.01;
    view1.hidden=YES;
    //view2的父视图
    NSLog(@"view2.superview：%@",view2.superview);
    
    //在指定的索引除差如视图view3(蓝色)
    UIView *view3=[[UIView alloc] initWithFrame:CGRectMake(20, 20, 250, 250)];
    [view1 insertSubview:view3 atIndex:0];
    view3.backgroundColor=[UIColor blueColor];
    //交换view2和view3
    [view1 exchangeSubviewAtIndex:0 withSubviewAtIndex:1];
    //在view3下方插入view4（橙色）
    UIView *view4=[[UIView alloc] initWithFrame:CGRectMake(10,10,300,300)];
    [view1 insertSubview:view4 belowSubview:view3];
    view3.backgroundColor=[UIColor orangeColor];
    //在view4上方插入view5
    UIView *view5=[[UIView alloc] initWithFrame:CGRectMake(10,5, 320, 320)];
    [view1 insertSubview:view5 aboveSubview:view4];
    return YES;
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
