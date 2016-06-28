//
//  ChangeUserInfoVC.m
//  02-LoginDemo
//
//  Created by qingyun on 16/4/28.
//  Copyright © 2016年 QingYun. All rights reserved.
//

#import "ChangeUserInfoVC.h"

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
    //代理执行协议方法之前要判断，具备相应协议方法的能力
    if ([self.delegate respondsToSelector:@selector(changeTextForDescLabel:)]) {
        [self.delegate changeTextForDescLabel:_textField.text];
    }
    
    //更改个性签名
    [self dismissViewControllerAnimated:YES completion:^{}];
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
