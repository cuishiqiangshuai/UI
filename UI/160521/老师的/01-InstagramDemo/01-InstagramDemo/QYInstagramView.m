//
//  QYInstagramView.m
//  01-InstagramDemo
//
//  Created by qingyun on 16/5/21.
//  Copyright © 2016年 QingYun. All rights reserved.
//

#import "QYInstagramView.h"
#import "Masonry.h"
#define AvatarSize CGSizeMake(35.0, 35.0)

@implementation QYInstagramView

//代码方式初始化
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self createAndAddSubviews];
        [self setPropertyForSubviews];
    }
    return self;
}

//利用IB方式初始化
-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        [self createAndAddSubviews];
        [self setPropertyForSubviews];
    }
    return self;
}


//创建子视图并添加子视图
-(void)createAndAddSubviews{
    //创建子视图
    _avatarImageView = [[UIImageView alloc] init];
    _nicknameLabel = [[UILabel alloc] init];
    _timestampIndicator = [UIView new];
    _timestampLabel = [UILabel new];
    _contentImageView = [UIImageView new];
    _likeIndicator = [UIView new];
    _likesLabel = [UILabel new];
    _likeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _commentButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _moreButton = [UIButton buttonWithType:UIButtonTypeCustom];
    //添加子视图
    [self addSubview:_avatarImageView];
    [self addSubview:_nicknameLabel];
    [self addSubview:_timestampIndicator];
    [self addSubview:_timestampLabel];
    [self addSubview:_contentImageView];
    [self addSubview:_likeIndicator];
    [self addSubview:_likesLabel];
    [self addSubview:_likeButton];
    [self addSubview:_commentButton];
    [self addSubview:_moreButton];
}

-(void)setPropertyForSubviews{
    //头像
    _avatarImageView.backgroundColor = [UIColor redColor];
    _avatarImageView.layer.cornerRadius = AvatarSize.height / 2.0;
    _avatarImageView.layer.masksToBounds = YES;
    
    //昵称
    _nicknameLabel.text = @"Dorayo";
    _nicknameLabel.textColor = [UIColor blueColor];
    _nicknameLabel.font = [UIFont boldSystemFontOfSize:17.0];
    
    //时间标识
    _timestampIndicator.backgroundColor = [UIColor greenColor];
    
    //时间
    _timestampLabel.text = @"7小时";
    _timestampLabel.textColor = [UIColor lightGrayColor];
    _timestampLabel.font = _nicknameLabel.font;
    
    //内容视图
    _contentImageView.backgroundColor = [UIColor purpleColor];
    
    //赞标识
    _likeIndicator.backgroundColor = [UIColor orangeColor];
    
    //赞
    _likesLabel.text = @"12次赞";
    _likesLabel.textColor = [UIColor blueColor];
    _likesLabel.font = _nicknameLabel.font;
    
    //赞/评论/更多
    _likeButton.backgroundColor = [UIColor grayColor];
    _commentButton.backgroundColor = [UIColor cyanColor];
    _moreButton.backgroundColor = [UIColor magentaColor];
    
}


-(void)layoutSubviews{
    [super layoutSubviews];
    NSLog(@"%s-----frame:%@",__func__,NSStringFromCGRect(self.frame));
}

-(void)updateConstraints{
    //设置子视图的约束
    __weak UIView *superView = self;
    [_avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(10);
        make.top.equalTo(@20);
        make.size.mas_equalTo(AvatarSize);
    }];
    
    [_nicknameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_avatarImageView.mas_right).with.offset(10);
    }];
    
    [_timestampIndicator mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_timestampLabel.mas_left).with.offset(-10);
        make.size.mas_equalTo(CGSizeMake(10, 10));
    }];
    
    [_timestampLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(@(-10));
        make.centerY.equalTo(@[_avatarImageView,_nicknameLabel,_timestampIndicator]);
    }];
    
    [_contentImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_avatarImageView.mas_bottom).with.offset(10);
        make.leading.equalTo(@0);
        make.width.equalTo(superView.mas_width);
        make.height.equalTo(superView.mas_width);
    }];
    
    [_likeIndicator mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(_avatarImageView);
        make.top.equalTo(_contentImageView.mas_bottom).with.offset(10);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
    
    [_likesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_likeIndicator);
        make.left.equalTo(_likeIndicator.mas_right).with.offset(10);
    }];
    
    [_likeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(_likeIndicator);
        make.top.equalTo(_likeIndicator.mas_bottom).with.offset(20);
        make.size.mas_equalTo(CGSizeMake(50, 25));
    }];
    
    [_commentButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(_likeButton.mas_trailing).with.offset(5);
        make.size.mas_equalTo(CGSizeMake(60, 25));
    }];
    
    [_moreButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(-10);
        make.size.mas_equalTo(CGSizeMake(40, 25));
        make.centerY.equalTo(@[_likeButton,_commentButton]);
    }];
    
    [super updateConstraints];
    NSLog(@"%s-----frame:%@",__func__,NSStringFromCGRect(self.frame));
}


@end
