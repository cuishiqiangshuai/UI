//
//  zhuxiao.m
//  UI-登录demo
//
//  Created by qingyun on 16/4/27.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "zhuxiao.h"

@interface zhuxiao ()
@property (weak, nonatomic) IBOutlet UILabel *welcome;

@end

@implementation zhuxiao

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor=[UIColor redColor];//不设置颜色的话，显示的是window的颜色
    //设置欢迎信息
    _welcome.text=[NSString stringWithFormat:@"欢迎你，%@",_userNameString];
}
//注销
- (IBAction)zhuxiao:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
