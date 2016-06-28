//
//  QYPhotoWall.m
//  04-PhotoWallDemo
//
//  Created by qingyun on 16/5/21.
//  Copyright © 2016年 QingYun. All rights reserved.
//

#import "QYPhotoWall.h"
#import "QYImageTile.h"
#import "Masonry.h"
#import "Common.h"
@implementation QYPhotoWall

+(instancetype)photoWall{
    QYPhotoWall *photoWall = [[QYPhotoWall alloc] init];
    [photoWall addSubImageTile];
    return photoWall;
}

//添加瓦片
-(void)addSubImageTile{
    for (int i = 1; i < 7; i++) {
        QYImageTile *imageTile = [[QYImageTile alloc] init];
        [self addSubview:imageTile];
        
        imageTile.tag = imageTile.tileIndex = 100 + i;
        NSString *tileName = [NSString stringWithFormat:@"cat%d.jpg",i];
        imageTile.image = [UIImage imageNamed:tileName]