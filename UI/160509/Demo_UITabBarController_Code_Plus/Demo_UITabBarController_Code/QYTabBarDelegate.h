//
//  QYTabBarDelegate.h
//  Demo_UITabBarController_Code
//
//  Created by qingyun on 16/5/9.
//  Copyright © 2016年 QingYun. All rights reserved.
//


@class QYTabBar;

@protocol QYTabBarDelegate <NSObject>

- (void)tabBarDidClickedMiddleButton:(QYTabBar *)tabBar;

@end

