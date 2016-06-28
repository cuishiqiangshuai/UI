//
//  QYViewE.m
//  01-触摸demo
//
//  Created by qingyun on 16/5/31.
//  Copyright © 2016年 QingYun. All rights reserved.
//

#import "QYViewE.h"

@implementation QYViewE

//单击操作
-(void)singleTap{
    NSLog(@"单击了");
}
//双击操作
-(void)doubleTap{
    NSLog(@"=====双击");
}

//响应方法 触摸开始的时候调用
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //NSLog(@"=======%s",__func__);
    //获取任意一个touch对象
     UITouch *touch=[touches anyObject];
     CGPoint point=[touch locationInView:self];
     NSLog(@"========%@",NSStringFromCGPoint(point));
    //点击次数
    NSLog(@"=======%f",touch.timestamp);
    if(touch.tapCount==1){
        //[self singleTap];
        //延迟.5s执行单击操作
        [self performSelector:@selector(singleTap) withObject:nil afterDelay:.3];
    }else if (touch.tapCount==2){
        //取消单击操作
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(singleTap) object:nil];
        [self doubleTap];
    }
}


//移动时候调用
-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
   // NSLog(@"=======%s",__func__);

}
//结束时候调用
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
   // NSLog(@"=======%s",__func__);

}

-(void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"======取消");
}




@end
