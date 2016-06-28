//
//  ViewController.m
//  Demo01_UISearchBar
//
//  Created by qingyun on 16/5/19.
//  Copyright © 2016年 QingYun. All rights reserved.
//

/** QLDEBUG Print | M:method, L:line, C:content*/
#ifndef QLLog
#ifdef DEBUG
#define QLLog(FORMAT, ...) fprintf(stderr,"M:%s|L:%d|C->%s\n", __FUNCTION__, __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String])
#else
#define QLLog(FORMAT, ...)
#endif
#endif

#import "ViewController.h"
#import "QYViewController.h"

@interface ViewController () <UISearchBarDelegate>
{
    __weak UISearchBar *_searchBar;
}

@end

@implementation ViewController

#pragma mark - ♻️ LifeCycle Methods
- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadDefaultSetting];
}

/** Load the default UI elements And prepare some datas needed. */
- (void)loadDefaultSetting {
    // 计算SearchBar的frame
    CGRect rectSearchBar = CGRectMake(0, 20, [[UIScreen mainScreen] bounds].size.width, 44);
    // 创建SearchBar, 同时设置frame
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:rectSearchBar];
    // 设置占位符
    searchBar.placeholder = @"请输入关键字";
    
    // 设置SearchBar的选染色
    searchBar.tintColor = [UIColor orangeColor];
    // 设置SearchBar的搜索样式
    /*!
     * UISearchBarStyleDefault
     * UISearchBarStyleProminent : 其实就是默认的样式
     * UISearchBarStyleMinimal: 去掉了边框的背景
     */
    searchBar.searchBarStyle = UISearchBarStyleMinimal;
    
    // 设置SearchBar的类型, 很少用
    //searchBar.barStyle = UIBarStyleBlack;
    
    //[searchBar setShowsBookmarkButton:YES];
    
    searchBar.delegate = self;
    
    // 把SearchBar添加到当前的视图中
    [self.view addSubview:searchBar];
    
    _searchBar = searchBar;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    QYViewController *viewController = [QYViewController new];
    [self.navigationController pushViewController:viewController animated:YES];
}

#pragma mark - UISearchBarDelegate
/*!
 * 当搜索框中的内容发生变化的时候调用, 询问当前的文字是否发生改变
 */
- (BOOL)searchBar:(UISearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    // text: 本次输入的内容
    // range: 第一个参数代表当前光标的位置
    QLLog(@"%@-%@", text, NSStringFromRange(range));
    
    if ([text containsString:@"s"]) {
        return NO;
    }
    
    return YES;
}

/*!
 * 当搜索框中的内容发生变化的时候调用
 */
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    // 输入框中的所有内容
    QLLog(@"%@", searchText);
}

/*!
 * 当SearchBar右侧的书签按钮被点击时候调用
 */
- (void)searchBarBookmarkButtonClicked:(UISearchBar *)searchBar {
    QLLog(@"%@", @"");
}

/*!
 * 当SearchBar右侧的Cancel按钮被点击的时候调用
 */
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    QLLog(@"%@", @"");
    
    searchBar.text = nil;
    [searchBar resignFirstResponder];
    [searchBar setShowsCancelButton:NO animated:YES];
}

/*!
 * 当SearchBar已经开始编辑的时候调用
 */
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    QLLog(@"%@", @"");

    [searchBar setShowsCancelButton:YES animated:YES];
}

/*!
 * 当SearchBar结束编辑的时候调用
 */
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    QLLog(@"%@", @"");
}

@end
