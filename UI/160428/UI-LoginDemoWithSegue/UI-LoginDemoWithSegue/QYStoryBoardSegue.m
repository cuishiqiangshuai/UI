//
//  QYStoryBoardSegue.m
//  UI-LoginDemoWithSegue
//
//  Created by qingyun on 16/5/2.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "QYStoryBoardSegue.h"

@implementation QYStoryBoardSegue
-(void)perform{
    //根据用户名和密码进行判断，正确情况下进行跳转
    //取出源视图控制器（LoginVC）和目标视图控制器
    UIViewController *sourceVC=self.sourceViewController;
    UIViewController *destinationVC=self.destinationViewController;
    //取出用户名和密码
    NSString *userName=[sourceVC valueForKeyPath:@"userNameTF.text"];
    NSString *userPassWord=[sourceVC valueForKeyPath:@"userPassWordTF.text"];
    NSLog(@"username:%@\n userpassword:%@",userName,userPassWord);
    //获取源视图控制器中的用户名和密码输入框
    UITextField *userTF=[sourceVC valueForKey:@"userNameTF"];
    UITextField *passTF=[sourceVC valueForKey:@"userPassWordTF"];
    if (userName.length==0||userPassWord.length==0)
    {
        UIAlertController *alertController=[UIAlertController alertControllerWithTitle:@"警告" message:@"用户名和密码不能为空" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action1=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {}];
        UIAlertAction *action2=[UIAlertAction actionWithTitle:@"考虑下" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {}];
        UIAlertAction *action3=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            userTF.text=nil;
            passTF.text=nil;
        }];
        [alertController addAction:action1];
        [alertController addAction:action2];
        [alertController addAction:action3];
        [sourceVC presentViewController:alertController animated:YES completion:nil];
        return;
    }
    //用户名和密码正确
    if ([userName isEqualToString:@"123456"] && [userPassWord isEqualToString:@"qwertyuiop"]) {
        [sourceVC presentViewController:destinationVC animated:YES completion:^{
            userTF.text = nil;
            passTF.text = nil;
        }];
    }else{
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"用户名或密码错误" delegate:nil cancelButtonTitle:@"取消" destructiveButtonTitle:@"想一下" otherButtonTitles:@"确定",@"不太确定", nil];
        [actionSheet showInView:sourceVC.view];
}
}
@end
