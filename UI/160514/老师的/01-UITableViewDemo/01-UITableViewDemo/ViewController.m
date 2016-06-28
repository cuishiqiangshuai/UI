//
//  ViewController.m
//  01-UITableViewDemo
//
//  Created by qingyun on 16/5/14.
//  Copyright © 2016年 QingYun. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) NSArray *datas;
@end

@implementation ViewController


-(NSArray *)datas{
    if (_datas == nil) {
        _datas = @[@"zhangsan",@"lisi",@"wangwu",@"zhaoliu",@"tianqi",@"songba"];
    }
    return _datas;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //1.创建并添加tableView
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    [self.view addSubview:tableView];
    //2.设置数据源和代理
    tableView.dataSource = self;
    tableView.delegate = self;
    // Do any additional setup after loading the view, typically from a nib.
}

#pragma mark -UITableViewDataSource

//组数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

//组内行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datas.count;
}
 
//每一行的内容
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    
    cell.textLabel.text = [NSString stringWithFormat:@"第%ld组 %@",indexPath.section,self.datas[indexPath.row]];
    
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
