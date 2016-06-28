//
//  QYSqliteTool.h
//  02-对象持久化技术
//
//  Created by qingyun on 16/6/16.
//  Copyright © 2016年 QingYun. All rights reserved.
//

#import <Foundation/Foundation.h>
@class QYStudent;
@interface QYSqliteTool : NSObject
//单例
+(instancetype)shareHandel;

//1.插入数据
-(BOOL)insertIntoStudent:(QYStudent *)mode;

//2.查询所有的数据
-(NSMutableArray *)selectAll;


@end
