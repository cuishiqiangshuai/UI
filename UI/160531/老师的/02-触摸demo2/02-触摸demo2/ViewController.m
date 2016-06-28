//
//  ViewController.m
//  02-触摸demo2
//
//  Created by qingyun on 16/5/31.
//  Copyright © 2016年 QingYun. All rights reserved.
//

#import "ViewController.h"
#import "QYTextField.h"
#import "QYButton.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet QYTextField *myTextFiled;
@property (weak, nonatomic) IBOutlet QYButton *clickBtn;

@end

@implementation ViewController

//-(void)clickMe{
//    NSLog(@"=====%s",__func__);
//}


//-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    NSLog(@"===%s",__func__);
//    [_myTextFiled resignFirstResponder];
//    [self.nextResponder touchesBegan:touches withEvent:event];
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    //打开多点触摸
    self.view.multipleTouchEnabled=YES;
    
//    CGRectContainsPoint(<#CGRect rect#>, <#CGPoint point#>);
    
    [_clickBtn addTarget:nil action:@selector(clickMe) forControlEvents:UIControlEventTouchUpInside];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
