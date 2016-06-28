//
//  ViewController.m
//  tom
//
//  Created by qingyun on 16/4/28.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *Tom;
@property(nonatomic,strong)NSArray *Array;
@end

@implementation ViewController

-(void)Name:(NSString *)name andCount:(NSInteger)count{

    if (_Tom.isAnimating)
    {
    return;
}
        NSMutableArray *Array2=[NSMutableArray array];
        for (int i=1; i<count; i++)
        {
            NSString *imageName=[NSString stringWithFormat:@"%@_%02d",name,i];
            NSString *path=[[NSBundle mainBundle] pathForResource:imageName ofType:@"jpg"];//这种方法可以获取文件的路径，不带缓存  ，减少内存消耗
            UIImage *image1=[UIImage imageWithContentsOfFile:path];            [Array2 addObject:image1];
        }
        _Array=Array2;
    //设置Tom的帧动画
    _Tom.animationImages=_Array;
    //设置动画的时间
    _Tom.animationDuration=0.1*_Array.count;
    //设置动画是否重复
    _Tom.animationRepeatCount=1;
    //启动动画
    [_Tom startAnimating];
    [_Tom performSelector:@selector(setAnimationImages:) withObject:nil afterDelay:_Tom.animationDuration];//把帧动画缓存的数组清空  还可以用NSTimer设置定时器的方法清空，但是用定时器时一定要回收定时器  perform这个方法是NSObject中的方法，也就是说只要是继承与NSObject的子类就都可以使用这个方法
    
}
-(IBAction)yunxing:(UIButton *)sender
{
    switch (sender.tag) {
        case 101:
            [self Name:@"angry" andCount:26];
            break;
        case 102:
            [self Name:@"knockout" andCount:81];
            break;
        case 103:
            [self Name:@"stomach" andCount:34];
            break;
        case 104:
            [self Name:@"foot_left" andCount:30];
            break;
        case 105:
            [self Name:@"foot_right" andCount:30];
            break;
        case 106:
            [self Name:@"fart" andCount:28];
            break;
        case 107:
            [self Name:@"drink" andCount:81];
            break;
        case 108:
            [self Name:@"cymbal" andCount:13];
            break;
        case 109:
            [self Name:@"pie" andCount:24];
            break;
        case 110:
            [self Name:@"scratch" andCount:56];
            break;
        case 111:
            [self Name:@"eat" andCount:40];
            break;
            
        default:
            break;
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
