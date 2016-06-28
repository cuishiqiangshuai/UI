//
//  FirstDownLoadViewController.m
//  03-DownLoadTaskDemo
//
//  Created by qingyun on 16/6/4.
//  Copyright © 2016年 QingYun. All rights reserved.
//

#import "FirstDownLoadViewController.h"
#define BASEURL @"http://imgst-dl.meilishuo.net/pic/_o/84/a4/a30be77c4ca62cd87156da202faf_1440_900.jpg"


@interface FirstDownLoadViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *tempImageView;
@end

@implementation FirstDownLoadViewController

- (IBAction)DownLoadAction:(id)sender {
   //1.创建URL
    NSURL *url=[NSURL URLWithString:BASEURL];
    //2.session对象
    NSURLSession *session=[NSURLSession sharedSession];
    //3.创建下载任务NSURLSessionDownloadTask
    __weak UIImageView *temp=_tempImageView;
    
    NSURLSessionDownloadTask *task=[session downloadTaskWithURL:url completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if(error)NSLog(@"=====%@",error);
        NSHTTPURLResponse *httpResponse=(NSHTTPURLResponse *)response;
        if (httpResponse.statusCode==200) {
          //location 移动到一个位置,或者打开使用location文件
            NSLog(@"=====%@",location.absoluteString);
         //保存另一个位置
        //            [[NSFileManager defaultManager] copyItemAtURL:location toURL:[NSURL fileURLWithPath:[NSString stringWithFormat:@"/Users/qingyun/Desktop/%@",httpResponse.suggestedFilename]] error:nil];
         //location 读取到内存
            NSData *data=[NSData dataWithContentsOfURL:location];
            UIImage *image=[UIImage imageWithData:data];
         //刷新UI 通过主线程来做
            if (image) {
              dispatch_async(dispatch_get_main_queue(), ^{
                  temp.image=image;
              });
            }
        }
    }];
    
    //4.执行下载
    [task resume];
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

@end
