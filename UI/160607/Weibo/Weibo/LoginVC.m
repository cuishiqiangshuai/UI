//
//  LoginVC.m
//  Weibo
//
//  Created by qingyun on 16/6/7.
//  Copyright © 2016年 QingYun. All rights reserved.
//

#import "LoginVC.h"
#import "ConfigFile.h"
#import "AccessToken.h"

static NSString *APPKEY=@"2952714169";
static NSString *DIRPATH=@"http://www.baidu.com";
static NSString *APPSECRET=@"4e808c66563fd9cbe63b96f979f63dda";

@interface LoginVC ()<UIWebViewDelegate>
@property(nonatomic,strong)UIWebView *myWeb;
@end

@implementation LoginVC

-(UIWebView*)myWeb{
    if (_myWeb==nil) {
        _myWeb=[[UIWebView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, self.view.frame.size.height)];
        _myWeb.delegate=self;
        //设置自适应宽度
        _myWeb.scalesPageToFit=YES;
    }
    return _myWeb;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.myWeb];
    [self getUserTempToken];
}

-(void)getUserTempToken{
    //合并url
    NSURL *url=[NSURL URLWithString:[BASEURL stringByAppendingPathComponent:AUTHORIZEPATH]];
    //设置请求
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod=@"POST";
    //设置body http 默认多个参数用&链接  有两种传输格式http和json，默认是http  body必须是data格式，所以要把string转化为data
    request.HTTPBody=[[NSString stringWithFormat:@"client_id=%@&redirect_uri=%@",APPKEY,DIRPATH] dataUsingEncoding:NSUTF8StringEncoding];
    //webView请求
    [self.myWeb loadRequest:request];
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    //获取授权的code，用来换区授权服务器的令牌accesstoken
    //获取url
    NSURL *url=request.URL;
    //把url转化为string，
    NSString *strUrl=[url absoluteString];
    //判断是否以回调地址开头url 说明是授权成功，获取授权码
    if ([strUrl hasPrefix:DIRPATH]) {
        //截取授权code，截取字符串
        NSArray *arr=[strUrl componentsSeparatedByString:@"="];
        NSString *code=[arr lastObject];
        //请求换取Access_token令牌
        [self getAccessTokenRequest:code];
        return NO;
    }
    return YES;
}

//获取AccessToken
-(void)getAccessTokenRequest:(NSString *)code{
    //url封装
    NSURL *url=[NSURL URLWithString:[BASEURL stringByAppendingPathComponent:GETACCESSTOKENPATH]];
    //设置请求
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
    //设置请求方法
    request.HTTPMethod=@"POST";
    request.HTTPBody=[[NSString stringWithFormat:@"client_id=%@&client_secret=%@&grant_type=authorization_code&code=%@&redirect_uri=%@",APPKEY,APPSECRET,code,DIRPATH] dataUsingEncoding:NSUTF8StringEncoding];
    NSURLSession *session=[NSURLSession sharedSession];
    NSURLSessionDataTask *task=[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSLog(@"%@",error);
        }
            //请求状态
            NSHTTPURLResponse *httpReponse=(NSHTTPURLResponse *)response;
            if (httpReponse.statusCode==200) {
                //解析数据，获取到accesstoken
                NSLog(@"=%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
                //将JSONdata转化为字典
                NSDictionary *pras=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                //字典换模型
                //获取单例对象
                AccessToken *token=[AccessToken shareHandel];
                //用KVC进行赋值
                [token setValuesForKeysWithDictionary:pras];
                //出栈,回到主页
                [self.navigationController popViewControllerAnimated:YES];
            }
    }];
    //启动请求
    [task resume];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
