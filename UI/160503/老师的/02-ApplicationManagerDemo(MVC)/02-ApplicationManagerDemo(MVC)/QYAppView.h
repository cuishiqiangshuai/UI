//
//  QYAppView.h
//  02-ApplicationManagerDemo(MVC)
//
//  Created by qingyun on 16/5/3.
//  Copyright © 2016年 QingYun. All rights reserved.
//

#import <UIKit/UIKit.h>
@class QYAppModel;
@interface QYAppView : UIView

@property (nonatomic, strong) QYAppModel *model;

//声明初始化方法
+(instancetype)appView;

//对appView设置子视图属性（图片、文本、下载链接）
//-(void)setPropertyForSubViews:(QYAppModel *)model;
@end
