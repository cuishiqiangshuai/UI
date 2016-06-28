//
//  ViewController.m
//  06-编辑表视图
//
//  Created by qingyun on 16/5/16.
//  Copyright © 2016年 QingYun. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) NSMutableDictionary *dict;
@property (nonatomic, strong) NSArray *keys;            //索引

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation ViewController
static NSString *identifier = @"cell";
-(void)loadDictionaryFromFile{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"sortednames" ofType:@"plist"];
    _dict = [NSMutableDictionary dictionaryWithContentsOfFile:path];
    
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
//        _tableView.sectionIndexBackgroundColor = [UIColor blueColor];
//        _tableView.sectionIndexTrackingBackgroundColor = [UIColor blackColor];
        
        //_tableView.allowsMultipleSelectionDuringEditing = YES;
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //加载数据
    [self loadDictionaryFromFile];
    //添加tableView
    [self.view addSubview:self.tableView];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(editAction:)];
    // Do any additional setup after loading the view, typically from a nib.
}

//更改tableView的编辑状态
- (void)editAction:(UIBarButtonItem *)barButtonItem {
    if ([barButtonItem.title isEqualToString:@"编辑"]) {
        [self.tableView setEditing:YES animated:YES];
        barButtonItem.title = @"完成";
    }else if ([barButtonItem.title isEqualToString:@"完成"]){
        [self.tableView setEditing:NO animated:YES];
        barButtonItem.title = @"编辑";
    }
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
    return index;
}


#pragma mark -编辑(插入和删除)
//允许编辑
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

//设置编辑的类型
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return indexPath.row % 2 ? UITableViewCellEditingStyleDelete : UITableViewCellEditingStyleInsert;
}

//提交编辑
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    //获取当前行所在section的数组
    NSString *key = _keys[indexPath.section];
    NSMutableArray *array1 = _dict[key];
    if (editingStyle == UITableViewCellEditingStyleInsert) {
        //1.插入数据(数据)
        [array1 insertObject:@"青云1603最棒!!!" atIndex:indexPath.row];
        //2.插入行(界面)
        [tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationRight];
    }else if (editingStyle == UITableViewCellEditingStyleDelete){
        //1.删除数据(数据)
        [array1 removeObjectAtIndex:indexPath.row];
        //2.删除行(界面)
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

#pragma mark -编辑(移动)
-(BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

//设置被推荐的indexPath
-(NSIndexPath *)tableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath{
    if (proposedDestinationIndexPath.row == 0) {
        return [NSIndexPath indexPathForRow:proposedDestinationIndexPath.row + 1 inSection:proposedDestinationIndexPath.section];
    }
    return proposedDestinationIndexPath;
}

//移动
-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(nonnull NSIndexPath *)sourceIndexPath toIndexPath:(nonnull NSIndexPath *)destinationIndexPath{
    
    //取出移动的cell对应的section的数据
    
    //取出sourcekey
    NSString *sourceKey = _keys[sourceIndexPath.section];
    //取出sourceArray
    NSMutableArray *sourceArray = _dict[sourceKey];
    //取出sourceString
    NSString *sourceString = sourceArray[sourceIndexPath.row];
    
    [sourceArray removeObjectAtIndex:sourceIndexPath.row];
    
    //获取目标位置
    
    //取出destinationKey
    NSString *destinationKey = _keys[destinationIndexPath.section];
    //获取destinationArray
    NSMutableArray *destinationArray = _dict[destinationKey];
    
    [destinationArray insertObject:sourceString atIndex:destinationIndexPath.row];
}

#pragma mark -UITableViewRowAction
-(NSArray <UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //获取当前行所在section的数组
    NSString *key = _keys[indexPath.section];
    NSMutableArray *array = _dict[key];
    
    UITableViewRowAction *rowAction1 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        //1.删除数据(数据)
        [array removeObjectAtIndex:indexPath.row];
        //2.删除行(界面)
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];

    }];
    rowAction1.backgroundColor = [UIColor orangeColor];
    
    UITableViewRowAction *rowAction2 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"置顶" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        
        tableView.editing = NO;
        
        NSString *string = array[indexPath.row];
        [array removeObjectAtIndex:indexPath.row];
        [array insertObject:string atIndex:0];
        
        [tableView moveRowAtIndexPath:indexPath toIndexPath:[NSIndexPath indexPathForRow:0 inSection:indexPath.section]];
        
    }];
    rowAction2.backgroundColor = [UIColor blueColor];
    
    return @[rowAction1,rowAction2];
    
}

#pragma mark  -menu
//控制menu是否显示
- (BOOL)tableView:(UITableView *)tableView shouldShowMenuForRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

//控制显示的操作
-(BOOL)tableView:(UITableView *)tableView canPerformAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender{
    if (action == @selector(cut:)) {
        return YES;
    }
    return YES;
}

//处理action
- (void)tableView:(UITableView *)tableView performAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(nullable id)sender{
    
}

@end
