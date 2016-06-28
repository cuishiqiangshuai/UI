//
//  QYView.m
//  02-触摸demo2
//
//  Created by qingyun on 16/5/31.
//  Copyright © 2016年 QingYun. All rights reserved.
//

#import "QYView.h"

@implementation QYView
//-(void)clickMe{
//    NSLog(@"=====%s",__func__);
//}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"===%s",__func__);
    //画一个圆
    //事件传递下个响应者
    [self.nextResponder touchesBegan:touches withEvent:event];
    
    //多点触摸
    NSLog(@"=====%@",[touches allObjects]);
    
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
