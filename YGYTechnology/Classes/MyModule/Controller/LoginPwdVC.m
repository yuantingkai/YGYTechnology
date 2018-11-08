//
//  LoginPwdVC.m
//  YGYTechnology
//
//  Created by 袁庭楷 on 2018/9/29.
//  Copyright © 2018年 YGY. All rights reserved.
//

#import "LoginPwdVC.h"

@interface LoginPwdVC ()<UITextFieldDelegate>
{
    UITextField *oldPwdTF;
    UITextField *newPwdTF;
    UITextField *nextNewPwdTF;
}
@end

@implementation LoginPwdVC

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = Color(0xf2f2f2);
    [self topNavigation];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textFieldchanged:) name:UITextFieldTextDidChangeNotification object:oldPwdTF];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textFieldchanged:) name:UITextFieldTextDidChangeNotification object:newPwdTF];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textFieldchanged:) name:UITextFieldTextDidChangeNotification object:nextNewPwdTF];
    
    [self setUI];
}

-(void)setUI{
    UIView *backgroundView = [UIView new];
    backgroundView.backgroundColor = [UIColor whiteColor];
    backgroundView.layer.masksToBounds = YES;
    backgroundView.layer.cornerRadius = 8;
    [self.view addSubview:backgroundView];
    [backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(14);
        make.top.offset(kNavHeight +14);
        make.right.offset(-14);
        make.height.mas_offset(150);
    }];
    
    UIView *topView = [UIView new];
    topView.backgroundColor = [UIColor whiteColor];
    [backgroundView addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.offset(0);
        make.height.mas_offset(50);
    }];
    
    UIView *centerView = [UIView new];
    centerView.backgroundColor = [UIColor whiteColor];
    [backgroundView addSubview:centerView];
    [centerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.equalTo(topView.mas_bottom).offset(0);
        make.height.mas_offset(50);
    }];
    
    UIView *oneline = [UIView new];
    oneline.backgroundColor = LINE_COLOR;
    [centerView addSubview:oneline];
    [oneline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(0);
        make.height.mas_offset(1);
        make.left.offset(14);
        make.right.offset(-14);
    }];
    
    UIView *twoline = [UIView new];
    twoline.backgroundColor = LINE_COLOR;
    [centerView addSubview:twoline];
    [twoline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.offset(0);
        make.height.mas_offset(1);
        make.left.offset(14);
        make.right.offset(-14);
    }];
    
    
    
    
    UIView *bottomView = [UIView new];
    bottomView.backgroundColor = [UIColor whiteColor];
    [backgroundView addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.equalTo(centerView.mas_bottom).offset(0);
        make.height.mas_offset(50);
    }];
    
    
    UILabel *oldPwd = [UILabel newWithText:@"原密码" fontSize:14 textColor:MAIN_BODY textAlignment:NSTextAlignmentLeft];
    [topView addSubview:oldPwd];
    [oldPwd mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.centerY.equalTo(topView);
    }];
    
    oldPwdTF = [UITextField createTextFieldWithPlace:@"请输入原密码" withColor:[ColorFormatter hex2Color:0x999999 withAlpha:1]];
    [oldPwdTF setValue:[ColorFormatter hex2Color:0x8890a4 withAlpha:1] forKeyPath:@"_placeholderLabel.textColor"];
    oldPwdTF.backgroundColor = [UIColor clearColor];
    oldPwdTF.borderStyle = UITextBorderStyleNone;
    oldPwdTF.delegate = self;
    //    pwdTextField.secureTextEntry = YES;
    [topView addSubview:oldPwdTF];
    [oldPwdTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(100);
        make.centerY.equalTo(oldPwd);
        make.right.offset(-15);
    }];
    
    UILabel *newPwd = [UILabel newWithText:@"新密码" fontSize:14 textColor:MAIN_BODY textAlignment:NSTextAlignmentLeft];
    [centerView addSubview:newPwd];
    [newPwd mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.centerY.equalTo(centerView);
    }];
    
    newPwdTF = [UITextField createTextFieldWithPlace:@"请输入新密码" withColor:[ColorFormatter hex2Color:0x999999 withAlpha:1]];
    [newPwdTF setValue:[ColorFormatter hex2Color:0x8890a4 withAlpha:1] forKeyPath:@"_placeholderLabel.textColor"];
    newPwdTF.backgroundColor = [UIColor clearColor];
    newPwdTF.borderStyle = UITextBorderStyleNone;
    newPwdTF.delegate = self;
    //    pwdTextField.secureTextEntry = YES;
    [centerView addSubview:newPwdTF];
    [newPwdTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(100);
        make.centerY.equalTo(newPwd);
        make.right.offset(-15);
    }];
    
    UILabel *nextNewPwd = [UILabel newWithText:@"确认密码" fontSize:14 textColor:MAIN_BODY textAlignment:NSTextAlignmentLeft];
    [bottomView addSubview:nextNewPwd];
    [nextNewPwd mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(14);
        make.centerY.equalTo(bottomView);
    }];
    
    nextNewPwdTF = [UITextField createTextFieldWithPlace:@"再次填写确认" withColor:[ColorFormatter hex2Color:0x999999 withAlpha:1]];
    [nextNewPwdTF setValue:[ColorFormatter hex2Color:0x8890a4 withAlpha:1] forKeyPath:@"_placeholderLabel.textColor"];
    nextNewPwdTF.backgroundColor = [UIColor clearColor];
    nextNewPwdTF.borderStyle = UITextBorderStyleNone;
    nextNewPwdTF.delegate = self;
    //    pwdTextField.secureTextEntry = YES;
    [bottomView addSubview:nextNewPwdTF];
    [nextNewPwdTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(100);
        make.centerY.equalTo(nextNewPwd);
        make.right.offset(-15);
    }];
    
    UILabel *remindLabel = [UILabel newWithText:@"* 密码必须是8-16位数字或者字母组成（不能纯数字）" fontSize:14 textColor:SECOND_BODY textAlignment:NSTextAlignmentLeft];
    [self.view addSubview:remindLabel];
    [remindLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(backgroundView.mas_bottom).offset(20);
    }];
    
    UIButton *OKBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    CAGradientLayer * gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(__bridge id)[ColorFormatter hex2Color:0x6593fb].CGColor, (__bridge id)[ColorFormatter hex2Color:0xad84f8].CGColor];
    gradientLayer.locations = @[@0.1, @1.0];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1, 0);
    gradientLayer.frame = CGRectMake(0, 0, 252,38);
    gradientLayer.cornerRadius = 19;
    [OKBtn.layer addSublayer:gradientLayer];
    
    OKBtn.titleLabel.font = Font(16);
    [OKBtn setTitleColor:YGYColor(255, 255, 255) forState:UIControlStateNormal];
    [OKBtn setTitle:@"确定" forState:UIControlStateNormal];
    [OKBtn addTarget:self action:@selector(clickOK:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:OKBtn];
    [OKBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(remindLabel.mas_bottom).offset(50);
        make.height.mas_offset(38);
        make.width.mas_offset(252);
    }];
}

//pragma mark 创建导航栏
-(void)topNavigation{
    UIView * topView = [ViewTools createGradientLayerNav_BarViewWithString:@"登录密码"];
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

//点击确定按钮
-(void)clickOK:(UIButton *)sender{
    //正则表达式 必须有字母和数字
    //    NSString * regex = @"^(?![^A-Za-z]+$)(?![^0-9]+$)[\x21-x7e]{8,15}$";
    NSString * regex = @"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{8,16}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:newPwdTF.text];
    
    
    if (oldPwdTF.text.length == 0) {
        [iToast showMessage:@"旧密码为空"];
        return;
    }
    
    if (newPwdTF.text.length == 0 && nextNewPwdTF.text.length == 0) {
        [iToast showMessage:@"密码不能为空"];
        return;
    }
    if (![nextNewPwdTF.text isEqualToString:newPwdTF.text]) {
        [iToast showMessage:@"两次密码不一致"];
        return;
    }
    if (!isMatch) {
        [iToast showMessage:@"密码格式不正确"];
        return;
    }
    
    [self requestWithNewPwd:newPwdTF.text];
    
}
-(void)delayMethod{
    [self returnTopVC];
}
-(void)textFieldchanged:(NSNotification *)notification{
    //限制符号输入
    NSString *characterStr = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    UITextField *textField = (UITextField *)notification.object;
    if (textField == oldPwdTF) {
        if (textField.text.length > 16) {
            textField.text = [textField.text substringToIndex:16];
        }
    }else if (textField == newPwdTF){
        if (textField.text.length > 16) {
            textField.text = [textField.text substringToIndex:16];
        }
    }else if (textField == nextNewPwdTF){
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


//修改密码请求
-(void)requestWithNewPwd:(NSString *)pwdStr{
    NSString *oldPwd = [USER_DEFAULT objectForKey:@"OLDPWD"];
    if ([oldPwd isEqualToString:pwdStr]) {
        [iToast showMessage:@"新旧密码不能相同"];
    }else{
        NSString *oldPwdMD5 = [NSString stringWithFormat:@"%@",[oldPwd MD5]];
        NSString *newPwdMD5 = [NSString stringWithFormat:@"%@",[pwdStr MD5]];
        NSString *urlStr = [NSString stringWithFormat:@"%@oldPassword=%@&password=%@&uid=%@",VERIFY_PWD_URL,oldPwdMD5,newPwdMD5,USER_ID];
        urlStr = [urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        [YGYBaseViewModel postRequestWithPath:urlStr parameters:nil responseDataModel:[YGYBaseDataModel class] success:^(id responseObject) {
            YGYBaseDataModel *model = responseObject;
            if ([model.status isEqualToString:@"200"]) {
                SLog(@"ok");
                MBHUD(@"密码修改成功");
                [USER_DEFAULT setObject:pwdStr forKey:@"OLDPWD"];
                [self performSelector:@selector(delayMethod) withObject:nil afterDelay:1.0f];
            }else{
                MBHUD(model.msg);
            }
            
        } failure:^(NSError *error) {
            if (error.code == WDNetError) {
                [iToast showMessage:NO_Network];
            }else{
                [iToast showMessage:NO_Service];
            }
        }];
    }
    
}

@end
