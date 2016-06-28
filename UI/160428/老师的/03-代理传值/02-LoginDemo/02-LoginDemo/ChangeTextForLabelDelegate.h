//
//  ChangeTextForLabelDelegate.h
//  02-LoginDemo
//
//  Created by qingyun on 16/4/28.
//  Copyright © 2016年 QingYun. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ChangeTextForLabelDelegate <NSObject>

//更改个性签名
-(void)changeTextForDescLabel:(NSString *)string;
@end
