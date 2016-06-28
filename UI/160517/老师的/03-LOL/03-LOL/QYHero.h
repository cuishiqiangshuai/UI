//
//  QYHero.h
//  03-LOL
//
//  Created by qingyun on 16/5/17.
//  Copyright © 2016年 QingYun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QYHero : NSObject
@property (nonatomic, strong) NSString *icon;       //头像
@property (nonatomic, strong) NSString *name;       //昵称
@property (nonatomic, strong) NSString *intro;      //个人描述
@property (nonatomic)         BOOL vip;

+(instancetype)heroWithDictionary:(NSDictionary *)dict;
-(instancetype)initWithDictionary:(NSDictionary *)dict;
@end
