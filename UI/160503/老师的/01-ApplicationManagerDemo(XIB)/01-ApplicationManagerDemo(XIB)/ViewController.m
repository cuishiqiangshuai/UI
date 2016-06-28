//
//  ViewController.m
//  01-ApplicationManagerDemo(XIB)
//
//  Created by qingyun on 16/5/3.
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
        //从apps.plist文件中读取数据
        _apps = [NSArray arrayWithContentsOfFile:path];
    }
    return _apps;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //总列数
    int totalColumn = 4;
    //appView的宽高
    CGFloat appViewW = 80;
    CGFloat appViewH = 90;
    //两个相邻的appView的间距（X / Y）
    CGFloat spaceX = (QYScreenW - totalColumn * appViewW) / (totalColumn + 1);
    CGFloat spaceY = 30;
    for (int i = 0; i < self.apps.count; i++) {
        //确定当前appView所在的行和列
        int row = i / totalColumn;
        int column = i % totalColumn;
        //计算appView的位置
        CGFloat appViewX = spaceX * (column + 1) + appViewW * column;
        CGFloat appViewY = spaceY * (row + 1) + appViewH * row;
        //创建appView并添加到self.view（从xib文件读取布局）
        UIView *appView = [[NSBundle mainBundle] loadNibNamed:@"QYAppView" owner:self options:nil][0];
        [self.view addSubview:appView];
        appView.frame = CGRectMake(appViewX, appViewY, appViewW, appViewH);
        
        //设置appView的子视图的属性（图片、文本、下载链接地址...）
        UIImageView *iconView = [appView viewWithTag:101];
        UILabel *titleLabel = [appView viewWithTag:102];
        QYButton *downLoadBtn = [appView viewWithTag:103];
        
        //取出当前appView对应的字典
        NSDictionary *dict = self.apps[i];
        
        iconView.image = [UIImage imageNamed:dict[@"icon"]];
        
        titleLabel.text = dict[@"name"];
        
        //添加事件监听
        [downLoadBtn addTarget:self action:@selector(downLoad:) forControlEvents:UIControlEventTouchUpInside];
        downLoadBtn.linkString = dict[@"link"];
        
    };
    
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)downLoad:(QYButton *)sender{
    //获取link
    NSString *linkString = sender.linkString;
    //跳转下载地址
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:linkString]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
