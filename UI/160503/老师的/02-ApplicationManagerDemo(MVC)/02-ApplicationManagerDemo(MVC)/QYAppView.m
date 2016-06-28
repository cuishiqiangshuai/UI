//
//  QYAppView.m
//  02-ApplicationManagerDemo(MVC)
//
//  Created by qingyun on 16/5/3.
//  Copyright © 2016年 QingYun. All rights reserved.
//

#import "QYAppView.h"
#import "QYAppModel.h"
#import "QYButton.h"
@interface QYAppView ()
@property (strong, nonatomic) IBOutlet UIImageView *iconView;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet QYButton *downLoadBtn;

@end

@implementation QYAppView

+(instancetype)appView{
    NSArray *views = [[NSBundle mainBundle] loadNibNamed:@"QYAppView" owner:self options:nil];
    return views[0];
}
//下载
- (IBAction)downLoad:(QYButton *)sender {
#if 0
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:sender.linkString]];
#else
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.model.link]];
#endif
}
#if 0
//对appView设置子视图属性（图片、文本、下载链接）
-(void)setPropertyForSubViews:(QYAppModel *)model{
    //设置图片
    _iconView.image = [UIImage imageNamed:model.icon];
    //设置标题
    _titleLabel.text = model.name;
    //设置链接地址
    _downLoadBtn.linkString = model.link;
}
#else
-(void)setModel:(QYAppModel *)model{
    //setter方法本身完成的事情（注意，一定不要忘记赋值）
    _model = model;
    //借助setter方法来对appView设置子视图属性（图片、文本）
    //设置图片
    _iconView.image = [UIImage imageNamed:model.icon];
    //设置标题
    _titleLabel.text = model.name;
    
}
#endif
@end
