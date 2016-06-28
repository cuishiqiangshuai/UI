//
//  ViewController.m
//  01-NSURLSessionDataTaskDemo
//
//  Created by qingyun on 16/6/4.
//  Copyright © 2016年 QingYun. All rights reserved.
//

#import "ViewController.h"

#define BASEURL @"http://www.baidu.com/"
#define BASEIMAGE @"http://img14.poco.cn/mypoco/myphoto/20130131/22/17323571520130131221457027_640.jpg"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *TempImageView;

@end

@implementation ViewController

- (IBAction)DownAction:(id)sender {
    //1.创建URL
    NSURL *url=[NSURL URLWithString:BASEIMAGE];
    //2.创建会话对象session
    NSURLSession *session=[NSURLSession sharedSession];
    //3.创建请求加载任务 NSURLSessionDataTask
    __weak UIImageView *temp=_TempImageView ;
    NSURLSessionDataTask *task=[session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
      //3.1判断是否成功
        if(error)NSLog(@"====%@",error);
        NSHTTPURLResponse *httpResponse=(NSHTTPURLResponse *)response;
        if (httpResponse.statusCode==200) {
          //3.2解析数据
            UIImage *image=[UIImage imageWithData:data];
          //3.3 刷新UI 要通过主线程来做
            
            dispatch_async(dispatch_get_main_queue(), ^{
               temp.image=image;
            });
        }
    }];
    
    //4.启动请求
    [task resume];
    
}


- (IBAction)touchAction:(UIButton *)sender {
    //1.创建URL
    NSURL *url=[NSURL URLWithString:BASEURL];
    //2.创建NSURLRequest对象
    NSURLRequest *request=[NSURLRequest requestWithURL:url];
    
    //3.创建session对象
    NSURLSession *seesion=[NSURLSession sharedSession];

    //4.NSURLSessionDataTask 对象 加载任务
    /**
     *  网络请求加载task
     *
     *  @param data     请求回来的数据
     *  @param response 响应的对象
     *  @param error    请求错误的信息
     *
     *  @return NSURLSessionDataTask 对象
     */
   NSURLSessionDataTask *task=[seesion dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
       if (error) {
           NSLog(@"======%@",error);
           return ;
       }
      //4.1 NSURLResponse+====>NSHttpURLResponse;
       NSHTTPURLResponse *httpResponse=(NSHTTPURLResponse *)response;
       //4.2判断响应状态码
       if(httpResponse.statusCode==200){
       //4.3 请求成功.   解析data数据
        NSString *str=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
           NSLog(@"============%@",str);
           [str writeToFile:@"/Users/qingyun/Desktop/qingyun.html" atomically:YES encoding:NSUTF8StringEncoding error:nil];
       }
  }];
    
    //5.启动请求
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
