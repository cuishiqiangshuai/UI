//
//  QYStoryBoardSegue.m
//  01-LoginDemoWithSegue
//
//  Created by qingyun on 16/4/28.
//  Copyright © 2016年 QingYun. All rights reserved.
//

#import "QYStoryBoardSegue.h"

@implementation QYStoryBoardSegue

-(void)perform{
    //根据用户名和密码来进行判断，正确的情况下跳转
    //取出源视图控制器（loginVC）
    UIViewController *sourceVC = self.sourceViewController;
    //取出目标视图控制器（userInfoVC）
    UIViewController *destinationVC = self.destinationViewController;
    //取出用户名和密码
    NSString *userName = [sourceVC valueForKeyPath:@"userNameTF.text"];
    NSString *passWord = [sourceVC valueForKeyPath:@"passWordTF.text"];
    NSLog(@"username:%@\npassword:%@",userName,passWord);
    //获取源视图控制器中的用户名和密码输入框
    UITextField *userTF = [sourceVC valueForKey:@"userNameTF"];
    UITextField *passWordTF = [sourceVC valueForKey:@"passWordTF"];
    
    //用户名或密码为nil
    if (userName.length == 0 || passWord.length == 0) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"警告" message:@"账号或密码不能为空" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {}];
        UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"考虑下" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {}];
        UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            userTF.text = nil;
            passWordTF.text = nil;
        }];
        [alertController addAction:action1];
        [alertController addAction:action2];
        [alertController addAction:action3];
        [sourceVC presentViewController:alertController animated:YES completion:nil];
        return;
    }
    
    //用户名和密码正确
    if ([userName isEqualToString:@"123456"] && [passWord isEqualToString:@"qwertyuiop"]) {
        [sourceVC presentViewController:destinationVC animated:YES completion:^{
            userTF.text = nil;
            passWordTF.text = nil;
        }];
    }else{
#if 1
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"用户名或密码错误" delegate:nil cancelButtonTitle:@"取消" destructiveButtonTitle:@"想一下" otherButtonTitles:@"确定",@"不太确定", nil];
        [actionSheet showInView:sourceVC.view];
#else
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"警告" message:@"用户名或密码错误" preferredStyle:UIAlertControllerStyleAlert];
        
        //添加用户名和密码输入框
        [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            textField.placeholder = @"请输入用户名";
            textField.keyboardType = UIKeyboardTypeNumberPad;
        }];
        
        [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            textField.placeholder = @"请输入密码";
            textField.secureTextEntry = YES;
        }];
        
        UIAlertAction *yesAction = [UIAlertAction actionWithTitle:@"登录" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            //取出弹出框内的用户名和密码输入框
            UITextField *tf1 = alertController.textFields[0];
            UITextField *tf2 = alertController.textFields.lastObject;
            if ([tf1.text isEqualToString:@"123456"] && [tf2.text isEqualToString:@"qwertyuiop"]) {
                [destinationVC setValue:tf1.text forKey:@"userNameString"];
                [sourceVC presentViewController:destinationVC animated:YES completion:^{}];
            }
        }];
        
        UIAlertAction *noAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {}];
        [alertController addAction:yesAction];
        [alertController addAction:noAction];
        [sourceVC presentViewController:alertController animated:YES completion:nil];
        
#endif
    }
}
@end
