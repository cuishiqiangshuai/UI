//
//  AccessionToken.m
//  Weibo
//
//  Created by qingyun on 16/6/8.
//  Copyright © 2016年 QingYun. All rights reserved.
//

#import "AccessToken.h"
//声明一个静态的变量，，这样就是单例了
static AccessToken *accesstoken;

@implementation AccessToken

+(instancetype)shareHandel{
    if (accesstoken==nil) {
        accesstoken=[[AccessToken alloc] init];
    }
    return accesstoken;
}
@end
