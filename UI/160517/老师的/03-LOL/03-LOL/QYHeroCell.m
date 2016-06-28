//
//  QYHeroCell.m
//  03-LOL
//
//  Created by qingyun on 16/5/17.
//  Copyright © 2016年 QingYun. All rights reserved.
//

#import "QYHeroCell.h"
#import "QYHero.h"
@implementation QYHeroCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier]) {
        
    }
    return self;
}

-(void)setHeroModel:(QYHero *)heroModel{
    //对属性的成员变量赋值
    _heroModel = heroModel;
    
    //设置头像/昵称/描述信息
    self.imageView.image = [UIImage imageNamed:heroModel.icon];
    self.textLabel.text = heroModel.name;
    self.detailTextLabel.text = heroModel.intro;
    self.textLabel.textColor = heroModel.vip ? [UIColor redColor] : [UIColor blackColor];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
