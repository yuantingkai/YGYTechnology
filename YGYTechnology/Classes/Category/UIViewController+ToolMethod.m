//
//  UIViewController+ToolMethod.m
//  ConsultAPP
//
//  Created by StormVCC on 2017/10/12.
//  Copyright © 2017年 WD. All rights reserved.
//
#import "UIViewController+ToolMethod.h"
#define kNavControlTitleBottom -10
@implementation UIViewController (ToolMethod)
- (void)backToSuperiorVc {
    if (self.navigationController.viewControllers.count > 0 && [self.navigationController.viewControllers indexOfObject:self] >= 1) {
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        [self.navigationController dismissViewControllerAnimated:YES completion:NULL];
    }
}

- (UIView *)newWhiteBgBlackTitleNavBar:(NSString *)title action:(SEL)action {
    UIView *topView = [self newWhiteBgBlackTitleNavBar:title];
    
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setImage:[UIImage imageNamed:@"icon_backarrow"] forState:UIControlStateNormal];
    [leftBtn sizeToFit];
    leftBtn.expandHitEdgeInsets = UIEdgeInsetsMake(20, 20, 15, 20);
    [leftBtn addTarget:self action:action ? action : @selector(backToSuperiorVc) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:leftBtn];
    leftBtn.tag = 0x550;
    [leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(14);
        make.bottom.mas_offset(kNavControlImgBottom);
        make.width.mas_offset(30);
    }];
    
    return topView;
}

- (UIView *)newWhiteBgBlackTitleNavBar:(NSString *)title {
    UIView *topView = [UIView new];
    topView.backgroundColor = [UIColor whiteColor];
    topView.userInteractionEnabled=YES;
    [self.view addSubview:topView];
    topView.tag = 0x441;
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_offset(0);
        make.height.mas_offset(kNavHeight);
    }];
    
    UILabel *topLb = [UILabel new];
    topLb.font = YGYFont(18.f);
    topLb.textColor = MAIN_BODY;
    topLb.text = title;
    [topView addSubview:topLb];
    [topLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_offset(0);
        make.bottom.mas_offset(kNavControlTitleBottom);
    }];
    topLb.tag = 0x440;
    
    UIView *bottomLineView = [UIView new];
    bottomLineView.backgroundColor = [UIColorFromRGB(0xa8b0bf) colorWithAlphaComponent:0.5];
    bottomLineView.tag = 0x442;
    [topView addSubview:bottomLineView];
    [bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.mas_offset(0);
        make.height.mas_equalTo(1);
    }];
    
    return topView;
}


- (UIView *)newWhiteBgBlackTitleNavBarNoLine:(NSString *)title {
    UIView *topView = [UIView new];
    topView.backgroundColor = [UIColor whiteColor];
    topView.userInteractionEnabled=YES;
    [self.view addSubview:topView];
    topView.tag = 0x441;
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_offset(0);
        make.height.mas_offset(kNavHeight);
    }];
    
    UILabel *topLb = [UILabel new];
    topLb.font = YGYFont(18.f);
    topLb.textColor = MAIN_BODY;
    topLb.text = title;
    [topView addSubview:topLb];
    [topLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_offset(0);
        make.bottom.mas_offset(kNavControlTitleBottom);
    }];
    topLb.tag = 0x440;
    
//    UIView *bottomLineView = [UIView new];
//    bottomLineView.backgroundColor = [UIColorFromRGB(0xa8b0bf) colorWithAlphaComponent:0.5];
//    bottomLineView.tag = 0x442;
//    [topView addSubview:bottomLineView];
//    [bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.left.right.mas_offset(0);
//        make.height.mas_equalTo(1);
//    }];
    
    return topView;
}


@end
