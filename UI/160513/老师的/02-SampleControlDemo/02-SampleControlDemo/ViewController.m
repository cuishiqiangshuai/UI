//
//  ViewController.m
//  02-SampleControlDemo
//
//  Created by qingyun on 16/5/13.
//  Copyright © 2016年 QingYun. All rights reserved.
//

#import "ViewController.h"
#import "QYSlider.h"
@interface ViewController ()
{
    UILabel *_label;
}
@property (nonatomic, strong) UISwitch *mySwitch;
@property (nonatomic, strong) UIProgressView *progressView;
@property (nonatomic, strong) QYSlider *slider;
@property (nonatomic, strong) UISegmentedControl *segmentedControl;
@property (nonatomic, strong) UIStepper *stepper;

@property (nonatomic, strong) NSTimer *switchTimer;
@property (nonatomic, strong) NSTimer *progressTimer;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //添加UISwitch
    [self.view addSubview:self.mySwitch];
    //添加UIProgressView
    [self.view addSubview:self.progressView];
    
    _label = [[UILabel alloc] initWithFrame:CGRectMake(270, 145, 100, 15)];
    [self.view addSubview:_label];
    
    //添加slider
    [self.view addSubview:self.slider];
    
    //添加segmentedControl
    [self.view addSubview:self.segmentedControl];
    
    //添加stepper
    [self.view addSubview:self.stepper];
    
    // Do any additional setup after loading the view, typically from a nib.
}

#pragma mark  -UISwitch
-(UISwitch *)mySwitch{
    if (_mySwitch == nil) {
        _mySwitch = [[UISwitch alloc] initWithFrame:CGRectMake(100, 100, 0, 0)];
        //_mySwitch.backgroundColor = [UIColor redColor];
        
        //开启状态下着色
        _mySwitch.onTintColor = [UIColor yellowColor];
        //关闭状态下着色
        _mySwitch.tintColor = [UIColor blackColor];
        //拇指着色
        _mySwitch.thumbTintColor = [UIColor purpleColor];
        //添加事件监听 (valuechanged)
        [_mySwitch addTarget:self action:@selector(stateChangedForSwith:) forControlEvents:UIControlEventValueChanged];
        
        _switchTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(changedOn:) userInfo:_mySwitch repeats:YES];
        
    }
    return _mySwitch;
}

-(void)changedOn:(NSTimer *)timer{
    UISwitch *sw = timer.userInfo;
    [sw setOn:!sw.on animated:YES];
}

-(void)stateChangedForSwith:(UISwitch *)sw{
    NSLog(@"%d",sw.on);
}

#pragma mark  -UIProgressView
-(UIProgressView *)progressView{
    if (_progressView == nil) {
        _progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleBar];
        _progressView.frame = CGRectMake(50, 150, 200, 0);
        
        //_progressView.backgroundColor = [UIColor cyanColor];
        
        //当前进度
        _progressView.progress = 0.0;
        
        //已经完成的部分轨迹的着色
        _progressView.progressTintColor = [UIColor purpleColor];
        //未完成的部分轨迹的着色
        _progressView.trackTintColor = [UIColor blackColor];
        
        //已经完成的部分轨迹的图片
        _progressView.progressImage = [UIImage imageNamed:@"1"];
        //未完成的部分轨迹的图片
        _progressView.trackImage = [UIImage imageNamed:@"2"];
        
//        _progressTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(changeProgress:) userInfo:_progressView repeats:YES];
        

        _progressTimer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(changeProgress:) userInfo:_progressView repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:_progressTimer forMode:NSRunLoopCommonModes];
        
    }
    return _progressView;
}

-(void)changeProgress:(NSTimer *)timer{
    UIProgressView *progressView = timer.userInfo;
    
    if (progressView.progress == 1.0) {
        [timer invalidate];
        timer = nil;
        return;
    }
    //设置progressView进度
    [progressView setProgress:(progressView.progress + (arc4random() % 10) / 100.0) animated:YES];
    _label.text = [NSString stringWithFormat:@"%d %%",(int)(progressView.progress * 100)];
}


#pragma mark  -UISlider
-(QYSlider *)slider{
    if (_slider == nil) {
        _slider = [[QYSlider alloc] initWithFrame:CGRectMake(10, 180, 300, 100)];
        _slider.backgroundColor = [UIColor redColor];
        
        //设置最大/小值
        _slider.minimumValue = 10;
        _slider.maximumValue = 100;
        
        //设置默认值
        _slider.value = 50;
        
        //设置slider的最大/小值对应的图片
        _slider.maximumValueImage = [UIImage imageNamed:@"coin"];
        _slider.minimumValueImage = [UIImage imageNamed:@"coin"];
        
        //设置最小值轨迹对应的tintColor
        _slider.minimumTrackTintColor = [UIColor blackColor];
        //设置最小值轨迹对应的image
        [_slider setMaximumTrackImage:[UIImage imageNamed:@"2"] forState:UIControlStateNormal];
        //设置拇指对应的image
        [_slider setThumbImage:[UIImage imageNamed:@"coin"] forState:UIControlStateNormal];
        //添加事件监听(valueChanged)
        [_slider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
        //是否连续触发ValueChanged事件(yes:连续触发,no:当手指松开的时候触发)
        _slider.continuous = NO;
    }
    return _slider;
}

-(void)sliderValueChanged:(QYSlider *)slider{
    NSLog(@"当前value:%f",slider.value);
}


#pragma  mark - UISegmentedControl
-(UISegmentedControl *)segmentedControl{
    if (_segmentedControl == nil) {
        NSArray *titles = @[@"简单",@"一般",@"困难",@"极难"];
        _segmentedControl = [[UISegmentedControl alloc] initWithItems:titles];
        
        _segmentedControl.frame = CGRectMake(10, 300, 350, 30);
        _segmentedControl.backgroundColor = [UIColor orangeColor];
        //选中段的索引
        _segmentedControl.selectedSegmentIndex = 1;
        //保留选中的效果(默认no:保留,yes:不保留)
        _segmentedControl.momentary = NO;
        
        //添加一段
        [_segmentedControl insertSegmentWithTitle:@"骨灰" atIndex:4 animated:NO];
        //删除其中一段
        [_segmentedControl removeSegmentAtIndex:3 animated:YES];
        
        //更改其中一段的标题
        [_segmentedControl setTitle:@"炮灰" forSegmentAtIndex:3];
        
        //设置内容的偏移量
        [_segmentedControl setContentOffset:CGSizeMake(20, 0) forSegmentAtIndex:3];
        
        _segmentedControl.tintColor = [UIColor blackColor];
        //设置分割线
        //[_segmentedControl setDividerImage:[UIImage imageNamed:@"coin"] forLeftSegmentState:UIControlStateNormal rightSegmentState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
        
        //添加事件监听(valueChanged)
        [_segmentedControl addTarget:self action:@selector(segmentedControlValueChanged:) forControlEvents:UIControlEventValueChanged];
        
    }
    return _segmentedControl;
}

-(void)segmentedControlValueChanged:(UISegmentedControl *)segmentedControl{
    NSLog(@"segmentedControl:%ld",segmentedControl.selectedSegmentIndex);
}

#pragma mark  -UIStepper
-(UIStepper *)stepper{
    if (_stepper == nil) {
        _stepper = [[UIStepper alloc] initWithFrame:CGRectMake(100, 400, 300, 100)];
        
        //设置范围
        _stepper.minimumValue = 10;
        _stepper.maximumValue = 50;
        //设置当前值
        _stepper.value = 30;
        //设置步长
        _stepper.stepValue = 5;
        
        //添加事件监听(valueChanged)
        [_stepper addTarget:self action:@selector(stepperValueChanged:) forControlEvents:UIControlEventValueChanged];
        
        //当press&hold,value连续更改(yes:连续更改, no:不连续更改)
        _stepper.autorepeat = YES;
        //是否连续触发ValueChanged事件(yes:连续触发,no:当手指松开的时候触发)
        _stepper.continuous = NO;
        //wraps,value循环变化 min<->max
        _stepper.wraps = NO;
        
    }
    return _stepper;
}

-(void)stepperValueChanged:(UIStepper *)stepper{
    NSLog(@"%f",stepper.value);
}


-(void)dealloc{
    [_switchTimer invalidate];
    _switchTimer = nil;
}

@end
