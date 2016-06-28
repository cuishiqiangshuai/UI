//
//  main.m
//  01-HelloWorldDemo
//
//  Created by qingyun on 16/4/26.
//  Copyright © 2016年 QingYun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QYAppDelegate.h"

int main(int argc, char * argv[]) {
    @autoreleasepool {
        //第三个参数是应用程序的类名,nil代表@“UIApplication”,根据类名创建应用程序对象
        //第四个参数是应用程序代理的类名，根据代理类名创建代理对象,把代理对象设置成应用程序的代理
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([QYAppDelegate class]));
    }
}
