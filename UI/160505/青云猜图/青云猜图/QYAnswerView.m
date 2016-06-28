//
//  QYAnswerView.m
//  青云猜图
//
//  Created by qingyun on 16/5/4.
//  Copyright © 2016年 QingYun. All rights reserved.
//

#import "QYAnswerView.h"
#import "Common.h"
@implementation QYAnswerView

+(instancetype)answerViewWithAnswerCount:(NSInteger)count{
    
    QYAnswerView *answerView = [[self alloc] initWithFrame:CGRectMake(0, 0, QYScreenW, 40)];
    //根据count添加answerBtn
    
    //answerBtn的间距10
    CGFloat answerBtnSpaceX = 10;
    //answerBtn的宽高
    CGFloat answerBtnW = 40;
    CGFloat answerBtnH = 40;
    
    //计算左边第一个answerBtn的X位置
    CGFloat baseX = (QYScreenW - answerBtnW * count - answerBtnSpaceX * (count - 1)) / 2.0;
    
    for (int  i = 0; i < count; i++) {
        //计算answerBtn的位置
        CGFloat answerBtnX = baseX + (answerBtnW + answerBtnSpaceX) * i;
        CGFloat answerBtnY = 0;
        
        UIButton *answerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [answerView addSubview:answerBtn];
        answerBtn.frame = CGRectMake(answerBtnX, answerBtnY, answerBtnW, answerBtnH);
        //设置背景图片
        [answerBtn setBackgroundImage:[UIImage imageNamed:@"btn_answer"] forState:UIControlStateNormal];
        [answerBtn setBackgroundImage:[UIImage imageNamed:@"btn_answer_highlighted"] forState:UIControlStateHighlighted];
        
        //设置标题颜色
        [answerBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        //添加事件监听
        //注意target能直接调用action，（btnClick:是实例方法，所以target应该是当前类的实例）
        [answerBtn addTarget:answerView action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return answerView;
}


-(void)btnClick:(UIButton *)sender{
    NSLog(@"%s",__func__);
    if (_answerBtnClick) {
        _answerBtnClick(sender);
    }
}


- (NSMutableArray *)answerBtnIndexs{
    if (_answerBtnIndexs == nil) {
        //初始化_answerBtnIndexs
        _answerBtnIndexs = [NSMutableArray array];
        //遍历self的子视图，然后把子视图对应的索引添加到_answerBtnIndexs
        [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [_answerBtnIndexs addObject:@(idx)];
        }];
    }
    return _answerBtnIndexs;
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
