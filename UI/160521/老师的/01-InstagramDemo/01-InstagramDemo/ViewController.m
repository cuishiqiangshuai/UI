//
//  ViewController.m
//  01-InstagramDemo
//
//  Created by qingyun on 16/5/21.
//  Copyright © 2016年 QingYun. All rights reserved.
//

#import "ViewController.h"
#import "QYInstagramView.h"
@interface ViewController ()
@property (nonatomic, strong) QYInstagramView *instagramView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _instagramView = [[QYInstagramView alloc] init];
    [self.view addSubview:_instagramView];
    
    
    _instagramView.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSDictionary *views = NSDictionaryOfVariableBindings(self.view,_instagramView);
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_instagramView]-|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_instagramView]|" options:0 metrics:nil views:views]];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSLog(@"%s-----frame:%@",__func__,NSStringFromCGRect(_instagramView.frame));
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    NSLog(@"%s-----frame:%@",__func__,NSStringFromCGRect(_instagramView.frame));
}

-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    NSLog(@"%s-----frame:%@",__func__,NSStringFromCGRect(_instagramView.frame));
}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    NSLog(@"%s-----frame:%@",__func__,NSStringFromCGRect(_instagramView.frame));
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
