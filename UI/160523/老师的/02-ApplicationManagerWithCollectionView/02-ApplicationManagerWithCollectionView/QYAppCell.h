//
//  QYAppCell.h
//  02-ApplicationManagerWithCollectionView
//
//  Created by qingyun on 16/5/23.
//  Copyright © 2016年 QingYun. All rights reserved.
//

#import <UIKit/UIKit.h>
@class QYAppModel;
@interface QYAppCell : UICollectionViewCell
@property (nonatomic, strong) QYAppModel *appModel;
@end
