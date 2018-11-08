//
//  loginView.m
//  YGYTechnology
//
//  Created by 袁庭楷 on 2018/9/27.
//  Copyright © 2018年 YGY. All rights reserved.
//

#import "loginView.h"

@implementation loginView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textFieldchanged:) name:UITextFieldTextDidChangeNotification object:telPhoneTextField];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textFieldchanged:) name:UITextFieldTextDidChangeNotification object:pwdTextField];
    
    [self createUI];
    return self;
}

-(void)createUI{
    self.backgroundColor = [UIColor whiteColor];
    
    UIView *backgroundView = [UIView new];
    [self addSubview:backgroundView];
    [backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.offset(0);
    }];
    
    UIImageView *backImageView = [UIImageView new];
    [backImageView setImage:[UIImage imageNamed:@"loginBackImage"]];
    [backgroundView addSubview:backImageView];
    [backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.offset(0);
        make.height.mas_offset(212);
    }];
    
    UIImageView *topImageView = [[UIImageView alloc]init];
    [topImageView setImage:[UIImage imageNamed:@"loginTop"]];
    [backgroundView addSubview:topImageView];
    [topImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.offset(104);
        make.centerX.equalTo(self);
        make.width.height.mas_offset(70);
        make.centerY.equalTo(backImageView);
    }];
    
    UIView *loginView = [UIView new];
    [backgroundView addSubview:loginView];
    [loginView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(51);
        make.right.offset(-51);
        make.height.mas_offset(22);
        make.top.equalTo(backImageView.mas_bottom).offset(72);
    }];
    
    UIImageView *phoneImageView = [[UIImageView alloc]init];
    [phoneImageView setImage:[UIImage imageNamed:@"shouji"]];
    [loginView addSubview:phoneImageView];
    [phoneImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(loginView);
        make.left.offset(0);
        make.width.mas_offset(28 /2 );
    }];
    
    telPhoneTextField = [UITextField createTextFieldWithPlace:@"输入手机号码" withColor:[ColorFormatter hex2Color:0x8890a4 withAlpha:1]];
    telPhoneTextField.font = Font(14);
    [telPhoneTextField setValue:[ColorFormatter hex2Color:0x999999 withAlpha:1] forKeyPath:@"_placeholderLabel.textColor"];
    telPhoneTextField.backgroundColor = [UIColor clearColor];
    telPhoneTextField.borderStyle = UITextBorderStyleNone;
    telPhoneTextField.keyboardType = UIKeyboardTypeNumberPad;
    [loginView addSubview:telPhoneTextField];
    [telPhoneTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(phoneImageView.mas_right).offset(8);
        make.centerY.equalTo(phoneImageView);
        make.right.offset(8);
    }];
    
    UIView *loginLine = [UIView new];
    loginLine.backgroundColor = LINE_COLOR;
    [loginView addSubview:loginLine];
    [loginLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(phoneImageView.mas_right).offset(10);
        make.right.bottom.offset(0);
        make.height.mas_offset(1);
    }];
    
    UIView *pwdView = [UIView new];
    [backgroundView addSubview:pwdView];
    [pwdView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(51);
        make.right.offset(-51);
        make.height.mas_offset(28);
        make.top.equalTo(loginView.mas_bottom).offset(60);
    }];
    
    UIImageView *pwdImageView = [[UIImageView alloc]init];
    [pwdImageView setImage:[UIImage imageNamed:@"yanzhen"]];
    [pwdView addSubview:pwdImageView];
    [pwdImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(pwdView);
        make.left.offset(0);
        make.width.mas_offset(32 /2 );
    }];
    
    pwdTextField = [UITextField createTextFieldWithPlace:@"请输入密码" withColor:[ColorFormatter hex2Color:0x8890a4 withAlpha:1]];
    [pwdTextField setValue:[ColorFormatter hex2Color:0x999999 withAlpha:1] forKeyPath:@"_placeholderLabel.textColor"];
    pwdTextField.backgroundColor = [UIColor clearColor];
    pwdTextField.borderStyle = UITextBorderStyleNone;
    pwdTextField.delegate = self;
        pwdTextField.secureTextEntry = YES;
    [pwdView addSubview:pwdTextField];
    [pwdTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(pwdImageView.mas_right).offset(8);
        make.centerY.equalTo(pwdImageView);
        make.right.offset(-80);
    }];
    
    UIView *pwdLine = [UIView new];
    pwdLine.backgroundColor = LINE_COLOR;
    [pwdView addSubview:pwdLine];
    [pwdLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(pwdImageView.mas_right).offset(10);
        make.right.bottom.offset(0);
        make.height.mas_offset(1);
    }];
    
    UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [loginBtn setBackgroundImage:[UIImage imageNamed:@"Login"] forState:UIControlStateNormal];
    [loginBtn addTarget:self action:@selector(clickLogin:) forControlEvents:UIControlEventTouchUpInside];
    [backgroundView addSubview:loginBtn];
    [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(pwdImageView.mas_bottom).offset(37);
        make.centerX.equalTo(self);
        make.width.mas_offset(285);
        make.height.mas_offset(40);
    }];
    
    _verifyLoginBtn  = [UIButton newWithTitle:@"使用验证码登录 >" font:12 textColor:Color(0x999999) textAlignment:NSTextAlignmentLeft Image:nil];
    _verifyLoginBtn.tag = 100001;
    [_verifyLoginBtn addTarget:self action:@selector(verifyLoginBtn:) forControlEvents:UIControlEventTouchUpInside];
    [backgroundView addSubview:_verifyLoginBtn];
    [_verifyLoginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(52);
        make.top.equalTo(loginBtn.mas_bottom).offset(21);
    }];
    
    //获取验证码按钮
    _getVerifyBtn  = [UIButton newWithTitle:@"获取验证码" font:11 textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentLeft Image:nil];
    _getVerifyBtn.cs_acceptEventInterval=2.0;
    [_getVerifyBtn setBackgroundImage:[UIImage imageNamed:@"verifyBackgroud"] forState:UIControlStateNormal];
    _getVerifyBtn.hidden = YES;
    [_getVerifyBtn addTarget:self action:@selector(getVerifyBtn:) forControlEvents:UIControlEventTouchUpInside];
    [pwdView addSubview:_getVerifyBtn];
    [_getVerifyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(0);
        make.centerY.equalTo(pwdView);
        make.height.mas_offset(24);
        make.width.mas_offset(80);
    }];
    
}
#pragma mark ---点击return键盘自动退出
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
#pragma mark ---点击屏幕键盘消失
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [telPhoneTextField resignFirstResponder];
    [pwdTextField resignFirstResponder];
}

//点击登录按钮
-(void)clickLogin:(UIButton *)sender{
    if (telPhoneTextField.text.length == 0 && pwdTextField.text.length == 0) {
        [iToast showMessage:@"请输入手机号和密码"];
        return;
    }
    
    if (telPhoneTextField.text.length == 0) {
        [iToast showMessage:@"请输入手机号"];
        return;
    }
    
    if (pwdTextField.text.length == 0) {
        [iToast showMessage:@"请输入密码"];
        return;
    }
    if(![ViewTools validatePhone:telPhoneTextField.text]){
        [iToast showMessage:@"手机格式错误"];
        return;
    }
    if(self.login){
        self.login(telPhoneTextField.text,pwdTextField.text);
    }
}

//点击验证码登录
-(void)verifyLoginBtn:(UIButton *)sender{
    pwdTextField.text = @"";
    if (sender.tag == 100001) {
        [self.verifyLoginBtn setTitle:@"使用密码登录 >" forState:UIControlStateNormal];
        pwdTextField.placeholder = @"请输入验证码";
        pwdTextField.keyboardType = UIKeyboardTypeNumberPad;
        _getVerifyBtn.hidden = NO;
        sender.tag = 100002;
        self.isChangeStr(@"YES");
    }else{
        [self.verifyLoginBtn setTitle:@"使用验证码登录 >" forState:UIControlStateNormal];
        pwdTextField.placeholder = @"请输入密码";
        pwdTextField.keyboardType = UIKeyboardTypeDefault;
        _getVerifyBtn.hidden = YES;
        sender.tag = 100001;
        self.isChangeStr(@"NO");
    }
    
}
//点击获取验证码按钮
-(void)getVerifyBtn:(UIButton *)sender{
    if (telPhoneTextField.text.length == 0) {
        [iToast showMessage:@"请输入手机号"];
        return;
    }
    if(![ViewTools validatePhone:telPhoneTextField.text]){
        [iToast showMessage:@"手机格式错误"];
        return;
    }
    

    self.getVerifyCodeBtn(sender,telPhoneTextField.text);
}

-(void)textFieldchanged:(NSNotification *)notification{
    //限制符号输入
    NSString *characterStr = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    UITextField *textField = (UITextField *)notification.object;
    if (textField == telPhoneTextField) {
        characterStr = @"0123456789";
        if (textField.text.length > 11) {
            textField.text = [textField.text substringToIndex:11];
        }
    }else if (textField == pwdTextField){
        characterStr = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
        if (textField.text.length > 16) {
            textField.text = [textField.text substringToIndex:16];
        }
    }
    NSCharacterSet *nameCharacters = [[NSCharacterSet characterSetWithCharactersInString:characterStr] invertedSet];
    if (textField.text.length < 1){
        return;
    }
    //取出最后一位
    NSString *lastStr = [textField.text substringFromIndex:textField.text.length-1];
    NSRange userNameRange = [lastStr rangeOfCharacterFromSet:nameCharacters];
    //最后一位是特殊字符
    if (userNameRange.location != NSNotFound) {
        textField.text = [textField.text substringToIndex:(textField.text.length - 1)];
    }
}

//必须销毁
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
