//
//  RuleStrategyVC.m
//  YGYTechnology
//
//  Created by 袁庭楷 on 2018/10/18.
//  Copyright © 2018年 YGY. All rights reserved.
//

#import "RuleStrategyVC.h"

@interface RuleStrategyVC ()<UIScrollViewDelegate>

@end
@implementation RuleStrategyVC
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //    self.view.backgroundColor = [UIColor whiteColor];
    [self creatNav];
    UIScrollView *scrollView = [UIScrollView new];
    scrollView.alwaysBounceVertical = NO;
    [self.view addSubview:scrollView];
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.offset(0);
        make.top.offset(kNavHeight);
    }];
    UIImageView *imageView = [UIImageView new];
    [imageView setImage:[UIImage imageNamed:@"规则攻略"]];
    [scrollView addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.offset(0);
    }];
}

-(void)creatNav{
    UIView * topView = [ViewTools createGradientLayerNav_BarViewWithString:@"规则攻略"];
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
@end
