//
//  ResultTableViewController.h
//  01-团购
//
//  Created by qingyun on 16/5/20.
//  Copyright © 2016年 QingYun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ResultTableViewController : UITableViewController<UISearchResultsUpdating>
@property (nonatomic, strong) NSArray *willFilterArray;
@end
