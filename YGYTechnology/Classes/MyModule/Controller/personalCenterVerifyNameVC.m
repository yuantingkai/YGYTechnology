//
//  personalCenterVerifyNameVC.m
//  YGYTechnology
//
//  Created by 袁庭楷 on 2018/9/30.
//  Copyright © 2018年 YGY. All rights reserved.
//

#import "personalCenterVerifyNameVC.h"
#define MAX_NAME_LENGTH 30
@interface personalCenterVerifyNameVC ()<UITextFieldDelegate>

@end

@implementation personalCenterVerifyNameVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = Color(0xf2f2f2);
    [self topNavigation];
    [self setUI];
    [self addNameTFMethod];
}

-(void)setUI{
    UIView *backgroundView = [[UIView alloc]init];
    backgroundView.layer.cornerRadius = 5;
    backgroundView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backgroundView];
    [backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(12);
        make.right.offset(-12);
        make.top.offset(12 + kNavHeight);
        make.height.mas_offset(48);
    }];
    
    
    self.nickName = [UITextField createTextFieldWithPlace:@"请输入昵称" withColor:[ColorFormatter hex2Color:0x8890a4 withAlpha:1]];
    [self.nickName setValue:[ColorFormatter hex2Color:0x8890a4 withAlpha:1] forKeyPath:@"_placeholderLabel.textColor"];
    self.nickName.backgroundColor = [UIColor clearColor];
    self.nickName.borderStyle = UITextBorderStyleNone;
    self.nickName.delegate = self;
    //    pwdTextField.secureTextEntry = YES;
    [backgroundView addSubview:self.nickName];
    [self.nickName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.right.offset(-10);
        make.centerY.equalTo(backgroundView);
    }];
    
    UIButton *saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    CAGradientLayer * gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(__bridge id)[ColorFormatter hex2Color:0x6593fb].CGColor, (__bridge id)[ColorFormatter hex2Color:0xad84f8].CGColor];
    gradientLayer.locations = @[@0.1, @1.0];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1, 0);
    gradientLayer.frame = CGRectMake(0, 0, 252,38);
    gradientLayer.cornerRadius = 19;
    [saveBtn.layer addSublayer:gradientLayer];
    
    saveBtn.titleLabel.font = Font(14);
    [saveBtn setTitleColor:YGYColor(255, 255, 255) forState:UIControlStateNormal];
    [saveBtn setTitle:@"保存" forState:UIControlStateNormal];
    [saveBtn addTarget:self action:@selector(saveBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:saveBtn];
    [saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(backgroundView.mas_bottom).offset(15);
        make.width.mas_offset(252);
        make.height.mas_offset(38);
        make.centerX.equalTo(self.view);
    }];
    
    
    
}

-(void)saveBtn:(UIButton *)sender{

    if (self.nickName.text.length > 0) {
        if (self.nickName.text.length <1) {
            MBHUD(@"格式有误");
        }else{
            self.nickNameTextFiled(self.nickName);
            [self returnTopVC];
        }
    }else{
        MBHUD(@"昵称不能为空");
    }
    
    SLog(@"点击了保存");
}

//pragma mark 创建导航栏
-(void)topNavigation{
    UIView * topView = [ViewTools createGradientLayerNav_BarViewWithString:@"个人中心"];
    [self.view addSubview:topView];
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setImage:[UIImage imageNamed:@"leftArrow"] forState:UIControlStateNormal];
    [leftBtn sizeToFit];
    leftBtn.expandHitEdgeInsets = UIEdgeInsetsMake(15, 15, 15, 15);
    [leftBtn addTarget:self action:@selector(returnTopVC) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:leftBtn];
    [leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(12);
        make.bottom.mas_offset(kNavControlImgBottom);
    }];
}

-(void)returnTopVC {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 监听姓名方法
-(void)addNameTFMethod{
    
    [self.nickName addTarget:self action:@selector(NameTFChange:) forControlEvents:UIControlEventEditingChanged];
}

-(void)NameTFChange:(UITextField *)textField{
    if (textField.markedTextRange == nil) {
        //正则表达式 不允许有特殊字符
        NSString * regex = @"^[A-Za-z0-9\u4E00-\u9FA5_-]+$";
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
        BOOL isMatch = [pred evaluateWithObject:textField.text];
        if (textField.text.length > 0 ) {
            if (isMatch) {
                if (textField.text.length >= MAX_NAME_LENGTH) {
                    textField.text = [textField.text substringToIndex:MAX_NAME_LENGTH];
                }
            }else{
                textField.text = [textField.text substringToIndex:(textField.text.length - 1)];
            }
        }
    }
    
    //    SLog(@"textField1 - 输入框内容改变,当前内容为: %@",textField.text);
}

//必须销毁
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
