//
//  ViewController.m
//  03-AutoLayoutDemo
//
//  Created by qingyun on 16/5/20.
//  Copyright © 2016年 QingYun. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"
@interface ViewController ()
@property (nonatomic, strong) UIView *redView;
@property (nonatomic, strong) UIView *greenView;
@property (nonatomic, strong) UIView *blueView;
@end

@implementation ViewController

#pragma mark -创建views

-(UIView *)redView{
    if (_redView == nil) {
        _redView = [[UIView alloc] init];
        _redView.backgroundColor = [UIColor redColor];
        
        [_redView setTranslatesAutoresizingMaskIntoConstraints:NO];
    }
    return _redView;
}

-(UIView *)greenView{
    if (_greenView == nil) {
        _greenView = [[UIView alloc] init];
        _greenView.backgroundColor = [UIColor greenColor];
        
        [_greenView setTranslatesAutoresizingMaskIntoConstraints:NO];
    }
    return _greenView;
}

-(UIView *)blueView{
    if (_blueView == nil) {
        _blueView = [[UIView alloc] init];
        _blueView.backgroundColor = [UIColor blueColor];
        
        _blueView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _blueView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    //添加红/绿/蓝视图
    [self.view addSubview:self.redView];
    [self.view addSubview:self.greenView];
    [self.view addSubview:self.blueView];
    
    //利用AutoLayout布局
    //[self setupLayoutWithMethod1];
    //[self setupLayoutWithVFL];
    [self setupLayoutWithMasonry];
    
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)setupLayoutWithMethod1{
    NSLayoutConstraint *redLeft = [NSLayoutConstraint constraintWithItem:self.redView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1.0 constant:30.0];
    
    NSLayoutConstraint *redTop = [NSLayoutConstraint constraintWithItem:self.redView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:30.0];
    
    NSLayoutConstraint *redRight = [NSLayoutConstraint constraintWithItem:self.redView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.greenView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:-30.0];
    
    NSLayoutConstraint *redBottom = [NSLayoutConstraint constraintWithItem:self.redView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.blueView attribute:NSLayoutAttributeTop multiplier:1.0 constant:-30.0];
    
    NSLayoutConstraint *redWidth = [NSLayoutConstraint constraintWithItem:self.redView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.greenView attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0.0];
    
    NSLayoutConstraint *redHeight = [NSLayoutConstraint constraintWithItem:self.redView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.greenView attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0.0];
    
    NSLayoutConstraint *redHeight1 = [NSLayoutConstraint constraintWithItem:self.redView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.blueView attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0.0];
    
    NSLayoutConstraint *greenTop = [NSLayoutConstraint constraintWithItem:self.greenView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.redView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.0];
    
    NSLayoutConstraint *greenRight = [NSLayoutConstraint constraintWithItem:self.greenView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:-30.0];
    
    NSLayoutConstraint *blueLeft = [NSLayoutConstraint constraintWithItem:self.blueView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1.0 constant:30.0];
    
    NSLayoutConstraint *blueBottom = [NSLayoutConstraint constraintWithItem:self.blueView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-30.0];
    
    NSLayoutConstraint *blueRight = [NSLayoutConstraint constraintWithItem:self.blueView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:-30.0];
    //添加约束
    [self.view addConstraints:@[redLeft,redTop,redRight,redBottom,redWidth,redHeight,redHeight1,greenTop,greenRight,blueLeft,blueBottom,blueRight]];
    
}


-(void)setupLayoutWithVFL{
    NSDictionary *views = NSDictionaryOfVariableBindings(self.view,_redView,_greenView,_blueView);
    NSNumber *margin = @30;
    NSDictionary *metrics = NSDictionaryOfVariableBindings(margin);
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-margin-[_redView(_greenView)]-margin-[_greenView]-margin-|" options:NSLayoutFormatAlignAllTop|NSLayoutFormatAlignAllBottom metrics:metrics views:views]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-margin-[_redView(_blueView)]-margin-[_blueView]-margin-|" options:0 metrics:metrics views:views]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-margin-[_blueView]-margin-|" options:0 metrics:metrics views:views]];
}

-(void)setupLayoutWithMasonry{
    UIView *superView = self.view;
    //_redView
    [_redView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(superView.mas_top).with.offset(30.0);
        make.leading.equalTo(@30.0);
        make.trailing.equalTo(_greenView.mas_leading).with.offset(-30.0);
        make.bottom.equalTo(_blueView.mas_top).with.offset(-30.0);
    }];
    
    //_greenView
    [_greenView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(-30.0);
        make.centerY.equalTo(_redView);
        make.size.equalTo(_redView);
    }];
    
    //_blueView
    [_blueView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.and.bottom.mas_equalTo(-30.0);
        make.leading.mas_equalTo(30.0);
        make.height.equalTo(_redView);
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
