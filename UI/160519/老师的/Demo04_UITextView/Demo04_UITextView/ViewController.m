//
//  ViewController.m
//  Demo04_UITextView
//
//  Created by qingyun on 16/5/19.
//  Copyright © 2016年 QingYun. All rights reserved.
//

/** QLDEBUG Print | M:method, L:line, C:content*/
#ifndef QLLog
#ifdef DEBUG
#define QLLog(FORMAT, ...) fprintf(stderr,"M:%s|L:%d|C->%s\n", __FUNCTION__, __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String])
#else
#define QLLog(FORMAT, ...)
#endif
#endif

/** QLScreenSize */
#define QLScreenSize [[UIScreen mainScreen] bounds].size
#define QLScreenWidth QLScreenSize.width
#define QLScreenHeight QLScreenSize.height

#import "ViewController.h"

@interface ViewController () <UITextViewDelegate>
{
    CGRect _rectTextView;
}

@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    NSLog(@"%@", NSStringFromCGRect(self.textView.frame));
    
    // 设置TextView的文字, 一般情况下多用于获取TextView的内容
    self.textView.text = @"你们好牛逼你们好牛逼你们好牛逼你们好牛逼你们好牛逼你们好牛逼你们好牛逼你们好牛逼你们好牛逼你们好牛逼你们好牛逼你们好牛逼你们好牛逼你们好牛逼你们好牛逼你们好牛逼你们好牛逼你们好牛逼你们好牛逼你们好牛逼你们好牛逼你们好牛逼你们好牛逼你们好牛逼你们好牛逼";
    
    // 设置TextView的字体
    NSLog(@"%@", [UIFont familyNames]);
    //UIFont *font = [UIFont fontWithName:@"Times New Roman" size:30];
    UIFont *font = [UIFont systemFontOfSize:80];
    self.textView.font = font;
    
    self.textView.tintColor = [UIColor purpleColor];
    
    // 设置文字的颜色
    self.textView.textColor = [UIColor whiteColor];
    
    // 设置文字的对齐方式
    self.textView.textAlignment = NSTextAlignmentRight;
    
    // ScrollView中的各种属性
    self.textView.contentOffset = CGPointMake(0, 20);
    
    // inputView可以用来做自定义键盘
    //UIView *view = [UIView new];
    //view.backgroundColor = [UIColor yellowColor];
    //view.frame = CGRectMake(0, 0, QLScreenWidth, 200);
    //self.textView.inputView = view;
    
    // inputAccessoryView 工具栏View
    UIView *viewAccessory = [UIView new];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeContactAdd];
    [button addTarget:self action:@selector(endEdit) forControlEvents:UIControlEventTouchUpInside];
    [viewAccessory addSubview:button];
    
    viewAccessory.backgroundColor = [UIColor purpleColor];
    viewAccessory.frame = CGRectMake(0, 0, QLScreenWidth, 44);
    self.textView.inputAccessoryView = viewAccessory;
    
    self.textView.delegate = self;
    
    // 监听键盘的弹出
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    // 监听键盘的收回
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
}

- (void)keyBoardWillShow:(NSNotification *)notification {
    NSLog(@"%@", notification);
    
    CGRect rectKeyBoard = [notification.userInfo[UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    QLLog(@"%@", NSStringFromCGRect(rectKeyBoard));
    CGRect rectTextView = self.textView.frame;
    _rectTextView = rectTextView;
    rectTextView.size.height = QLScreenHeight - rectKeyBoard.size.height;
    self.textView.frame = rectTextView;
}
- (void)keyBoardWillHide:(NSNotification *)notification {
    NSLog(@"%@", notification);
    self.textView.frame = _rectTextView;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"%@", NSStringFromRange(self.textView.selectedRange));
    [self.view endEditing:YES];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.textView.frame = [[UIScreen mainScreen] bounds];
}

- (void)endEdit {
    [self.view endEditing:YES];
}

#pragma mark - UITextViewDelegate
/*!
 * 是否应该响应用户点击URL链接的操作
 */
- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange {
    return YES;
}

/*!
 * 是否应该改变NSRange范围内的文字text
 */
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    return YES;
}

/*!
 * 是否应该响应Attachment对象的点击操作
 */
- (BOOL)textView:(UITextView *)textView shouldInteractWithTextAttachment:(NSTextAttachment *)textAttachment inRange:(NSRange)characterRange {
    return YES;
}

/*!
 * 开始编辑的时候调用
 */
- (void)textViewDidBeginEditing:(UITextView *)textView {
    
}

/*!
 * 文字发生变化的时候调用
 */
- (void)textViewDidChange:(UITextView *)textView {
    
}

/*!
 * 当用户选中的范围发生变化的时候调用
 */
- (void)textViewDidChangeSelection:(UITextView *)textView {
    NSLog(@"%@", NSStringFromRange(textView.selectedRange));
}

/*!
 * 结束编辑的时候调用
 */
- (void)textViewDidEndEditing:(UITextView *)textView {
    
}

/*!
 * 是否允许开始编辑
 */
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    return YES;
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView {
    return YES;
}

@end
