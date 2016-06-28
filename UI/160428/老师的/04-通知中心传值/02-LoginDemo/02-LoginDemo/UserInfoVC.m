//
//  UserInfoVC.m
//  02-LoginDemo
//
//  Created by qingyun on 16/4/27.
//  Copyright © 2016年 QingYun. All rights reserved.
//

#import "UserInfoVC.h"
#import "ChangeUserInfoVC.h"
#import "Common.h"
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
    //1、获取通知中心
    //2、添加监听,第一个参数:通知的监听者（通知的接收者），第二个参数:接收通知之后，所做的action，第三个参数:当前通知的名称，第四个参数:通知的发送者,（一般情况下，不限）
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeTextForDescLabel:) name:NotificationName object:nil];
    // Do any additional setup after loading the view.
}

//接收到通知后，更改个性签名
-(void)changeTextForDescLabel:(NSNotification *)notification{
    NSLog(@"%@",notification);
    NSDictionary *dict = notification.userInfo;
    NSString *text = dict[@"value"];
    _descLabel.text = text;
}

-(void)dealloc{
    //在控制器销毁的时候移除通知
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NotificationName object:nil];
}

//注销
- (IBAction)logout:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)nextPage:(UIButton *)sender {
    //跳转至更改个性签名界面，并且把个性签名传过去
    ChangeUserInfoVC *changeUserInfoVC = [self.storyboard instantiateViewControllerWithIdentifier:@"changeUserInfo"];
    changeUserInfoVC.descString = _descLabel.text;
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
