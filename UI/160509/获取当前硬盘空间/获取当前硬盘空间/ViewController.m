//
//  ViewController.m
//  获取当前硬盘空间
//
//  Created by qingyun on 16/5/10.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSFileManager *fm=[NSFileManager defaultManager];
    NSDictionary *dict=[fm attributesOfFileSystemForPath:NSHomeDirectory() error:nil];
    NSLog(@"容量:%lldG",[[dict objectForKey:NSFileSystemSize] longLongValue]/1000000000);
    NSLog(@"可用:%lldG",[[dict objectForKey:NSFileSystemFreeSize] longLongValue]/1000000000);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
