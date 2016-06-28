//
//  QYViewController.m
//  Demo01_UISearchBar
//
//  Created by qingyun on 16/5/19.
//  Copyright © 2016年 QingYun. All rights reserved.
//

#import "QYViewController.h"

@interface QYViewController () <UITableViewDataSource, UISearchBarDelegate>
{
    __weak UITableView *_tableView;
    __weak UISearchBar *_searchBar;
}

/*!
 * 正常情况下显示数据的数据源
 */
@property (nonatomic, strong) NSMutableArray *arrDatas;
/*!
 * 当在SearchBar中输入文字后过滤显示的内容的数据源
 */
@property (nonatomic, strong) NSMutableArray *arrSearchDatas;

/*!
 * 当前是否是主界面(区别于搜索界面)
 */
@property (nonatomic, assign) BOOL isMainDisplay;

@end

@implementation QYViewController

// 懒加载主界面显示的数据
- (NSMutableArray *)arrDatas {
    if (!_arrDatas) {
        _arrDatas = [NSMutableArray array];
    }
    return _arrDatas;
}

// 懒加载搜索结果界面的数据
- (NSMutableArray *)arrSearchDatas {
    if (!_arrSearchDatas) {
        _arrSearchDatas = [NSMutableArray array];
    }
    return _arrSearchDatas;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadDefaultSetting];
}

- (void)loadDefaultSetting {
    //translucent : 当是YES的时候navigationBar是透明的, 控制器的View的原点在NavigationBar的左上角
    // 当时NO的时候, NavigationBar是不透明的, 控制器的原点在NavigationBar的左下角
    self.navigationController.navigationBar.translucent = NO;
    // 创建SearchBar
    UISearchBar *searchBar = [UISearchBar new];
    searchBar.placeholder = @"请输入关键字";
    searchBar.frame = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 44);
    searchBar.delegate = self;
    [self.view addSubview:searchBar];
    _searchBar = searchBar;
    
    // 创建UITableView
    UITableView *taleView = [UITableView new];
    taleView.frame = CGRectMake(0, 44, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height - 44);
    taleView.dataSource = self;
    [self.view addSubview:taleView];
    _tableView = taleView;
    
    // 初始化数据源
    for (NSUInteger index = 0; index < 26; index ++) {
        for (NSUInteger j = 0; j < 4; j ++) {
            NSString *strText = [NSString stringWithFormat:@"%lc - %ld", 'A' + index, j];
            [self.arrDatas addObject:strText];
        }
    }
    
    self.isMainDisplay = YES;
}

#pragma mark - 🔌 Delegate Methods
#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.isMainDisplay) {
        return self.arrDatas.count;
    }
    return self.arrSearchDatas.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *strId = @"cellStyle1";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:strId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strId];
    }
    NSString *strText = nil;
    if (self.isMainDisplay) {
        strText = self.arrDatas[indexPath.row];
    } else {
        strText = self.arrSearchDatas[indexPath.row];
    }
    cell.textLabel.text = strText;
    
    return cell;
}

#pragma mark UISearchBarDelegate
// 当SearchBar开始编辑的时候会调用这个方法
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    // 开始编辑的时候把, 切换界面为搜索的数据
    self.isMainDisplay = NO;
}

// 当SearchBar的内容发生变化的时候就会调用这个方法
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    NSLog(@"%@", searchText);
    // 移除变化之前所有的搜索内容
    [self.arrSearchDatas removeAllObjects];
    if ([searchText isEqualToString:@""]) {
        // 如果清空了搜索的内容, 重置isMainDisplay为YES, 后面再刷新界面
        self.isMainDisplay = YES;
    } else {
        // 根据输入框中的关键字过滤
        for (NSString *strText in self.arrDatas) {
            if ([strText containsString:searchText]) {
                
                // 把通过过滤的字符串加入搜索结果的数组中
                [self.arrSearchDatas addObject:strText];
            }
        }
        // 搜索框不为空的情况下, 需要把isMainDisplay置为NO
        self.isMainDisplay = NO;
    }
    
    // 刷新TableView
    [_tableView reloadData];
}

@end
