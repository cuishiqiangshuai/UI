//
//  QYOptionView.h
//  青云猜图崔世强
//
//  Created by qingyun on 16/5/4.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QYOptionView : UIView
@property(nonatomic,strong)NSArray *btnTitles;
+(instancetype)optionView;
@property(nonatomic,strong)void (^optionBtnClick)(UIButton *optionBtn);
@end
