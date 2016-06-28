//
//  SecondViewController.m
//  03-DownLoadTaskDemo
//
//  Created by qingyun on 16/6/4.
//  Copyright © 2016年 QingYun. All rights reserved.
//

#import "SecondViewController.h"
#define BaseURL @"http://imgst-dl.meilishuo.net/pic/_o/84/a4/a30be77c4ca62cd87156da202faf_1440_900.jpg"


@interface SecondViewController ()<NSURLSessionDownloadDelegate>
@property (weak, nonatomic) IBOutlet   UIImageView *tempImageView;
@property (strong, nonatomic) IBOutlet UIProgressView *ProgressView;
@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (IBAction)downLoadAction:(id)sender {
   //1.创建URL
    NSURL *url=[NSURL URLWithString:BaseURL];
   //2.创建session对象
    NSURLSession *session=[NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:nil];
    //3.创建下载任务
     NSURLSessionDownloadTask *task=[session downloadTaskWithURL:url];
   //4.启动任务
    [task resume];
}
#pragma mark - NSURLSeesionDownLoadTaskDelegate
//下载完成时候调用,只会调用一次
-(void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location{
    //location文件转换成Nsdata
    NSData *data=[[NSData alloc] initWithContentsOfURL:location];
    UIImage *image=[UIImage imageWithData:data];
   //更新UI
    __weak UIImageView *tempImage=_tempImageView;
    __weak UIProgressView *proView=_ProgressView;
    dispatch_sync(dispatch_get_main_queue(), ^{
        tempImage.image=image;
        proView.hidden=YES;
    });
   
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
