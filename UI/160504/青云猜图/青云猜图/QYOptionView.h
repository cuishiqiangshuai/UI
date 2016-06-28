//
//  QYOptionView.h
//  青云猜图
//
//  Created by qingyun on 16/5/4.
//  Copyright © 2016年 QingYun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QYOptionView : UIView
@property (nonatomic, strong) NSArray *btnTitles;
@property (nonatomic, strong) void (^optionBtnClick)(UIButton *btn);
//声明初始化方法
+ (instancetype) optionView;
@end
