//
//  ViewController.m
//  UIPagecontrolDemo
//
//  Created by qingyun on 16/5/10.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //创建并添加
    UIPageControl *page1=[[UIPageControl alloc] initWithFrame:CGRectMake(100, 100, 200, 30)];
    [self.view addSubview:page1];
    page1.backgroundColor=[UIColor blackColor];
    //总页数
    page1.numberOfPages=7;
    //当前页数
    page1.currentPage=5;
    //页码指示着色(所有小点的颜色)
    page1.pageIndicatorTintColor=[UIColor redColor];
    //当前页码指示着色（当前选中的小点的颜色）
    page1.currentPageIndicatorTintColor=[UIColor blueColor];
    //添加事件监听（ValueChange）
    [page1 addTarget:self action:@selector(pageControlAction:) forControlEvents:UIControlEventValueChanged];
    
    //延迟更新界面
    page1.defersCurrentPageDisplay=YES;//手动调用updateCurrentPageDisplay
    
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)pageControlAction:(UIPageControl *)pageControl{
    NSLog(@"%ld",pageControl.currentPage);
    [pageControl performSelector:@selector(updateCurrentPageDisplay) withObject:nil afterDelay:1];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
