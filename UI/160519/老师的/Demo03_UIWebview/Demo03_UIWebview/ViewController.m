//
//  ViewController.m
//  Demo03_UIWebview
//
//  Created by qingyun on 16/5/19.
//  Copyright © 2016年 QingYun. All rights reserved.
//

/** QLDEBUG Print | M:method, L:line, C:content*/
#ifndef QLLog
#ifdef DEBUG
#define QLLog(FORMAT, ...) fprintf(stderr,"M:%s|L:%d|C->%s\n", __FUNCTION__, __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String])
#else
#define QLLog(FORMAT, ...)
#endif
#endif

#define QYScreenFrame [UIScreen mainScreen].bounds

#import "ViewController.h"

@interface ViewController () <UIWebViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 创建一个UIWebview实例对象
    UIWebView *webview = [[UIWebView alloc] initWithFrame: QYScreenFrame];
    // 设置UIWebView的代理
    webview.delegate = self;
    
    // 加载网页 方式1:
    //NSURL *url = [NSURL URLWithString:@"http://www.baidu.com"];
    //NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    //[webview loadRequest:urlRequest];
    
    // 加载网页 方式2
    // baseURL: 用来加载HTML对应的修饰文件
    // HTML: html源码, css, javascript
    NSString *strPath = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"html"];
    NSString *strHTML = [NSString stringWithContentsOfFile:strPath encoding:NSUTF8StringEncoding error:nil];
    [webview loadHTMLString:strHTML baseURL:nil];
    
    // MIMEType: text/json, image/jpg, image/png
    //[webview loadData:<#(nonnull NSData *)#> MIMEType:<#(nonnull NSString *)#> textEncodingName:<#(nonnull NSString *)#> baseURL:<#(nonnull NSURL *)#>];
    
    // 把webView添加到当前的视图上
    [self.view addSubview:webview];
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
}

#pragma mark - 🔌 Delegate Methods
#pragma mark UIWebViewDelegate
/*!
 * 当网页请求加载失败的时候会调用这个方法
 */
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    NSLog(@"%@", error.localizedDescription);
}
/*!
 * 当前的请求是不是应该去服务器请求
 */
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    //QLLog(@"%@", request.URL.absoluteString);
    // 取出要请求的URL字符串
    NSString *strUrl = request.URL.absoluteString;
    // 判断这个请求字符串是不是以字符串 [http://map.baidu.com]开头
    BOOL hasPrefix = [strUrl hasPrefix:@"http://map.baidu.com"];
    if (hasPrefix) { // 如果是以这个字符串开头, 就不让加载这个请求
        return NO;
    }
    
    // 否则, 继续加载
    return YES;
}

/*!
 * 请求已经完成加载的时候调用
 */
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    QLLog(@"%@", @"");
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}

/*!
 * 请求已经开始的时候调用这个方法
 */
- (void)webViewDidStartLoad:(UIWebView *)webView {
    QLLog(@"%@", @"");
}


@end
