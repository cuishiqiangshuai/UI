//
//  ViewController.m
//  青云猜图二
//
//  Created by qingyun on 16/5/6.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "ViewController.h"
#import "Model.h"
#import "AnswerView.h"
#import "Common.h"
#import "OptionView.h"

@interface ViewController ()
@property(nonatomic,strong)NSArray *questions;//声明一个数组用于接收plist文件
@property (weak, nonatomic) IBOutlet UILabel *numLabel;
@property (weak, nonatomic) IBOutlet UILabel *TitleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *coinBtn;
@property (weak, nonatomic) IBOutlet UIButton *nextBtn;

@property(nonatomic,assign)NSInteger currentIndex;
@property(nonatomic,strong)AnswerView *answerView;
@property(nonatomic,strong)OptionView *optionView;

@end

@implementation ViewController
//懒加载plist文件的数组
-(NSArray *)questions{
    if (_questions==nil)
    {
        //获取plist路径
    NSString *path=[[NSBundle mainBundle] pathForResource:@"questions" ofType:@"plist"];
        //从path路径提取数据
    NSArray *array=[NSArray arrayWithContentsOfFile:path];
        //定义一个可变数组，存放转化后的模型
    NSMutableArray *array2=[NSMutableArray array];
        //遍历array，把其中的字典转化成模型
    for (NSDictionary *dict in array)
    {
        Model *models=[[Model alloc] initWithDictionary:dict];
        [array2 addObject:models];
    }
        _questions=array2;
    }
    return _questions;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self upDateUI];
    
}
-(void)hint
{
    //判断当前金币是否足够消费，不够的话充值
    if ([_coinBtn.currentTitle integerValue]<1000)
    {
        //弹出视图（是否充值）
        UIAlertController *alertController=[UIAlertController alertControllerWithTitle:@"提示" message:@"金币不足，请充值" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            [self changeCoin:10000];
        }];
        UIAlertAction *action2=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alertController addAction:action];
        [alertController addAction:action2];
        [self presentViewController:alertController animated:YES completion:nil];
        return;
    }
    //提示
    Model *model=self.questions[_currentIndex];
    //声明需要填充的answerBtn的索引
    __block NSUInteger willFillIndex=-1;
    __weak ViewController *weafSelf=self;
    //确定answerBtn的索引
    [_answerView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[UIButton class]])
        {
            //正确答案
            NSString *rightString=[model.answer substringWithRange:NSMakeRange(idx, 1)];
            if (![rightString isEqualToString:((UIButton *)obj).currentTitle])
            {
                willFillIndex=willFillIndex==-1?idx:willFillIndex;
                //当answerBtn的title不正确时，需要先模拟点击answerBtn把answerBtn的title清除，在模拟点击optionBtn填充正确的title
                //模拟点击answerBtn
                [weafSelf answerBlock:(UIButton *)obj];
            }
        }
    }];
    if (willFillIndex !=-1)
    {
        NSString *rightString=[model.answer substringWithRange:NSMakeRange(willFillIndex, 1)];
        //根据rightString找optionView中对应的optionBtn
        [_optionView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj isKindOfClass:[UIButton class]])
            {
                UIButton *optionBtn=(UIButton *)obj;
                if ([optionBtn.currentTitle isEqualToString:rightString])
                {
                    //跳出循环
                    *stop=YES;
                    //更改提示状态
                    model.isHint=YES;
                    //减金币
                    [weafSelf changeCoin:-1000];
                    //模拟点击optionBtn
                    [weafSelf optionBlock:optionBtn];
                }
            }
            
        }];
    }
}
//更新UI界面
-(void)upDateUI{
    _currentIndex=_currentIndex%self.questions.count;
    Model *model=self.questions[_currentIndex];
    //当我们已经回答过的题目下次就不会出现
    if (model.isFinish)
    {
        [self next];
        return;
    }
    //1.更改题号
    _numLabel.text=[NSString stringWithFormat:@"%ld/%ld",_currentIndex+1,self.questions.count];
    //2.更改提示信息
    _TitleLabel.text=model.title;
    //3.更改题目对应的图片
    _imageView.image=[UIImage imageNamed:model.icon];
    
    
    //添加answerView
    [_answerView removeFromSuperview];
    AnswerView *answerView=[AnswerView answerViewWithAnswerCount:model.answer.length];
    [self.view addSubview:answerView];
    answerView.frame=CGRectMake(0, 370, ScreenW, 40);
    _answerView=answerView;
    __weak ViewController *weakSelf=self;
    answerView.answerblock=^(UIButton *answerBtn){
        //处理answerView的点击事件
        [weakSelf answerBlock:answerBtn];
    };
    
    
    //添加optionView
    [_optionView removeFromSuperview];
    OptionView *optionView=[OptionView OptionViewWithModel:model];
    optionView.frame=CGRectMake(0, 430, ScreenW, 150);
    [self.view addSubview:optionView];
    _optionView=optionView;
    //在这里赋值给optionblock
    optionView.optionblock=^(UIButton *optionBtn){
        //处理optionView的点击事件
        [weakSelf optionBlock:optionBtn];
    };
}
//处理answerBtn的点击事件
-(void)answerBlock:(UIButton *)answerBtn{
    if (answerBtn.currentTitle.length==0)
    {
        return;
    }
    //1.清除answerBtn的标题
    [answerBtn setTitle:nil forState:UIControlStateNormal];
    //2.将optionView中对应的optionBtn显示
    UIButton *optionBtn=[_optionView viewWithTag:answerBtn.tag];
    optionBtn.hidden=NO;
    optionBtn.tag=answerBtn.tag=0;
    [self changeColor:[UIColor blackColor]];
    //提取answerBtn在answerView.subviews中的索引
    NSInteger idx=[_answerView.subviews indexOfObject:answerBtn];
    //把索引添加到answerView.answerBtnIndexs中
    [_answerView.answerBtnIndexs addObject:@(idx)];
    //对answerView.answerBtnIndexs排序（确保从左至右）
    NSArray *array=[_answerView.answerBtnIndexs sortedArrayUsingSelector:@selector(compare:)];
    _answerView.answerBtnIndexs=[NSMutableArray arrayWithArray:array];
}
//处理optionbtn的点击事件
-(void)optionBlock:(UIButton *)optionBtn{
    if (_answerView.answerBtnIndexs.count>0)
    {
    //1.隐藏当前点击的optionBtn
    optionBtn.hidden=YES;
    //2.把optionBtn的当前标题设置到answerView上对应的answerBtn（从左至右）
       //(1)获取需要填写的answerBtn的索引
    NSInteger answerBtnIndex=[_answerView.answerBtnIndexs.firstObject integerValue];
       //(2)从answerView.subviews中获取answerBtn
    UIButton *answerBtn=_answerView.subviews[answerBtnIndex];
       //(3)设置answerBtn的标题为当前optionBtn的标题
    [answerBtn setTitle:optionBtn.currentTitle forState:UIControlStateNormal];
//        [answerBtn setTintColor:[UIColor blackColor]];
        //从answerView.answerBtnIndexs中移除第一个索引
    [_answerView.answerBtnIndexs removeObjectAtIndex:0];
        //(4)设置optionBtn和answerBtn的tag一致，方便后期通过answerBtn获取optionBtn
        optionBtn.tag=answerBtn.tag=100+answerBtnIndex;
    }
    //3.判断答案填充完整，判断答案正确
    if (_answerView.answerBtnIndexs.count==0) {
        //获取answerView中所有answerBtn标题
        NSMutableString *mutableString=[NSMutableString string];
        [_answerView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj isKindOfClass:[UIButton class]]) {
                [mutableString appendString:((UIButton *)obj).currentTitle];
            }
        }];
        Model *model=self.questions[_currentIndex];
        if ([model.answer isEqualToString:mutableString])
        {
            //正确情况下
            //0>更改题目完成状态
            model.isFinish=YES;
            //1>更改答案的颜色为绿色
            [self changeColor:[UIColor greenColor]];
            //2>加金币（当前题目没提示过）
            if (!model.isHint)
            {
                [self changeCoin:1000];
            }
            //3>延迟跳转下一题
            [self performSelector:@selector(next) withObject:nil afterDelay:1];
            _nextBtn.enabled=NO;
        }
        else{
            //不正确
            //1>更改答案颜色为红色
            [self changeColor:[UIColor redColor]];
        }
    }
}
-(void)next
{
    _nextBtn.enabled=YES;
    //判断是否通关
    __block BOOL isPass=YES;
    [self.questions enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        Model *model=(Model *)obj;
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
                Model *model=(Model *)obj;
                model.isFinish=NO;
                model.isHint=NO;
                _currentIndex=0;
                [weakSelf upDateUI];
            }];
        }];
        UIAlertAction *action2=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alertController addAction:action];
        [alertController addAction:action2];
        [self presentViewController:alertController animated:YES completion:nil];
        return;
}
    _currentIndex++;
    [self upDateUI];
}
-(void)changeCoin:(NSInteger)num
{
    //提取金币
    NSString *currentTitle=_coinBtn.currentTitle;
    NSInteger coinnum=[currentTitle integerValue]+num;
    NSString *title=[@(coinnum) stringValue];
    [_coinBtn setTitle:title forState:UIControlStateNormal];
}
-(void)changeColor:(UIColor *)color
{
    [_answerView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[UIButton class]])
        {
            [((UIButton *)obj) setTitleColor:color forState:UIControlStateNormal];
        }
    }];
}
-(IBAction)BtnClick:(UIButton *)sender
{
    switch (sender.tag) {
        case 101://下一题
            [self next];
            break;
        case 102://大图
            [self datu];
            break;
        case 103://提示
            [self hint];
            break;
            
        default:
            break;
    }
}
-(void)datu
{
    UIButton *Btn=[UIButton buttonWithType:UIButtonTypeCustom];
    Btn.frame=self.view.frame;
    [self.view addSubview:Btn];
    [Btn setBackgroundColor:[UIColor redColor]];
    Btn.alpha=0;
    [self.view bringSubviewToFront:_imageView];
    [UIView animateWithDuration:0.5 animations:^{
        _imageView.transform=CGAffineTransformScale(_imageView.transform, 1.5, 1.5);
        Btn.alpha=0.5;
    }];
    [Btn addTarget:self action:@selector(huanyuan:) forControlEvents:UIControlEventTouchUpInside];
}
-(void)huanyuan:(UIButton *)sender
{
    [UIView animateWithDuration:1 animations:^{
        _imageView.transform=CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        [sender removeFromSuperview];
        sender.alpha=0;
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
