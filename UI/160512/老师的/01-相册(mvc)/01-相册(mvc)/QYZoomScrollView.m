//
//  QYZoomScrollView.m
//  01-相册(mvc)
//
//  Created by qingyun on 16/5/12.
//  Copyright © 2016年 QingYun. All rights reserved.
//

#import "QYZoomScrollView.h"

@interface QYZoomScrollView ()<UIScrollViewDelegate>
@property (nonatomic, strong) UIImageView *imageView;
@end

@implementation QYZoomScrollView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
       //添加子视图(imageView)
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        [self addSubview:imageView];
        _imageView = imageView;
        
        //设置属性
        self.maximumZoomScale = 1.5;
        self.minimumZoomScale = 0.5;
        
        self.delegate = self;
        
        //双击
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleClick:)];
        tap.numberOfTapsRequired = 2;
        [self addGestureRecognizer:tap];
    }
    return self;
}
//双击功能
-(void)doubleClick:(UITapGestureRecognizer *)tap{
    if (self.zoomScale != 1.0) {
        [self setZoomScale:1.0 animated:YES];
        return;
    }
    
    CGPoint point = [tap locationInView:self];
    
    CGRect rect = CGRectMake(point.x - 100, point.y - 100, 200, 200);
    
    [self zoomToRect:rect animated:YES];
    
}
//借用setImg方法设置imageView的图片
-(void)setImg:(UIImage *)img{
    //1.赋值
    _img = img;
    //2.设置imageView的image
    _imageView.image = img;
}

#pragma mark -UIScrollViewdelegate

//指定缩放的内容视图
-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return _imageView;
}

@end
