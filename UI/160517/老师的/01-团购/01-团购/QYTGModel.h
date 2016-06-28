//
//  QYTGModel.h
//  01-团购
//
//  Created by qingyun on 16/5/17.
//  Copyright © 2016年 QingYun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QYTGModel : NSObject
@property (nonatomic, strong) NSString *buycount;
@property (nonatomic, strong) NSString *icon;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSNumber *type;

+(instancetype)tgModelWithDictionary:(NSDictionary *)dict;
-(instancetype)initWithDictionary:(NSDictionary *)dict;

@end
