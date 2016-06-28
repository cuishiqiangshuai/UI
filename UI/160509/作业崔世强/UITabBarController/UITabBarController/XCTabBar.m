//
//  UItabBar.m
//  UITabBarController
//
//  Created by qingyun on 16/5/9.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "XCTabBar.h"

@implementation XCTabBar

-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame])
    {
        [self loadDefaultSetting];
    }
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self=[super initWithCoder:aDecoder])
    {
        [self loadDefaultSetting];
    }
    return self;
}

-(void)loadDefaultSetting{
    UIButton *btnPlus = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnPlus setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
    [btnPlus setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button"] forState:UIControlStateNormal];
    [btnPlus setImage:[UIImage imageNamed:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateHighlighted];
    [btnPlus setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
    
    
    [btnPlus sizeToFit];
    
    //btnPlus.center = self.tabBar.center;
    CGFloat itemWidth=[UIScreen mainScreen].bounds.size.width/5;
    CGFloat screenWidth = [[UIScreen mainScreen] bounds].size.width;
    CGFloat btnPlusX = screenWidth - itemWidth;
    CGFloat btnPlusY = (49 - btnPlus.frame.size.height) / 2;
    CGRect rectBtnPlus = CGRectMake(btnPlusX, btnPlusY, btnPlus.frame.size.width, btnPlus.frame.size.height);
//    CGRect rectBtnPlus = (CGRect){btnPlusX, btnPlusY, btnPlus.frame.size};
    btnPlus.frame = rectBtnPlus;
    
    [self addSubview:btnPlus];
}

- (void)plusButtonClicked {
    if ([self.clickDelegate respondsToSelector:@selector(tabBarDidClickedMiddleButton:)]) {
        [self.clickDelegate tabBarDidClickedMiddleButton:self];
    }
}

-(void)layoutSubviews{
    [super layoutSubviews];
    NSUInteger count=5;
    //计算每个TabBarItem的宽度
    CGFloat itemWidth=[UIScreen mainScreen].bounds.size.width/count;
    NSMutableArray *array=[NSMutableArray array];
    for (UIView *view in self.subviews)
    {
        Class cls=NSClassFromString(@"UITabBarButton");
        if ([view isKindOfClass:cls])
        {
            [array addObject:view];
        }
    }
    NSUInteger num=0;
    for (NSUInteger index=0; index<array.count; index++)
    {
        if (num==5) {
            num++;
        }
        UIView *item=array[index];
            item.frame=CGRectMake(num*itemWidth, 0, itemWidth, 49);
            num++;
    }
}

@end
