//
//  ViewController.m
//  03-RecordPlayer
//
//  Created by qingyun on 16/6/23.
//  Copyright © 2016年 QingYun. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>
@interface ViewController ()
//声明录音对象
@property(nonatomic,strong)AVAudioRecorder *recorder;
//播放器对象
@property(nonatomic,strong)AVAudioPlayer *player;

//文件路径
@property(nonatomic,strong)NSString *filePath;
@end

@implementation ViewController

-(NSString *)filePath{
    if (_filePath) {
        return _filePath;
    }
    NSString *documentsPath=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    _filePath=[documentsPath stringByAppendingPathComponent:@"temp.caf"];
    return _filePath;
}
//设置录音的音频格式
-(NSMutableDictionary *)setAudioSetings{
    NSMutableDictionary *setS=[NSMutableDictionary dictionary];
   //1设置编码格式,编码格式为线性时,存储格式不能用mp3  用caf wav
    [setS setObject:@(kAudioFormatLinearPCM) forKey:AVFormatIDKey];
   //2设置采样率
    [setS setObject:@(8000) forKey:AVSampleRateKey];
   //3设置声道数量
    [setS setObject:@(2) forKey:AVNumberOfChannelsKey];
   //4.设置量化位数
    [setS setObject:@8 forKey:AVLinearPCMBitDepthKey];
   //5.设置编码质量
    [setS setObject:@(AVAudioQualityHigh) forKey:AVEncoderAudioQualityKey];

    return setS;
}

-(AVAudioPlayer *)player{
    if (_player) {
        return _player;
    }
    //初始化播放器对象
    _player=[[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:self.filePath] error:nil];
    //准备播放
    [_player prepareToPlay];
    return _player;
}

-(AVAudioRecorder *)recorder{
    if (_recorder) {
        return _recorder;
    }
   
    //初始化录音器对象
    NSError *error;
    _recorder=[[AVAudioRecorder alloc] initWithURL:[NSURL URLWithString:self.filePath] settings:[self setAudioSetings] error:&error];
    NSLog(@"=====%@",error);
    
    //准备初始化
    [_recorder prepareToRecord];
    
    return _recorder;
}



-(void)deleteAction:(UIButton *)btn{
    //停止录制
    [self.recorder stop];
    if ([self.recorder deleteRecording]) {
        NSLog(@"删除成功");
    }
    
}

-(void)recordAction:(UIButton *)btn{
    if (self.recorder.isRecording) {
        [btn setTitle:@"录音" forState:UIControlStateNormal];
        [self.recorder pause];
    }else{
        [btn setTitle:@"暂停" forState:UIControlStateNormal];
        [self.recorder record];
    }
}


-(void)playAction:(UIButton *)btn{
    if (self.player.isPlaying) {
        [self.player pause];
    }else{
    [self.player play];
    }
}

//添加视图
-(void)addSubViews{
 //1.录制音频按钮
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btn setTitle:@"录制" forState:UIControlStateNormal];
    btn.frame=CGRectMake(100, 100, 100, 50);
    [btn addTarget:self action:@selector(recordAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    
    //播放
    UIButton *btn2=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btn2 setTitle:@"播放" forState:UIControlStateNormal];
    btn2.frame=CGRectMake(100, 150, 100, 50);
    [btn2 addTarget:self action:@selector(playAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
    
    UIButton *btn3=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btn3 setTitle:@"删除" forState:UIControlStateNormal];
    btn3.frame=CGRectMake(100, 200, 100, 50);
    [btn3 addTarget:self action:@selector(deleteAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn3];


}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self addSubViews];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
