//
//  QYTitleCollectionView.h
//  01-QYNews
//
//  Created by qingyun on 16/5/23.
//  Copyright © 2016年 QingYun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QYTitleCollectionView : UICollectionView

@property (nonatomic, strong) NSArray *titles;

+(instancetype)titleCollectionViewWithTitles:(NSArray *)titles;
@end
