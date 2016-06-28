//
//  Model.m
//  青云猜图二
//
//  Created by qingyun on 16/5/6.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "Model.h"

@implementation Model

-(instancetype)initWithDictionary:(NSDictionary *)dict
{
    if (self=[super init])
    {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
+(instancetype)modelWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}
@end
