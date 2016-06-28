//
//  ViewController.m
//  02-UIScrollViewDemo
//
//  Created by qingyun on 16/5/10.
//  Copyright © 2016年 QingYun. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置contentSize,默认是0,不支持滚动
    _scrollView.contentSize = CGSizeMake(375, 667);
    //设置contentOffset
    //_scrollView.contentOffset = CGPointMake(-50, -50);
    //
    //_scrollView.contentInset = UIEdgeInsetsMake(100, 0, 0, 0);
    //锁定方向
    _scrollView.directionalLockEnabled = YES;
    
    //滚动的时候,超出内容视图边界,是否有反弹效果
    _scrollView.bounces = YES;
    //假如是yes并且bounces是yes,甚至如果内容大小小于bounds的时候，允许垂直拖动
    _scrollView.alwaysBounceVertical = YES;
    
    //分页
    _scrollView.pagingEnabled = YES;
    
    //设置滚动条的显示
    _scrollView.showsVerticalScrollIndicator = YES;
    
    //设置滚动条的滚动范围
    _scrollView.scrollIndicatorInsets = UIEdgeInsetsMake(50, 50, 0, 0);
    //滚动条样式
    _scrollView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
