//
//  ViewController.m
//  01-TomCat
//
//  Created by qingyun on 16/4/29.
//  Copyright © 2016年 QingYun. All rights reserved.
//

#import "ViewController.h"
#import "Common.h"
@interface ViewController ()
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (nonatomic, strong) NSTimer *timer;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
//执行动画（imgName:帧动画图片的前缀，count:动画图片的张数）
-(void)startAnimationWithImageName:(NSString *)imgName imageCount:(NSInteger)count{
    
    if (_imageView.isAnimating) {
        return;
    }
    
    NSMutableArray *images = [NSMutableArray array];
    for (int i = 0; i < count; i++) {
#if 0
        //下面这种方式imageNamed加载image的时候，带有缓存
        //获取图片的名称
        NSString *imageName = [NSString stringWithFormat:@"%@_%02d.jpg",imgName,i];
        //获取图片
        UIImage *image = [UIImage imageNamed:imageName];
#else
        NSString *imageName = [NSString stringWithFormat:@"%@_%02d",imgName,i];
//        NSString *path = [[NSBundle mainBundle] pathForResource:imageName ofType:@"jpg"];
//        //利用获取的图片路径来加载image（不带缓存）
//        UIImage *image = [UIImage imageWithContentsOfFile:path];
        UIImage *image = ImageWithPath2(ResourcePath2(imageName, @"jpg"));
#endif
        [images addObject:image];
    }
    //设置帧动画
    _imageView.animationImages = images;
    //设置动画的时间、重复次数
    _imageView.animationDuration = 0.05 * count;
    _imageView.animationRepeatCount = 1;
    //启动动画
    [_imageView startAnimating];
    //_timer = [NSTimer scheduledTimerWithTimeInterval:_imageView.animationDuration target:self selector:@selector(clearMemory) userInfo:nil repeats:NO];
    
    //[self performSelector:@selector(clearMemory) withObject:nil afterDelay:_imageView.animationDuration];
    
    [_imageView performSelector:@selector(setAnimationImages:) withObject:nil afterDelay:_imageView.animationDuration];
    
}

-(void)clearMemory{
    //把帧动画数组置空
    _imageView.animationImages = nil;
    [_timer invalidate];
    _timer = nil;
}

- (IBAction)btnClick:(UIButton *)sender {
    
    switch (sender.tag) {
        case 101://cymbal
            [self startAnimationWithImageName:@"cymbal" imageCount:13];
            break;
        case 102://drink
            [self startAnimationWithImageName:@"drink" imageCount:81];
            break;
        case 103://eat
            [self startAnimationWithImageName:@"eat" imageCount:40];
            break;
        case 104://pie
            [self startAnimationWithImageName:@"pie" imageCount:24];
            break;
        case 105://fart
            [self startAnimationWithImageName:@"fart" imageCount:28];
            break;
        case 106://scratch
            [self startAnimationWithImageName:@"scratch" imageCount:56];
            break;
        case 107://knockout
            [self startAnimationWithImageName:@"knockout" imageCount:81];
            break;
        case 108://stomach
            [self startAnimationWithImageName:@"stomach" imageCount:34];
            break;
        case 109://footRight
            [self startAnimationWithImageName:@"footRight" imageCount:30];
            break;
        case 110://footLeft
            [self startAnimationWithImageName:@"footLeft" imageCount:30];
            break;
        case 111://angry
            [self startAnimationWithImageName:@"angry" imageCount:26];
            break;
            
        default:
            break;
    }
}
@end
