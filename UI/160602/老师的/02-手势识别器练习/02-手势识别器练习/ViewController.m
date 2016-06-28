//
//  ViewController.m
//  02-手势识别器练习
//
//  Created by qingyun on 16/6/2.
//  Copyright © 2016年 QingYun. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIGestureRecognizerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *cyanImageView;
@property (weak, nonatomic) IBOutlet UIImageView *magentImageView;
@property (weak, nonatomic) IBOutlet UIImageView *yellowImagView;
@property (strong,nonatomic) UIView *tempView;
@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

#pragma mark - 重置
-(void)clickRest{
    [UIView animateWithDuration:.3 animations:^{
        _tempView.transform=CGAffineTransformIdentity;
    }];
}


//平移手势
- (IBAction)PanGestureAction:(UIPanGestureRecognizer *)sender {
    //1.获取一个点绝对值,但是需要的是一个增量值
    CGPoint point=[sender translationInView:sender.view.superview];
    NSLog(@"=====%@",NSStringFromCGPoint(point));
    //2重置point坐标 x,y 设置初始化 从零开始
    [sender setTranslation:CGPointZero inView:sender.view.superview];
    sender.view.center=CGPointMake(sender.view.center.x+point.x, sender.view.center.y+point.y);

}
//捏合手势放大缩小
- (IBAction)pinchAction:(UIPinchGestureRecognizer *)sender {
    //1.获取当前放大的比例
    float scale=sender.scale;
    NSLog(@"========%f",scale);
    //仿射变换 scale 比例
    sender.view.transform=CGAffineTransformScale(sender.view.transform, scale, scale);
    //scale 置1,因为它本身是个绝对值,我们所需要的是个增量值
    sender.scale=1;
}

//旋转手势
- (IBAction)rotationAction:(UIRotationGestureRecognizer *)sender {
    //旋转角度
    NSLog(@"=====%f",sender.rotation);
    sender.view.transform=CGAffineTransformRotate(sender.view.transform, sender.rotation);
    //因为rotaion是个绝对值,而我们需要一个增量值,所以要rotation置0;
    sender.rotation=0;
}

-(BOOL)canBecomeFirstResponder{
    return YES;
}


//长按手势
- (IBAction)longPressAction:(UILongPressGestureRecognizer *)sender {
    
    //调用编辑菜单时必须当前控制器成为第一响应者
    
     if (sender.state==UIGestureRecognizerStateBegan&&[sender.view becomeFirstResponder]) {
       //1.获取MenuController对象
         UIMenuController *menuController=[UIMenuController sharedMenuController];
        //1.1 menuItems对象
         UIMenuItem *menuItem=[[UIMenuItem alloc] initWithTitle:@"reset" action:@selector(clickRest)];
         menuController.menuItems=@[menuItem];
      //2.显示位置
         CGPoint point=[sender locationInView:sender.view];
         [menuController setTargetRect:CGRectMake(point.x, point.y,0,0) inView:sender.view];
      //3.显示出来
         [menuController setMenuVisible:YES animated:YES];

         _tempView=sender.view;
         
    }
}



//代理主要可以解决两个手势的冲突 return YES 两个手势可以同时执行
#pragma mark - GesutreDelegate
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{

    return YES;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
