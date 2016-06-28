//
//  QYTabBar.m
//  Demo_UITabBarController_Code
//
//  Created by qingyun on 16/5/9.
//  Copyright © 2016年 QingYun. All rights reserved.
//

#import "QYTabBar.h"

@implementation QYTabBar

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self loadDefaultSetting];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self loadDefaultSetting];
    }
    return self;
}

/** Load the default UI elements And prepare some datas needed. */
- (void)loadDefaultSetting {
    UIButton *btnPlus = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnPlus setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
    [btnPlus setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button"] forState:UIControlStateNormal];
    [btnPlus setImage:[UIImage imageNamed:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateHighlighted];
    [btnPlus setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
    
    
    [btnPlus sizeToFit];
    
    //btnPlus.center = self.tabBar.center;
    CGFloat screenWidth = [[UIScreen mainScreen] bounds].size.width;
    CGFloat btnPlusX = (screenWidth - btnPlus.frame.size.width) / 2;
    CGFloat btnPlusY = (49 - btnPlus.frame.size.height) / 2;
    
    CGRect rectBtnPlus = (CGRect){btnPlusX, btnPlusY, btnPlus.frame.size};
    btnPlus.frame = rectBtnPlus;
    
    [self addSubview:btnPlus];
    
    [btnPlus addTarget:self action:@selector(plusButtonClicked) forControlEvents:UIControlEventTouchUpInside];
}
- (void)plusButtonClicked {
    if ([self.clickDelegate respondsToSelector:@selector(tabBarDidClickedMiddleButton:)]) {
        [self.clickDelegate tabBarDidClickedMiddleButton:self];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    NSUInteger count = 5;
    // 计算每个TabBarItem的宽度
    CGFloat itemWidth = [UIScreen mainScreen].bounds.size.width / count;
    NSMutableArray *arrMTemp = [NSMutableArray array];
    for (UIView *view in self.subviews) {
        Class cls = NSClassFromString(@"UITabBarButton");
        if ([view isKindOfClass:cls]) {
            [arrMTemp addObject:view];
        }
    }
    NSUInteger number = 0;
    for (NSUInteger index = 0; index < arrMTemp.count; index ++) {
        if (number == 2) {
            number ++;
        }
        UIView *item = arrMTemp[index];
        CGRect rectItem = CGRectMake(number * itemWidth, 0, itemWidth, 49);
        item.frame = rectItem;
        number ++;
    }
}

@end
