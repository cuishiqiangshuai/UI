//
//  ViewController.m
//  01-CustomCell(ContentView)
//
//  Created by qingyun on 16/5/16.
//  Copyright © 2016年 QingYun. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) NSArray *datas;

@property (nonatomic, strong) UITableView *tableView;
@end

@implementation ViewController

-(NSArray *)datas{
    if (_datas == nil) {
        _datas = @[@"zhangsan",@"lisi",@"wangwu",@"zhaoliu",@"tianqi",@"songba"];
    }
    return _datas;
}

//懒加载tableView
-(UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
        //设置数据源和代理
        _tableView.dataSource = self;
        _tableView.delegate = self;
        
        //设置行高
        _tableView.rowHeight = 100;
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //添加tableView
    [self.view addSubview:self.tableView];
    // Do any additional setup after loading the view, typically from a nib.
}

#pragma mark - UITableViewDataSource

//设置section数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

//设置每个section中的行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datas.count;
}

//设置每行的内容
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"cell";
    //从重用队列中获取闲置单元格
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        //自定义cell的内容(子视图titleLabel/detailTitleLabel/iconView)
        
        //titleLabel
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 200, 40)];
        [cell.contentView addSubview:titleLabel];
        titleLabel.tag = 101;
        
        //detailTitleLabel
        UILabel *detailTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 50, 200, 40)];
        [cell.contentView addSubview:detailTitleLabel];
        detailTitleLabel.tag = 102;
        
        //iconView
        UIImageView *iconView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetWidth([UIScreen mainScreen].bounds) - 100, 10, 80, 80)];
        [cell.contentView addSubview:iconView];
        iconView.tag = 103;
    }
    
    //获取titleLabel/detailTitleLabel/iconView
    UILabel *titleLabel = [cell.contentView viewWithTag:101];
    UILabel *detailTitleLabel = [cell.contentView viewWithTag:102];
    UIImageView *iconView = [cell.contentView viewWithTag:103];
   
    titleLabel.text = self.datas[indexPath.row];
    detailTitleLabel.text = @"我是好人";
    NSString *iconName = [NSString stringWithFormat:@"icon%ld.jpg",indexPath.row];
    iconView.image = [UIImage imageNamed:iconName];
    
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
