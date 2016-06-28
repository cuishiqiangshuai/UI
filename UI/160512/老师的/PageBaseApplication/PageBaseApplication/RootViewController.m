//
//  RootViewController.m
//  PageBaseApplication
//
//  Created by qingyun on 16/5/12.
//  Copyright © 2016年 QingYun. All rights reserved.
//

#import "RootViewController.h"
#import "DataViewController.h"

@interface RootViewController ()<UIPageViewControllerDelegate,UIPageViewControllerDataSource>
@property (strong, nonatomic) UIPageViewController *pageViewController;
@property (strong, nonatomic) NSArray *pageData;
@end

@implementation RootViewController

//懒加载月份数据
-(NSArray *)pageData{
    if (_pageData == nil) {
        // Create the data model.
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        _pageData = [[dateFormatter monthSymbols] copy];
    }
    return _pageData;
}

-(UIPageViewController *)pageViewController{
    if (_pageViewController == nil) {
        //创建pageViewController、scroll的意思是滚动、horizontal是水平
        _pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:@{UIPageViewControllerOptionInterPageSpacingKey:@(20.0)}];
        //设置代理
        _pageViewController.delegate = self;
        //设置数据源
        _pageViewController.dataSource = self;
        
        //获取内容控制器
        DataViewController *startingViewController = [self viewControllerAtIndex:0];
        //设置内容控制器
        NSArray *viewControllers = @[startingViewController];
        [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    }
    return _pageViewController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //添加pageViewController作为self的子视图控制器
    [self addChildViewController:self.pageViewController];
    //添加pageViewController的view
    [self.view addSubview:self.pageViewController.view];

    // Set the page view controller's bounds using an inset rect so that self's view is visible around the edges of the pages.
    CGRect pageViewRect = self.view.bounds;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        pageViewRect = CGRectInset(pageViewRect, 40.0, 40.0);
    }
    self.pageViewController.view.frame = pageViewRect;
    [self.pageViewController didMoveToParentViewController:self];
}

//根据索引和storyboard来获取内容控制器
- (DataViewController *)viewControllerAtIndex:(NSUInteger)index {
    // Return the data view controller for the given index.
    //当月份不存在 或者是 index越界的时候,返回nil
    if (([self.pageData count] == 0) || (index >= [self.pageData count])) {
        return nil;
    }
    
    // Create a new view controller and pass suitable data.
    //创建一个内容控制器
    DataViewController *dataViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"DataViewController"];
    //对内容控制器设置属性,(传递月份)
    dataViewController.dataObject = self.pageData[index];
    return dataViewController;
}

//获取viewController的月份在self.pageData中索引
- (NSUInteger)indexOfViewController:(DataViewController *)viewController {
    //获取当前控制器的月份,在self.pageData中的索引
    return [self.pageData indexOfObject:viewController.dataObject];
}

#pragma mark - Page View Controller Data Source
//设置当前控制器的上一个内容控制器
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    //获取当前控制器的索引
    NSUInteger index = [self indexOfViewController:(DataViewController *)viewController];
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    //索引-1
    index--;
    //返回上一个内容控制器
    return [self viewControllerAtIndex:index];
}

//设置当前控制器的下一个内容控制器
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    //获取当前控制器的索引
    NSUInteger index = [self indexOfViewController:(DataViewController *)viewController];
    if (index == NSNotFound) {
        return nil;
    }
    
    //索引 + 1
    index++;
    if (index == [self.pageData count]) {
        return nil;
    }
    //返回下一个内容控制器
    return [self viewControllerAtIndex:index];
}


#pragma mark - UIPageViewController delegate methods

//设置书脊的位置
- (UIPageViewControllerSpineLocation)pageViewController:(UIPageViewController *)pageViewController spineLocationForInterfaceOrientation:(UIInterfaceOrientation)orientation {
    if (UIInterfaceOrientationIsPortrait(orientation) || ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)) {
        // In portrait orientation or on iPhone: Set the spine position to "min" and the page view controller's view controllers array to contain just one view controller. Setting the spine position to 'UIPageViewControllerSpineLocationMid' in landscape orientation sets the doubleSided property to YES, so set it to NO here.
        
        UIViewController *currentViewController = self.pageViewController.viewControllers[0];
        NSArray *viewControllers = @[currentViewController];
        [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
        
        self.pageViewController.doubleSided = NO;
        return UIPageViewControllerSpineLocationMin;
    }
    
    // In landscape orientation: Set set the spine location to "mid" and the page view controller's view controllers array to contain two view controllers. If the current page is even, set it to contain the current and next view controllers; if it is odd, set the array to contain the previous and current view controllers.
    DataViewController *currentViewController = self.pageViewController.viewControllers[0];
    NSArray *viewControllers = nil;
    //获取当前currentViewController的索引,如果(索引为偶数,需要设置下一页内容控制器,索引为奇数,需要设置上一页内容控制器)
    NSUInteger indexOfCurrentViewController = [self indexOfViewController:currentViewController];
    if (indexOfCurrentViewController == 0 || indexOfCurrentViewController % 2 == 0) {
        UIViewController *nextViewController = [self pageViewController:self.pageViewController viewControllerAfterViewController:currentViewController];
        viewControllers = @[currentViewController, nextViewController];
    } else {
        UIViewController *previousViewController = [self pageViewController:self.pageViewController viewControllerBeforeViewController:currentViewController];
        viewControllers = @[previousViewController, currentViewController];
    }
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    
    //返回的书脊在中间
    return UIPageViewControllerSpineLocationMid;
}

@end
