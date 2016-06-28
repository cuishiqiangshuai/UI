//
//  QYSectionHeaderView.m
//  03-LOL
//
//  Created by qingyun on 16/5/17.
//  Copyright © 2016年 QingYun. All rights reserved.
//

#import "QYSectionHeaderView.h"
#import "QYHeroGroup.h"
@interface QYSectionHeaderView ()
@property (nonatomic, strong) UIButton *bgBtn;
@property (nonatomic, strong) UILabel *onLineLabel;
@end

@implementation QYSectionHeaderView
static NSString *headerIdentifier = @"headerSection";

+(instancetype)sectionHeaderView:(UITableView *)tableView{
    QYSectionHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerIdentifier];
    if (headerView == nil) {
        headerView = [[QYSectionHeaderView alloc] initWithReuseIdentifier:headerIdentifier];
    }
    return headerView;
}


-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        //添加bgBtn
        UIButton *bgBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:bgBtn];
        
        //设置背景
        UIImage *image = [[UIImage imageNamed:@"buddy_header_bg"] resizableImageWithCapInsets:UIEdgeInsetsMake(44, 0, 44, 1) resizingMode:UIImageResizingModeStretch];
        UIImage *highLightedImage = [[UIImage imageNamed:@"buddy_header_bg_highlighted"] resizableImageWithCapInsets:UIEdgeInsetsMake(44, 0, 44, 1) resizingMode:UIImageResizingModeStretch];
        [bgBtn setBackgroundImage:image forState:UIControlStateNormal];
        [bgBtn setBackgroundImage:highLightedImage forState:UIControlStateHighlighted];
        //字体颜色
        [bgBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        //设置图片
        UIImage *arrowImage = [UIImage imageNamed:@"buddy_header_arrow"];
        [bgBtn setImage:arrowImage forState:UIControlStateNormal];
        
        //添加事件监听
        [bgBtn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
        
        
        //设置bgBtn的内容模式
        bgBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        //设置内容的偏移
        bgBtn.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        //设置标题的偏移
        bgBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        
        bgBtn.imageView.contentMode = UIViewContentModeCenter;
        bgBtn.imageView.clipsToBounds = NO;
        
        //添加Label
        UILabel *label = [[UILabel alloc] init];
        [self.contentView addSubview:label];
        
        //设置label的对齐方式
        label.textAlignment = NSTextAlignmentRight;
        
        _bgBtn = bgBtn;
        _onLineLabel = label;
        
    }
    return self;
}

//重新布局子视图
-(void)layoutSubviews{
    [super layoutSubviews];
    //设置子视图的frame
    _bgBtn.frame = self.bounds;
    
    _onLineLabel.frame = CGRectMake(CGRectGetWidth(self.bounds) - 100 - 10, 0, 100, CGRectGetHeight(self.bounds));
}

-(void)btnClick{
    //更改sectionModel的isOpen状态
    _sectionModel.isOpen = !_sectionModel.isOpen;
    
    if (_headerViewClick) {
        _headerViewClick();
    }
    
    
    
}

//设置bgBtn的标题,label的wenb
-(void)setSectionModel:(QYHeroGroup *)sectionModel{
    _sectionModel = sectionModel;
    
    [_bgBtn setTitle:sectionModel.name forState:UIControlStateNormal];
    _onLineLabel.text = [NSString stringWithFormat:@"%ld/%ld",sectionModel.online,sectionModel.friends.count];
    
    if (_sectionModel.isOpen) {
        _bgBtn.imageView.transform = CGAffineTransformMakeRotation(M_PI_2);
    }else{
        _bgBtn.imageView.transform = CGAffineTransformIdentity;
    }
}
@end
