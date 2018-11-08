//
//  ActivityView.m
//  YGYTechnology
//
//  Created by 袁庭楷 on 2018/10/4.
//  Copyright © 2018年 YGY. All rights reserved.
//

#import "ActivityView.h"

@implementation ActivityView

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
    backView.backgroundColor = [UIColor whiteColor];
    backView.layer.cornerRadius = 8;
    [self addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(14);
        make.right.offset(-14);
        make.bottom.offset(-30);
        make.height.mas_offset(300);
    }];
    
    UIView *topView = [UIView new];
    [backView addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.offset(0);
        make.height.mas_offset(50);
    }];
    
    UILabel *topLabel = [UILabel newWithText:@"活动说明" fontSize:15 textColor:MAIN_BODY textAlignment:NSTextAlignmentLeft];
    [topView addSubview:topLabel];
    [topLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15);
        make.centerY.equalTo(topView);
    }];
    
    UIButton *cancelBtn = [UIButton newWithTitle:@"" font:14 textColor:nil textAlignment:NSTextAlignmentCenter Image:[UIImage imageNamed:@"guanbi"]];
    [cancelBtn addTarget:self action:@selector(cancelBtn:) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:cancelBtn];
    [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-15);
        make.centerY.equalTo(topView);
    }];
    
    UIView *topLine = [UIView new];
    topLine.backgroundColor = LINE_COLOR;
    [topView addSubview:topLine];
    [topLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.right.offset(-10);
        make.height.mas_offset(1);
        make.bottom.offset(0);
    }];
    
    UILabel *oneLabel = [UILabel newWithText:@"1.邀请好友注册，成功注册即挖SDT。" fontSize:13 textColor:Color(0x999999) textAlignment:NSTextAlignmentLeft];
    [backView addSubview:oneLabel];
    oneLabel.numberOfLines = 0;
    [oneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15);
        make.right.offset(-15);
        make.top.equalTo(topLine.mas_bottom).offset(20);
    }];
    
    UILabel *twoLabel = [UILabel newWithText:@"2.邀请好友注册，成功注册即挖SDT，邀请第一个好友挖1SDT，邀请第二个好友挖矿2枚SDT，邀请N个好友挖矿N枚SDT，直至第100名好友位置，后续将保持为100SDT奖励。" fontSize:13 textColor:Color(0x999999) textAlignment:NSTextAlignmentLeft];
    [backView addSubview:twoLabel];
    [twoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15);
        make.right.offset(-15);
        make.top.equalTo(oneLabel.mas_bottom).offset(20);
    }];
    
    
    UILabel *threeLabel = [UILabel newWithText:@"3.邀请好友注册，成功注册即挖SDT，挖矿收益数列递增，无限可能。" fontSize:13 textColor:Color(0x999999) textAlignment:NSTextAlignmentLeft];
    [backView addSubview:threeLabel];
    [threeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15);
        make.right.offset(-15);
        make.top.equalTo(twoLabel.mas_bottom).offset(20);
    }];
    
    UIButton *OKBtn = [UIButton newWithTitle:@"确定" font:14 textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter Image:nil];
    OKBtn.layer.cornerRadius = 25;
    [OKBtn setBackgroundColor:[UIColor blueColor]];
    [OKBtn addTarget:self action:@selector(OKBtn:) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:OKBtn];
    [OKBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-25);
        make.left.offset(25);
        make.bottom.offset(-20);
        make.height.mas_offset(50);
    }];
}

-(void)cancelBtn:(UIButton *)sender{
    self.cancelBtn(sender);
}

-(void)OKBtn:(UIButton *)sender{
    self.OKBtn(sender);
}

@end
