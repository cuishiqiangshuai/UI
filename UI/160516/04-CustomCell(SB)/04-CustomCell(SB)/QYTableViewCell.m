//
//  QYTableViewCell.m
//  04-CustomCell(SB)
//
//  Created by qingyun on 16/5/16.
//  Copyright © 2016年 QingYun. All rights reserved.
//

#import "QYTableViewCell.h"
#import "QYModel.h"
@interface QYTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailTitleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UISwitch *mySwitch;

@end

@implementation QYTableViewCell

-(void)setModel:(QYModel *)model{
    //对属性对应的成员变量赋值
    _model = model;
    
    //设置子视图属性
    _titleLabel.text = model.name;
    _detailTitleLabel.text = model.desc;
    _iconView.image = [UIImage imageNamed:model.icon];
    _mySwitch.on = model.ison;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
