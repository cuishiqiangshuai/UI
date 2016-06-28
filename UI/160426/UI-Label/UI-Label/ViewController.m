//
//  ViewController.m
//  UI-Label
//
//  Created by qingyun on 16/4/26.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "ViewController.h"
#define Viewkuan [UIScreen mainScreen].bounds.size.width
@interface ViewController ()
@property(nonatomic,strong)NSTimer *timer;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //创建一个label
    UILabel *label1=[[UILabel alloc] initWithFrame:CGRectMake(0, 100, 100,50)];
    //添加进view
    [self.view addSubview:label1];
    //设置背景颜色
    [label1 setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:1 alpha:0.3]];
    //设置文本
    [label1 setText:@"hello,world"];
    //设置文本显示的颜色
    [label1 setTextColor:[UIColor redColor]];
    //文本的阴影
    [label1 setShadowColor:[UIColor blackColor]];
    //设置阴影的偏移
    [label1 setShadowOffset:CGSizeMake(0, 50)];
    //对齐方式
    [label1 setTextAlignment:NSTextAlignmentLeft];
    //设置高亮状态文本的颜色
    [label1 setHighlightedTextColor:[UIColor yellowColor]];
    //设置高亮状态
    [label1 setHighlighted:YES];
    //换行方式
    [label1 setLineBreakMode:NSLineBreakByTruncatingHead];
    //行数（0代表不限行数）
    [label1 setNumberOfLines:1];
    //自行调节文本的大小来适应Label的宽度
    [label1 setAdjustsFontSizeToFitWidth:YES];
    //设置一个定时器
    _timer=[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timer:) userInfo:label1 repeats:YES];//注意：使用时能够使其调用方法的参数必须是NSTimer类型的，在相应的时机回收定timer
    
    
//    [UIView animateWithDuration:2 animations:^{
//        label1.frame=CGRectMake(Viewkuan-CGRectGetWidth(label1.frame), CGRectGetMinY(label1.frame), CGRectGetWidth(label1.frame), CGRectGetHeight(label1.frame));
//    }];
    
//    [UIView animateWithDuration:2 delay:0.3 options:UIViewAnimationOptionAutoreverse |UIViewAnimationOptionRepeat animations:^{
//        label1.frame=CGRectMake(Viewkuan-CGRectGetWidth(label1.frame), CGRectGetMinY(label1.frame), CGRectGetWidth(label1.frame), CGRectGetHeight(label1.frame));
//    } completion:nil];
    [UIView animateWithDuration:2 delay:0.3 usingSpringWithDamping:1 initialSpringVelocity:0.5 options:UIViewAnimationOptionAutoreverse|UIViewAnimationOptionRepeat animations:^{
        label1.frame=CGRectMake(Viewkuan-CGRectGetWidth(label1.frame), CGRectGetMinY(label1.frame), CGRectGetWidth(label1.frame), CGRectGetHeight(label1.frame));
    } completion:nil];
}
-(void)timer:(NSTimer *)timer
{
    UILabel *lable2=timer.userInfo;
    lable2.highlighted=!lable2.highlighted;
}
//注意：在视图控制器将要销毁的时候，回收定时器
-(void)dealloc
{
    [_timer invalidate];
    _timer=nil;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
