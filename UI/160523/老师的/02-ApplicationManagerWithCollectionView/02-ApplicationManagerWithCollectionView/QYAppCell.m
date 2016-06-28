//
//  QYAppCell.m
//  02-ApplicationManagerWithCollectionView
//
//  Created by qingyun on 16/5/23.
//  Copyright © 2016年 QingYun. All rights reserved.
//

#import "QYAppCell.h"
#import "QYAppModel.h"
@interface QYAppCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation QYAppCell

- (void)awakeFromNib {
    // Initialization code
}

-(void)setAppModel:(QYAppModel *)appModel{
    _appModel = appModel;
    
    _imageView.image = [UIImage imageNamed:appModel.icon];
    _titleLabel.text = appModel.name;
}

- (IBAction)btnClick:(UIButton *)sender {
    
    NSURL *url = [NSURL URLWithString:self.appModel.link];
    
    [[UIApplication sharedApplication] openURL:url];
}

@end
