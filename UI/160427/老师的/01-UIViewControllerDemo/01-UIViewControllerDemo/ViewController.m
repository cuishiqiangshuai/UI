//
//  ViewController.m
//  01-UIViewControllerDemo
//
//  Created by qingyun on 16/4/27.
//  Copyright © 2016年 QingYun. All rights reserved.
//

#import "ViewController.h"
#import "SecondVC.h"
@interface ViewController ()

@end

@implementation ViewController


//视图控制器的指定初始化方法
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        
    }
    return self;
}

////重写loadView方法(加载self.view的过程)
//- (void)loadView{
//#if 0
//    //方法中要创建一个满屏的view给self.view
//    UIView *tempView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
//    tempView.backgroundColor = [UIColor redColor];
//    self.view = tempView;
//    
//    //使用场景，把当前视图控制器的self.view设置成一个非普通的view（webView/tableView）
//    UIWebView *webView = [[UIWebView alloc] initWithFrame:[UIScreen mainScreen].bounds];
//    self.view = webView;
//    NSURL *url = [NSURL URLWithString:@"https://www.baidu.com"];
//    NSURLRequest *request = [NSURLRequest requestWithURL:url];
//    [webView loadRequest:request];
//#else
//    UITableView *tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
//    self.view = tableView;
//    
//#endif
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.view.backgroundColor = [UIColor cyanColor];
    NSLog(@"%@",self.view);
    // Do any additional setup after loading the view, typically from a nib.
}
//跳转下一页
- (IBAction)nextPage:(UIButton *)sender {
    SecondVC *secondVC = [[SecondVC alloc] init];
    [self presentViewController:secondVC animated:YES completion:nil];
}

//视图将要显示
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSLog(@"%s",__func__);
}

//视图已经显示
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    NSLog(@"%s",__func__);
}

//视图将要消失
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    NSLog(@"%s",__func__);
}

//视图已经消失
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    NSLog(@"%s",__func__);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
