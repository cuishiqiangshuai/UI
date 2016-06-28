//
//  AccessionToken.h
//  Weibo
//
//  Created by qingyun on 16/6/8.
//  Copyright © 2016年 QingYun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AccessToken : NSObject
@property(nonatomic,strong)NSString *access_token;//授权的token
@property(nonatomic,strong)NSString *remind_in;//accesstoken的生命周期
@property(nonatomic,strong)NSString *uid;//授权用户uid
@property(nonatomic,strong)NSString *expires_in;//accesstoken的生命周期
//单例
+(instancetype)shareHandel;
@end
