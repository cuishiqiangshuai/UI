//
//  ViewController.m
//  01-MpMoviePlayerDemo
//
//  Created by qingyun on 16/6/24.
//  Copyright © 2016年 QingYun. All rights reserved.
//

#import "ViewController.h"
#import <MediaPlayer/MediaPlayer.h>


@interface ViewController ()

@property(nonatomic,strong)MPMoviePlayerController *mpController;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}


- (IBAction)touchAction:(id)sender {
    
    //1nsurl
    NSURL *url=[NSURL URLWithString:@"http://qiniuuwmp3.changba.com/576270413.mp4"];
    
#if 0
    //2.初始化对象
    _mpController=[[MPMoviePlayerController alloc] initWithContentURL:url];
    //3设置控制面板
    _mpController.controlStyle=MPMovieControlStyleEmbedded;
    
    //4.设置frame
    _mpController.view.frame=CGRectMake(0, 150, self.view.frame.size.width, 300);
    
    [self.view addSubview:_mpController.view];
    //5.播放
    [_mpController play];
#endif
    MPMoviePlayerViewController *playerController=[[MPMoviePlayerViewController alloc] initWithContentURL:url];
    //模态
    [self presentViewController:playerController animated:YES completion:nil];
}


@end
