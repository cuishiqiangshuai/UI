//
//  QYAppModel.h
//  02-ApplicationManagerDemo(MVC)
//
//  Created by qingyun on 16/5/3.
//  Copyright © 2016年 QingYun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QYAppModel : NSObject
//声明属性（注意:属性名称跟字典文件中键相同）
@property (nonatomic, strong) NSString *icon;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *link;
//声明初始化方法（建议实例方法和类方法都要）
-(instancetype)initWithDictionary:(NSDictionary *)dict;

+(instancetype)modelWithDictionary:(NSDictionary *)dict;
@end
