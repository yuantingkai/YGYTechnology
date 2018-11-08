//
//  LoginFinishSetPwdVC.m
//  YGYTechnology
//
//  Created by 袁庭楷 on 2018/10/3.
//  Copyright © 2018年 YGY. All rights reserved.
//

#import "LoginFinishSetPwdVC.h"

@interface LoginFinishSetPwdVC ()<UITextFieldDelegate>
@property (nonatomic, strong) UITextField * setPwdTF;
@property (nonatomic, strong) UITextField * nextSetPwdTF;
@end

@implementation LoginFinishSetPwdVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = Color(0xf2f2f2);
    [self topNavigation];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textFieldchanged:) name:UITextFieldTextDidChangeNotification object:self.setPwdTF];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textFieldchanged:) name:UITextFieldTextDidChangeNotification object:self.nextSetPwdTF];
    
    [self setUI];
}

-(void)setUI{
    UIView *backgroundView = [[UIView alloc]init];
    backgroundView.layer.cornerRadius = 8;
    backgroundView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backgroundView];
    [backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(12);
        make.right.offset(-12);
        make.top.offset(12 + kNavHeight);
        make.height.mas_offset(96);
    }];
    
    UIView *topView = [UIView new];
    topView.backgroundColor = [UIColor clearColor];
    [backgroundView addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.offset(0);
        make.height.mas_offset(48);
    }];
    
    UIView *oneline = [UIView new];
    oneline.backgroundColor = LINE_COLOR;
    [topView addSubview:oneline];
    [oneline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.offset(0);
        make.height.mas_offset(1);
        make.left.offset(8);
        make.right.offset(-8);
    }];
    
    UILabel *newLabel  = [UILabel newWithText:@"设置密码:" fontSize:14 textColor:MAIN_BODY textAlignment:NSTextAlignmentLeft];
    [topView addSubview:newLabel];
    [newLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.centerY.equalTo(topView);
        make.width.offset(70);
    }];
    self.setPwdTF = [UITextField createTextFieldWithPlace:@"请输入密码" withColor:[ColorFormatter hex2Color:0x999999 withAlpha:1]];
    [self.setPwdTF setValue:[ColorFormatter hex2Color:0x8890a4 withAlpha:1] forKeyPath:@"_placeholderLabel.textColor"];
    self.setPwdTF.backgroundColor = [UIColor clearColor];
    self.setPwdTF.borderStyle = UITextBorderStyleNone;
    self.setPwdTF.delegate = self;
    //    pwdTextField.secureTextEntry = YES;
    [topView addSubview:self.setPwdTF];
    [self.setPwdTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(newLabel.mas_right).offset(10);
        make.right.offset(-10);
        make.centerY.equalTo(newLabel);
    }];
    
    UIView *bottomView = [UIView new];
    bottomView.backgroundColor = [UIColor clearColor];
    [backgroundView addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.equalTo(topView.mas_bottom).offset(0);
        make.height.mas_offset(48);
    }];
    
    
    UILabel *nextLabel  = [UILabel newWithText:@"确认密码:" fontSize:14 textColor:Color(0x333333) textAlignment:NSTextAlignmentLeft];
    [bottomView addSubview:nextLabel];
    [nextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.centerY.equalTo(bottomView);
        make.width.mas_offset(70);
    }];
    
    self.nextSetPwdTF = [UITextField createTextFieldWithPlace:@"请确认密码" withColor:[ColorFormatter hex2Color:0x999999 withAlpha:1]];
    [self.nextSetPwdTF setValue:[ColorFormatter hex2Color:0x8890a4 withAlpha:1] forKeyPath:@"_placeholderLabel.textColor"];
    self.nextSetPwdTF.backgroundColor = [UIColor clearColor];
    self.nextSetPwdTF.borderStyle = UITextBorderStyleNone;
    self.nextSetPwdTF.delegate = self;
    [bottomView addSubview:self.nextSetPwdTF];
    [self.nextSetPwdTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(nextLabel.mas_right).offset(10);
        make.right.offset(-10);
        make.centerY.equalTo(nextLabel);
    }];
    
    UILabel *remindLabel = [UILabel newWithText:@"*密码必须是8-16位数字或字母组成（不能纯数字）" fontSize:14 textColor:SECOND_BODY textAlignment:NSTextAlignmentLeft];
    [self.view addSubview:remindLabel];
    [remindLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(12);
        make.top.equalTo(backgroundView.mas_bottom).offset(12);
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
    
    saveBtn.titleLabel.font = Font(16);
    [saveBtn setTitleColor:YGYColor(255, 255, 255) forState:UIControlStateNormal];
    [saveBtn setTitle:@"确定" forState:UIControlStateNormal];
    [saveBtn addTarget:self action:@selector(saveBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:saveBtn];
    [saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_offset(252);
        make.centerX.equalTo(self.view);
        make.top.equalTo(remindLabel.mas_bottom).offset(35);
        make.height.mas_offset(38);
    }];
}

-(void)saveBtn:(UIButton *)sender{
    //正则表达式 必须有字母和数字
    //    NSString * regex = @"^(?![^A-Za-z]+$)(?![^0-9]+$)[\x21-x7e]{8,15}$";
    NSString * regex = @"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{8,16}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:self.setPwdTF.text];
    
    
    if (self.setPwdTF.text.length > 0 || self.nextSetPwdTF.text.length > 0) {
        if (![self.setPwdTF.text isEqualToString:self.nextSetPwdTF.text]) {
            MBHUD((@"两次密码不一致"));
        }else{
            if (isMatch) {
                [self requestWithNewPwd:self.setPwdTF.text];
            }else{
                MBHUD(@"密码格式有误");
            }
        }
    }else{
        MBHUD(@"密码不能为空");
    }
    
    SLog(@"点击了保存");
}

//pragma mark 创建导航栏
-(void)topNavigation{
    UIView * topView = [ViewTools createGradientLayerNav_BarViewWithString:@"设置密码"];
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

-(void)textFieldchanged:(NSNotification *)notification{
    //限制符号输入
    NSString *characterStr = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    UITextField *textField = (UITextField *)notification.object;
    if (textField == self.setPwdTF) {
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


//第一次登陆设置密码请求
-(void)requestWithNewPwd:(NSString *)pwdStr{
    NSString *pwdStrMD5 = [NSString stringWithFormat:@"%@",[pwdStr MD5]];
    NSString *urlStr = [NSString stringWithFormat:@"%@password=%@&uid=%@",VERIFY_PWD_URL,pwdStrMD5,USER_ID];
    urlStr = [urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    [YGYBaseViewModel postRequestWithPath:urlStr parameters:nil responseDataModel:[YGYBaseDataModel class] success:^(id responseObject) {
        YGYBaseDataModel *model = responseObject;
        if ([model.status isEqualToString:@"200"]) {
            SLog(@"ok");
            [USER_DEFAULT setObject:pwdStr forKey:@"OLDPWD"];
            [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:0]animated:YES];
        }
        MBHUD(model.msg);
    } failure:^(NSError *error) {
        if (error.code == WDNetError) {
            [iToast showMessage:NO_Network];
        }else{
            [iToast showMessage:NO_Service];
        }
    }];
}


//必须销毁
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
