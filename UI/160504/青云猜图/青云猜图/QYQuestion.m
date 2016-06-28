//
//  QYQuestion.m
//  青云猜图
//
//  Created by qingyun on 16/5/4.
//  Copyright © 2016年 QingYun. All rights reserved.
//

#import "QYQuestion.h"

@implementation QYQuestion

- (instancetype) initWithDictionary:(NSDictionary *)dict {
    if (self = [super init]) {
        //对属性赋值
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (instancetype) modelWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}
@end
