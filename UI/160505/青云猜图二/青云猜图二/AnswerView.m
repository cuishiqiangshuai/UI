//
//  AnswerView.m
//  青云猜图二
//
//  Created by qingyun on 16/5/7.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "AnswerView.h"
#import "Common.h"

@implementation AnswerView

+(instancetype)answerViewWithAnswerCount:(NSInteger)count
{
    AnswerView *answerView=[[AnswerView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 40)];
    //添加Btn(根据答案的个数count)
    //Btn的间距
    CGFloat answerBtnSpaceX=10;
    //Btn的宽和高
    CGFloat answerBtnW=40;
    CGFloat answerBtnH=40;
    //计算左边第一个answerBtn的X位置
    CGFloat baseX=(ScreenW-answerBtnW*count-answerBtnSpaceX*(count-1))/2.0;
    //用for循环遍历count，在里面设置Btn的各种属性，也就把所有Btn全部设置了
    for (int i=0; i<count; i++)
    {
        //计算answerBtn的位置
        CGFloat answerBtnX=baseX+(answerBtnSpaceX+answerBtnW)*i;
        CGFloat answerBtnY=0;//
        UIButton *answerBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [answerView addSubview:answerBtn];
        answerBtn.frame=CGRectMake(answerBtnX, answerBtnY, answerBtnW, answerBtnH);
        //设置背景图片
        [answerBtn setBackgroundImage:[UIImage imageNamed:@"btn_answer"] forState:UIControlStateNormal];
        [answerBtn setBackgroundImage:[UIImage imageNamed:@"btn_answer_highlighted"] forState:UIControlStateHighlighted];
        //设置标题颜色
        [answerBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        //添加时间监听
        [answerBtn addTarget:answerView action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];//注意target是方法的调用者，这个要调用的方法是实例方法，因为所在的方法是类方法所以self的话指的是当前的类，所以不能用self，要用当前类的对象answerView
    }
    return answerView;
    
}
-(void)btnClick:(UIButton *)sender
{
    if (_answerblock) {
        _answerblock(sender);
    }
}
-(NSMutableArray *)answerBtnIndexs
{
    if (_answerBtnIndexs==nil)
    {
        //初始化——answerBtnIndexs
        _answerBtnIndexs=[NSMutableArray array];
        //遍历self的子视图，然后把子视图对应的索引添加到_answerBtnIndexs
        [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [_answerBtnIndexs addObject:@(idx)];
        }];
    }
    return _answerBtnIndexs;
}
@end
