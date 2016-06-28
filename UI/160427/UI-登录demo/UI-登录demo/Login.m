//
//  ViewController.m
//  UI-登录demo
//
//  Created by qingyun on 16/4/27.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "Login.h"
#import "zhuxiao.h"

@interface Login ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *userpass;

@end

@implementation Login  

- (void)viewDidLoad {
    [super viewDidLoad];
    _userName.delegate=self;
    _userpass.delegate=self;
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)login:(UIButton *)sender {
    //判断用户名或密码不能为空
    if (_userName.text.length==0||_userpass.text.length==0)
    {
        //需要创建一个但弹出视图控制器
        UIAlertController *alertController=[UIAlertController alertControllerWithTitle:@"警告" message:@"用户名和密码不能为空" preferredStyle: UIAlertControllerStyleAlert];//UIAlertControllerStyleAlert是从中间弹出
        //创建action()
        UIAlertAction *action=[UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"知道之后需要做的事");
        }];
        //添加action
        [alertController addAction:action];
        //弹出alertController
        [self presentViewController:alertController animated:YES completion:nil];
        return;
    }
    //正确情况下
    if ([_userName.text isEqualToString:@"123456"]&&[_userpass.text isEqualToString:@"qwertyuiop"])
    {
        //会跳转到下一界面
        //需要先创建一个storyboard
        UIStoryboard *zhuxiaosb=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
        //创建下一个界面的视图控制器
        zhuxiao *zhuxiaoVC=[zhuxiaosb instantiateViewControllerWithIdentifier:@"userInfo"];
        zhuxiaoVC.userNameString=_userName.text;
        //设置模态动画效果
        zhuxiaoVC.modalTransitionStyle=UIModalTransitionStylePartialCurl;
        [self presentViewController:zhuxiaoVC animated:YES completion:^{
            _userName.text=nil;
            _userpass.text=nil;
        }];
    }
    else
    {
#if 1
        //创建一个弹出视图
        UIAlertController *alertController2=[UIAlertController alertControllerWithTitle:@"警告" message:@"用户名不存在或密码错误" preferredStyle:UIAlertControllerStyleActionSheet];//UIAlertControllerStyleActionSheet是从底部弹出
        UIAlertAction *alertAction=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@".....");
        }];
        [alertController2 addAction:alertAction];
        [self presentViewController:alertController2 animated:YES completion:nil];
#else
        //创建一个弹出视图
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"警告" message:@"用户名或密码错误，请重新输入" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        //显示弹出视图
        [alertView show];
#endif
    }
}
//当将要修改textfield的内容时，判断是否允许修改
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(nonnull NSString *)string
{
    NSLog(@"range:%@",NSStringFromRange(range));
    NSLog(@"replacementString:%@",string);
    if (string.length>1)
    {
        return NO;
    }
    return YES;
}
//当点击return时候调用
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];//resignFirstResponder是触发键盘隐藏
    [self login:nil];//这句话的意思就是点return也触发上面的login的方法
    return YES;
}
//这个方法是隐藏键盘的方法（当点击屏幕是隐藏键盘）
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
