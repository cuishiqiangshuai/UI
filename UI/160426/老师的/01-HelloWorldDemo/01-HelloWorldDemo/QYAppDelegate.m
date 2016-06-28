//
//  AppDelegate.m
//  01-HelloWorldDemo
//
//  Created by qingyun on 16/4/26.
//  Copyright © 2016年 QingYun. All rights reserved.
//

#import "QYAppDelegate.h"

@interface QYAppDelegate ()

@end

@implementation QYAppDelegate

- (BOOL)application:(UIApplication *)application willFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    NSLog(@"%ld,%s",application.applicationState,__func__);
    return YES;
}

//应用程序准备工作完毕，开始显示界面前最后一个方法（对应用添加新功能，比如：推送）
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
     NSLog(@"%ld,%s",application.applicationState,__func__);
    NSLog(@"_window:%@",_window);
    NSLog(@"rootViewController:%@",_window.rootViewController);
    
    return YES;
}

//将要进入未激活状态
- (void)applicationWillResignActive:(UIApplication *)application {
    NSLog(@"%ld,%s",application.applicationState,__func__);
}
//已经计入后台
- (void)applicationDidEnterBackground:(UIApplication *)application {
    NSLog(@"%ld,%s",application.applicationState,__func__);
}
//将要进入前台
- (void)applicationWillEnterForeground:(UIApplication *)application {
    NSLog(@"%ld,%s",application.applicationState,__func__);
}
//已经进入激活状态
- (void)applicationDidBecomeActive:(UIApplication *)application {
    NSLog(@"%ld,%s",application.applicationState,__func__);
    NSLog(@"subviews:%@",_window.subviews);
}
//将要退出应用程序
- (void)applicationWillTerminate:(UIApplication *)application {
    NSLog(@"%ld,%s",application.applicationState,__func__);
}

@end
