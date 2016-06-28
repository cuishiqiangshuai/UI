//
//  ViewController.m
//  青云猜图崔世强
//
//  Created by qingyun on 16/5/3.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "ViewController.h"
#import "QYCTModel.h"
#import "QYAnswerView.h"
#import "QYOptionView.h"
#import "Common.h"


@interface ViewController ()

@property(nonatomic,strong)NSArray *questions;
@property (weak, nonatomic) IBOutlet UILabel *numLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property(nonatomic,assign)NSInteger currentIndex;
@property (weak, nonatomic) IBOutlet UIButton *coinBtn;
@property (weak, nonatomic) IBOutlet UIButton *nextBtn;

@property(nonatomic,strong)QYAnswerView *answerView;
@property(nonatomic,strong)QYOptionView *optionView;

@end

@implementation ViewController

-(NSArray *)questions
{
    if (_questions==nil)
    {
        NSString *path=[[NSBundle mainBundle] pathForResource:@"questions" ofType:@"plist"];
        NSArray *array=[NSArray arrayWithContentsOfFile:path];
        NSMutableArray *models=[NSMutableArray array];
        for (NSDictionary *dict in array)
        {
            QYCTModel *appModel=[[QYCTModel alloc] initWithDictionary:dict];
            [models addObject:appModel];
        }
        _questions=models;
    }
    return _questions;
}

-(IBAction)BtnClick:(UIButton *)sender
{
    switch (sender.tag) {
        case 101://
              [self datuimageView];
            break;
        case 102:
            
            break;
        case 103:
            [self next];
            break;
        case 104:
            //
            break;
        case 105:
            //
            break;
        case 110:
            [self hint];
            break;
            
        default:
            break;
    }
}
-(void)genggai
{
    _currentIndex=_currentIndex%self.questions.count;//循环
    
    QYCTModel *model=self.questions[_currentIndex];
    if (model.isFinish)
    {
        [self next];
        return;
    }
    
    _numLabel.text=[NSString stringWithFormat:@"%ld/%ld",_currentIndex+1,self.questions.count];
    _titleLabel.text=model.title;
    _iconView.image=[UIImage imageNamed:model.icon];
    
    //添加answerView
    [_answerView removeFromSuperview];
    QYAnswerView *answerView=[QYAnswerView answerViewWithAnswerCount:model.answer.length];
    [self.view addSubview:answerView];
    answerView.frame=CGRectMake(0, 370, 0, 0);
    _answerView=answerView;
    __weak ViewController *weakSelf=self;
    answerView.answerBtnClick=^(UIButton *answerBtn){
        [weakSelf answerBtnClick:answerBtn];
    };
    
    //添加optionview
    [_optionView removeFromSuperview];
    QYOptionView *optionView=[QYOptionView optionView];
    [self.view addSubview:optionView];
    optionView.frame=CGRectMake(0, 430, 0, 0);
    
    _optionView=optionView;
    optionView.btnTitles=model.options;
    //对optionBtnClick赋值
    optionView.optionBtnClick=^(UIButton *optionBtn){
        [weakSelf optionBtnClick:optionBtn];
    };
}
-(void)hint
{
    //判断当前金币是否足够消费，不够的话，充值
    if ([_coinBtn.currentTitle integerValue]<1000)
    {
        UIAlertController *alertController=[UIAlertController alertControllerWithTitle:@"提示" message:@"金币不足，请充值！" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"跳转支付平台！！");
            [self changeCoin:10000];
        }];
        UIAlertAction *cancelAction=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alertController addAction:action];
        [alertController addAction:cancelAction];
        [self presentViewController:alertController animated:YES completion:nil];
        return;
    }
    //提示
    QYCTModel *model=self.questions[_currentIndex];
    //声明需要填充的answerBtn的索引
    __block NSUInteger willFillIndex=-1;
    //确定answerBtn的索引
    [_answerView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[UIButton class]])
        {
             //正确答案
            NSString *rightString=[model.answer substringWithRange:NSMakeRange(idx, 1)];
            if (![rightString isEqualToString:((UIButton *)obj).currentTitle])
            {
                willFillIndex =willFillIndex==-1 ? idx : willFillIndex;
                [self answerBtnClick:(UIButton *)obj];
            }
        }
    }];
    if (willFillIndex !=-1)
    {
        NSString *rightString=[model.answer substringWithRange:NSMakeRange(willFillIndex, 1)];
        //根据rightString找optionBtn
        [_optionView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj isKindOfClass:[UIButton class]])
            {
                UIButton *optionBtn=(UIButton *)obj;
                if ([optionBtn.currentTitle isEqualToString:rightString])
                {
                    //跳出循环
                    *stop=YES;
                    //1.更改提示状态
                    model.isHint=YES;
                    //2.减金币
                    [self changeCoin:-1000];
                    //2.模拟点击optionBtn
                    [self optionBtnClick:optionBtn];
                }
            }
        }];
    }
}
-(void)answerBtnClick:(UIButton *)answerBtn
{
    if (answerBtn.currentTitle.length==0) {
        return;
    }
    //1.清除answerBtn的标题
    [answerBtn setTitle:nil forState:UIControlStateNormal];
    //2.将optionView中对应的optionBtn显示
    UIButton *optionBtn=[_optionView viewWithTag:answerBtn.tag];
    optionBtn.hidden=NO;
    optionBtn.tag=answerBtn.tag=0;
    [self changeAnswerbtnTitleColor:[UIColor blackColor]];
    //提取answerbtn在answerView.subViews中的索引
    NSInteger idx=[_answerView.subviews indexOfObject:answerBtn];
    //把索引添加到answerView.answerBtnIndexs中
    [_answerView.answerBtnIndexs addObject:@(idx)];
    //对answerView.answerBtnIndexs排序（确保从左至右）
    NSArray *array=[_answerView.answerBtnIndexs sortedArrayUsingSelector:@selector(compare:)];
    _answerView.answerBtnIndexs=[NSMutableArray arrayWithArray:array];
}
-(void)optionBtnClick:(UIButton *)optionBtn
{
    if (_answerView.answerBtnIndexs.count>0)
    {
        //1.隐藏当前点击的optionBtn
        optionBtn.hidden=YES;
        //2.把optionBtn的当前标题设置到answerView上对应的answerBtn（从左至右）
        //获取需要填写的answerBtn的索引
        NSInteger answerBtnIndex=[_answerView.answerBtnIndexs.firstObject integerValue];
        //从answerView.subViews中获取answerBtn
        UIButton *answerBtn=_answerView.subviews[answerBtnIndex];
        //设置answerBtn的标题为当前optionBtn的标题
        [answerBtn setTitle:optionBtn.currentTitle forState:UIControlStateNormal];
        //从answerView。answerBtnIndexs中移除第一个索引
        [_answerView.answerBtnIndexs removeObjectAtIndex:0];
        //设置optionBtn和answerBtn的tag一致，方便后期通过answerBtn获取optionBtn
        optionBtn.tag=answerBtn.tag=100+answerBtnIndex;
    }
    //3.判断答案填充完整，判断答案正确
    //正确情况下
    //0>更改题目的完成状态
    //1>更改答案的颜色为绿色
    //2>加金币（当前题目没有被提示）
    //3>延迟跳转下一题
    //不正确
    //1>更改答案的颜色为红色
    if (_answerView.answerBtnIndexs.count==0)
    {
        //获取answerView中所有answerBtn标题
        NSMutableString *mutableString=[NSMutableString string];
        [_answerView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj isKindOfClass:[UIButton class]])
            {
                [mutableString appendString:((UIButton *)obj).currentTitle];
            }
        }];
        //获取当前题目对应的模型
        QYCTModel *model=self.questions[_currentIndex];
        if ([mutableString isEqualToString:model.answer])
        {
            //答案正确
            model.isFinish=YES;
            [self changeAnswerbtnTitleColor:[UIColor greenColor]];
            if (!model.isHint)
            {
                [self changeCoin:1000];
            }
            [self performSelector:@selector(next) withObject:nil afterDelay:1];
            _nextBtn.enabled=NO;
        }
        else
        {
            [self changeAnswerbtnTitleColor:[UIColor redColor]];
        }
    }
}
-(void)next
{
    _nextBtn.enabled=YES;
    //判断是否通关
    __block BOOL isPass=YES;
    [self.questions enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        QYCTModel *model=(QYCTModel *)obj;
        if (!model.isFinish)
        {
            isPass=NO;
            *stop=YES;
        }
    }];
    if (isPass)
    {
        UIAlertController *alertController=[UIAlertController alertControllerWithTitle:@"提示" message:@"恭喜您，通关了，是否再来一次！" preferredStyle:UIAlertControllerStyleAlert];
        __weak ViewController *weakSelf=self;
        UIAlertAction *action=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            [weakSelf.questions enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                QYCTModel *model=(QYCTModel *)obj;
                model.isHint=NO;
                model.isFinish=NO;
                _currentIndex=0;
                [weakSelf genggai];
            }];
        }];
        UIAlertAction *cancelAction=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alertController addAction:action];
        [alertController addAction:cancelAction];
        [self presentViewController:alertController animated:YES completion:nil];
        return;
    }
    _currentIndex++;
    [self genggai];
}
-(void)changeCoin:(NSInteger)num
{
    //提取当前金币
    NSString *currentTitle=_coinBtn.currentTitle;
    NSInteger coinnum=[currentTitle integerValue]+num;
    NSString *title=[@(coinnum) stringValue];
    [_coinBtn setTitle:title forState:UIControlStateNormal];
}
-(void)datuimageView{
    UIButton *Btn=[UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:Btn];
    Btn.frame=self.view.frame;
    [Btn setBackgroundColor:[UIColor redColor]];
    Btn.alpha=0.0;
    [Btn addTarget:self action:@selector(huanyuan:) forControlEvents:UIControlEventTouchUpInside];
    [self.view bringSubviewToFront:_iconView];
    [UIView animateWithDuration:0.5 animations:^{
        _iconView.transform=CGAffineTransformScale(_iconView.transform, 1.5,1.5);
        Btn.alpha=0.5;
    }];
    
}
-(void)changeAnswerbtnTitleColor:(UIColor *)color
{
    [_answerView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[UIButton class]]) {
            [((UIButton *)obj) setTitleColor:color forState:UIControlStateNormal];
        }
    }];
}
-(void)huanyuan:(UIButton *)sender{
    [UIView animateWithDuration:1 animations:^{
        _iconView.transform=CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        [sender removeFromSuperview];
         sender.alpha=0;
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self genggai];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
