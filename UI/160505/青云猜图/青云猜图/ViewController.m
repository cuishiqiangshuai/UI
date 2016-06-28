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
@property (weak, nonatomic) IBOutlet UIButton *nextBtn;

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
            [self hint];
            break;
        case 102://大图
            [self bigImageView];
            break;
        case 103://帮助
            
            break;
        case 104://下一题
            [self next];
            break;
        case 105://充值
            
            break;
            
        default:
            break;
    }
}

-(void)hint{
    //判断当前金币是否足够消费，不够的话，充值
    if ([_coinBtn.currentTitle integerValue] < 1000) {
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"金币不足，请充值！" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"跳转支付平台！！");
            [self changeCoin:10000];
        }];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            //NSLog(@"跳转支付平台！！");
        }];
        
        [alertController addAction:action];
        [alertController addAction:cancelAction];
        
        [self presentViewController:alertController animated:YES completion:nil];
        
        return;
    }
    //提示
    QYQuestion *question = self.questions[currentIndex];
    //声明需要填充的answerBtn的索引
    __block NSUInteger willFillIndex = -1;
    //确定answerBtn的索引
    [_answerView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[UIButton class]]) {
            
            //正确答案
            NSString *rightString = [question.answer substringWithRange:NSMakeRange(idx, 1)];
            
            if (![rightString isEqualToString:((UIButton *)obj).currentTitle]) {
                
                willFillIndex = willFillIndex == -1 ? idx : willFillIndex;
                [self answerBtnClick:(UIButton *)obj];
                //*stop = YES;
            }
        }
    }];
    
    
    if (willFillIndex != -1) {
        NSString *rightString = [question.answer substringWithRange:NSMakeRange(willFillIndex, 1)];
        
        //根据rightString找optionView中对应的optionBtn
        [_optionView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj isKindOfClass:[UIButton class]]) {
                UIButton *optionBtn = (UIButton *)obj;
                
                if ([optionBtn.currentTitle isEqualToString:rightString]) {
                    //跳出循环
                    *stop = YES;
                    //1、更改提示状态
                    question.isHint = YES;
                    //2、减金币
                    [self changeCoin:-1000];
                    //3、模拟点击optionBtn
                    [self optionBtnClick:optionBtn];
                }
            }
        }];
    }
    
}
#pragma mark -更新UI界面

-(void)next{
    _nextBtn.enabled = YES;
    
    //判断是否通关
    __block BOOL isPass = YES;
    [self.questions enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        QYQuestion *question = (QYQuestion *)obj;
        if (!question.isFinish) {
            isPass = NO;
            *stop = YES;
        }
    }];
    
    if (isPass) {
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"恭喜您，通关了，是否再来一次！" preferredStyle:UIAlertControllerStyleAlert];
        
        __weak ViewController *weakSelf = self;
        
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            [weakSelf.questions enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                QYQuestion *question = (QYQuestion *)obj;
                question.isHint = NO;
                question.isFinish = NO;
                currentIndex = 0;
                [weakSelf updateUI];
            }];
        }];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }];
        
        [alertController addAction:action];
        [alertController addAction:cancelAction];
        
        [self presentViewController:alertController animated:YES completion:nil];
        
        
        return;
    }
    
    currentIndex++;
    [self updateUI];
}

//更新UI界面
-(void)updateUI{
    //确保currentIndex可用（防止越界）
    currentIndex = currentIndex % self.questions.count;
    
    QYQuestion *question = self.questions[currentIndex];
    if (question.isFinish) {
        [self next];
        return;
    }
    
    //1、更改题号
    _numLabel.text = [NSString stringWithFormat:@"%ld/%ld",currentIndex + 1,self.questions.count];
    //2、更改提示信息
    
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
    if (answerBtn.currentTitle.length == 0) {
        return;
    }
    
    //1、清除answerBtn的标题
    [answerBtn setTitle:nil forState:UIControlStateNormal];
    //2、将optionView中对应的optionBtn显示
    UIButton *optionBtn = [_optionView viewWithTag:answerBtn.tag];
    optionBtn.hidden = NO;
    
    optionBtn.tag = answerBtn.tag = 0;
    
    [self changeAnswerBtnTitleColor:[UIColor blackColor]];
    
    //提取answerBtn在answerView.subViews中的索引
    NSInteger idx = [_answerView.subviews indexOfObject:answerBtn];
    //把索引添加到answerView.answerBtnIndexs中
    [_answerView.answerBtnIndexs addObject:@(idx)];
    //对answerView.answerBtnIndexs排序（确保从左至右）
    NSArray *array = [_answerView.answerBtnIndexs sortedArrayUsingSelector:@selector(compare:)];
    
    _answerView.answerBtnIndexs = [NSMutableArray arrayWithArray:array];
}

//处理optionBtn的点击事件
- (void) optionBtnClick:(UIButton *) optionBtn{
    if (_answerView.answerBtnIndexs.count > 0) {
        //1、隐藏当前点击的optionBtn
        optionBtn.hidden = YES;
        //2、把optionBtn的当前标题设置到answerView上对应的answerBtn（从左至右）
            //获取需要填写的answerBtn的索引
        NSInteger answerBtnIndex = [_answerView.answerBtnIndexs.firstObject integerValue];
            //从answerView.subViews中获取answerBtn
        UIButton *answerBtn = _answerView.subviews[answerBtnIndex];
            //设置answerBtn的标题为当前optionBtn的标题
        [answerBtn setTitle:optionBtn.currentTitle forState:UIControlStateNormal];
            //从answerView.answerBtnIndexs中移除第一个索引
        [_answerView.answerBtnIndexs removeObjectAtIndex:0];
            //设置optionBtn和answerBtn的tag一致，方便后期通过answerBtn获取optionBtn
        optionBtn.tag = answerBtn.tag = 100 + answerBtnIndex;
    }
    
    //3、判断答案填充完整,判断答案正确
    //正确的情况下
    //0>更改题目完成状态
    //1>更改答案的颜色为绿色
    //2>加金币（当前题目没有被提示过）
    //3>延迟跳转下一题
    //不正确
    //1>更改答案颜色为红色
    if (_answerView.answerBtnIndexs.count == 0){
        //获取answerView中所有answerBtn标题
        NSMutableString *mutableString = [NSMutableString string];
        [_answerView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj isKindOfClass:[UIButton class]]) {
                [mutableString appendString:((UIButton *)obj).currentTitle];
            }
        }];
        //获取当前题目对应的模型
        QYQuestion *question = self.questions[currentIndex];
        
        if ([question.answer isEqualToString:mutableString]) {
            //答案正确
            question.isFinish = YES;
            
            [self changeAnswerBtnTitleColor:[UIColor greenColor]];
            
            if (!question.isHint) {
                [self changeCoin:1000];
            }
            
            [self performSelector:@selector(next) withObject:nil afterDelay:1];
            
            _nextBtn.enabled = NO;
            
        }else{
            [self changeAnswerBtnTitleColor:[UIColor redColor]];
        }
    }
    
}

//更改金币
-(void)changeCoin:(NSInteger)num{
    //提取当前金币
    NSString *currentTitle = _coinBtn.currentTitle;
    NSInteger coinNum = [currentTitle integerValue] + num;
    
    NSString *title = [@(coinNum) stringValue];
    [_coinBtn setTitle:title forState:UIControlStateNormal];
}


//更改所有answerBtn的标题颜色
- (void)changeAnswerBtnTitleColor:(UIColor *)color{
    [_answerView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[UIButton class]]) {
            [((UIButton *)obj) setTitleColor:color forState:UIControlStateNormal];
        }
    }];
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
