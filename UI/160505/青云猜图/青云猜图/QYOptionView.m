//
//  QYOptionView.m
//  青云猜图
//
//  Created by qingyun on 16/5/4.
//  Copyright © 2016年 QingYun. All rights reserved.
//

#import "QYOptionView.h"

@implementation QYOptionView

+ (instancetype) optionView {
    //从xib加载optionView
    NSArray *views = [[NSBundle mainBundle] loadNibNamed:@"QYOptionView" owner:self options:nil];
    return views[0];
}

//重写setBtnTitles方法,设置每一个optionBtn的标题，并且的添加事件监听
-(void)setBtnTitles:(NSArray *)btnTitles{
    _btnTitles = btnTitles;
    
#if 0
    for (id obj in self.subviews) {
        //类型检测(obj是UIButton类型)
        if ([obj isKindOfClass:[UIButton class]]) {
            UIButton *optionBtn = (UIButton *)obj;
            //取出当前optionBtn在self.subViews中的索引
            NSInteger index = [self.subviews indexOfObject:optionBtn];
            [optionBtn setTitle:btnTitles[index] forState:UIControlStateNormal];
            [optionBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
#else
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        //类型检测
        if ([obj isKindOfClass:[UIButton class]]) {
            UIButton *optionBtn = (UIButton *)obj;
            [optionBtn setTitle:btnTitles[idx] forState:UIControlStateNormal];
            [optionBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        }
    }];
#endif
}

//optionBtn的点击事件
-(void)btnClick:(UIButton *)sender{
    NSLog(@"%s",__func__);
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
