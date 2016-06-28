//
//  QYTableViewCell.h
//  04-CustomCell(SB)
//
//  Created by qingyun on 16/5/16.
//  Copyright © 2016年 QingYun. All rights reserved.
//

#import <UIKit/UIKit.h>
@class QYModel;
@interface QYTableViewCell : UITableViewCell
@property (nonatomic, strong) QYModel *model;
@end
