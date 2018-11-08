//
//  BTCGetMoneyView.m
//  YGYTechnology
//
//  Created by 袁庭楷 on 2018/10/13.
//  Copyright © 2018年 YGY. All rights reserved.
//

#import "BTCGetMoneyView.h"

@implementation BTCGetMoneyView
#define NUMBERS @"0123456789."

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self){
        self.backgroundColor = [UIColor clearColor];
        [self setUI];
    }
    return self;
}

-(void)setUI{
    UIView *backView = [UIView new];
    backView.backgroundColor = [UIColor whiteColor];
    backView.layer.cornerRadius = 8;
    [self addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(12);
        make.right.offset(-12);
        make.bottom.offset(-35);
        make.height.mas_offset(320);
    }];
    
    //    UIView *topView = [UIView new];
    //    [backView addSubview:topView];
    //    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.left.top.right.offset(0);
    //        make.height.mas_offset(48);
    //    }];
    
    UILabel *topLabel = [UILabel newWithText:@"BTC提现" fontSize:14 textColor:MAIN_BODY textAlignment:NSTextAlignmentLeft];
    [backView addSubview:topLabel];
    [topLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(23);
        make.top.offset(14);
    }];
    
    UIButton *cancelBtn = [UIButton newWithTitle:@"" font:14 textColor:nil textAlignment:NSTextAlignmentCenter Image:[UIImage imageNamed:@"guanbi"]];
    [cancelBtn addTarget:self action:@selector(cancelBtn:) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:cancelBtn];
    [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-18);
        make.centerY.equalTo(topLabel);
    }];
    
    UIView *topLine = [UIView new];
    topLine.backgroundColor = LINE_COLOR;
    [backView addSubview:topLine];
    [topLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(5);
        make.right.offset(-5);
        make.height.mas_offset(1);
        make.bottom.equalTo(topLabel.mas_bottom).offset(14);
    }];
    
    self.accountTextField = [UITextField createTextFieldWithPlace:@"请输入提币地址" withColor:[ColorFormatter hex2Color:0x999999 withAlpha:1]];
    [self.accountTextField setValue:[ColorFormatter hex2Color:0x999999 withAlpha:1] forKeyPath:@"_placeholderLabel.textColor"];
    self.accountTextField.backgroundColor = [UIColor clearColor];
    self.accountTextField.borderStyle = UITextBorderStyleRoundedRect;
//    self.accountTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.accountTextField.layer.cornerRadius = 5;
    self.accountTextField.layer.borderColor = [UIColor colorWithRed:14/255.0 green:174/255.0 blue:131/255.0 alpha:1].CGColor;
    [backView addSubview:self.accountTextField];
    [self.accountTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_offset(264);
        make.right.offset(-23);
        make.height.mas_offset(40);
        make.top.equalTo(topLine.mas_bottom).offset(18);
    }];
    
    UIImageView *accountImageView = [UIImageView new];
    [accountImageView setImage:[UIImage imageNamed:@"Locate"]];
    accountImageView.layer.cornerRadius = 15;
    [backView addSubview:accountImageView];
    [accountImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_offset(30);
        make.centerY.equalTo(self.accountTextField);
        make.right.equalTo(self.accountTextField.mas_left).offset(-12);
        make.left.offset(23);
    }];
    
    
    self.numTextField = [UITextField createTextFieldWithPlace:@"请输入提币数量" withColor:[ColorFormatter hex2Color:0x999999 withAlpha:1]];
    [self.numTextField setValue:[ColorFormatter hex2Color:0x999999 withAlpha:1] forKeyPath:@"_placeholderLabel.textColor"];
    self.numTextField.backgroundColor = [UIColor clearColor];
    self.numTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.numTextField.delegate = self;
//    self.numTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.numTextField.layer.cornerRadius = 5;
    self.numTextField.layer.borderColor = [UIColor colorWithRed:14/255.0 green:174/255.0 blue:131/255.0 alpha:1].CGColor;
    [backView addSubview:self.numTextField];
    [self.numTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_offset(264);
        make.right.offset(-23);
        make.height.mas_offset(40);
        make.top.equalTo(self.accountTextField.mas_bottom).offset(12);
    }];
    
    UIImageView *numImageView = [UIImageView new];
    numImageView.layer.cornerRadius = 15;
    [numImageView setImage:[UIImage imageNamed:@"Quantity"]];
    [backView addSubview:numImageView];
    [numImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_offset(30);
        make.centerY.equalTo(self.numTextField);
        make.right.equalTo(self.numTextField.mas_left).offset(-12);
        make.left.offset(23);
    }];
    
    self.pwdTextField = [UITextField createTextFieldWithPlace:@"请输入资产密码" withColor:[ColorFormatter hex2Color:0x999999 withAlpha:1]];
    [self.pwdTextField setValue:[ColorFormatter hex2Color:0x999999 withAlpha:1] forKeyPath:@"_placeholderLabel.textColor"];
    self.pwdTextField.backgroundColor = [UIColor clearColor];
    self.pwdTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.pwdTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.pwdTextField.secureTextEntry = YES;
    self.pwdTextField.layer.cornerRadius = 5;
    self.pwdTextField.layer.borderColor = [UIColor colorWithRed:14/255.0 green:174/255.0 blue:131/255.0 alpha:1].CGColor;
    [backView addSubview:self.pwdTextField];
    [self.pwdTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_offset(264);
        make.right.offset(-23);
        make.height.mas_offset(40);
        make.top.equalTo(self.numTextField.mas_bottom).offset(12);
    }];
    
    UIImageView *pwdImageView = [UIImageView new];
    [pwdImageView setImage:[UIImage imageNamed:@"password"]];
    pwdImageView.layer.cornerRadius = 15;
    [backView addSubview:pwdImageView];
    [pwdImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_offset(30);
        make.centerY.equalTo(self.pwdTextField);
        make.right.equalTo(self.pwdTextField.mas_left).offset(-12);
        make.left.offset(23);
    }];
    
    
    
    
    
    UIButton *OKBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    CAGradientLayer * gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(__bridge id)[ColorFormatter hex2Color:0x6593fb].CGColor, (__bridge id)[ColorFormatter hex2Color:0xad84f8].CGColor];
    gradientLayer.locations = @[@0.1, @1.0];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1, 0);
    if (SCREEN == 1) {
        gradientLayer.frame = CGRectMake(0, 0, 270,50);
    }else{
        gradientLayer.frame = CGRectMake(0, 0, 305,50);
    }
    
    gradientLayer.cornerRadius = 25;
    [OKBtn.layer addSublayer:gradientLayer];
    
    OKBtn.titleLabel.font = Font(14);
    [OKBtn setTitleColor:YGYColor(255, 255, 255) forState:UIControlStateNormal];
    [OKBtn setTitle:@"确认提现" forState:UIControlStateNormal];
    OKBtn.layer.cornerRadius = 25;
    [OKBtn setBackgroundColor:[UIColor blueColor]];
    [OKBtn addTarget:self action:@selector(OKBtn:) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:OKBtn];
    [OKBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        if (SCREEN == 1) {
            make.width.mas_offset(270);
        }else{
            make.width.mas_offset(305);
        }
        
        make.bottom.offset(-20);
        make.height.mas_offset(50);
        make.centerX.equalTo(backView);
    }];
    
    UIView *bottomLine = [UIView new];
    bottomLine.backgroundColor = LINE_COLOR;
    [backView addSubview:bottomLine];
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(5);
        make.right.offset(-5);
        make.height.mas_offset(1);
        make.bottom.equalTo(OKBtn.mas_top).offset(-20.5);
    }];
    
}

-(void)cancelBtn:(UIButton *)sender{
    self.cancelBtn(sender);
}

-(void)OKBtn:(UIButton *)sender{
//    if (self.accountTextField.text.length == 0 && self.numTextField.text.length == 0 && self.pwdTextField.text == 0) {
//        [iToast showMessage:@"提币地址、提币数量、资产密码不能为空"];
//        return;
//    }
    if (self.accountTextField.text.length == 0) {
        [iToast showMessage:@"地址不能为空"];
        return;
    }
    if (self.numTextField.text.length == 0) {
        [iToast showMessage:@"提币数量不能为空"];
        return;
    }
    if (self.pwdTextField.text.length == 0) {
        [iToast showMessage:@"资产密码不能为空"];
        return;
    }
    self.returnTextField(self.accountTextField.text, self.numTextField.text, self.pwdTextField.text);
}




- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    //删除处理
    if ([string isEqualToString:@""]) {
        return YES;
    }
    //首位不能为.号
    if (range.location == 0 && [string isEqualToString:@"."]) {
        return NO;
    }
    return [self isRightInPutOfString:textField.text withInputString:string range:range];
}


- (BOOL)isRightInPutOfString:(NSString *) string withInputString:(NSString *) inputString range:(NSRange) range{
    //判断只输出数字和.号
    NSString *passWordRegex = @"[0-9\\.]";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passWordRegex];
    if (![passWordPredicate evaluateWithObject:inputString]) {
        return NO;
    }
    
    //逻辑处理
    if ([string containsString:@"."]) {
        if ([inputString isEqualToString:@"."]) {
            return NO;
        }
        NSRange subRange = [string rangeOfString:@"."];
        if (range.location - subRange.location > 8) {
            return NO;
        }
    }
    return YES;
}


@end
