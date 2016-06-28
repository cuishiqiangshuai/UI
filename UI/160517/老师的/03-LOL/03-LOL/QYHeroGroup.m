//
//  QYHeroGroup.m
//  03-LOL
//
//  Created by qingyun on 16/5/17.
//  Copyright © 2016年 QingYun. All rights reserved.
//

#import "QYHeroGroup.h"
#import "QYHero.h"
@implementation QYHeroGroup

+(instancetype)heroGroupWithDictionary:(NSDictionary *)dict{
    return [[self alloc] initWithDictionary:dict];
}

-(instancetype)initWithDictionary:(NSDictionary *)dict{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
        //把friends中的字典转化成QYHero模型
        NSMutableArray *models = [NSMutableArray array];
        for (NSDictionary *heroDict in _friends) {
            QYHero *hero = [QYHero heroWithDictionary:heroDict];
            [models addObject:hero];
        }
        _friends = models;
        
        //_isOpen = YES;
    }
    return self;
}
@end
