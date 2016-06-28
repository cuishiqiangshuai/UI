//
//  QYBlueViewController.m
//  Demo02_UINavigationController_SB
//
//  Created by qingyun on 16/5/6.
//  Copyright © 2016年 QingYun. All rights reserved.
//

#import "QYBlueViewController.h"

@interface QYBlueViewController ()
{
    __weak IBOutlet UIButton *_btnBlue;
    
}

@end

@implementation QYBlueViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeContactAdd];
    [self.view addSubview:button];
    
}
- (IBAction)blueButtonAction:(UIButton *)sender {
    
}

@end
