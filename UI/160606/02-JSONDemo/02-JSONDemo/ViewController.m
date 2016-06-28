//
//  ViewController.m
//  02-JSONDemo
//
//  Created by qingyun on 16/6/6.
//  Copyright © 2016年 QingYun. All rights reserved.
//

#import "ViewController.h"
#define BASEURL @"http://www.zhihuiluanchuan.com/index.php?s=/Api/document/zxrd"
@interface ViewController ()

@end

@implementation ViewController

-(void)request{
   //1.网络请求
    NSURL *url=[NSURL URLWithString:BASEURL];
    
   //2.session 对象
    NSURLSession *session=[NSURLSession sharedSession];
   //3.请求
    NSURLSessionDataTask *task=[session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
       if(error)NSLog(@"====%@",error);
        NSHTTPURLResponse *httpResoponse=(NSHTTPURLResponse *)response;
        if (httpResoponse.statusCode==200) {
         //1.把data转化成一个json对象 json解析
            id responsedObjc=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            if ([responsedObjc isKindOfClass:[NSDictionary class]]) {
                NSLog(@"======%@",responsedObjc);
                
          //2.字典装模型
                
          //3.刷新UI
            }
        }
    }];
    //4.启动请求
    [task resume];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self request];
    //封装一个JsonData json封装
    /**
     *  username
        pwd
        phone:[]
     */
    NSDictionary *pras=@{@"usrename":@"zhangsan",@"pwd":@"123556",@"phone":@[@"1234567890",@"098765432"]};
    
    NSData *Jsondata=[NSJSONSerialization dataWithJSONObject:pras options:NSJSONWritingPrettyPrinted error:nil];
    
    NSString *string=[[NSString alloc] initWithData:Jsondata encoding:NSUTF8StringEncoding];
    NSLog(@"=========%@",string);
    //json格式数据交换方式  http & & &
    //www.example.com/index.html/?string
    
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
