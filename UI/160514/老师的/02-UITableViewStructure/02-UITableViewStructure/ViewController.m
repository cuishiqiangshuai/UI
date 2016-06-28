//
//  ViewController.m
//  02-UITableViewStructure
//
//  Created by qingyun on 16/5/14.
//  Copyright © 2016年 QingYun. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *datas;
@end

@implementation ViewController

//懒加载数据
-(NSArray *)datas{
    if (_datas == nil) {
        _datas = @[@"张三",@"李四",@"王五",@"赵六",@"田七",@"宋八"];
    }
    return _datas;
}

//懒加载tableView
-(UITableView *)tableView{
    if (_tableView == nil) {
        //创建tableView
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        //设置数据源和代理
        _tableView.dataSource = self;
        _tableView.delegate = self;
        
        //设置背景视图
        UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:_tableView.bounds];
        bgImageView.image = [UIImage imageNamed:@"bg.jpg"];
        _tableView.backgroundView = bgImageView;
        
        //设置tableHeaderView/tableFooterView
        UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(_tableView.bounds), 100)];
        headerLabel.backgroundColor = [UIColor orangeColor];
        headerLabel.text = @"TableViewHeaderView";
        headerLabel.textAlignment = NSTextAlignmentCenter;
        headerLabel.font = [UIFont boldSystemFontOfSize:25.0];
        _tableView.tableHeaderView = headerLabel;
        
        UILabel *footerLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 100)];
        footerLabel.backgroundColor = [UIColor purpleColor];
        footerLabel.text = @"TableViewFooterView";
        footerLabel.textAlignment = NSTextAlignmentCenter;
        footerLabel.font = [UIFont boldSystemFontOfSize:25.0];
        _tableView.tableFooterView = footerLabel;
        
        //设置section的头尾高度(style == UITableViewStylePlain,起作用)
        _tableView.sectionHeaderHeight = 180;
        _tableView.sectionFooterHeight = 60;
        
        //设置行高
        _tableView.rowHeight = 60;
        
        //分割线
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.separatorColor = [UIColor blackColor];
        _tableView.separatorInset = UIEdgeInsetsMake(0, 50, 0, 50);
        //允许多选
        _tableView.allowsMultipleSelection = YES;
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //添加tableView
    [self.view addSubview:self.tableView];
    
    // Do any additional setup after loading the view, typically from a nib.
}

#pragma mark -UITableViewDataSource

//组数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}
//组内行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datas.count;
    //return arc4random() % (self.datas.count - 1) + 1;
}
//行内容
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    
    cell.backgroundColor = [UIColor colorWithRed:0.4 green:0.6 blue:0.8 alpha:0.65];
    
    cell.textLabel.text = [NSString stringWithFormat:@"第%ld组 %@",indexPath.section,self.datas[indexPath.row]];
    
    return cell;
}

//设置section的头尾标题
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return [NSString stringWithFormat:@"SectionHeaderView:%ld",section];
}

-(NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
    return [NSString stringWithFormat:@"SectionFooterView:%ld",section];
}


#pragma mark -UITableViewDelegate
//设置section的头尾视图的高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 80;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 160;
}


//设置section的头尾视图

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(_tableView.bounds), 100)];
    headerLabel.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.8 alpha:1.0];
    headerLabel.text = [NSString stringWithFormat:@"SectionHeaderView:%ld",section];
    headerLabel.textAlignment = NSTextAlignmentCenter;
    headerLabel.font = [UIFont boldSystemFontOfSize:20.0];
    return headerLabel;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UILabel *footerLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 100)];
    //footerLabel.backgroundColor = [UIColor clearColor];
    footerLabel.text = [NSString stringWithFormat:@"SectionFooterView:%ld",section];
    footerLabel.textAlignment = NSTextAlignmentCenter;
    footerLabel.font = [UIFont systemFontOfSize:20.0];
    return footerLabel;
}

//设置某行高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 60;
    }
    return 44;
}

//已经选中行
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSLog(@"您已经选中:%@",cell.textLabel.text);
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
    //选中的单元格集合
    NSArray *selectedIndexPaths = tableView.indexPathsForSelectedRows;
    //界面可视的单元格集合
    //tableView.indexPathsForVisibleRows;
    //界面上点击的单元格
    //[tableView indexPathForRowAtPoint:<#(CGPoint)#>];
}

//已经取消选中行

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSLog(@"您已经取消选中:%@",cell.textLabel.text);
    cell.accessoryType = UITableViewCellAccessoryNone;
}


#if 0
//设置辅助视图
-(UITableViewCellAccessoryType)tableView:(UITableView *)tableView accessoryTypeForRowWithIndexPath:(NSIndexPath *)indexPath{
    return indexPath.row % 5;
}
- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSLog(@"您已经点击:%@",cell.textLabel.text);
}
#endif


@end
