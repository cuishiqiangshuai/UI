//
//  OptionView.h
//  青云猜图二
//
//  Created by qingyun on 16/5/7.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Model;

@interface OptionView : UIView

@property(nonatomic,copy)void (^optionblock)(UIButton *optionBtn);
-(instancetype)initOptionViewWithModel:(Model *)model;
+(instancetype)OptionViewWithModel:(Model *)model;
@end
