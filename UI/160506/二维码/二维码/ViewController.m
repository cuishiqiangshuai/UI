//
//  ViewController.m
//  二维码
//
//  Created by qingyun on 16/5/9.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "ViewController.h"
#import <CoreImage/CoreImage.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //创建过滤器
    CIFilter *filter=[CIFilter filterWithName:@"CIQRCodeGenerator"];
    //恢复默认设置
    [filter setDefaults];
    //给过滤器添加数据
    NSString *str=@"崔世强";//这里可以是URL
    NSData *data=[str dataUsingEncoding:NSUTF8StringEncoding];
    [filter setValue:data forKey:@"inputMessage"];
    //输出获取的二维码
    CIImage *image=[filter outputImage];
    //显示二维码
    UIImageView *imageView=[[UIImageView alloc] initWithFrame:CGRectMake(20, 20, 100, 100)];
    imageView.image=[UIImage imageWithCIImage:image];
    [self.view addSubview:imageView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
