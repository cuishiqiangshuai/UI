//
//  QYTGCell.m
//  01-团购
//
//  Created by qingyun on 16/5/17.
//  Copyright © 2016年 QingYun. All rights reserved.
//

#import "QYTGCell.h"
#import "QYTGModel.h"
@interface QYTGCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UILabel *buyCount;

@end

@implementation QYTGCell

-(void)setTgModel:(QYTGModel *)tgModel{
    _tgModel = tgModel;
    
    _iconView.image = [UIImage imageNamed:tgModel.icon];
    _title.text = tgModel.title;
    _price.text = tgModel.price;
    _buyCount.text = tgModel.buycount;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
