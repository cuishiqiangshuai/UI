//
//  ViewController.m
//  UIButten
//
//  Created by qingyun on 16/4/25.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property(weak,nonatomic) UIButton *headerBtn;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];//创建butten对象
    [self.view addSubview:btn];//把butten对象添加到父视图里面
    btn.frame=CGRectMake(100, 100, 100, 100);//设置butten的位置和大小
    [btn setBackgroundImage:[UIImage imageNamed:@"dog1"] forState:UIControlStateNormal];//设置butten普通状态下的背景图片
    [btn setTitle:@"点我试试" forState:UIControlStateNormal];//设置butten的文字
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:@"dog2"] forState:UIControlStateHighlighted];//设置高亮状态下的butten图片
    [btn setTitle:@"点你咋的" forState:UIControlStateHighlighted];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];//监听按钮点击
    [self setHeaderBtn:btn];
    
    //创建上的butten
    UIButton *top=[UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:top];
    top.frame=CGRectMake(50, 200, 50, 50);
    [top setBackgroundImage:[UIImage imageNamed:@"top_normal"] forState:UIControlStateNormal];
    [top addTarget:self action:@selector(move:) forControlEvents:UIControlEventTouchUpInside];//监听按钮点击
    top.tag=101;
    //创建左的butten
    UIButton *left=[UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:left];
    left.frame=CGRectMake(10, 250, 50, 50);
    [left setBackgroundImage:[UIImage imageNamed:@"left_normal"] forState:UIControlStateNormal];
    [left addTarget:self action:@selector(move:) forControlEvents:UIControlEventTouchUpInside];//监听按钮点击

    left.tag=102;
    //创建下的butten
    UIButton *bottom=[UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:bottom];
    bottom.frame=CGRectMake(50,300, 50, 50);
    [bottom setBackgroundImage:[UIImage imageNamed:@"bottom_normal"] forState:UIControlStateNormal];
    [bottom addTarget:self action:@selector(move:) forControlEvents:UIControlEventTouchUpInside];//监听按钮点击

    bottom.tag=103;
    //创建右的butten
    UIButton *right=[UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:right];
    right.frame=CGRectMake(100,250, 50, 50);
    [right setBackgroundImage:[UIImage imageNamed:@"right_normal"] forState:UIControlStateNormal];
    [right addTarget:self action:@selector(move:) forControlEvents:UIControlEventTouchUpInside];//监听按钮点击
    right.tag=104;
    
    //创建放大的butten
    UIButton *plus=[UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:plus];
    plus.frame=CGRectMake(250, 200, 50, 50);
    [plus setBackgroundImage:[UIImage imageNamed:@"plus_highlighted"] forState:UIControlStateNormal];
    [plus addTarget:self action:@selector(fangsuo:) forControlEvents:UIControlEventTouchUpInside];//监听按钮点击
    plus.tag=105;
    //创建缩小的butten
    UIButton *minus=[UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:minus];
    minus.frame=CGRectMake(250, 250, 50, 50);
    [minus setBackgroundImage:[UIImage imageNamed:@"minus_normal"] forState:UIControlStateNormal];
    [minus addTarget:self action:@selector(fangsuo:) forControlEvents:UIControlEventTouchUpInside];//监听按钮点击
    minus.tag=106;
    //创建左旋转的butten
    UIButton *left_rotate=[UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:left_rotate];
    left_rotate.frame=CGRectMake(150, 400, 50, 50);
    [left_rotate setBackgroundImage:[UIImage imageNamed:@"left_rotate_normal"] forState:UIControlStateNormal];
    [left_rotate addTarget:self action:@selector(xuanzhuan:) forControlEvents:UIControlEventTouchUpInside];//监听按钮点击
    left_rotate.tag=107;
    //创建右旋转的butten
    UIButton *right_rotate=[UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:right_rotate];
    right_rotate.frame=CGRectMake(250, 400, 50, 50);
    [right_rotate setBackgroundImage:[UIImage imageNamed:@"right_rotate_highlighted"] forState:UIControlStateNormal];
    [right_rotate addTarget:self action:@selector(xuanzhuan:) forControlEvents:UIControlEventTouchUpInside];//监听按钮点击
    right_rotate.tag=108;
}

-(void)btnClick:(UIButton *)btn{
    NSLog(@"%s",__func__);
}

-(void)move:(UIButton *)sender
{
    
    //取中心点
    CGPoint center=_headerBtn.center;
    CGFloat lol=10;
    switch (sender.tag)
    {
        case 101:
            center.y-=lol;
            break;
        case 102:
            center.x-=lol;
            break;
        case 103:
            center.y+=lol;
            break;
        case 104:
            center.x+=lol;
            break;

        default:
            break;
    }
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    _headerBtn.center=center;
    [UIView commitAnimations];
    
}

-(void)fangsuo:(UIButton *)sender
{
#if 0
    CGRect rect=_headerBtn.frame;
    CGFloat lol=20;
    if (sender.tag==105)
    {
        rect.size.width+=lol;
        rect.size.height+=lol;
    }
    else if (sender.tag==106)
    {
        rect.size.width-=lol;
        rect.size.height-=lol;
    }
    [UIView animateWithDuration:0.5 animations:^{
        _headerBtn.frame=rect;
    }];
#else
    [UIView animateWithDuration:0.5 animations:^{
        if (sender.tag==105)
        {
            _headerBtn.transform=CGAffineTransformScale(_headerBtn.transform, 1.2, 1.2);
        }
        else if (sender.tag==106)
        {
            _headerBtn.transform=CGAffineTransformScale(_headerBtn.transform, 0.8, 0.8);
        }
    }];
#endif
}


-(void)xuanzhuan:(UIButton *)sender
{
    [UIView animateWithDuration:0.5 animations:^{
        if (sender.tag==107)
        {
            _headerBtn.transform=CGAffineTransformRotate(_headerBtn.transform,-M_PI_2);
        }
        else if (sender.tag==108)
        {
            _headerBtn.transform=CGAffineTransformRotate(_headerBtn.transform, M_PI_2);
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
