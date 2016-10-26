//
//  TextFieldView.m
//  ReviewTextField
//
//  Created by youme on 16/1/13.
//  Copyright © 2016年 youme. All rights reserved.
//

#import "TextFieldView.h"

@interface TextFieldView ()<UITextViewDelegate,UITextFieldDelegate>
{
    UITextField *_textfield;
    UIView *_view; // 背景图
    UITextView *_textView;
    UIView *_clearBgView;
}
@property (nonatomic, strong) UIToolbar *toolBar;

@end

@implementation TextFieldView

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        // 让 键盘 变成 第一响应者
        [self createTextField];
        
        // 监听键盘 让 _textView 变成第一响应者
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrameNotification:) name:UIKeyboardWillChangeFrameNotification object:nil];
    }
    return self;
}
#pragma mark 让 键盘 变成 第一响应者
- (void)createTextField
{
    _textfield = [[UITextField alloc]init];
    [_textfield becomeFirstResponder];
    _textfield.delegate = self;
    _textfield.inputAccessoryView = self.toolBar;
    [self addSubview:_textfield];
}
#pragma mark 键盘 上的 toolBar
- (UIToolbar *)toolBar
{
    if (_toolBar == nil)
    {
        // 创建 toolBar
        _toolBar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 40)];
        // 白色 view 添加在 toolbar 上
        [self createWhiteBg];
        // 透明背景
        [self createClearBackground];
        // 添加 控件
        [self addSubviews];
    }
    return _toolBar;
}
#pragma mark 白色 背景 添加在 tooBar 上
- (void)createWhiteBg
{
    // 在 view 上 添加  控件
    _view =[[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, self.toolBar.frame.size.height)];
    [_toolBar addSubview:_view];
}
#pragma mark 创建 透明背景view
- (void)createClearBackground
{
    _clearBgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick:)];
    _clearBgView.userInteractionEnabled = YES;
    [_clearBgView addGestureRecognizer:tap];
    //  把 背景添加到 windou 上
    [[UIApplication sharedApplication].keyWindow addSubview:_clearBgView];
}

- (void)tapClick:(UIGestureRecognizer *)sender
{
    // 透明背景消失
    _clearBgView.hidden = YES;
    // 收起键盘
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
    // 失去所有第一响应者
    [self allResignFirstResponder];
}
#pragma mark 添加 控件
- (void)addSubviews
{
    _textView = [[UITextView alloc]initWithFrame:CGRectMake(10, 5, [UIScreen mainScreen].bounds.size.width-20, 30)];
    _textView.layer.cornerRadius = 3.0f;
    _textView.clipsToBounds = YES;
    _textView.delegate = self;
    [_view addSubview:_textView];
    
    // 发送 按钮
    [self sendButton];
}
#pragma mark 发送 按钮
- (void)sendButton
{
    UIButton *sendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    float btnX = [UIScreen mainScreen].bounds.size.width-80;
    sendBtn.frame = CGRectMake(btnX, 8, 70, 25);
//    sendBtn.backgroundColor = [UIColor colorWithRed:0.301 green:0.842 blue:0.868 alpha:1.000];
    sendBtn.backgroundColor = [NSString colorWithHexString:heitizi];
    sendBtn.layer.cornerRadius = 3.0f;
    sendBtn.clipsToBounds = YES;
    sendBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [sendBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [sendBtn setTitle:@"发表评论" forState:UIControlStateNormal];
    [sendBtn addTarget:self action:@selector(sendBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_view addSubview:sendBtn];
}
#pragma mark 发送 按钮 点击事件
- (void)sendBtnClick:(UIButton *)sender
{
    // 代理传值
    [self.delegate sendReviewValue:_textView.text];
    _clearBgView.hidden = YES;
    [self allResignFirstResponder];
   
}

#pragma mark 键盘 收回
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    _clearBgView.hidden = YES;
    [self endEditing:YES];
    return  YES;
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"])
    {
        _clearBgView.hidden = YES;
        [self allResignFirstResponder];
        return NO;
    }
    return YES;
}

- (void)allResignFirstResponder
{
    [_textView resignFirstResponder];
    [_textfield resignFirstResponder];
}

- (void)keyboardWillChangeFrameNotification:(NSNotification *)notification
{
    [_textView becomeFirstResponder];
}
    //  NSDictionary *dic = @{@"id":@"1",@"page":@"1",@"route":@"News_submitNews",@"token":[USER_DEFAULT objectForKey:@"token"],@"version":@"1",@"sign":@"b571194de646528d16c1dbd4c5a88cfa",@"debug":@"true"};

    
    

@end






























