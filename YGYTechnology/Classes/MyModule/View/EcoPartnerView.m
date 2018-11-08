//
//  EcoPartnerView.m
//  YGYTechnology
//
//  Created by 袁庭楷 on 2018/10/2.
//  Copyright © 2018年 YGY. All rights reserved.
//

#import "EcoPartnerView.h"

@implementation EcoPartnerView

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
    [self addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.offset(0);
    }];
    
    UIView *ecoView = [UIView new];
    [backView addSubview:ecoView];
    [ecoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.offset(0);
        make.height.mas_offset(50);
    }];
    
    UILabel *ecoLabel = [UILabel newWithText:@"生态合伙人申请表" fontSize:15 textColor:MAIN_BODY textAlignment:NSTextAlignmentLeft];
    [ecoView addSubview:ecoLabel];
    [ecoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15);
        make.centerY.equalTo(ecoView);
    }];
    
    UIButton *cancelBtn = [UIButton newWithTitle:@"" font:14 textColor:nil textAlignment:NSTextAlignmentCenter Image:[UIImage imageNamed:@"guanbi"]];
    [cancelBtn addTarget:self action:@selector(cancelBtn:) forControlEvents:UIControlEventTouchUpInside];
    [ecoView addSubview:cancelBtn];
    [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-15);
        make.centerY.equalTo(ecoView);
    }];
    
    UIView *topLine = [UIView new];
    topLine.backgroundColor = LINE_COLOR;
    [ecoView addSubview:topLine];
    [topLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.right.offset(-10);
        make.height.mas_offset(1);
        make.bottom.offset(0);
    }];
    
    UILabel *introLabel = [UILabel newWithText:@"    “有关云”是一家布局区块链全产业平台的高科技公司。旗下事业部包括有关区块链、有关云计算、有关云存储，公司的主营业务包括区块链技术开发、IPFS技术开发、区块链金融、数字资产支付接入v\\shuzi资产云计算中心运营、分布式云储存中心运营。节点合伙人是有关云生态的参与者、建设者、共享者。" fontSize:12 textColor:SECOND_BODY textAlignment:NSTextAlignmentLeft];
    introLabel.numberOfLines = 0;
    [backView addSubview:introLabel];
    [introLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ecoView.mas_bottom).offset(15);
        make.left.offset(15);
        make.right.offset(-15);
    }];
    
    UILabel *litterIntroLabel = [UILabel newWithText:@"成为生态合伙人，只需三步" fontSize:14 textColor:MAIN_BODY textAlignment:NSTextAlignmentCenter];
    [backView addSubview:litterIntroLabel];
    [litterIntroLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(backView);
        make.top.equalTo(introLabel.mas_bottom).offset(15);
    }];
//    Review审批
//    Cooperation合作
//    To apply for 申请
//    diandian_h 点点
    UIImageView *centerImage = [UIImageView new];
    [centerImage setImage:[UIImage imageNamed:@"Review"]];
    [backView addSubview:centerImage];
    [centerImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(litterIntroLabel.mas_bottom).offset(15);
        make.centerX.equalTo(backView);
    }];
    
    UILabel *centerLabel = [UILabel newWithText:@"审批" fontSize:14 textColor:MAIN_BODY textAlignment:NSTextAlignmentCenter];
    [backView addSubview:centerLabel];
    [centerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(centerImage.mas_bottom).offset(10);
        make.centerX.equalTo(centerImage);
    }];
    
    UIImageView *tintImage = [UIImageView new];
    [tintImage setImage:[UIImage imageNamed:@"diandian"]];
    [backView addSubview:tintImage];
    [tintImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(centerImage.mas_left).offset(-10);
        make.centerY.equalTo(centerImage);
    }];
    
    UIImageView *darkImage = [UIImageView new];
    [darkImage setImage:[UIImage imageNamed:@"diandian_h"]];
    [backView addSubview:darkImage];
    [darkImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(centerImage.mas_right).offset(10);
        make.centerY.equalTo(centerImage);
    }];
    
    UIImageView *leftImage = [UIImageView new];
    [leftImage setImage:[UIImage imageNamed:@"Cooperation"]];
    [backView addSubview:leftImage];
    [leftImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(centerImage);
        make.right.equalTo(tintImage.mas_left).offset(-10);
    }];
    
    UILabel *leftLabel = [UILabel newWithText:@"合作" fontSize:14 textColor:MAIN_BODY textAlignment:NSTextAlignmentCenter];
    [backView addSubview:leftLabel];
    [leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(leftImage.mas_bottom).offset(15);
        make.centerX.equalTo(leftImage);
    }];
    
    UIImageView *rightImage = [UIImageView new];
    [rightImage setImage:[UIImage imageNamed:@"To apply for"]];
    [backView addSubview:rightImage];
    [rightImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(darkImage.mas_right).offset(10);;
        make.centerY.equalTo(centerImage);
    }];
    
    UILabel *rightLabel = [UILabel newWithText:@"合作" fontSize:14 textColor:MAIN_BODY textAlignment:NSTextAlignmentCenter];
    [backView addSubview:rightLabel];
    [rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(rightImage.mas_bottom).offset(15);
        make.centerX.equalTo(rightImage);
    }];
    
    
    
    
    
    UIView *applyView = [UIView new];
    CAGradientLayer * gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(__bridge id)[ColorFormatter hex2Color:0x6593fb].CGColor, (__bridge id)[ColorFormatter hex2Color:0xad84f8].CGColor];
    gradientLayer.locations = @[@0.1, @1.0];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1, 0);
    gradientLayer.frame = CGRectMake(0, 0, SCREEN_WIDTH - 80 -20,70);
    gradientLayer.cornerRadius = 8;
    [applyView.layer addSublayer:gradientLayer];
    [backView addSubview:applyView];
    [applyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(40);
        make.right.offset(-40);
//        make.top.equalTo(wxNumLabel.mas_bottom).offset(15);
        make.bottom.offset(-15);
        make.height.mas_offset(70);
    }];
    
    UILabel *ApplyLabel = [UILabel newWithText:@"我要申请" fontSize:16 textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter];
    [applyView addSubview:ApplyLabel];
    [ApplyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(15);
        make.centerX.equalTo(applyView);
    }];
    
    UILabel *copyLabel = [UILabel newWithText:@"复制微信号，并打开微信" fontSize:14 textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter];
    [applyView addSubview:copyLabel];
    [copyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ApplyLabel.mas_bottom).offset(5);
        make.centerX.equalTo(applyView);
    }];
    
    UIButton *jumpWXAPPBtn = [UIButton new];
    [jumpWXAPPBtn addTarget:self action:@selector(jumpWXBtn:) forControlEvents:UIControlEventTouchUpInside];
    [applyView addSubview:jumpWXAPPBtn];
    [jumpWXAPPBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.right.offset(0);
        make.top.offset(0);
        make.bottom.offset(0);
    }];
    
    UILabel *wxNumLabel = [UILabel newWithText:@"Guanyun 2011" fontSize:13 textColor:SECOND_BODY textAlignment:NSTextAlignmentCenter];
    [backView addSubview:wxNumLabel];
    [wxNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(backView);
        make.bottom.equalTo(applyView.mas_top).offset(-20);
    }];
    
    UIImageView *wxImage = [UIImageView new];
    [backView addSubview:wxImage];
    [wxImage setImage:[UIImage imageNamed:@"weixin"]];
    [wxImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(wxNumLabel.mas_left).offset(-5);
        make.centerY.equalTo(wxNumLabel);
    }];
    
    UIView *bottomLine = [UIView new];
    bottomLine.backgroundColor = LINE_COLOR;
    [backView addSubview:bottomLine];
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.right.offset(-10);
        make.height.mas_offset(1);
        make.bottom.equalTo(wxNumLabel.mas_top).offset(-15);
    }];
    
}


-(void)cancelBtn:(UIButton *)sender{
    self.cancelBtn(sender);
    
}


-(void)jumpWXBtn:(UIButton *)sender{
    UIPasteboard *pboard = [UIPasteboard generalPasteboard];
    pboard.string = @"Guanyun2011";
    NSURL * url = [NSURL URLWithString:@"weixin://"];
    BOOL canOpen = [[UIApplication sharedApplication] canOpenURL:url];
    if (canOpen){   //打开微信
        [[UIApplication sharedApplication] openURL:url];
    }else {
        [iToast showMessage:@"未检测到微信"];
    }
}




@end
