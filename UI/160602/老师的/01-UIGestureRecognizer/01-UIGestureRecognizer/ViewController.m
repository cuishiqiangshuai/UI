//
//  ViewController.m
//  01-UIGestureRecognizer
//
//  Created by qingyun on 16/6/2.
//  Copyright © 2016年 QingYun. All rights reserved.
//

#import "ViewController.h"
/**
 点击手势 (UITapGestureRecognizer)
 滑动手势 (UISwipeGestureRecognizer)
 旋转手势 (UIRotationGestureRecognizer)
 捏合手势 (UIPinchGestureRecognizer)
 长按手势 (UILongPressGestureRecognizer)
 平移手势 (UIPanGestureRecognizer)
 屏幕边缘平移手势 (UIScreenEdgePanGestureRecognizer)
 */

@interface ViewController ()

@end

@implementation ViewController

//单击
-(void)singleTapGesture:(UITapGestureRecognizer *)gesture{
    NSLog(@"单击了");
}
//双击
-(void)doubleTapGesture:(UITapGestureRecognizer *)gesture{
    NSLog(@"====双击了");

}
//滑动手势
-(void)swipeAction:(UISwipeGestureRecognizer *)geture{
    NSLog(@"=======滑动了");
}

//旋转手势
-(void)rotationAction:(UIRotationGestureRecognizer *)rotaton{
    NSLog(@"[======旋转====%f",rotaton.rotation);
    rotaton.rotation=0;
}

//捏合手势
-(void)pinchAction:(UIPinchGestureRecognizer *)pinchRecognizer{
    //绝对值
    NSLog(@"====捏合===%f",pinchRecognizer.scale);
}
//长按手势
-(void)longPressAction:(UILongPressGestureRecognizer *)longPressRecognizer{
    if(longPressRecognizer.state==UIGestureRecognizerStateBegan){
       NSLog(@"====begin=长按了");
    }else if(longPressRecognizer.state==UIGestureRecognizerStateChanged){
        NSLog(@"===change==长按了");
    }else if(longPressRecognizer.state==UIGestureRecognizerStateEnded){
        NSLog(@"===end==长按了");
    }
}
//平移手势
-(void)pangesture:(UIPanGestureRecognizer*)panGesutre{
  //平移手势
    NSLog(@"======平移了");
    CGPoint point=[panGesutre translationInView:panGesutre.view];
    NSLog(@"=====%@",NSStringFromCGPoint(point));
}
//屏幕边缘手势
-(void)screenAction:(UIScreenEdgePanGestureRecognizer *)screent{
    NSLog(@"边缘移动了");
}


- (void)viewDidLoad {
    [super viewDidLoad];
    //1.单击手势
    UITapGestureRecognizer *singleTap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapGesture:)];
    //1.2点击次数
     singleTap.numberOfTapsRequired=1;
    [self.view addGestureRecognizer:singleTap];

    //2.双击手势
    UITapGestureRecognizer *doubleTap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTapGesture:)];
    doubleTap.numberOfTapsRequired=2;
    [self.view addGestureRecognizer:doubleTap];
    //xample usage: a single tap may require a double tap to fail
    //建立单击手势和双击手势的依赖关系
    [singleTap requireGestureRecognizerToFail:doubleTap];
    //滑动手势
    UISwipeGestureRecognizer *swipeGesture=[[UISwipeGestureRecognizer alloc] init];
    [swipeGesture addTarget:self action:@selector(swipeAction:)];
    swipeGesture.direction=UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:swipeGesture];
    
    //旋转手势
    UIRotationGestureRecognizer *rotationGesture=[[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotationAction:)];
    [self.view addGestureRecognizer:rotationGesture];
    
    //捏合手势
    UIPinchGestureRecognizer *pinchGesture=[[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchAction:)];
    [self.view addGestureRecognizer:pinchGesture];
    //长按
    UILongPressGestureRecognizer *longPressGesture=[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressAction:)];
    [self.view addGestureRecognizer:longPressGesture];
//    //平移
//    UIPanGestureRecognizer *panGesture=[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pangesture:)];
//    [self.view addGestureRecognizer:panGesture];
//    
    //屏幕边缘手势
    UIScreenEdgePanGestureRecognizer *screenGesture=[[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(screenAction:)];
    screenGesture.edges=UIRectEdgeAll;
    [self.view addGestureRecognizer:screenGesture];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
