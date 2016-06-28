//
//  ViewController.m
//  01-相册(mvc)
//
//  Created by qingyun on 16/5/12.
//  Copyright © 2016年 QingYun. All rights reserved.
//

#import "ViewController.h"
#import "QYZoomScrollView.h"

#define QYScreenW [UIScreen mainScreen].bounds.size.width
#define QYScreenH [UIScreen mainScreen].bounds.size.height
#define ImageCount 6
@interface ViewController ()<UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView *scrollView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //1.在self.view上添加一个底部滚动的scrollView
    [self addScrollViewForView];
    //2.在scrollView上添加缩放的zoomScrollView
    [self addZoomScrollViewForScrollView];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)addScrollViewForView{
    //创建并添加scrollView
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, (QYScreenW + 25.0), QYScreenH)];
    [self.view addSubview:scrollView];
    
    //设置属性
    scrollView.contentSize = CGSizeMake((QYScreenW + 25.0) * ImageCount, QYScreenH);
    
    scrollView.pagingEnabled = YES;
    
    scrollView.delegate = self;
    
    scrollView.backgroundColor = [UIColor blackColor];
    
    _scrollView = scrollView;
}

-(void)addZoomScrollViewForScrollView{
    for (int i = 0; i < ImageCount; i++) {
        //创建并添加zoomScrollView
        QYZoomScrollView *zoomScrollView = [[QYZoomScrollView alloc] initWithFrame:CGRectMake((QYScreenW + 25.0) * i, 0, QYScreenW, QYScreenH)];
        [_scrollView addSubview:zoomScrollView];
        
        NSString *imageName = [NSString stringWithFormat:@"new_feature_%d",i + 1];
        zoomScrollView.img = [UIImage imageNamed:imageName];
    }
}

#pragma mark - UIScrollViewDelegate


//滚动结束
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [scrollView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[QYZoomScrollView class]]) {
            ((QYZoomScrollView *)obj).zoomScale = 1.0;
        }
    }];
}

@end
