//
//  ViewController.m
//  05-CellPropertyDemo
//
//  Created by qingyun on 16/5/14.
//  Copyright © 2016年 QingYun. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableView.rowHeight = 100;
    
    //设置允许多选
    _tableView.allowsMultipleSelection = YES;
    // Do any additional setup after loading the view, typically from a nib.
}

#pragma mark  -UITableViewDataSource

//组内行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:indexPath.row % 4 reuseIdentifier:identifier];
        
        //设置背景视图
        UIView *bgView = [[UIView alloc] init];
        bgView.backgroundColor = [UIColor colorWithRed:0.3 green:0.5 blue:0.2 alpha:0.5];
        //cell.backgroundView = bgView;
        
        //设置多选的时候背景
        UIView *selectedView = [[UIView alloc] init];
        selectedView.backgroundColor = [UIColor orangeColor];
        //cell.multipleSelectionBackgroundView = selectedView;
        
        //辅助视图
        //自定义辅助视图
        cell.accessoryView = [[UISwitch alloc] init];
        //系统类型
        //cell.accessoryType = indexPath.row % 5;
        //选中的风格
        cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    }
    
    //获取图片的名称
    NSString *iconName = [NSString stringWithFormat:@"icon%ld.jpg",indexPath.row];
    cell.imageView.image = [UIImage imageNamed:iconName];
    
    //设置标题
    cell.textLabel.text = [NSString stringWithFormat:@"第%ld行",indexPath.row];
    
    //设置副标题
    cell.detailTextLabel.text = @"小东";
    
    return cell;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
