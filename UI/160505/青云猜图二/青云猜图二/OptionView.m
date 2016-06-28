//
//  OptionView.m
//  青云猜图二
//
//  Created by qingyun on 16/5/7.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "OptionView.h"
#import "Common.h"
#import "Model.h"

@implementation OptionView

-(instancetype)initOptionViewWithModel:(Model *)model
{
    OptionView *optionView=[[OptionView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 150)];
    //设置列数
    NSInteger column=7;
    //设置Btn的宽和高
    CGFloat optionBtnW=40;
    CGFloat optionBtnH=40;
    //设置间距
    CGFloat SpaceX=(ScreenW-optionBtnW*column)/(column+1);
    CGFloat SpaceY=10;
    for (int i=0; i<model.options.count; i++)
    {
        //计算当前所在行列
        NSInteger row=i/column;//行
        NSInteger col=i%column;//列
        //计算optionBtn的X和Y
        CGFloat optionBtnX=SpaceX*(col+1)+(col*optionBtnW);
        CGFloat optionBtnY=SpaceY*(row+1)+(row*optionBtnH);
        //创建Btn并添加
        UIButton *optionBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [optionView addSubview:optionBtn];
        optionBtn.frame=CGRectMake(optionBtnX, optionBtnY, optionBtnW, optionBtnH);
        [optionBtn setBackgroundImage:[UIImage imageNamed:@"btn_option"] forState:UIControlStateNormal];
        [optionBtn setBackgroundImage:[UIImage imageNamed:@"btn_option_highlighted"] forState:UIControlStateHighlighted];
        [optionBtn setTitle:model.options[i] forState:UIControlStateNormal];
        [optionBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        //添加监听事件
        [optionBtn addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return optionView;
    
}
-(void)BtnClick:(UIButton *)sender
{
    //当点击optionView中的Btn时，控制器需要把Btn的信息传给answerView的btn，所以需要通过block块来进行传值（首先在.h文件中定义一个block）这个block是在点击optionBtn是使用
    //先要赋值给block块（只能在控制器里面赋值）
    if (_optionblock) {
        _optionblock(sender);
    }
    
}
+(instancetype)OptionViewWithModel:(Model *)model
{
    return [[self alloc] initOptionViewWithModel:model];
}
@end
