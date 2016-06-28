//
//  QYAnswerView.h
//  青云猜图
//
//  Created by qingyun on 16/5/4.
//  Copyright © 2016年 QingYun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QYAnswerView : UIView

@property (nonatomic, strong) void (^answerBtnClick) (UIButton *btn);

@property (nonatomic, strong) NSMutableArray *answerBtnIndexs;      //界面上需要填充的answerBtn在answerView的subViews中对应的索引

//声明初始化方法（参数：子视图的个数）
+(instancetype)answerViewWithAnswerCount:(NSInteger)count;
@end
