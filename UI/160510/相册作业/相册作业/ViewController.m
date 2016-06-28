//
//  ViewController.m
//  相册作业
//
//  Created by qingyun on 16/5/10.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "ViewController.h"
#import "ZoomScrollView.h"

#define ScreenW [UIScreen mainScreen].bounds.size.width
#define ScreenH [UIScreen mainScreen].bounds.size.height
#define ImageViewCount 22
@interface ViewController ()<UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView *scrollView;
@property(nonatomic,assign)NSInteger currentpage;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addScrollView];
}

//添加滚动的scrollView
-(void)addScrollView{
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenW + 25.0, ScreenH)];
    [self.view addSubview:scrollView];
    //设置背景颜色
    scrollView.backgroundColor = [UIColor blueColor];
    //设置contentSize
    scrollView.contentSize = CGSizeMake((ScreenW + 25.0) * ImageViewCount, ScreenH);
    //分页
    scrollView.pagingEnabled = YES;
    //滚动结束后，需要把所有的scrollView的比例重置为1.0，所以需要代理，上面需要添加<UIScrollViewDelegate>
    //设置代理
    scrollView.delegate = self;
    _scrollView = scrollView;
    
    for (int i=0; i<ImageViewCount; i++) {
        ZoomScrollView *zoomScrollView=[ZoomScrollView addzoomscrollView:i];
        [scrollView addSubview:zoomScrollView];
        zoomScrollView.delegate=self;
        
        //创建手势识别器
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleClick:)];
        //双击
        tap.numberOfTapsRequired=2;
        //在缩放的scrollView添加一个手势识别器
        [zoomScrollView addGestureRecognizer:tap];
    }
}
-(void)doubleClick:(UITapGestureRecognizer *)tap{
    //用手势识别器取到手势识别器所在的view
    UIScrollView *zoomScrollView=(UIScrollView *)tap.view;
    //如果当前的zoomScrollView的比例不是默认状态，则置为1.0
    if (zoomScrollView.zoomScale!=1.0) {
        [zoomScrollView setZoomScale:1.0 animated:YES];
        return;
    }
    //当前的比例为1.0时，放大，首先要找到点击的矩形区域
    //获取点击的点所在的view的位置
    CGPoint point=[tap locationInView:zoomScrollView];
    CGRect rect=CGRectMake(point.x-50, point.y-50, 100, 100);
    [zoomScrollView zoomToRect:rect animated:YES];
}
//用来取到开始拖拽时的页码
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    if (scrollView==_scrollView) {
        _currentpage=scrollView.contentOffset.x/(ScreenW+25.0);
    }
    
}
//减速完成后，把所有的zoomScrollView的缩放比例重置为1.0；
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    //判断是不是scrollView（还有可能是那两个滚动条）
    if (scrollView==_scrollView)
    {
        //判断开始拖拽时取到的页码等于拖拽完成时的页码是，（有可能只是动了下没有翻页，就不重置比例）
        if (_currentpage==scrollView.contentOffset.x/(ScreenW+25.0))
        {
            return;
        }
    //如果已经翻页就把所有的zoomScrollView的缩放比例重置为1.0（因为是所有的所以需要遍历）
    [scrollView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[UIScrollView class]])
        {
            UIScrollView *zoomScrollView=(UIScrollView *)obj;
            zoomScrollView.zoomScale=1.0;
        }
    }];
    }
}
//指定缩放视图
-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    //判断当前的scrollView是滚动的scrollView的时候，需要return
    if (scrollView==_scrollView) {
        return nil;
    }
    //是的话好要找到对应的imageView
    UIImageView *imageView=[scrollView viewWithTag:110];
    return imageView;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
