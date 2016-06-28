//
//  ChangeUserInfoVC.h
//  02-LoginDemo
//
//  Created by qingyun on 16/4/28.
//  Copyright © 2016年 QingYun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChangeUserInfoVC : UIViewController
@property (nonatomic, strong) NSString *descString;
@property (nonatomic, strong) void (^changeDescLabel)(NSString *value);
@end
