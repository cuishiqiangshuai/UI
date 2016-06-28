//
//  ViewController.m
//  04-新手引导页
//
//  Created by qingyun on 16/5/10.
//  Copyright © 2016年 QingYun. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置contentSize
    _scrollView.contentSize = CGSizeMake(CGRectGetWidth(_scrollView.frame) * 3, CGRectGetHeight(_scrollView.frame));
    
    //设置分页
    _scrollView.pagingEnabled = YES;
    
    //设置代理
    _scrollView.delegate = self;
    
    
}
//监听pageControl的valueChanged事件 ,根据pageControl的当前页码改变scrollView的contentOffset
- (IBAction)pageControlValueChanged:(UIPageControl *)sender {
    //计算scrollView的contentOffset
    CGPoint offset = CGPointMake(CGRectGetWidth(_scrollView.frame) * sender.currentPage, 0);
    
    [_scrollView setContentOffset:offset animated:YES];
}

#pragma mark  -UIScrollViewDelegate
//滚动结束
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    //根据当前的偏移量来计算当前显示的页码
    NSInteger currentPage = scrollView.contentOffset.x / CGRectGetWidth(scrollView.frame);
    //设置pageControl的当前页码
    _pageControl.currentPage = currentPage;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
