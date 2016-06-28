//
//  ViewController.m
//  UI-LoginDemoWithSegue
//
//  Created by qingyun on 16/4/28.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "LoginVC.h"

@interface LoginVC ()
@property (weak, nonatomic) IBOutlet UITextField *userNameTF;
@property (weak, nonatomic) IBOutlet UITextField *userPassWordTF;

@end

@implementation LoginVC

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"login"]) {
        UIViewController *sourceVC=segue.sourceViewController;
        UIViewController *destinationVC=segue.destinationViewController;
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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
