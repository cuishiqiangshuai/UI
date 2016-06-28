//
//  ViewController.m
//  02-LoginDemo
//
//  Created by qingyun on 16/4/27.
//  Copyright © 2016年 QingYun. All rights reserved.
//

#import "LoginVC.h"
#import "UserInfoVC.h"
@interface LoginVC ()<UIAlertViewDelegate,UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UITextField *userNameTF;
@property (strong, nonatomic) IBOutlet UITextField *passWordTF;

@end

@implementation LoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置用户名和密码的代理
    _userNameTF.delegate = self;
    _passWordTF.delegate = self;
    // Do any additional setup after loading the view, typically from a nib.
}

//登录
- (IBAction)login:(UIButton *)sender {
    //1、用户名或密码不能为空
    if (_userNameTF.text.length == 0 || _passWordTF.text.length == 0) {
        //创建一个弹出视图控制器
        //preferredStyle:表示弹出视图控制器的类型（alert，actionSheet）
        //iOS8.0之前的弹出视图：1、UIAlertView 2、UIActionSheet,(课下自己了解)
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"警告" message:@"用户名或密码不能为空" preferredStyle:UIAlertControllerStyleAlert];
        //创建action
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"知道之后，需要做的事情");
        }];
        //添加action
        [alertController addAction:action];
        //弹出alertController
        [self presentViewController:alertController animated:YES completion:nil];
        return;
    }
    //2、用户名和密码必须正确(模拟网络校验)
    if ([_userNameTF.text isEqualToString:@"123456"] && [_passWordTF.text isEqualToString:@"qwertyuiop"]) {
       //3、正确的情况下，跳转到个人中心界面
        //UserInfoVC *userVC = [[UserInfoVC alloc] init];
        //取出storyBoard  self.storyBoard一样（当前视图控制器在storyBoard中）
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UserInfoVC *userVC = [sb instantiateViewControllerWithIdentifier:@"userInfo"];
        userVC.userNameString = _userNameTF.text;
        //设置模态动画效果
        userVC.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        [self presentViewController:userVC animated:YES completion:^{
            _userNameTF.text = nil;
            _passWordTF.text = nil;
        }];
    }else{
        //创建一个弹出视图
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"警告" message:@"用户名或密码错误，请重新输入" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        //显示弹出视图
        [alertView show];
    }
}

#pragma mark - UITextFieldDelegate
//当点击键盘上的return键的时候被调用
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];//
    [self login:nil];
    return YES;
}
//当将要修改textField的内容的时候，判断是否允许更改
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    NSLog(@"range:%@",NSStringFromRange(range));
    NSLog(@"replacementString:%@",string);
    if (string.length > 1) {
        return NO;
    }
    return YES;
}

#pragma mark - UIAlertViewDelegate
//处理点击不同的button
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSLog(@"%ld",buttonIndex);
    if (buttonIndex == 1) {//确定
        _userNameTF.text = nil;
        _passWordTF.text = nil;
    }
}
//触摸开始
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

@end
