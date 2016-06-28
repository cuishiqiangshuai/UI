//
//  ViewController.m
//  01-团购
//
//  Created by qingyun on 16/5/17.
//  Copyright © 2016年 QingYun. All rights reserved.
//

#import "ViewController.h"
#import "QYTGCell.h"
#import "QYAdCell.h"
#import "QYTGModel.h"
#import "ResultTableViewController.h"
@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) UISearchController *searchController;
@property (nonatomic, strong) NSArray *datas;
@end

@implementation ViewController
static NSString *adIdentifier = @"adCell";
//懒加载datas
-(NSArray *)datas{
    if (_datas == nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"tgs" ofType:@"plist"];
        NSArray *array = [NSArray arrayWithContentsOfFile:path];
        
        NSMutableArray *models = [NSMutableArray array];
        for (NSDictionary *dict in array) {
            QYTGModel *model = [QYTGModel tgModelWithDictionary:dict];
            [models addObject:model];
        }
        _datas = models;
    }
    return _datas;
}

-(UISearchController *)searchController{
    if (_searchController == nil) {
        //创建一个结果控制器
        ResultTableViewController *resultVC = [[ResultTableViewController alloc] initWithStyle:UITableViewStylePlain];
        resultVC.willFilterArray = self.datas;
        //创建searchController
        _searchController = [[UISearchController alloc] initWithSearchResultsController:resultVC];
        //更新者(一般设置成当前searchController的结果控制器)
        _searchController.searchResultsUpdater = resultVC;
        //隐藏导航栏
        _searchController.hidesNavigationBarDuringPresentation = YES;
        //显示蒙版
        _searchController.dimsBackgroundDuringPresentation = YES;
    }
    return _searchController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //注册广告cell
    [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([QYAdCell class]) bundle:nil] forCellReuseIdentifier:adIdentifier];
    //把searchController中的searchBar放置在 表头
    //_tableView.tableHeaderView = self.searchController.searchBar;
    
    //把searchController中的searchBar放置在 导航栏上
    //self.navigationItem.titleView = self.searchController.searchBar;
    //self.searchController.hidesNavigationBarDuringPresentation = NO;
    
   
}

//弹出搜索控制器
- (IBAction)searchAction:(UIBarButtonItem *)sender {
    [self presentViewController:self.searchController animated:YES completion:nil];
}
#pragma mark  - UITableViewDataSource
//行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datas.count;
}

//行内容
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //获取当前行对应的模型
    QYTGModel *tgModel = self.datas[indexPath.row];
    
    if ([tgModel.type integerValue] == 0) {
        //广告
        QYAdCell *adCell = [tableView dequeueReusableCellWithIdentifier:adIdentifier forIndexPath:indexPath];
        adCell.adModel = tgModel;
        return adCell;
    }else if ([tgModel.type integerValue] == 1){
        //商品
        QYTGCell *tgCell = [tableView dequeueReusableCellWithIdentifier:@"tgCell" forIndexPath:indexPath];
        tgCell.tgModel = tgModel;
        return tgCell;
    }
    
    return nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
