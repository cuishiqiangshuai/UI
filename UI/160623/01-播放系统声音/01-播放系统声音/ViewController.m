//
//  ViewController.m
//  01-播放系统声音
//
//  Created by qingyun on 16/6/23.
//  Copyright © 2016年 QingYun. All rights reserved.
//

#import "ViewController.h"
//第一步
#import <AudioToolbox/AudioToolbox.h>
@interface ViewController ()
//播放声音对象
@property(nonatomic)SystemSoundID soundID;
@end

@implementation ViewController
//回调函数
void soundFinished(SystemSoundID snd,void *content){
    NSLog(@"=======wancheng==");
}

//配置播放对象
-(void)setSystemSoundId{
//    //获取音频文件的路径
//    NSURL *url=[[NSBundle mainBundle] URLForResource:@"tap" withExtension:@"caf"];
//    //同过bridge转换
//    CFURLRef urlRef= (__bridge CFURLRef)url;
//    
    CFURLRef urlRef= CFBundleCopyResourceURL(CFBundleGetMainBundle(), CFSTR("tap"), CFSTR("caf"), NULL);
    AudioServicesCreateSystemSoundID(urlRef, &_soundID);
    //释放
    CFRelease(urlRef);
    
    //给声音注册监听,当声音播放完毕后调用
    AudioServicesAddSystemSoundCompletion(_soundID, NULL, NULL,soundFinished, NULL);
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setSystemSoundId];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)playSound:(UIButton *)sender {
    //播放一个声音
    AudioServicesPlaySystemSound(_soundID);
    
}
- (IBAction)playAlertSound:(id)sender {
    //播放警告音+震动
    AudioServicesPlayAlertSound(_soundID);
}

- (IBAction)playVibrate:(UIButton *)sender {
    //播放震动效果
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
}

-(void)dealloc{
    //释放掉_soundID
    AudioServicesDisposeSystemSoundID(_soundID);
}



@end
