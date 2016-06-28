//
//  QYCTModel.h
//  青云猜图崔世强
//
//  Created by qingyun on 16/5/3.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QYCTModel : NSObject
@property(nonatomic,strong)NSString *answer;
@property(nonatomic,strong)NSString *icon;
@property(nonatomic,strong)NSString *title;
@property(nonatomic,strong)NSArray *options;

@property(nonatomic,assign)BOOL isFinish;//当前题目是否已经回答过
@property(nonatomic,assign)BOOL isHint;//当前题目是否被提示
@property(nonatomic,assign)NSInteger answerCount;
-(instancetype)initWithDictionary:(NSDictionary *)dict;
@end
