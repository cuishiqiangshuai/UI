//
//  ViewController.m
//  ScanImageDemo
//
//  Created by qingyun on 16/5/2.
//  Copyright © 2016年 qingyun. All rights reserved.
//
//第一步：定义一个数组用于接收plist文件，然后对数组进行懒加载
//第二步:在搭建UI界面


#import "ViewController.h"

@interface ViewController ()
@property(strong,nonatomic)NSArray *images;
@property (weak, nonatomic) IBOutlet UILabel *numLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *leftBtn;
@property (weak, nonatomic) IBOutlet UIButton *rightBtn;

@property (weak, nonatomic) IBOutlet UILabel *InfoLabel;
@property (nonatomic,assign)NSInteger currentIndex;
@end

@implementation ViewController

-(NSArray *)images
{
    if (_images==nil)
    {
        NSString *path=[[NSBundle mainBundle] pathForResource:@"Images" ofType:@"plist"];
        _images =[NSArray arrayWithContentsOfFile:path];
    }
    return _images;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setPropertyForSubViews];
    // Do any additional setup after loading the view, typically from a nib.
}
//更改numLabel，Btn的状态，InfoLabel，更改imageView的方法
-(void)setPropertyForSubViews
{
    NSDictionary *dict=self.images[_currentIndex];
    //1.更改numLabel的文本
    _numLabel.text=[NSString stringWithFormat:@"%ld/%ld",_currentIndex + 1,self.images.count];
    //2.更改imageView的图片
    _imageView.image=[UIImage imageNamed:dict[@"name"]];
    //3.更改infoLabel的文本
    _InfoLabel.text=dict[@"desc"];
    //4.更改左右btn的状态（当_curretIndex==0时，leftBtn不可用，当_curretIndex==self.images.count-1时，rightBtn不可用）
    _leftBtn.enabled= _currentIndex == 0 ? NO : YES;
    _rightBtn.enabled=_currentIndex==self.images.count-1 ? NO:YES;
}
- (IBAction)BtnClink:(UIButton *)sender {
    if (sender.tag==101)
    {
        _currentIndex--;
    }
    else if(sender.tag==102)
    {
        _currentIndex++;
    }
    [self setPropertyForSubViews];
}
//图片Button的点击事件
- (IBAction)imageBtn:(UIButton *)sender {
    NSDictionary *dict=self.images[_currentIndex];
    UIAlertController *alertController=[UIAlertController alertControllerWithTitle:@"提示" message:@"图片详情" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action1=[UIAlertAction actionWithTitle:@"否" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        return;
    }];
    UIAlertAction *action2=[UIAlertAction actionWithTitle:@"是" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        NSString *linkString=dict[@"url"];
        NSURL *url=[NSURL URLWithString:linkString];
        [[UIApplication sharedApplication] openURL:url];
    }];
    [alertController addAction:action1];
    [alertController addAction:action2];
    [self presentViewController:alertController animated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
