//
//  ViewController.m
//  01-LoginDemoWithSegue
//
//  Created by qingyun on 16/4/28.
//  Copyright © 2016年 QingYun. All rights reserved.
//

#import "LoginVC.h"

@interface LoginVC ()
@property (strong, nonatomic) IBOutlet UITextField *userNameTF;
@property (strong, nonatomic) IBOutlet UITextField *passWordTF;

@end

@implementation LoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

//为当前视图控制器中所有的UIStoryboardSegue做准备
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"login"]) {
        //源控制器（self）和目标视图控制器（userInfoVC）
        UIViewController *sourceVC = segue.sourceViewController;
        UIViewController *destinationVC = segue.destinationViewController;
        //把源视图控制器的用户名传递目标视图控制器的userNameString
        [destinationVC setValue:_userNameTF.text forKey:@"userNameString"];
    }
}

-(IBAction)back:(UIStoryboardSegue *)unwindSegue{
    if ([unwindSegue.identifier isEqualToString:@"back"]) {
        //从个人中心返回
        NSLog(@"sourceVC:%@",unwindSegue.sourceViewController);
        NSLog(@"destinationVC:%@",unwindSegue.destinationViewController);
    }
}

@end
