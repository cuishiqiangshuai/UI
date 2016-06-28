//
//  QYOptionView.m
//  青云猜图崔世强
//
//  Created by qingyun on 16/5/4.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "QYOptionView.h"
#import "Common.h"

@implementation QYOptionView

+(instancetype)optionView
{
    NSArray *views=[[NSBundle mainBundle] loadNibNamed:@"QYOptionView" owner:self options:nil];
//    //总列数
//    int totalColumn=7;
//    //button的宽和高
//    CGFloat BtnWidth=40;
//    CGFloat BtnHight=40;
//    //两个相邻的Btn的间距
//    CGFloat spaceX=12;
//    CGFloat spaceY=10;
//    for (int i=0; i<21; i++)
//    {
//        //确定当前Btn所在的行和列
//        int column=i%totalColumn;
//        int row=i/totalColumn;
//        //计算Btn的位置
//        CGFloat BtnX=spaceX*(column+1)+BtnWidth*column;
//        CGFloat BtnY=spaceY*(row+1)+BtnHight*row;
//        //创建Btn并添加
//        UIButton *Btn=[UIButton buttonWithType:UIButtonTypeCustom];
//        [views arrayByAddingObject:Btn];
//        Btn.frame=CGRectMake(BtnX, 447+BtnY, BtnWidth, BtnHight);
//        [Btn setBackgroundImage:[UIImage imageNamed:@"btn_option"] forState:UIControlStateNormal];
//        [Btn setBackgroundImage:[UIImage imageNamed:@"btn_option_highlighted"] forState:UIControlStateHighlighted];
    return views[0];
}
-(void)setBtnTitles:(NSArray *)btnTitles
{
    _btnTitles=btnTitles;
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[UIButton class]])
        {
            UIButton *optionBtn=(UIButton *)obj;
            [optionBtn setTitle:btnTitles[idx] forState:UIControlStateNormal];
            [optionBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [optionBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        }
    }];
}
-(void)btnClick:(UIButton *)sender
{
    if (_optionBtnClick) {
        _optionBtnClick(sender);
    }
}
//重写setFrame方法，重置answerView的位置，不更改大小
- (void)setFrame:(CGRect)frame{
    //1、获取初始化的时候answerView的frame
    CGRect originFrame = self.frame;
    //2、拿重置frame的位置来改变初始化的时候answerView的frame
    originFrame.origin = frame.origin;
    //3、把最终的frame设置到answerView上
    //下面这行代码，导致无线递归，在setFrame方法中调用setFrame
    //self.frame = originFrame;
    //下面这行代码，是对frame属性的直接赋值
    [super setFrame:originFrame];
}
@end
