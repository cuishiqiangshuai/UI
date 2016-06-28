//
//  ViewController.m
//  02-ScanImageDemo
//
//  Created by qingyun on 16/4/29.
//  Copyright © 2016年 QingYun. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, strong) NSArray *images;
@property (weak, nonatomic) IBOutlet UILabel *numLabel;
@property (weak, nonatomic) IBOutlet UILabel *infoLabel;
@property (weak, nonatomic) IBOutlet UIButton *leftBtn;
@property (weak, nonatomic) IBOutlet UIButton *rightBtn;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (nonatomic)         NSInteger currentIndex;
@end

@implementation ViewController

//懒加载images
- (NSArray *)images{
    if (_images == nil) {
        //获取Images.plist文件路径
        NSString *path = [[NSBundle mainBundle] pathForResource:@"Images" ofType:@"plist"];
        _images = [NSArray arrayWithContentsOfFile:path];
    }
    return _images;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setPropertyForSubViews];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)setPropertyForSubViews{
    NSDictionary *dict = self.images[_currentIndex];
    //1、更改numLabel的文本
    _numLabel.text = [NSString stringWithFormat:@"%ld/%ld",_currentIndex + 1,self.images.count];
    //2、更改imageView的图片
    _imageView.image = [UIImage imageNamed:dict[@"name"]];
    //3、更改infoLabel的文本
    _infoLabel.text = dict[@"desc"];
    //4、更改左右两边btn的状态(当_currentIndex==0,_leftBtn不可用；当_currentIndex == self.images.count - 1,_rightBtn不可用)
    _leftBtn.enabled = _currentIndex == 0 ? NO : YES;
    _rightBtn.enabled = _currentIndex == self.images.count - 1 ? NO : YES;
#if 0
    //判断左边按钮可用状态
    if (_currentIndex == 0) {
        _leftBtn.enabled = NO;
    }else{
        _leftBtn.enabled = YES;
    }
    //判断右边按钮可用状态
    if (_currentIndex == self.images.count - 1) {
        _rightBtn.enabled = NO;
    }else{
        _rightBtn.enabled = YES;
    }
#endif
}

- (IBAction)btnClick:(UIButton *)sender {
    if (sender.tag == 101) {//上一张
        _currentIndex--;
    }else if (sender.tag == 102){//下一张
        _currentIndex++;
    }
    [self setPropertyForSubViews];
}

- (IBAction)gotoDetailInfo:(UIButton *)sender {
    NSDictionary *dict = self.images[_currentIndex];
    NSString *linkString = dict[@"url"];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:linkString]];  
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
