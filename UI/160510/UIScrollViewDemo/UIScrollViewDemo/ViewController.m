//
//  ViewController.m
//  UIScrollViewDemo
//
//  Created by qingyun on 16/5/10.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor=[UIColor redColor];
    _scrollView.backgroundColor=[UIColor blueColor];
    _scrollView.contentOffset=CGPointMake(-50, -50);
    _scrollView.contentSize=CGSizeMake(300,200);
    //设置代理
    _scrollView.delegate=self;
    //设置缩放的比例
    _scrollView.maximumZoomScale=1.5;
    _scrollView.minimumZoomScale=1.5;
    
    //缩放反弹动画
    _scrollView.bouncesZoom=NO;
    
    //
    
}
//时刻监听scrollView的内容的偏移量
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
}
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
}
-(void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
}
-(void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
}
-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    
}

#pragma mark
//指定缩放的视图(注意：scrollerView缩放时，必须实现的委托方法)
-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return  _imageView;
}
//时刻监听——scrolleView的内容的缩放比例
-(void)scrollViewDidZoom:(UIScrollView *)scrollView{
    
}
//将要开始缩放
-(void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(UIView *)view{
    
}
//已经结束缩放（在反弹效果结束后，被调用）
-(void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale{
    
}
//允许滚动至顶部(默认是YES)
-(BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView{
    return YES;
}
//滚动至顶部后，需要做的操作(当滑动动画结束后，会立即调用这个方法)
-(void)scrollViewDidScrollToTop:(UIScrollView *)scrollView{
    NSLog(@"获取新数据，刷新界面");
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
