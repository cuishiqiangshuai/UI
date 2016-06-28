//
//  Model.h
//  青云猜图二
//
//  Created by qingyun on 16/5/6.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Model : NSObject//声明属性
@property(nonatomic,strong)NSString *answer;//题目答案
@property(nonatomic,strong)NSString *icon;//题目图片名称
@property(nonatomic,strong)NSString *title;//题目提示信息
@property(nonatomic,strong)NSArray *options;//选择区域的按钮标题
@property(nonatomic,assign)BOOL isFinish;//题目完成状态
@property(nonatomic,assign)BOOL isHint;//题目是否被提示过
//声明初始化方法
-(instancetype)initWithDictionary:(NSDictionary *)dict;
+(instancetype)modelWithDictionary:(NSDictionary *)dict;
@end
