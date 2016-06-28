//
//  QYTableViewCell.m
//  02-CustomCell(LayoutSubviews)
//
//  Created by qingyun on 16/5/16.
//  Copyright © 2016年 QingYun. All rights reserved.
//

#import "QYTableViewCell.h"
#import "QYModel.h"
@interface QYTableViewCell ()
@property (nonatomic, strong) UISwitch *mySwitch;
@end

@implementation QYTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    NSLog(@"%ld",style);
    if (self = [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier]) {
        //添加子视图(UISwitch)
        _mySwitch = [[UISwitch alloc] init];
        [self.contentView addSubview:_mySwitch];
    }
    return self;
}

//布局子视图
-(void)layoutSubviews{
    [super layoutSubviews];
    
    self.textLabel.frame = CGRectMake(10, 10, 200, 40);
    self.detailTextLabel.frame = CGRectMake(10, 50, 200, 40);
    self.imageView.frame = CGRectMake(CGRectGetWidth([UIScreen mainScreen].bounds) - 100, 10, 80, 80);
    self.mySwitch.frame = CGRectMake(210, (100 - 31) / 2.0, 0, 0);
}

-(void)setModel:(QYModel *)model{
    _model = model;
    
    self.textLabel.text = model.name;
    self.detailTextLabel.text = model.desc;
    self.imageView.image = [UIImage imageNamed:model.icon];
    self.mySwitch.on = model.ison;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
