//
//  ViewController.m
//  01-QYNews
//
//  Created by qingyun on 16/5/23.
//  Copyright © 2016年 QingYun. All rights reserved.
//

#import "ViewController.h"
#import "QYTitleScrollView.h"
#import "QYTitleCollectionView.h"
#import "DataTableViewController.h"
#import "Masonry.h"
@interface ViewController ()<UIPageViewControllerDataSource,UIPageViewControllerDelegate>
@property (nonatomic, strong) NSArray *titles;              //所有栏目标题集合
@property (nonatomic, strong) QYTitleScrollView *titleScrollView;

@property (nonatomic, strong) QYTitleCollectionView *titleCollectionView;

@property (nonatomic, strong) UIPageViewController *pageViewController;
@end

@implementation ViewController
//懒加载所有的栏目
-(NSArray *)titles{
    if (_titles == nil) {
        _titles = @[@"头条",@"郑州",@"黑科技",@"互联网",@"娱乐",@"社会",@"国际",@"智能设备",@"历史",@"体育",@"星座",@"内涵图",@"段子",@"游戏"];
    }
    return _titles;
}

//懒加载所有的栏目(scrollView)
-(QYTitleScrollView *)titleScrollView{
    if (_titleScrollView == nil) {
        //创建_titleScrollView
        _titleScrollView = [QYTitleScrollView titleScrollViewWithTitles:self.titles];
        __weak ViewController *weakSelf = self;
        _titleScrollView.changeContentVC = ^(NSUInteger index){
            [weakSelf changeContentViewControllerWithIndex:index];
        };
    }
    return _titleScrollView;
}

-(QYTitleCollectionView *)titleCollectionView{
    if (_titleCollectionView == nil) {
        _titleCollectionView = [QYTitleCollectionView titleCollectionViewWithTitles:self.titles];
    }
    return _titleCollectionView;
}

-(UIPageViewController *)pageViewController{
    if (_pageViewController == nil) {
        //创建一个水平滚动的pageViewController
        _pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
        //设置数据源和代理
        _pageViewController.dataSource = self;
        _pageViewController.delegate = self;
        
        //设置内容控制器
        DataTableViewController *contentVC = [self viewControllerWithIndex:0];
        [_pageViewController setViewControllers:@[contentVC] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
        
    }
    
    return _pageViewController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置滚动栏目视图
    self.navigationItem.titleView = self.titleCollectionView;
    //设置_titleScrollView的约束
    [_titleCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    
//    [self addChildViewController:self.pageViewController];
//    [self.view addSubview:self.pageViewController.view];
    
}

//根据选中的栏目的索引来更改内容控制器
-(void)changeContentViewControllerWithIndex:(NSUInteger)index{
    //1.获取当前控制器的type在titles中的索引currentIndex
    DataTableViewController *currentDataVC = self.pageViewController.viewControllers.firstObject;
    NSUInteger currentIndex = [self indexOfViewController:currentDataVC];
    //2.currentIndex == index,return;
    if (currentIndex == index) {
        return;
    }
    //3.根据index获取对应的内容控制器,然后设置内容控制器
    DataTableViewController *willChangedVC = [self viewControllerWithIndex:index];
    [self.pageViewController setViewControllers:@[willChangedVC] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
}


-(DataTableViewController *)viewControllerWithIndex:(NSUInteger)index{
    if (self.titles.count == 0 || index >= self.titles.count) {
        return nil;
    }
    
    DataTableViewController *dataVC = [[DataTableViewController alloc] initWithStyle:UITableViewStylePlain];
    dataVC.type = self.titles[index];
    return dataVC;
}

//获取当前控制器的type在titles中的索引currentIndex
-(NSUInteger)indexOfViewController:(DataTableViewController *)vc{
    return [self.titles indexOfObject:vc.type];
}

#pragma mark  -UIPageViewControllerDataSource
//上一个内容控制器
-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController{
    //1.获取当前控制器的type在titles中的索引currentIndex
    NSUInteger currentIndex = [self indexOfViewController:(DataTableViewController *)viewController];
    //2.假如currentIndex == 0 返回nil; currentIndex != 0,currentIndex -= 1
    if (currentIndex == 0) {
        return nil;
    }
    currentIndex -= 1;
    //3.根据currentIndex获取上一个内容控制器
    return [self viewControllerWithIndex:currentIndex];
}

//下一个内容控制器
-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController{
    //1.获取当前控制器的type在titles中的索引currentIndex
    NSUInteger currentIndex = [self indexOfViewController:(DataTableViewController *)viewController];
    //2.currentIndex++
    currentIndex++;
    //3.假如currentIndex >= self.titles.count,返回nil
    if (currentIndex >= self.titles.count) {
        return nil;
    }
    //4.根据currentIndex获取下一个内容控制器
    return [self viewControllerWithIndex:currentIndex];
}

#pragma mark -UIPageViewControllerDelegate
-(void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed{
    //1.获取当前控制器的type在titles中的索引currentIndex
    DataTableViewController *currentDataVC = self.pageViewController.viewControllers.firstObject;
    NSUInteger currentIndex = [self indexOfViewController:currentDataVC];
    
    //2.获取上一个内容控制器的type在titles中的索引previousIndex
    NSUInteger previousIndex = [self indexOfViewController:(DataTableViewController *)previousViewControllers.firstObject];
    //3.判断currentIndex != previousIndex,设置_titleScrollView的currentIndex等于currentIndex
    if (currentIndex != previousIndex) {
        _titleScrollView.currentIndex = currentIndex;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
