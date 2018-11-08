//
//  NewsInfoDeatilsVC.m
//  YGYTechnology
//
//  Created by 袁庭楷 on 2018/10/5.
//  Copyright © 2018年 YGY. All rights reserved.
//

#import "NewsInfoDeatilsVC.h"

@interface NewsInfoDeatilsVC ()<UIWebViewDelegate>
{
    UIWebView *webView;
    NSTimer *timer;
}
@end

@implementation NewsInfoDeatilsVC

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.navigationController.navigationBar.hidden = YES;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self topNavigation];
    [self creatWebView];
}

-(void)creatWebView{
    // 1.创建webview，并设置大小，"20"为状态栏高度
    webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, kNavHeight, SCREEN_WIDTH, SCREEN_HEIGHT - kNavHeight)];
    // 2.创建请求
    NSMutableURLRequest *request =[NSMutableURLRequest requestWithURL:[NSURL URLWithString:self.webUrlStr]];
    // 3.加载网页
    [webView loadRequest:request];
    webView.userInteractionEnabled = YES;
    webView.scrollView.scrollEnabled = YES;
    webView.delegate = self;
    webView.backgroundColor = [UIColor whiteColor];
    // 最后将webView添加到界面
    [self.view addSubview:webView];
}

- (void)webViewDidStartLoad:(UIWebView *)webView{
//    LOADING
    SLog(@"加载中");
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
//    STOP_LOADING
    SLog(@"加载结束");
    NSString *str = [USER_DEFAULT objectForKey:@"LOGIN_SUCCESS"];
    if ([str isEqualToString:@"loginSuccess"]) {
        //创建定时器
        timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(show) userInfo:nil repeats:YES];
        //添加带runloop中,并且设定模式(默认模式,当用户进行交互的时候,定时器会停止工作)
        [[NSRunLoop currentRunLoop] addTimer:timer forMode:UITrackingRunLoopMode];
        //设置结束时间
        [self performSelector:@selector(stopcount) withObject:nil afterDelay:5];
    }
    if (webView.isLoading) {
        return;
    }
    
}

-(void)show{
    SLog(@"111");
}

-(void)stopcount{
    if (timer) {
        //结束定时器
        [timer invalidate];
        timer = nil;
        [self updateClacRequest];
    }
    
}

//pragma mark 创建导航栏
-(void)topNavigation{
    UIView * topView = [ViewTools createGradientLayerNav_BarViewWithString:@"资讯"];
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
        //结束定时器
        [timer invalidate];
        timer = nil;
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark ------阅读时长2分钟发送请求
-(void)updateClacRequest{
    NSString *urlStr = [NSString stringWithFormat:@"%@uid=%@&behavior=news",UPDATE_CLOUD_CLAC_URL,USER_ID];
    urlStr = [urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    [YGYBaseViewModel postRequestWithPath:urlStr parameters:nil responseDataModel:[YGYBaseDataModel class] success:^(id responseObject) {
        YGYBaseDataModel *model = responseObject;
        if ([model.status isEqualToString:@"200"]) {
//            MBHUD(@"阅读时长2分钟，无极云力+1")
//            [iToast showMessage:model.msg];
        }else{
//            MBHUD(model.msg);
        }
        
    } failure:^(NSError *error) {
    }];
}
@end
