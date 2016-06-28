//
//  ViewController.m
//  UINavigationViewController 代码
//
//  Created by qingyun on 16/5/6.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "ViewController.h"
#import "secondViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent=YES;
    [self.view setBackgroundColor:[UIColor greenColor]];
    UIButton *Btn=[UIButton buttonWithType:UIButtonTypeCustom];
    Btn.center=self.view.center;
    Btn.frame=CGRectMake(self.view.center.x, self.view.center.y, 40, 40);
    [Btn setBackgroundColor:[UIColor redColor]];
    [Btn setTitle:@"点我" forState:UIControlStateNormal];
    [self.view addSubview:Btn];
    self.title=[NSString stringWithFormat:@"点我"];
    [Btn addTarget:self action:@selector(firstBtn) forControlEvents:UIControlEventTouchUpInside];
}
-(void)firstBtn
{
    SecondViewController *second=[[SecondViewController alloc] init];
    [self.navigationController pushViewController:second animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
