//
//  QYTitleScrollView.h
//  01-QYNews
//
//  Created by qingyun on 16/5/23.
//  Copyright © 2016年 QingYun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QYTitleScrollView : UIScrollView

@property (nonatomic) NSUInteger currentIndex;

@property (nonatomic, copy) void (^changeContentVC) (NSUInteger index);

+(instancetype) titleScrollViewWithTitles:(NSArray *)titles;
@end
