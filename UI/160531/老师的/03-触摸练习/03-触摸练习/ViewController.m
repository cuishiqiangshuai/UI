//
//  ViewController.m
//  03-触摸练习
//
//  Created by qingyun on 16/5/31.
//  Copyright © 2016年 QingYun. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *cyanSquare;
@property (weak, nonatomic) IBOutlet UIImageView *manentaSquare;
@property (weak, nonatomic) IBOutlet UIImageView *yellowSquare;

@property(nonatomic)CGRect rect1,rect2,rect3;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //保存初始化的Frame
    _rect1=_cyanSquare.frame;
    _rect2=_manentaSquare.frame;
    _rect3=_yellowSquare.frame;
    
    
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)setRestFrame{
  [UIView animateWithDuration:.25 animations:^{
      _cyanSquare.frame=_rect1;
      _manentaSquare.frame=_rect2;
      _yellowSquare.frame=_rect3;
  }];
}


-(CGPoint)locationInTouch:(NSSet*)touches{
    //1.获取手指
    UITouch *touch=[touches anyObject];
    //2.获取点相对于self.view
    CGPoint point=[touch locationInView:self.view];
    return point;
}

//判断一个点是否在任意一个矩形区域内
-(BOOL)isImageViewContainPoint:(CGPoint)point{
    if( CGRectContainsPoint(_cyanSquare.frame, point)||CGRectContainsPoint(_manentaSquare.frame, point)||CGRectContainsPoint(_yellowSquare.frame, point))return YES;
    return NO;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //1.获取当前点击的点
    CGPoint point=[self locationInTouch:touches];
    //1.1获取任意一个手指对象UItouch
    UITouch *touch=[touches anyObject];

    //2.判断当前点是否在imageView区域内
    if ([self isImageViewContainPoint:point]) {
        //3.获取当前点击的视图
        UIView *tempView=[touch view];
        [UIView animateWithDuration:.25 animations:^{
            tempView.center=point;
           tempView.transform=CGAffineTransformMakeScale(1.2, 1.2);
        }];
    }else{
        if (touch.tapCount==2) {
            //双击操作恢复当前状态
            [self setRestFrame];
        }
    }
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //1.获取一个点
    CGPoint point=[self locationInTouch:touches];
    
    //2.判断点是否在矩形区域内,矩形区域中心点等于point
    if(CGRectContainsPoint(_cyanSquare.frame, point)){
    [UIView animateWithDuration:.25 animations:^{
        _cyanSquare.center=point;
    }];
    }
    if (CGRectContainsPoint(_manentaSquare.frame, point)) {
       [UIView animateWithDuration:.25 animations:^{
           _manentaSquare.center=point;
       }];
    }
    if (CGRectContainsPoint(_yellowSquare.frame, point)) {
        [UIView animateWithDuration:.25 animations:^{
            _yellowSquare.center=point;
        }];
    }
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //还原视图
    [UIView animateWithDuration:.25 animations:^{
        //获取一个手指对象UITouch
        UITouch *touch=[touches anyObject];
        //获取手指点击视图UIView
        touch.view.transform=CGAffineTransformIdentity;
    }];
}





@end
