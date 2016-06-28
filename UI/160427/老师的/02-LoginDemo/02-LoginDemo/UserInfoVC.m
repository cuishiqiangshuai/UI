//
//  UserInfoVC.m
//  02-LoginDemo
//
//  Created by qingyun on 16/4/27.
//  Copyright © 2016年 QingYun. All rights reserved.
//

#import "UserInfoVC.h"

@interface UserInfoVC ()
@property (strong, nonatomic) IBOutlet UILabel *welcomeLabel;

@end

@implementation UserInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor cyanColor];
    //设置欢迎信息
    _welcomeLabel.text = [NSString stringWithFormat:@"欢迎您，%@",_userNameString];
    // Do any additional setup after loading the view.
}
//注销
- (IBAction)logout:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
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
