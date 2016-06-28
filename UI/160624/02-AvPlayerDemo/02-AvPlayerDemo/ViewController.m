//
//  ViewController.m
//  02-AvPlayerDemo
//
//  Created by qingyun on 16/6/24.
//  Copyright © 2016年 QingYun. All rights reserved.
//
#import <AVFoundation/AVFoundation.h>
#import "ViewController.h"

#import <AVKit/AVKit.h>

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *playView;
@property (weak, nonatomic) IBOutlet UISlider *proSlider;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
//播放器对象
@property(nonatomic,strong)AVPlayer *player;
//声明Item对象
@property(nonatomic,strong)AVPlayerItem *playerItem;
//声明播放当前状态变量
@property(nonatomic)BOOL isPlaying;
@end

@implementation ViewController

-(AVPlayerItem *)playerItem{
    if (_playerItem) return _playerItem;
     //1.创建Url
    NSURL *url=[NSURL URLWithString:@"http://qiniuuwmp3.changba.com/576270413.mp4"];
     //2.创建item对象
    _playerItem=[[AVPlayerItem alloc] initWithURL:url];
    //3.注册监听
    [self addObserverforAvplayer];
    return _playerItem;
}

-(AVPlayer *)player{
    if(_player)return _player;
    //1.创建player
    _player=[[AVPlayer alloc] initWithPlayerItem:self.playerItem];
    //2.监听当前播放的时间
    __weak ViewController *vc=self;
    [_player addPeriodicTimeObserverForInterval:CMTimeMake(1,1) queue:nil usingBlock:^(CMTime time) {
        //处理当前播放时间
        float seconds=CMTimeGetSeconds(time);
        //更新UI
        [vc.proSlider setValue:seconds animated:YES];
    }];
    return  _player;
}

//设置slider
-(void)setSliderValue:(CMTime )time{
    //将时间转换成秒
    CGFloat  seconds=time.value/time.timescale;
    _proSlider.maximumValue=seconds;
}

#pragma mark 播放完成后调用
-(void)playDidFinshed:(NSNotification *)notFication{
    _progressView.progress=0;
    _proSlider.value=0;
}

//注册KVO 监听
-(void)addObserverforAvplayer{
  //给当前播放器监听 Status
    [self.playerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
  //监听当前音乐缓冲的进度
    [self.playerItem addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];
  //添加通知中心监听当播放完毕后调用
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playDidFinshed:) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
}

//移除监听
-(void)dealloc{
    [self.playerItem removeObserver:self forKeyPath:@"status"];
    [self.playerItem removeObserver:self forKeyPath:@"loadedTimeRanges"];
}
//回调监听
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    AVPlayerItem *item=(AVPlayerItem*)object;
    if ([keyPath isEqualToString:@"status"]) {
        //判断当前状态 准备播放
        if (item.status==AVPlayerStatusReadyToPlay) {
            //初始化slider值
            CMTime time=item.duration;
            NSLog(@"====%f",CMTimeGetSeconds(time));
            [self setSliderValue:time];
        }else if(item.status==AVPlayerStatusFailed){
            NSLog(@"play error");
        }
    }else if([keyPath isEqualToString:@"loadedTimeRanges"]){
        //处理当前缓冲进度
         NSArray *timeArr=change[@"new"];
        //获取到当前缓冲的进度
        CMTimeRange range=[timeArr.firstObject CMTimeRangeValue];
        float start=CMTimeGetSeconds(range.start);
        float endD=CMTimeGetSeconds(range.duration);
        NSLog(@"========%f=======%f",start,endD);
        //换算当前缓冲的比例 =已经缓冲/视频的总长度;
        float totalBuffer=start+endD;
        float value=totalBuffer/CMTimeGetSeconds(item.duration);
        //更新UI
        self.progressView.progress=value;
    }
}

-(void)addSubLayer{
    //1.初始化PlayerLayer对象
    AVPlayerLayer *playLayer=[AVPlayerLayer playerLayerWithPlayer:self.player];
    //1.1设置frame
    playLayer.frame=_playView.layer.bounds;
    //1.2内容填充模式
    playLayer.videoGravity=AVLayerVideoGravityResize;
    //2添加到layer上
    [_playView.layer addSublayer:playLayer];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
//滑动到哪里播放哪里
- (IBAction)sliderValueChange:(UISlider *)sender {
    //滑动结束,播放当前位置
    [self.playerItem seekToTime:CMTimeMake(sender.value, 1) completionHandler:^(BOOL finished) {
        NSLog(@"=========wang");
        //播放
        [self.player play];
        _isPlaying=YES;
    }];
}

- (IBAction)PlayAction:(UIButton *)sender {
    //播放
    if(!_isPlaying){
        BOOL isOpen = false;
        //判断当前视图是否已经有AVPlayerLayer对象
        for (CALayer *layer in _playView.layer.sublayers) {
        if ([layer isKindOfClass:[AVPlayerLayer class]]) {
            isOpen=YES;
         }
        }
        //如果不存在,添加播放视图
        if(!isOpen)[self addSubLayer];
         [sender setTitle:@"暂停" forState:UIControlStateNormal];
         [self.player play];
    }else{
         [sender setTitle:@"播放" forState:UIControlStateNormal];
         [self.player pause];
    }
    _isPlaying=!_isPlaying;
}


- (IBAction)playerAction:(id)sender {
    //初始化控制器对象
    AVPlayerViewController *playerViewController=[[AVPlayerViewController alloc] init];
    //设置播放器对象
    AVPlayer *player=[[AVPlayer alloc] initWithURL:[NSURL URLWithString:@"http://qiniuuwmp3.changba.com/576270413.mp4"]];
    playerViewController.player=player;
    //设置
    playerViewController.videoGravity=AVLayerVideoGravityResizeAspect;
    //播放
    [playerViewController.player play];
    //模态
    [self presentViewController:playerViewController animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
