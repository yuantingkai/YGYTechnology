//
//  CheckProductVC.m
//  YGYTechnology
//
//  Created by 袁庭楷 on 2018/10/11.
//  Copyright © 2018年 YGY. All rights reserved.
//

#import "CheckProductVC.h"

@interface CheckProductVC ()<UIWebViewDelegate>
{
    UIWebView *webView;
}

@end

@implementation CheckProductVC

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self setNav];
    [self creatWebView];
}

-(void)creatWebView{
    // 1.创建webview，并设置大小，"20"为状态栏高度
    webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, kNavHeight, SCREEN_WIDTH, SCREEN_HEIGHT -kNavHeight)];
    // 2.创建请求
    NSMutableURLRequest *request =[NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BASEURL,@"/resources/product/index.html"]]];
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
    SLog(@"加载中");
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    SLog(@"加载结束");
}


-(void)setNav{
    UIView * topView = [ViewTools createGradientLayerNav_BarViewWithString:@"产品合约"];
    [self.view addSubview:topView];
    
    UIButton *returnTopBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [returnTopBtn setImage:[UIImage imageNamed:@"leftArrow"] forState:UIControlStateNormal];
    [returnTopBtn sizeToFit];
    returnTopBtn.expandHitEdgeInsets = UIEdgeInsetsMake(15, 15, 15, 15);
    [returnTopBtn addTarget:self action:@selector(returnTopVC) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:returnTopBtn];
    [returnTopBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(12);
        make.bottom.mas_offset(kNavControlImgBottom);
    }];
}

-(void)returnTopVC {
    [self.navigationController popViewControllerAnimated:YES];
}


@end
