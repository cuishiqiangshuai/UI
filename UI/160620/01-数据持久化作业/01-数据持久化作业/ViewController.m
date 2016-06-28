//
//  ViewController.m
//  01-数据持久化作业
//
//  Created by qingyun on 16/6/20.
//  Copyright © 2016年 QingYun. All rights reserved.
//

#import "ViewController.h"
#import "AFNetWorking.h"
#import "QYstudent.h"
#import "QYDataBaseTool.h"

#define BASEURL @"http://afnetworking.sinaapp.com/persons.json"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (strong,nonatomic)UIRefreshControl *refreshControl;
@property (nonatomic)BOOL isRefrsh;
//存放数据源
@property(strong,nonatomic)NSMutableArray *dataArr;

@end

@implementation ViewController

-(void)requestPerson{
   //1.设置参数
    NSDictionary *pars=@{@"person_type":@"student"};
   //2.生成manager对象
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
   //3.Post请求
    __weak UITableView *tableView=_myTableView;
    __weak UIRefreshControl *refresh=_refreshControl;
    [manager POST:BASEURL parameters:pars progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //1.判断是否请求成功 200
        NSHTTPURLResponse *response=(NSHTTPURLResponse *)task.response;
        if (response.statusCode==200) {
        //2.取出数据===字典转mode
            NSArray *tempArr=responseObject[@"data"];
            if (_dataArr) {
            //判断是否下拉刷新
                if (_isRefrsh) {
                    [_dataArr removeAllObjects];
                    [refresh endRefreshing];
                   [QYDataBaseTool  updateStatementsSql:DeleteAll withParsmeters:nil block:^(BOOL isOk, NSString *errorMsg) {
                   }];
                }
            }else{
                _dataArr=[NSMutableArray array];
            }
          //mode
            for (NSDictionary *dic in tempArr) {
                //数据持久化
                [QYDataBaseTool updateStatementsSql:Inserinto withParsmeters:dic block:^(BOOL isOk, NSString *errorMsg) {
                    if (isOk) {
                        NSLog(@"insert OK");
                    }else{
                        NSLog(@"====%@",errorMsg);
                    }
                    
                }];
                
                QYstudent *student=[[QYstudent alloc] init];
                [student setValuesForKeysWithDictionary:dic];
                [_dataArr addObject:student];
            }
            
            [tableView reloadData];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    
    }];
}

-(void)refresh{
    //开始刷新
    _isRefrsh=YES;
    [self requestPerson];
}

-(void)addsubView{
   _refreshControl=[[UIRefreshControl alloc] init];
    [_refreshControl addTarget:self action:@selector(refresh) forControlEvents:UIControlEventValueChanged];
    [_myTableView addSubview:_refreshControl];
}

- (void)viewDidLoad {
    
    //1判断本地是否有存储数据
    __weak ViewController *controller=self;
    [QYDataBaseTool selectStatementsSql:selectAll withParsmeters:nil forMode:@"QYstudent" block:^(NSMutableArray *resposeOjbc, NSString *errorMsg) {
            if (resposeOjbc.count>0) {
                //从本地读取
                controller.dataArr=resposeOjbc;
                [controller.myTableView reloadData];
            }else{
                [controller requestPerson];
            }
    }];
    [self addsubView];
    [super viewDidLoad];
   // [self requestPerson];
    // Do any additional setup after loading the view, typically from a nib.
}
#pragma mark datasource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identfier=@"cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identfier];
    if (cell==nil) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identfier];
    }
    //取出mode ,赋值Ui
    QYstudent *mode=_dataArr[indexPath.row];
    cell.textLabel.text=mode.name;
    cell.detailTextLabel.text=[NSString stringWithFormat:@"ID:%@     age:%@",mode.stu_id,mode.age];

    return cell;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
