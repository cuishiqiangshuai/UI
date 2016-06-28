//
//  QYTGModel.m
//  01-团购
//
//  Created by qingyun on 16/5/17.
//  Copyright © 2016年 QingYun. All rights reserved.
//

#import "QYTGModel.h"

@implementation QYTGModel
+(instancetype)tgModelWithDictionary:(NSDictionary *)dict{
    return [[self alloc] initWithDictionary:dict];
}
-(instancetype)initWithDictionary:(NSDictionary *)dict{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
@end
