//
//  ViewController.m
//  02-NSURLSeesionDataTaskPOST
//
//  Created by qingyun on 16/6/4.
//  Copyright © 2016年 QingYun. All rights reserved.
//

#import "ViewController.h"
#define BASEPOSTURL @"http://afnetworking.sinaapp.com/request_post_body_http.json"



@interface ViewController ()

@end

@implementation ViewController

- (IBAction)PostAction:(id)sender {
    //1.创建URL对象
    NSURL *url=[NSURL URLWithString:BASEPOSTURL];
    //2.创建请求对象
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
    //2.1设置请求方法
      request.HTTPMethod=@"POST";
    //2.2设置HTTPBody 请求体
       NSString *bodyStr=@"foo=bar";
      request.HTTPBody=[bodyStr dataUsingEncoding:NSUTF8StringEncoding];
    //3.创建session会话对象
    NSURLSession *session=[NSURLSession sharedSession];
    //3.1创建NSURLSessionDataTask 对象
     NSURLSessionDataTask *task=[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
         if(error)NSLog(@"=====%@",error);
         NSHTTPURLResponse *httpResponse=(NSHTTPURLResponse *)response;
         //判断当前响应状态码
         if (httpResponse.statusCode==200) {
            //1.数据解析
             NSString *str=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
             NSLog(@"========%@",str);
            //2.刷新UI 主线程刷新
            
         }
     }];
    
    //4.请求
    [task resume];
    
    
    
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
