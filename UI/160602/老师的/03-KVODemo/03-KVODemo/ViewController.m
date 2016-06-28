//
//  ViewController.m
//  03-KVODemo
//
//  Created by qingyun on 16/6/2.
//  Copyright © 2016年 QingYun. All rights reserved.
//

#import "ViewController.h"
#import "QYPerson.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *ageLabel;
@property(nonatomic,strong) QYPerson *mode;
@end

@implementation ViewController

- (IBAction)changeValueAction:(UIButton *)sender {
    _mode.age+=1;
}

#pragma mark - 监听方法
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
   //1.获取KeyPath
    if([keyPath isEqualToString:@"age"]){
      //2.取出change 里边new值
        NSString *ageStr=[change[@"new"] stringValue];
        
      //3.刷新UI
        UILabel *lab=(__bridge UILabel *)context;
        lab.text=ageStr;
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UILabel *ageLab=[[UILabel alloc] initWithFrame:CGRectMake(100, 100,50, 10)];
    ageLab.backgroundColor=[UIColor clearColor];
    [self.view addSubview:ageLab];
    
    
    //1.初始化mode
    QYPerson *person=[[QYPerson alloc] init];
    person.name=@"小明";
    person.age=22;

    //2.注册Kvo观察者属性age
    [person addObserver:self forKeyPath:@"age" options:NSKeyValueObservingOptionNew context:(__bridge void *)ageLab];
    
    _mode=person;
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)dealloc{
    //移除监听
    [_mode removeObserver:self forKeyPath:@"age"];

}

@end
