//
//  ViewController.m
//  UI-ViewsDemo
//
//  Created by qingyun on 16/4/29.
//  Copyright © 2016年 qingyun. All rights reserved.
//


//在一个view上添加多个view（比如一个界面上弄很多下载的APP）
//首先要有plist文件（可以自己写plist文件：点击Supporting Files选择New File，）
//从文件中提取数据（用懒加载的方式），再搭建UI界面
//首先先创建view（需要利用算法确定各个View的坐标）再在View上添加图标UIImageView，titleLabel和Butten
#import "ViewController.h"
#import "QYButton.h"

#define QYScreenW [UIScreen mainScreen].bounds.size.width//宏定义屏幕的宽
@interface ViewController ()
@property(nonatomic,strong)NSArray *apparray;//定义一个数组，接收plist中的信息，plist里面是什么就定义什么
@end

@implementation ViewController
//懒加载数组
-(NSArray *)apparray
{
    if (_apparray==nil)
    {
        //获取plist文件的路径
        NSString *path=[[NSBundle mainBundle]pathForResource:@"apps" ofType:@"plist"];
        //根据路径初始化_apparray
        _apparray=[NSArray arrayWithContentsOfFile:path];
    }
    return _apparray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
   //根据self.apparray来添加子视图（appview）
    //定义总列数
    int column=4;//column=列
    //appview(子视图)的宽和高
    CGFloat appviewWidth=80;
    CGFloat appviewHeight=90;
    //appview（子视图）之间的间距
    CGFloat spaceY=30;//因为不知道会排多少行，所以要定义
    CGFloat spaceX=(QYScreenW-appviewWidth*column)/(column+1);//横着的间距=（（屏幕的宽-appview的宽）乘以列数）除以列数加一
    for (int i=0; i<self.apparray.count; i++)
    {
        //获取当前应用所在的行、列
        int appViewRow=i/column;//下标对总列数取整就是行数
        int appViewColumn=i%column;//下标对总列数取余就是列数
        //计算当前appview的位置
        CGFloat appViewX=spaceX*(appViewColumn+1)+appViewColumn*appviewWidth;
        CGFloat appViewY=spaceY*(appViewRow+1)+appViewRow*appviewHeight;
        //创建并添加appview
        UIView *appView=[[UIView alloc] initWithFrame:CGRectMake(appViewX, appViewY, appviewWidth, appviewHeight)];
        [self.view addSubview:appView];
        
        
        //需要先取出当前应用对应的字典
        NSDictionary *dict=self.apparray[i];
        //添加图标iconview（40*40）
        CGFloat iconViewW=40;
        CGFloat iconViewH=40;
        CGFloat iconViewX=(appviewWidth-iconViewW)/2.0;
        CGFloat iconViewY=0;//以上是确定图标的大小和在view上的位置
        UIImageView *iconView=[[UIImageView alloc] initWithFrame:CGRectMake(iconViewX, iconViewY, iconViewW, iconViewH)];
        [appView addSubview:iconView];
        iconView.image=[UIImage imageNamed:dict[@"icon"]];
        //添加label，也就是应用的名字（titleLabel）(80*20)
        CGFloat titleLabelW=80;
        CGFloat titleLabelH=20;
        CGFloat titleLabelX=(appviewWidth-titleLabelW)/2;
        CGFloat titleLableY=iconViewY+iconViewH;
        UILabel *titleLabel=[[UILabel alloc] initWithFrame:CGRectMake(titleLabelX, titleLableY, titleLabelW, titleLabelH)];
        [appView addSubview:titleLabel];
        titleLabel.text=dict[@"name"];
        //居中对齐
        titleLabel.textAlignment=NSTextAlignmentCenter;//居中对齐的方法alignment
        //字体大小
        titleLabel.font=[UIFont systemFontOfSize:12.0];
        
        //3.添加下载按钮DownLoadBtn（60*20）
        CGFloat downLoadBtnW=60;
        CGFloat downLoadBtnH=20;
        CGFloat downLoadBtnX=(appviewWidth-downLoadBtnW)/2;
        CGFloat downLoadBtnY=titleLableY+titleLabelH;
        QYButton *downLoadBtn=[QYButton buttonWithType:UIButtonTypeCustom];
        [appView addSubview:downLoadBtn];
        downLoadBtn.frame=CGRectMake(downLoadBtnX, downLoadBtnY, downLoadBtnW, downLoadBtnH);
        //设置btn的标题
        [downLoadBtn setTitle:@"下载" forState:UIControlStateNormal];
        //设置背景图片
        [downLoadBtn setBackgroundImage:[UIImage imageNamed:@"buttongreen"] forState:UIControlStateNormal];
        [downLoadBtn setBackgroundImage:[UIImage imageNamed:@"buttongreen_highlighted"] forState:UIControlStateHighlighted];
        //更改字体的大小
        downLoadBtn.titleLabel.font=[UIFont systemFontOfSize:12.0];
        //添加监听事件（touchUpInside）
        [downLoadBtn addTarget:self action:@selector(downLoad:) forControlEvents:UIControlEventTouchUpInside];
        downLoadBtn.link=dict[@"link"];//这里是先定义了一个类QYButton为downloadBtn声明了一个link属性，所以下面的下载的方法里面就可以直接取到link（还可以用定义tag的值得方法取link）
    }
}

//点击button进行下载
-(void)downLoad:(QYButton *)sender{
    
    NSURL *url=[NSURL URLWithString:sender.link];
    [[UIApplication sharedApplication] openURL:url];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
