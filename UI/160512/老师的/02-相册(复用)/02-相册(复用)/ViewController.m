//
//  ViewController.m
//  02-相册(复用)
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
@property (nonatomic)         NSInteger currentPage;        //当前页
@property (nonatomic, strong) NSArray *imagePaths;          //所有的图片集合(路径)
@property (nonatomic)         NSInteger currentIndex;       //当前显示的图片索引
@end

@implementation ViewController

//懒加载imagePaths
-(NSArray *)imagePaths{
    if (_imagePaths == nil) {
        NSMutableArray *paths = [NSMutableArray array];
        for (int i = 0; i < ImageCount; i++) {
            NSString *imageName = [NSString stringWithFormat:@"new_feature_%d@2x",i + 1];
            
            NSString *path = [[NSBundle mainBundle] pathForResource:imageName ofType:@"png"];
            
            [paths addObject:path];
        }
        _imagePaths = paths;
    }
    return _imagePaths;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //1.在self.view上添加一个底部滚动的scrollView
    [self addScrollViewForView];
    //2.在scrollView上添加缩放的zoomScrollView
    [self addZoomScrollViewForScrollView];
    
    //3.配置zoomScrollView的属性
    [self configurationPropertyForZoomScrollViews];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)addScrollViewForView{
    //创建并添加scrollView
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, (QYScreenW + 25.0), QYScreenH)];
    [self.view addSubview:scrollView];
    
    //设置属性
    scrollView.contentSize = CGSizeMake((QYScreenW + 25.0) * 3, QYScreenH);
    
    scrollView.pagingEnabled = YES;
    
    scrollView.delegate = self;
    
    scrollView.backgroundColor = [UIColor blackColor];
    
    scrollView.showsHorizontalScrollIndicator = NO;
    
    _scrollView = scrollView;
}

-(void)addZoomScrollViewForScrollView{
    for (int i = 0; i < 3; i++) {
        //创建并添加zoomScrollView
        QYZoomScrollView *zoomScrollView = [[QYZoomScrollView alloc] initWithFrame:CGRectMake((QYScreenW + 25.0) * i, 0, QYScreenW, QYScreenH)];
        [_scrollView addSubview:zoomScrollView];
        zoomScrollView.tag = 1000 + i;
    }
}

//校验索引可用
-(NSInteger)indexEnable:(NSInteger)index{
    if (index < 0) {
        return self.imagePaths.count - 1;
    }else if (index > self.imagePaths.count - 1){
        return 0;
    }else{
        return index;
    }
}

//配置ZoomScrollView的属性(图片和偏移量)
-(void)configurationPropertyForZoomScrollViews{
    QYZoomScrollView *leftZoomSC = [_scrollView viewWithTag:1000];
    QYZoomScrollView *middleZoomSC = [_scrollView viewWithTag:1001];
    QYZoomScrollView *rightZoomSC = [_scrollView viewWithTag:1002];
    
    //设置图片
    NSString *leftImagePath = self.imagePaths[[self indexEnable:(_currentIndex - 1)]];
    leftZoomSC.img = [UIImage imageWithContentsOfFile:leftImagePath];
    
    NSString *middleImagePath = self.imagePaths[[self indexEnable:_currentIndex]];
    middleZoomSC.img = [UIImage imageWithContentsOfFile:middleImagePath];
    
    NSString *rightImagePath = self.imagePaths[[self indexEnable:(_currentIndex + 1)]];
    rightZoomSC.img = [UIImage imageWithContentsOfFile:rightImagePath];
    //设置内容的偏移量
    _scrollView.contentOffset = CGPointMake((QYScreenW + 25.0), 0);
}

#pragma mark - UIScrollViewDelegate

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    _currentPage = scrollView.contentOffset.x / (QYScreenW + 25);
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    scrollView.userInteractionEnabled = NO;
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    scrollView.userInteractionEnabled = YES;
    if (_currentPage == scrollView.contentOffset.x / (QYScreenW + 25)) {
        return;
    }
    
    [scrollView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[QYZoomScrollView class]]) {
            ((QYZoomScrollView *)obj).zoomScale = 1.0;
        }
    }];
    
    //判断左右滑动
    if (scrollView.contentOffset.x == 0) {
        //右滑
        _currentIndex--;
    }else if (scrollView.contentOffset.x == (QYScreenW + 25.0) * 2){
        //左滑
        _currentIndex++;
    }
    
    //保证_currentIndex可用
    _currentIndex = [self indexEnable:_currentIndex];
    
    [self configurationPropertyForZoomScrollViews];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
