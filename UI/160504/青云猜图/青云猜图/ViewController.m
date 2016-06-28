//
//  ViewController.m
//  青云猜图
//
//  Created by qingyun on 16/5/4.
//  Copyright © 2016年 QingYun. All rights reserved.
//

#import "ViewController.h"
#import "QYQuestion.h"
#import "QYAnswerView.h"
#import "QYOptionView.h"
@interface ViewController (){
    NSInteger currentIndex;             //当前题目的索引
}
@property (weak, nonatomic) IBOutlet UIButton *coinBtn;
@property (weak, nonatomic) IBOutlet UILabel *numLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (nonatomic, strong) QYAnswerView *answerView;
@property (nonatomic, strong) QYOptionView *optionView;

@property (nonatomic, strong) NSArray *questions;           //所有题目数据集合
@end

@implementation ViewController

//懒加载questions
- (NSArray *)questions {
    if (_questions == nil) {
        //获取plist路径
        NSString *path = [[NSBundle mainBundle] pathForResource:@"questions" ofType:@"plist"];
        //从path路径提取数据
        NSArray *array = [NSArray arrayWithContentsOfFile:path];
        //定义一个可变数组，存放转化后的模型
        NSMutableArray *models = [NSMutableArray array];
        //遍历array，把其中的字典转化成模型
        for (NSDictionary *dict in array) {
            QYQuestion *question = [QYQuestion modelWithDictionary:dict];
            [models addObject:question];
        }
        _questions = models;
    }
    return _questions;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //初始化UI界面
    [self updateUI];
    // Do any additional setup after loading the view, typically from a nib.
}

#pragma mark -点击事件处理
- (IBAction)btnClick:(UIButton *)sender {
    switch (sender.tag) {
        case 101://提示
            
            break;
        case 102://大图
            [self bigImageView];
            break;
        case 103://帮助
            
            break;
        case 104://下一题
            currentIndex++;
            [self updateUI];
            break;
        case 105://充值
            
            break;
            
        default:
            break;
    }
}
#pragma mark -更新UI界面
//更新UI界面
-(void)updateUI{
    //确保currentIndex可用（防止越界）
    currentIndex = currentIndex % self.questions.count;
    //1、更改题号
    _numLabel.text = [NSString stringWithFormat:@"%ld/%ld",currentIndex + 1,self.questions.count];
    //2、更改提示信息
    QYQuestion *question = self.questions[currentIndex];
    _titleLabel.text = question.title;
    //3、更改题目对应的图片
    _imageView.image = [UIImage imageNamed:question.icon];
    
    //添加answerView
    [_answerView removeFromSuperview];
    QYAnswerView *answerView = [QYAnswerView answerViewWithAnswerCount:question.answer.length];
    [self.view addSubview:answerView];
    answerView.frame = CGRectMake(0, 370, 0, 0);
    _answerView = answerView;
    
    __weak ViewController *weakSelf = self;
    //对answerBtnClick赋值
    answerView.answerBtnClick = ^(UIButton *answerBtn){
        [weakSelf answerBtnClick:answerBtn];
    };
    
    //添加optionView
    [_optionView removeFromSuperview];
    QYOptionView *optionView = [QYOptionView optionView];
    [self.view addSubview:optionView];
    optionView.frame = CGRectMake(0, 430, 0, 0);
    _optionView = optionView;
    //设置optionBtn的标题
    optionView.btnTitles = question.options;
    
    //对optionBtnClick赋值
    optionView.optionBtnClick = ^(UIButton *optionBtn){
        //处理optionBtn的点击事件
        [weakSelf optionBtnClick:optionBtn];
    };
    
}

- (void) answerBtnClick:(UIButton *) answerBtn{
    //1、清除answerBtn的标题
    
    //2、将optionView中对应的optionBtn显示
}

//处理optionBtn的点击事件
- (void) optionBtnClick:(UIButton *) optionBtn{
    //1、隐藏当前点击的optionBtn
    
    //2、把optionBtn的当前标题设置到answerView上对应的answerBtn（从左至右）
    
    //3、判断答案填充完整,判断答案正确
            //正确的情况下
            //0>更改题目完成状态
            //1>更改答案的颜色为绿色
            //2>加金币（当前题目没有被提示过）
            //3>延迟跳转下一题
            //不正确
            //1>更改答案颜色为红色
}


#pragma mark  -大图、缩小
//大图
- (void) bigImageView{
    //1、创建并添加全屏的btn
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:btn];
    btn.frame = self.view.frame;
    btn.backgroundColor = [UIColor yellowColor];
    btn.alpha = 0.0;
    //2、添加事件监听
    [btn addTarget:self action:@selector(smallImageView:) forControlEvents:UIControlEventTouchUpInside];
    //3、需要把_imageView置顶
    [self.view bringSubviewToFront:_imageView];
    //4、执行动画（1、放大_imageView,2、更改btn的透明度）
    [UIView animateWithDuration:1 animations:^{
        _imageView.transform = CGAffineTransformScale(_imageView.transform, 1.2, 1.5);
        btn.alpha = 0.5;
    }];
}

//还原_imageView
- (void) smallImageView:(UIButton *)sender {
    [UIView animateWithDuration:1 animations:^{
        //1、还原_imageView
        _imageView.transform = CGAffineTransformIdentity;
        //2、更改btn的透明度
        sender.alpha = 0.0;
    } completion:^(BOOL finished) {
        //3、动画完成之后，移除btn
        [sender removeFromSuperview];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
