//
//  UserInfoVC.m
//  02-LoginDemo
//
//  Created by qingyun on 16/4/27.
//  Copyright © 2016年 QingYun. All rights reserved.
//

#import "UserInfoVC.h"
#import "ChangeUserInfoVC.h"
@interface UserInfoVC ()
@property (strong, nonatomic) IBOutlet UILabel *welcomeLabel;
@property (strong, nonatomic) IBOutlet UILabel *descLabel;

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

- (IBAction)nextPage:(UIButton *)sender {
    //跳转至更改个性签名界面，并且把个性签名传过去
    ChangeUserInfoVC *changeUserInfoVC = [self.storyboard instantiateViewControllerWithIdentifier:@"changeUserInfo"];
    changeUserInfoVC.descString = _descLabel.text;
    //对更改个性签名的block赋值
    changeUserInfoVC.changeDescLabel = ^(NSString *string){
        _descLabel.text = string;
    };
    [self presentViewController:changeUserInfoVC animated:YES completion:nil];
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
