//
//  ViewController.m
//  Demo02_UISearchController
//
//  Created by qingyun on 16/5/19.
//  Copyright © 2016年 QingYun. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UISearchResultsUpdating, UITableViewDataSource>

@property (nonatomic, strong) UISearchController *searchController;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 创建TableView
    UITableView *tableView = [UITableView new];
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    tableView.frame = [UIScreen mainScreen].bounds;//CGRectMake(0, 44, screenSize.width, screenSize.height - 44);
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    
    // 创建SearchController
    UISearchController *searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    searchController.searchResultsUpdater = self;
    //searchController.searchBar.frame = CGRectMake(0, 0, screenSize.width, 44);
    //[self.view addSubview:searchController.searchBar];
    [searchController.searchBar sizeToFit];
    tableView.tableHeaderView = searchController.searchBar;
    
    self.searchController = searchController;
}

#pragma mark - UISearchResultsUpdating
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    NSLog(@"%@", searchController.searchBar.text);
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *strIdentifire = @"asbdv";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:strIdentifire];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strIdentifire];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"row-%ld", indexPath.row];
    return cell;
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

@end
