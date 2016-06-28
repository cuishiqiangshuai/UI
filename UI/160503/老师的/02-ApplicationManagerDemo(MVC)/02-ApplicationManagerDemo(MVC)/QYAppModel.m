//
//  QYAppModel.m
//  02-ApplicationManagerDemo(MVC)
//
//  Created by qingyun on 16/5/3.
//  Copyright © 2016年 QingYun. All rights reserved.
//

#import "QYAppModel.h"

@implementation QYAppModel

//实例初始化方法
-(instancetype)initWithDictionary:(NSDictionary *)dict{
    if (self = [super init]) {
        //对属性进行赋值
#if 0
        _icon = dict[@"icon"];
        _name = dict[@"name"];
        _link = dict[@"link"];
#else
        //使用kvc直接灌入数据
        [self setValuesForKeysWithDictionary:dict];
#endif
    }
    return self;
}
//类方法
+(instancetype)modelWithDictionary:(NSDictionary *)dict{
    //在类方法中self指的是当前类(self 相当于 QYAppModel)
    return [[self alloc] initWithDictionary:dict];
}
@end
