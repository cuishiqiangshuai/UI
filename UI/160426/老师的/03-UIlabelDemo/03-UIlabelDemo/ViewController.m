//
//  ViewController.m
//  03-UIlabelDemo
//
//  Created by qingyun on 16/4/26.
//  Copyright © 2016年 QingYun. All rights reserved.
//

#import "ViewController.h"
#define QYScreenW [UIScreen mainScreen].bounds.size.width
@interface ViewController ()
@property (nonatomic, strong) NSTimer *timer;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //创建并添加UIlabel
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, 180, 60)];
    [self.view addSubview:label];
    //设置背景颜色
    label.backgroundColor = [UIColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:0.3];
    
    //设置text
    label.text = @"hello,world，hello,qingyun!";
    //设置文本显示的颜色
    label.textColor = [UIColor blueColor];
    //文本的阴影
    label.shadowColor = [UIColor blackColor];
    //设置阴影的偏移
    label.shadowOffset = CGSizeMake(0, -10);
    //对齐方式
    label.textAlignment = NSTextAlignmentLeft;
    //设置高亮状态文本的颜色
    label.highlightedTextColor = [UIColor yellowColor];
    //设置高亮状态
    //label.highlighted = YES;
    //注意使用定时器调用方法的参数必须是NSTimer类型的，在相应的时机回收timer
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(changedHighlightedForLabel:) userInfo:label repeats:YES];
    //换行方式
    label.lineBreakMode = NSLineBreakByTruncatingHead;
    //行数(0代表不限行数)
    label.numberOfLines = 1;
    //自动调节文本的大小来适应label的宽度
    label.adjustsFontSizeToFitWidth = YES;
    
    
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)changedHighlightedForLabel:(NSTimer *)timer{
    UILabel *label = timer.userInfo;
    label.highlighted = !label.highlighted;
//    if (label.highlighted) {
//        label.highlighted = NO;
//    }else{
//        label.highlighted = YES;
//    }
}

//注意：在视图控制器将要销毁的时候，回收定时器
- (void)dealloc{
    //回收定时器
    [_timer invalidate];
    _timer = nil;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
