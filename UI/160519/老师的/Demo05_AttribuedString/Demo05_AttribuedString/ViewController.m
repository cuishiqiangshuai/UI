//
//  ViewController.m
//  Demo05_AttribuedString
//
//  Created by qingyun on 16/5/19.
//  Copyright © 2016年 QingYun. All rights reserved.
//

#define QLColorWithRGB(redValue, greenValue, blueValue) ([UIColor colorWithRed:((redValue)/255.0) green:((greenValue)/255.0) blue:((blueValue)/255.0) alpha:1])

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // UITextFiled, UITextView, UILabel
    
    // NSAttributedString: iOS中的富文本
    // NSAttributedString
    // NSMutableAttributedString
    NSMutableAttributedString *strMText = [[NSMutableAttributedString alloc]
    initWithString:@"你们真牛逼!你们真牛逼!你们真牛逼!你们真牛逼!你们真牛逼!你们真牛逼!你们真牛逼!你们真牛逼!你们真牛逼!你们真牛逼!你们真牛逼!你们真牛逼!你们真牛逼!你们真牛逼!你们真牛逼!你们真牛逼!你们真牛逼!你们真牛逼!你们真牛逼!你们真牛逼!你们真牛逼!"];
    // 设置某段字符串的字体大小
    [strMText addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:20] range:NSMakeRange(0, 4)];
    // 设置某段字符串的背景颜色
    [strMText addAttribute:NSBackgroundColorAttributeName value:QLColorWithRGB(0, 200, 0) range:NSMakeRange(5, 1)];
    [strMText addAttribute:NSUnderlineStyleAttributeName value:@(1) range:NSMakeRange(7, 5)];
    
    // 为某段文字添加阴影
    // 😙 emoji
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowColor = [UIColor whiteColor];
    shadow.shadowOffset = CGSizeMake(1, 1);
    [strMText addAttribute:NSShadowAttributeName value:shadow range:NSMakeRange(25, 5)];
    
    // 为富文本添加图片
    NSTextAttachment *attachment = [[NSTextAttachment alloc] init];
    attachment.image = [UIImage imageNamed:@"000"];
    attachment.bounds = CGRectMake(0, -5, 20, 20);
    NSAttributedString *strAImage = [NSAttributedString attributedStringWithAttachment:attachment];
    [strMText insertAttributedString:strAImage atIndex:31];
    
    
    self.label.attributedText = strMText;
}

@end
