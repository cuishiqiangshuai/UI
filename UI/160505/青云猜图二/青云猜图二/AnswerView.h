//
//  AnswerView.h
//  青云猜图二
//
//  Created by qingyun on 16/5/7.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AnswerView : UIView
@property(nonatomic,strong)NSMutableArray *answerBtnIndexs;
@property(nonatomic,copy)void(^answerblock)(UIButton *answerBtn);
+(instancetype)answerViewWithAnswerCount:(NSInteger)count;
@end
