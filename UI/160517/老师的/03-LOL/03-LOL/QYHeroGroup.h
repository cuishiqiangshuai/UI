//
//  QYHeroGroup.h
//  03-LOL
//
//  Created by qingyun on 16/5/17.
//  Copyright © 2016年 QingYun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QYHeroGroup : NSObject
@property (nonatomic, strong) NSArray *friends;             //英雄s
@property (nonatomic, strong) NSString *name;               //分组名称
@property (nonatomic)         NSInteger online;             //在线人数
@property (nonatomic)         BOOL isOpen;                  //打开状态

+(instancetype)heroGroupWithDictionary:(NSDictionary *)dict;
-(instancetype)initWithDictionary:(NSDictionary *)dict;
@end
