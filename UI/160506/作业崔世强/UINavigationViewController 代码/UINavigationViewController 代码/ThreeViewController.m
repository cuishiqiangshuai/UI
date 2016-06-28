//
//  ThreeViewController.m
//  UINavigationViewController 代码
//
//  Created by qingyun on 16/5/6.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "ThreeViewController.h"
#import "SecondViewController.h"

@interface ThreeViewController ()

@end

@implementation ThreeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    self.title=@"不要点我";
    UIButton *threeBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    threeBtn.center=self.view.center;
    threeBtn.frame=CGRectMake(self.view.center.x-20, self.view.center.y-2, 120, 40);
    [threeBtn setBackgroundColor:[UIColor blackColor]];
    
    [self.view addSubview:threeBtn];
    [threeBtn setTitle:@"不要点我" forState:UIControlStateNormal];
    [threeBtn addTarget:self action:@selector(threeBtn) forControlEvents:UIControlEventTouchUpInside];
    
}
-(void)threeBtn
{
    [self.navigationController popViewControllerAnimated:YES];
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
