//
//  QYAppModel.h
//  02-ApplicationManagerWithCollectionView
//
//  Created by qingyun on 16/5/23.
//  Copyright © 2016年 QingYun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QYAppModel : NSObject
@property (nonatomic, strong) NSString *icon;           //图片名称
@property (nonatomic, strong) NSString *name;           //应用标题
@property (nonatomic, strong) NSString *link;           //下载地址

+(instancetype)appModelWithDictionary:(NSDictionary *)dict;
-(instancetype)initWithDictionary:(NSDictionary *)dict;
@end
