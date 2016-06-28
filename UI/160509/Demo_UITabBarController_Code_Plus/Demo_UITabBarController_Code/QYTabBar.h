//
//  QYTabBar.h
//  Demo_UITabBarController_Code
//
//  Created by qingyun on 16/5/9.
//  Copyright © 2016年 QingYun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QYTabBarDelegate.h"


@interface QYTabBar : UITabBar

@property (nonatomic, weak) id<QYTabBarDelegate> clickDelegate;

@end
