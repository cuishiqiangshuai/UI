//
//  ViewController.m
//  UIView-QQ登录界面
//
//  Created by qingyun on 16/4/25.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *QQ;
@property (weak, nonatomic) IBOutlet UITextField *mima;



@end

@implementation ViewController

- (IBAction)denglu:(UIButton *)sender {
    
    NSLog(@"%@,%@",_QQ.text,_mima.text);
}

@end
