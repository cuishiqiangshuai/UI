//
//  ChangeUserInfoVC.m
//  02-LoginDemo
//
//  Created by qingyun on 16/4/28.
//  Copyright © 2016年 QingYun. All rights reserved.
//

#import "ChangeUserInfoVC.h"
#import "Common.h"
@interface ChangeUserInfoVC ()
@property (strong, nonatomic) IBOutlet UITextField *textField;

@end

@implementation ChangeUserInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _textField.text = _descString;
    // Do any additional setup after loading the view.
}

- (IBAction)back:(UIButton *)sender {
    
    //更改个性签名
    
    //1、获取通知中心
    //2、发送更改个性签名的通知,第一个参数:通知的名称,第二个参数:通知的发送者,第三个参数:通知的内容
    [[NSNotificationCenter defaultCenter] postNotificationName:NotificationName object:nil userInfo:@{@"value":_textField.text}];
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
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
