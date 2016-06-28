//
//  UItabBar.h
//  UITabBarController
//
//  Created by qingyun on 16/5/9.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DaiLi.h"

@interface XCTabBar : UITabBar
@property (nonatomic, weak) id<XCTabBarDelegate> clickDelegate;
@end
