//
//  userInfoVC.m
//  UI-LoginDemoWithSegue
//
//  Created by qingyun on 16/5/2.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "userInfoVC.h"

@interface UserInfoVC ()
@property (weak, nonatomic) IBOutlet UILabel *welcomeLabel;

@end

@implementation UserInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _welcomeLabel.text=[NSString stringWithFormat:@"欢迎你，%@",_UserNameString];
    // Do any additional setup after loading the view.
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
