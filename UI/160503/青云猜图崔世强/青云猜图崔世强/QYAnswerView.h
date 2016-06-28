//
//  QYAnswerView.h
//  青云猜图崔世强
//
//  Created by qingyun on 16/5/4.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QYAnswerView : UIView
+(instancetype)answerViewWithAnswerCount:(NSInteger) count;
@property(nonatomic,strong)void (^answerBtnClick)(UIButton *answerBtn);
@property(nonatomic,strong)NSMutableArray *answerBtnIndexs;//界面上需要填充的answerBtn在answerView的subViews中对应的索引
@end
