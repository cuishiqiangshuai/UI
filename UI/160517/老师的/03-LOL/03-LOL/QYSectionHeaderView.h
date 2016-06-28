//
//  QYSectionHeaderView.h
//  03-LOL
//
//  Created by qingyun on 16/5/17.
//  Copyright © 2016年 QingYun. All rights reserved.
//

#import <UIKit/UIKit.h>
@class QYHeroGroup;
@interface QYSectionHeaderView : UITableViewHeaderFooterView
@property (nonatomic, strong) QYHeroGroup *sectionModel;
@property (nonatomic, strong) void (^headerViewClick)();
+(instancetype)sectionHeaderView:(UITableView *)tableView;
@end
