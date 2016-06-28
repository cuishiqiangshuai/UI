//
//  secondViewController.m
//  UINavigationViewController 代码
//
//  Created by qingyun on 16/5/6.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "SecondViewController.h"
#import "ThreeViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor redColor]];
    self.title=[NSString stringWithFormat:@"点我"];
    UIBarButtonItem *rightBtnItem=[[UIBarButtonItem alloc] initWithTitle:@"点我" style:UIBarButtonItemStylePlain target:self action:@selector(nextView)];
    self.navigationItem.rightBarButtonItem=rightBtnItem;
}
-(void)nextView
{
    ThreeViewController *threeView=[ThreeViewController new];
    [self.navigationController pushViewController:threeView animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
