//
//  QYQuestion.h
//  青云猜图
//
//  Created by qingyun on 16/5/4.
//  Copyright © 2016年 QingYun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QYQuestion : NSObject
//声明属性
@property (nonatomic, strong) NSString *answer;             //题目答案
@property (nonatomic, strong) NSString *icon;               //题目图片名称
@property (nonatomic, strong) NSString *title;              //题目提示信息
@property (nonatomic, strong) NSArray *options;             //选择区域的按钮标题

@property (nonatomic)         BOOL isHint;                  //当前题目是否被提示
@property (nonatomic)         BOOL isFinish;                //当前题目是否已经回答过

//声明初始化方法
- (instancetype) initWithDictionary:(NSDictionary *)dict;
+ (instancetype) modelWithDictionary:(NSDictionary *)dict;

@end
