//
//  QYCTModel.m
//  青云猜图崔世强
//
//  Created by qingyun on 16/5/3.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "QYCTModel.h"


@implementation QYCTModel

-(instancetype)initWithDictionary:(NSDictionary *)dict
{
    if (self=[super init])
    {
        [self setValuesForKeysWithDictionary:dict];
        
    }
    return self;
}
+(instancetype)modelWithDictionary:(NSDictionary *)dict{
    //在类方法中self指的是当前类(self 相当于 QYAppModel)
    return [[self alloc] initWithDictionary:dict];
}
@end
