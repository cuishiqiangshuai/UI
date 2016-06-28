//
//  ViewController.m
//  考试一
//
//  Created by qingyun on 16/5/11.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "ViewController.h"
#define ScreenW [UIScreen mainScreen].bounds.size.width

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *addBtn;
@property (weak, nonatomic) IBOutlet UIButton *removeBtn;
@property (weak, nonatomic) IBOutlet UILabel *label;

@property(nonatomic,strong)NSArray *array;
@property(nonatomic,assign)NSInteger i;
@end

@implementation ViewController
-(NSArray *)array{
    if (_array==nil) {
        NSString *path=[[NSBundle mainBundle] pathForResource:@"app" ofType:@"plist"];
        _array=[NSArray arrayWithContentsOfFile:path];
    }
    return _array;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _label.enabled=NO;
}
- (IBAction)add:(UIButton *)sender {
    [self buju:_i];
}
- (IBAction)remove:(UIButton *)sender {
    [self removeView:_i];
}
-(void)buju:(NSInteger)i{
    _removeBtn.enabled=YES;
    _label.text=nil;
    if (i==6) {
        _addBtn.enabled=NO;
        _label.enabled=YES;
        _label.text=@"当前按钮不能点击了";
        return;
    }
    int column=3;//列
    //    CGFloat row=2;//行
    CGFloat viewW=80;
    CGFloat viewH=90;
    CGFloat spaceX=(ScreenW-(80*3))/4;
    CGFloat spaceY=10;
    NSInteger viewColumn=i%column;
    NSInteger viewRow=i/column;
    NSDictionary *dict=self.array[i];
    CGFloat viewX=spaceX*(viewColumn+1)+(viewColumn*80);
    CGFloat viewY=spaceY*(viewRow+1)+(viewRow*90);
    
    UIView *view=[[UIView alloc] init];
    view.frame=CGRectMake(viewX, 100+viewY, viewW , viewH);
    //        view.backgroundColor=[UIColor blueColor];
    [self.view addSubview:view];
    
    UIImageView *imageView=[[UIImageView alloc] init];
    imageView.frame=CGRectMake((viewW-40)/2, 0,40, 40);
    [view addSubview:imageView];
    imageView.image=[UIImage imageNamed:dict[@"image"]];
    
    UILabel *Label=[[UILabel alloc] init];
    Label.frame=CGRectMake((viewW-80)/2, 40, 80,20);
    [view addSubview:Label];
    Label.text=dict[@"name"];
    view.tag=i+1;
    Label.textAlignment=NSTextAlignmentCenter;
    _i++;
}

-(void)removeView:(NSInteger)i{
    _addBtn.enabled=YES;
    _label.text=nil;
    if (i==0) {
        _removeBtn.enabled=NO;
        _label.enabled=YES;
        _label.text=@"当前按钮不能点击了";
        return;
    }
    _label.enabled=NO;
    UIView *view=[self.view viewWithTag:i];
    [view removeFromSuperview];
    _i=i-1;
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
