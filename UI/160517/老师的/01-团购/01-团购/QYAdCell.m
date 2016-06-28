//
//  QYAdCell.m
//  01-团购
//
//  Created by qingyun on 16/5/17.
//  Copyright © 2016年 QingYun. All rights reserved.
//

#import "QYAdCell.h"
#import "QYTGModel.h"
@interface QYAdCell ()
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UIImageView *iconView;

@end

@implementation QYAdCell

-(void)setAdModel:(QYTGModel *)adModel{
    _adModel = adModel;
    
    _label.text = adModel.title;
    _iconView.image = [UIImage imageNamed:adModel.icon];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
