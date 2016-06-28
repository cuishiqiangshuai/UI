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
    
    //更改个性签名
    //使用block的时候要确保不为nil
    if (_changeDescLabel) {
        _changeDescLabel(_textField.text);
    }
    
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
