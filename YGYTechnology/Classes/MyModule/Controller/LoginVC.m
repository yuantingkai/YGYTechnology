//
//  LoginVC.m
//  YGYTechnology
//
//  Created by 袁庭楷 on 2018/9/27.
//  Copyright © 2018年 YGY. All rights reserved.
//

#import "LoginVC.h"
#import "loginView.h"
#import "LoginFinishSetPwdVC.h"
#import "LoginModel.h"
#import "RoamVC.h"

@interface LoginVC ()
@property (nonatomic, strong) NSString *isChangeVerifyStr;
@end

@implementation LoginVC

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    //    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault]; [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self topNavigation];
}

//pragma mark 创建导航栏
-(void)topNavigation{
    loginView *loginview = [[loginView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [self.view addSubview:loginview];
    
    WeakSelf(self);
    [loginview setLogin:^(NSString *telPhone, NSString *pwd) {
        [weakSelf loginRequestWithPhone:telPhone pwd:pwd];
    }];

    [loginview setGetVerifyCodeBtn:^(UIButton *getVerifyCodeBtn, NSString *telPhone) {
        [weakSelf clickGetVerifyBtn:getVerifyCodeBtn withTel:telPhone];
    }];
    [loginview setIsChangeStr:^(NSString *isChangeStr) {
        [weakSelf changeStr:isChangeStr];
    }];

    
    UIView * topView = [self newWhiteBgBlackTitleNavBarNoLine:@""];
    topView.backgroundColor = [UIColor clearColor];
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setImage:[UIImage imageNamed:@"leftArrow"] forState:UIControlStateNormal];
    [leftBtn sizeToFit];
    leftBtn.expandHitEdgeInsets = UIEdgeInsetsMake(15, 15, 15, 15);
    [leftBtn addTarget:self action:@selector(returnTopVC) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:leftBtn];
    [leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(14);
        make.bottom.mas_offset(kNavControlImgBottom);
    }];
    
}
-(void)returnTopVC {
    if ([self.isExitLogin isEqualToString:@"YES"]) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }else{
       [self.navigationController popViewControllerAnimated:YES];
    }
    
}

-(void)changeStr:(NSString *)isChangeVerifyStr{
    self.isChangeVerifyStr = isChangeVerifyStr;
}

//点击获取验证码按钮
-(void)clickGetVerifyBtn:(UIButton *)clickVerifyBtn withTel:(NSString *)telPhone{
    SLog(@"获取验证码");
    
    NSString *urlStr = [NSString stringWithFormat:@"%@phone=%@&type=login",sendCode_URL,telPhone];
    urlStr = [urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    [YGYBaseViewModel getRequestWithPath:urlStr parameters:nil responseDataModel:[YGYBaseDataModel class] success:^(id responseObject) {
        YGYBaseDataModel *model = responseObject;
        if ([model.status isEqualToString:@"200"]) {
            [self startTime:clickVerifyBtn];
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


//登录请求
-(void)loginRequestWithPhone:(NSString *)phoneStr pwd:(NSString *)pwdStr{
    NSString *urlStr;
    if([self.isChangeVerifyStr isEqualToString:@"YES"]){//切换验证码与非验证码输入框
            urlStr = [NSString stringWithFormat:@"%@phone=%@&authCode=%@",LOGIN_URL,phoneStr,pwdStr];
    }else{
        NSString *pwdStrMD5 = [NSString stringWithFormat:@"%@",[pwdStr MD5]];
        urlStr = [NSString stringWithFormat:@"%@phone=%@&password=%@",LOGIN_URL,phoneStr,pwdStrMD5];
    }
    urlStr = [urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    [YGYBaseViewModel postRequestWithPath:urlStr parameters:nil responseDataModel:[LoginModel class] success:^(id responseObject) {
        LoginModel *model = responseObject;
        SLog(@"登录信息：%@",model);
        if ([model.status isEqualToString:@"200"]) {
            [[LoginSaveTool sharedTool] addLoginData:model.data];
            //存储登录获取的照片 姓名 性别
            [USER_DEFAULT setObject:[LoginGetTool getUserInfo].avatarImg forKey:@"IMAGE_STR"];
            [USER_DEFAULT setObject:[LoginGetTool getUserInfo].name forKey:@"NAME_STR"];
            NSString *genderStr = [[LoginGetTool getUserInfo].gender  isEqualToString: @"0"]  ? @"女" : @"男";
            [USER_DEFAULT setObject:genderStr forKey:@"GENDER_STR"];
            //设置资产密码 0代表未设置
            [USER_DEFAULT setObject:[LoginGetTool getUserInfo].assetsPwdExist forKey:@"AS_SETS_PWD_EXIST"];
            //登录成功之后 本地存储一个登录成功的状态码
            [USER_DEFAULT setObject:@"loginSuccess" forKey:@"LOGIN_SUCCESS"];
            [USER_DEFAULT setObject:pwdStr forKey:@"OLDPWD"];
            if ([LoginGetTool getUserInfo].password.length > 0) {
                [self returnTopVC];
            }else{//第一次登陆
                LoginFinishSetPwdVC *pwdVC = [[LoginFinishSetPwdVC alloc]init];
                [self.navigationController pushViewController:pwdVC animated:YES];
            }

        }else{
            MBHUD(model.msg);
            //登录失败之后 清空本地存储的登录成功的状态码
            [USER_DEFAULT removeObjectForKey:@"LOGIN_SUCCESS"];
        }
    } failure:^(NSError *error) {
        if (error.code == WDNetError) {
            [iToast showMessage:NO_Network];
        }else{
            [iToast showMessage:NO_Service];
        }
    }];
}



//倒计时
-(void)startTime:(UIButton *)sender{
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
                    [sender setTitle:@"重新获取验证码" forState:UIControlStateNormal];
                }else{
                    [sender setTitle:@"获取验证码" forState:UIControlStateNormal];
                }
                
                sender.userInteractionEnabled = YES;
            });
        }else{
            int seconds = timeout % 60;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                //NSLog(@"____%@",strTime);
                [UIView beginAnimations:nil context:nil];
                [UIView setAnimationDuration:1];
                [sender setTitle:[NSString stringWithFormat:@"还有%@s",strTime] forState:UIControlStateNormal];
                [UIView commitAnimations];
                
                sender.userInteractionEnabled = NO;
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
}



@end
