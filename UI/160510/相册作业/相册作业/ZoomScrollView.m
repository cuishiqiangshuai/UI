//
//  ScrollView.m
//  相册作业
//
//  Created by qingyun on 16/5/10.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "ZoomScrollView.h"

#define ScreenW [UIScreen mainScreen].bounds.size.width
#define ScreenH [UIScreen mainScreen].bounds.size.height

@interface ZoomScrollView ()<UIScrollViewDelegate>

@property(nonatomic,strong)UIImageView *imageView;

@end

@implementation ZoomScrollView

+(instancetype)addzoomscrollView:(NSInteger)count{
    ZoomScrollView *zoomScrollView=[[ZoomScrollView alloc]init];
        //在缩放的scrollview上添加imageView
        zoomScrollView.frame=CGRectMake((ScreenW+25.0)*count, 0, ScreenW, ScreenH);
        UIImageView *imageView=[[UIImageView alloc] initWithFrame:zoomScrollView.bounds];
        [zoomScrollView addSubview:imageView];
        //设置图片
        imageView.image=[UIImage imageNamed:[NSString stringWithFormat:@"%ld.jpg",count+1]];
        imageView.tag=110;
        //设置zoomScorllView的缩放比例范围
        zoomScrollView.maximumZoomScale=2.0;
        zoomScrollView.minimumZoomScale=0.5;
        return zoomScrollView;
}

@end
