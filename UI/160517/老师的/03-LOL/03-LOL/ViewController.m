//
//  ViewController.m
//  03-LOL
//
//  Created by qingyun on 16/5/17.
//  Copyright © 2016年 QingYun. All rights reserved.
//

#import "ViewController.h"
#import "QYHeroCell.h"
#import "QYSectionHeaderView.h"
#import "QYHeroGroup.h"
#import "QYHero.h"
@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *heroGroups;          //英雄分组
@end

@implementation ViewController
static NSString *identifier = @"heroCell";


//懒加载heroGroups
-(NSArray *)heroGroups{
    if (_heroGroups == nil) {
        //获取hero.plist文件路径
        NSString *path = [[NSBundle mainBundle] pathForResource:@"hero" ofType:@"plist"];
        //读取数据
        NSArray *array = [NSArray arrayWithContentsOfFile:path];
        
        //遍历数据,把其中的字典转化成QYHeroGroup模型
        NSMutableArray *groups = [NSMutableArray array];
        for (NSDictionary *groupDict in array) {
            QYHeroGroup *heroGroup = [QYHeroGroup heroGroupWithDictionary:groupDict];
            [groups addObject:heroGroup];
        }
        _heroGroups = groups;
    }
    return _heroGroups;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //注册单元格
    [_tableView registerClass:[QYHeroCell class] forCellReuseIdentifier:identifier];
    // Do any additional setup after loading the view, typically from a nib.
}

#pragma mark -UITabelViewDataSource

//组数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.heroGroups.count;
}

//组内的行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //获取当前section对应的模型
    QYHeroGroup *heroGroup = self.heroGroups[section];
    return heroGroup.isOpen ? heroGroup.friends.count : 0;
}

//行内容
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    QYHeroCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    //获取当前cell所在的section对应的模型
    QYHeroGroup *heroGroup = self.heroGroups[indexPath.section];
    //获取当前cell对应的模型
    QYHero *hero = heroGroup.friends[indexPath.row];
    
    cell.heroModel = hero;
    
    return cell;
}

#if 0
//section的头标题
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    //获取当前cell所在的section对应的模型
    QYHeroGroup *heroGroup = self.heroGroups[section];
    return heroGroup.name;
}
#endif

//设置section的头视图的高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 44.0;
}

//设置section的头视图
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    QYSectionHeaderView *sectionHeaderView = [QYSectionHeaderView sectionHeaderView:tableView];
    
    //获取当前cell所在的section对应的模型
    QYHeroGroup *heroGroup = self.heroGroups[section];
    sectionHeaderView.sectionModel = heroGroup;
    
    sectionHeaderView.headerViewClick = ^{
        [_tableView reloadData];
    };
    
    return sectionHeaderView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
