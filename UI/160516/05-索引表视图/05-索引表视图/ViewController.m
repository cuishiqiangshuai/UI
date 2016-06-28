//
//  ViewController.m
//  05-索引表视图
//
//  Created by qingyun on 16/5/16.
//  Copyright © 2016年 QingYun. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) NSDictionary *dict;
@property (nonatomic, strong) NSArray *keys;            //索引

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation ViewController
static NSString *identifier = @"cell";
-(void)loadDictionaryFromFile{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"sortednames" ofType:@"plist"];
    _dict = [NSDictionary dictionaryWithContentsOfFile:path];
    
    //获取索引
    NSArray *allKeys = _dict.allKeys;
    //排序
    _keys = [allKeys sortedArrayUsingSelector:@selector(compare:)];
    
}

-(UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
        //设置数据源和代理
        _tableView.dataSource = self;
        _tableView.delegate = self;
        //注册单元格
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:identifier];
        
        //索引对应的属性
        _tableView.sectionIndexMinimumDisplayRowCount = 1000;
        _tableView.sectionIndexColor = [UIColor orangeColor];
        _tableView.sectionIndexBackgroundColor = [UIColor blueColor];
        _tableView.sectionIndexTrackingBackgroundColor = [UIColor blackColor];
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //加载数据
    [self loadDictionaryFromFile];
    //添加tableView
    [self.view addSubview:self.tableView];
    // Do any additional setup after loading the view, typically from a nib.
}

#pragma mark -UITableViewDataSource
//组数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _keys.count;
}

//每组行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //获取section对应的key
    NSString *key = _keys[section];
    //用key取出section对应的数组array
    NSArray *array = _dict[key];
    return array.count;
}

//行内容
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    
    //获取section对应的key
    NSString *key = _keys[indexPath.section];
    //用key取出section对应的数组array
    NSArray *array = _dict[key];
    
    cell.textLabel.text = array[indexPath.row];
    
    
    return cell;
}

//设置section的头标题
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return _keys[section];
}

//设置索引
-(NSArray <NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    return _keys;
}
// 当点击索引条上的相关字母后，返回相应的section索引
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index{
    return index + 1;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
