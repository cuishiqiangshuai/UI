//
//  ViewController.m
//  MVC，字典转模型，应用管理器的Demo
//
//  Created by qingyun on 16/5/3.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property(nonatomic,strong)NSArray *apps;
@end

@implementation ViewController


-(NSArray *)apps
{
    if (_apps==nil)
    {
        NSString *path=[[NSBundle mainBundle] pathForResource:@"apps" ofType:@"plist"];
        
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
