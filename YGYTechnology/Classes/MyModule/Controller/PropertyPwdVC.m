//
//  PropertyPwdVC.m
//  YGYTechnology
//
//  Created by 袁庭楷 on 2018/9/29.
//  Copyright © 2018年 YGY. All rights reserved.
//

#import "PropertyPwdVC.h"
#import "SetSafePwdView.h"

@interface PropertyPwdVC ()<UITextFieldDelegate>
{
    UITextField *phoneNumTF;
    UITextField *verifyTF;
    NSString *propertyPwdStr;
}
@property (nonatomic, strong) UIButton * verifyBtn;
@end

@implementation PropertyPwdVC

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = Color(0xf2f2f2);
    [self topNavigation];
    [self setUI];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textFieldchanged:) name:UITextFieldTextDidChangeNotification object:phoneNumTF];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textFieldchanged:) name:UITextFieldTextDidChangeNotification object:verifyTF];
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
        make.height.mas_offset(100);
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
    
    UILabel *phoneNumLabel = [UILabel newWithText:@"手机号码" fontSize:14 textColor:MAIN_BODY textAlignment:NSTextAlignmentLeft];
    [topView addSubview:phoneNumLabel];
    [phoneNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(14);
        make.centerY.equalTo(topView);
    }];
    
    phoneNumTF = [UITextField createTextFieldWithPlace:@"输入手机号码" withColor:[ColorFormatter hex2Color:0x999999 withAlpha:1]];
    [phoneNumTF setValue:[ColorFormatter hex2Color:0x8890a4 withAlpha:1] forKeyPath:@"_placeholderLabel.textColor"];
    phoneNumTF.backgroundColor = [UIColor clearColor];
    phoneNumTF.borderStyle = UITextBorderStyleNone;
    phoneNumTF.keyboardType = UIKeyboardTypeNumberPad;
    phoneNumTF.delegate = self;
    //    pwdTextField.secureTextEntry = YES;
    [topView addSubview:phoneNumTF];
    [phoneNumTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(100);
        make.centerY.equalTo(phoneNumLabel);
    }];
    
    UILabel *verifyLabel = [UILabel newWithText:@"验证码" fontSize:14 textColor:MAIN_BODY textAlignment:NSTextAlignmentLeft];
    [centerView addSubview:verifyLabel];
    [verifyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(14);
        make.centerY.equalTo(centerView);
    }];
    
    verifyTF = [UITextField createTextFieldWithPlace:@"输入验证码" withColor:[ColorFormatter hex2Color:0x999999 withAlpha:1]];
    [verifyTF setValue:[ColorFormatter hex2Color:0x8890a4 withAlpha:1] forKeyPath:@"_placeholderLabel.textColor"];
    verifyTF.backgroundColor = [UIColor clearColor];
    verifyTF.borderStyle = UITextBorderStyleNone;
    verifyTF.keyboardType = UIKeyboardTypeNumberPad;
    verifyTF.delegate = self;
    //    pwdTextField.secureTextEntry = YES;
    [centerView addSubview:verifyTF];
    [verifyTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(100);
        make.centerY.equalTo(verifyLabel);
    }];
    
    //获取验证码按钮
    self.verifyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.verifyBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [self.verifyBtn setTitleColor:[UIColor colorWithRed:85.0/255 green:166.0/255 blue:229.0/255 alpha:1] forState:UIControlStateNormal];
    self.verifyBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    //点击获取验证码按钮
    [self.verifyBtn addTarget:self action:@selector(clickCaptchaBtn) forControlEvents:UIControlEventTouchUpInside];
    self.verifyBtn.cs_acceptEventInterval=2.0;
    [self.verifyBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    self.verifyBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [centerView addSubview:self.verifyBtn];
    [self.verifyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(centerView).offset(-30);
        make.width.mas_offset(120);
        make.centerY.equalTo(verifyLabel);
    }];
    
    UIView *safePwdView = [UIView new];
    safePwdView.backgroundColor = [UIColor whiteColor];
    safePwdView.layer.masksToBounds = YES;
    safePwdView.layer.cornerRadius = 8;
    [self.view addSubview:safePwdView];
    [safePwdView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(14);
        make.top.equalTo(backgroundView.mas_bottom).offset(10);
        make.right.offset(-14);
        make.height.mas_offset(180);
    }];
   
    UILabel *safePwdLabel = [UILabel newWithText:@"资产密码" fontSize:14 textColor:MAIN_BODY textAlignment:NSTextAlignmentCenter];
    [safePwdView addSubview:safePwdLabel];
    [safePwdLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(40);
        make.centerX.equalTo(safePwdView);
    }];
    
    UILabel *safeRemindLabel = [UILabel newWithText:@"请设置支付密码，用于验证" fontSize:14 textColor:SECOND_BODY textAlignment:NSTextAlignmentCenter];
    [safePwdView addSubview:safeRemindLabel];
    [safeRemindLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(safePwdLabel.mas_bottom).offset(25);
        make.centerX.equalTo(safePwdView);
    }];
    
    CGFloat width = 38 * 6;
    SetSafePwdView *pwdView = [[SetSafePwdView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH - width)/2, 280 +kStatusBarHeight, width, 38)];
    [self.view addSubview:pwdView];
    [pwdView setPasswordDidChangeBlock:^(NSString *password) {
        [self setPropertyPwd:password];
        SLog(@"%@",password);
    }];
    
    UIButton *okBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    CAGradientLayer * gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(__bridge id)[ColorFormatter hex2Color:0x6593fb].CGColor, (__bridge id)[ColorFormatter hex2Color:0xad84f8].CGColor];
    gradientLayer.locations = @[@0.1, @1.0];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1, 0);
    gradientLayer.frame = CGRectMake(0, 0, 252,38);
    gradientLayer.cornerRadius = 19;
    [okBtn.layer addSublayer:gradientLayer];
    
    okBtn.titleLabel.font = Font(16);
    [okBtn setTitleColor:YGYColor(255, 255, 255) forState:UIControlStateNormal];
    [okBtn setTitle:@"确定" forState:UIControlStateNormal];
    okBtn.cs_acceptEventInterval=2.0;
    [okBtn addTarget:self action:@selector(clickOKBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:okBtn];
    [okBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(safePwdView.mas_bottom).offset(30);
        make.centerX.equalTo(self.view);
        make.height.mas_offset(38);
        make.width.mas_offset(252);
    }];
    
}
-(void)clickCaptchaBtn{
    if (phoneNumTF.text.length ==0) {
        ALERT(@"手机号不能为空");
        return;
    }
    if(![ViewTools validatePhone:phoneNumTF.text]){
        [iToast showMessage:@"手机格式错误"];
        return;
    }
    [self getVerifyCode:phoneNumTF.text];
}

-(void)setPropertyPwd:(NSString *)propertyStr{
    propertyPwdStr = propertyStr;
}

-(void)clickOKBtn{
    if (phoneNumTF.text.length ==0) {
        ALERT(@"手机号不能为空");
        return;
    }
    if (verifyTF.text.length ==0) {
        ALERT(@"验证码不能为空");
        return;
    }
    if(![ViewTools validatePhone:phoneNumTF.text]){
        [iToast showMessage:@"手机格式错误"];
        return;
    }
    if (propertyPwdStr.length > 0 && propertyPwdStr.length < 7) {
        [self setPropertyRequest];
    }else{
        [iToast showMessage:@"请输入正确的支付密码"];
        return;
    }
    
    SLog(@"确定");
}
//pragma mark 创建导航栏
-(void)topNavigation{
    UIView * topView = [ViewTools createGradientLayerNav_BarViewWithString:@"设置资产密码"];
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
    NSString *characterStr = @"0123456789";
    UITextField *textField = (UITextField *)notification.object;
    if (textField == phoneNumTF) {
        if (textField.text.length > 11) {
            textField.text = [textField.text substringToIndex:11];
        }
    }else if (textField == verifyTF){
        if (textField.text.length > 6) {
            textField.text = [textField.text substringToIndex:6];
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

//倒计时
-(void)startTime{
    __block int timeout=59; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    //dispatch_walltime现实时间
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                if (timeout <=0) {
                    [self.verifyBtn setTitle:@"重新获取验证码" forState:UIControlStateNormal];
                }else{
                    [self.verifyBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
                }
                
                self.verifyBtn.userInteractionEnabled = YES;
            });
        }else{
            int seconds = timeout % 60;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                //NSLog(@"____%@",strTime);
                [UIView beginAnimations:nil context:nil];
                [UIView setAnimationDuration:1];
                [self.verifyBtn setTitle:[NSString stringWithFormat:@"还有%@s",strTime] forState:UIControlStateNormal];
                [UIView commitAnimations];
                
                self.verifyBtn.userInteractionEnabled = NO;
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
}

//s设置资产密码请求
-(void)setPropertyRequest{
    NSString *propertyPwdStrMD5 = [NSString stringWithFormat:@"%@",[propertyPwdStr MD5]];
    NSString *urlStr  = [NSString stringWithFormat:@"%@assetsPassword=%@&authCode=%@&phone=%@&uid=%@",PROPERTY_PWD_URL,propertyPwdStrMD5,verifyTF.text,phoneNumTF.text,USER_ID];
    urlStr = [urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    [YGYBaseViewModel postRequestWithPath:urlStr parameters:nil responseDataModel:[YGYBaseDataModel class] success:^(id responseObject) {
        YGYBaseDataModel *model = responseObject;
        if ([model.status isEqualToString:@"200"]) {
            MBHUD(@"设置成功");
            [USER_DEFAULT setObject:@"1" forKey:@"AS_SETS_PWD_EXIST"];
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

-(void)delayMethod{
    [self returnTopVC];
}
//获得验证码请求
-(void)getVerifyCode:(NSString *)telPhone{
    NSString *urlStr = [NSString stringWithFormat:@"%@phone=%@&type=editAssetsPwd",sendCode_URL,telPhone];
    urlStr = [urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    [YGYBaseViewModel getRequestWithPath:urlStr parameters:nil responseDataModel:[YGYBaseDataModel class] success:^(id responseObject) {
        YGYBaseDataModel *model = responseObject;
        if ([model.status isEqualToString:@"200"]) {
            [self startTime];
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


//必须销毁
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
