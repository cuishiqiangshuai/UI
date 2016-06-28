//
//  ViewController.m
//  03-ApplicationManagerDemo
//
//  Created by qingyun on 16/4/29.
//  Copyright © 2016年 QingYun. All rights reserved.
//

#import "ViewController.h"
#import "QYButton.h"

#define QYScreenW [UIScreen mainScreen].bounds.size.width
@interface ViewController ()
@property (nonatomic, strong) NSArray *apps;
@end

@implementation ViewController
//懒加载apps
-(NSArray *)apps{
    if (_apps == nil) {
        //获取apps.plist文件路径
        NSString *path = [[NSBundle mainBundle] pathForResource:@"apps" ofType:@"plist"];
        //根据路径来初始化_apps
        _apps = [NSArray arrayWithContentsOfFile:path];
    }
    return _apps;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //根据self.apps来添加子视图（appView）
    //总列数
    int column = 4;
    //appView的宽高
    CGFloat appViewW = 80;
    CGFloat appViewH = 90;
    //间距
    CGFloat spaceY = 30;
    CGFloat spaceX = (QYScreenW - appViewW * column) / (column + 1);
    
    for (int i = 0; i < self.apps.count; i++) {
        //获取当前应用所在的行、列
        int appViewRow = i / column;
        int appViewColumn = i % column;
        //计算当前appView的位置
        CGFloat appViewX = spaceX * (appViewColumn + 1) + appViewW * appViewColumn;
        CGFloat appViewY = spaceY * (appViewRow + 1) + appViewH * appViewRow;
        //创建并添加appView
        UIView *appView = [[UIView alloc] initWithFrame:CGRectMake(appViewX, appViewY, appViewW, appViewH)];
        [self.view addSubview:appView];
        //appView.backgroundColor = [UIColor redColor];
        
        //取出当前应用对应的字典
        NSDictionary *dict = self.apps[i];
        //1、添加图标iconView (40*40)
        CGFloat iconViewW = 40;
        CGFloat iconViewH = 40;
        CGFloat iconViewX = (appViewW - iconViewW) / 2.0;
        CGFloat iconViewY = 0;
        UIImageView *iconView = [[UIImageView alloc] initWithFrame:CGRectMake(iconViewX, iconViewY, iconViewW, iconViewH)];
        [appView addSubview:iconView];
        iconView.image = [UIImage imageNamed:dict[@"icon"]];
        //2、添加标题titleLabel (80*20)
        CGFloat titlelabelW = 80;
        CGFloat titlelabelH = 20;
        CGFloat titlelabelX = (appViewW - titlelabelW) / 2.0;
        CGFloat titlelabelY = iconViewY + iconViewH;
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(titlelabelX, titlelabelY, titlelabelW, titlelabelH)];
        [appView addSubview:titleLabel];
        titleLabel.text = dict[@"name"];
        //居中对齐
        titleLabel.textAlignment = NSTextAlignmentCenter;
        //字体大小
        titleLabel.font = [UIFont systemFontOfSize:12.0];
        
        //3、添加下载按钮downLoadBtn (60*20)
        CGFloat downLoadBtnW = 60;
        CGFloat downLoadBtnH = 20;
        CGFloat downLoadBtnX = (appViewW - downLoadBtnW) / 2.0;
        CGFloat downLoadBtnY = titlelabelY + titlelabelH;
        QYButton *downLoadBtn = [QYButton buttonWithType:UIButtonTypeCustom];
        [appView addSubview:downLoadBtn];
        downLoadBtn.frame = CGRectMake(downLoadBtnX, downLoadBtnY, downLoadBtnW, downLoadBtnH);
        //设置btn的标题
        [downLoadBtn setTitle:@"下载" forState:UIControlStateNormal];
        //设置背景图片
        [downLoadBtn setBackgroundImage:[UIImage imageNamed:@"buttongreen"] forState:UIControlStateNormal];
        [downLoadBtn setBackgroundImage:[UIImage imageNamed:@"buttongreen_highlighted"] forState:UIControlStateHighlighted];
        //[downLoadBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        //更改btn的字体大小
        downLoadBtn.titleLabel.font = [UIFont systemFontOfSize:12.0];
        //添加事件监听（touchUpInside）
        [downLoadBtn addTarget:self action:@selector(downLoad:) forControlEvents:UIControlEventTouchUpInside];
        
        //设置tag值
#if 0
        downLoadBtn.tag = 100 + i;
#else
        downLoadBtn.link = dict[@"link"];
#endif
    }
    
    
    // Do any additional setup after loading the view, typically from a nib.
}

//下载
-(void)downLoad:(QYButton *)sender{
#if 0
    NSInteger index = sender.tag - 100;
    //取出当前点击的btn所在的应用程序对应的字典
    NSDictionary *dict = self.apps[index];
    NSString *link = dict[@"link"];
    NSURL *url = [NSURL URLWithString:link];
#else
    NSURL *url = [NSURL URLWithString:sender.link];
#endif
    [[UIApplication sharedApplication] openURL:url];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
