//
//  ViewController.m
//  02-ApplicationManagerDemo(MVC)
//
//  Created by qingyun on 16/5/3.
//  Copyright © 2016年 QingYun. All rights reserved.
//

#import "ViewController.h"
#import "QYAppModel.h"
#import "QYAppView.h"
#define QYScreenW [UIScreen mainScreen].bounds.size.width
@interface ViewController ()
@property (nonatomic, strong) NSArray *apps;        //应用数据集合
@end

@implementation ViewController
//懒加载apps
-(NSArray *)apps{
    if (_apps == nil) {
        //获取plist文件路径
        NSString *path = [[NSBundle mainBundle] pathForResource:@"apps" ofType:@"plist"];
        //取出plist文件中的数据
        NSArray *array = [NSArray arrayWithContentsOfFile:path];
        //遍历array，把其中的dictionary转化成QYAppModel
        //定义一个可变的数组来存储转化后的模型
        NSMutableArray *models = [NSMutableArray array];
        for (NSDictionary *dict in array) {
            QYAppModel *appModel = [QYAppModel modelWithDictionary:dict];
            [models addObject:appModel];
        }
        _apps = models;
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
        //创建并添加appView
        QYAppView *appView = [QYAppView appView];
        [self.view addSubview:appView];
        appView.frame = CGRectMake(appViewX, appViewY, appViewW, appViewH);
        //对appView设置子视图属性（图片、文本、下载链接）
        QYAppModel *appModel = self.apps[i];
        //[appView setPropertyForSubViews:appModel];
        appView.model = appModel;
    };

    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
