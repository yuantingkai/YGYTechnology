//
//  MarketTableViewCell.m
//  YGYTechnology
//
//  Created by 袁庭楷 on 2018/10/30.
//  Copyright © 2018年 YGY. All rights reserved.
//

#import "MarketTableViewCell.h"

@implementation MarketTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor  = [UIColor clearColor];
        [self setUI];
    }
    return self;
}

-(void)setUI{
    UIView *backGroundView = [UIView new];
    backGroundView.backgroundColor = [UIColor whiteColor];
    backGroundView.layer.cornerRadius = 10;
    [self addSubview:backGroundView];
    [backGroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(10);
        make.left.offset(12);
        make.right.offset(-12);
        make.bottom.offset(-10);
    }];
    
    UILabel *btcLabel = [UILabel newWithText:@"BTC" fontSize:16 textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter];
    btcLabel.backgroundColor = Color(0xff5c00);
    btcLabel.layer.cornerRadius = 11;
    btcLabel.layer.masksToBounds = YES;
    [backGroundView addSubview:btcLabel];
    [btcLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(20);
        make.left.offset(12);
        make.height.mas_offset(22);
        make.width.mas_offset(47);
    }];
    
    self.btcLocationMoneyLabel = [UILabel newWithText:@"￥127277.60" fontSize:20 textColor:MAIN_BODY textAlignment:NSTextAlignmentLeft];
    self.btcLocationMoneyLabel.font = BoldFont(20);
    [backGroundView addSubview:self.btcLocationMoneyLabel];
    [self.btcLocationMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(12);
        make.top.equalTo(btcLabel.mas_bottom).offset(9);
    }];
    
    self.dropLabel = [UILabel newWithText:@"-0.13%" fontSize:12 textColor:Color(0xff5c00) textAlignment:NSTextAlignmentLeft];
    [backGroundView addSubview:self.dropLabel];
    [self.dropLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(12);
        make.top.equalTo(self.btcLocationMoneyLabel.mas_bottom).offset(4);
    }];
    
    self.amplificationLabel = [UILabel newWithText:@"+0.13%" fontSize:12 textColor:Color(0x8286fa) textAlignment:NSTextAlignmentLeft];
    [backGroundView addSubview:self.amplificationLabel];
    [self.amplificationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.dropLabel.mas_right).offset(12);
        make.centerY.equalTo(self.dropLabel);
    }];
    
    self.averageRateLabel = [UILabel newWithText:@"￥127277.60" fontSize:12 textColor:MAIN_BODY textAlignment:NSTextAlignmentRight];
    [backGroundView addSubview:self.averageRateLabel];
    [self.averageRateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-12);
        make.top.offset(20);
    }];
    
    UILabel *showAverageRateLabel = [UILabel newWithText:@"(24h)成交额" fontSize:12 textColor:SECOND_BODY textAlignment:NSTextAlignmentRight];
    [backGroundView addSubview:showAverageRateLabel];
    [showAverageRateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.averageRateLabel.mas_left).offset(-6);
        make.centerY.equalTo(self.averageRateLabel);
    }];
    
    self.highestRateLabel = [UILabel newWithText:@"￥127277.60" fontSize:12 textColor:MAIN_BODY textAlignment:NSTextAlignmentRight];
    [backGroundView addSubview:self.highestRateLabel];
    [self.highestRateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-12);
        make.top.equalTo(self.averageRateLabel.mas_bottom).offset(15);
    }];
    
    UILabel *showHighestRateLabel = [UILabel newWithText:@"(24h)最高" fontSize:12 textColor:SECOND_BODY textAlignment:NSTextAlignmentRight];
    [backGroundView addSubview:showHighestRateLabel];
    [showHighestRateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.highestRateLabel.mas_left).offset(-6);
        make.centerY.equalTo(self.highestRateLabel);
    }];
    
    self.lowestRateLabel = [UILabel newWithText:@"￥127277.60" fontSize:12 textColor:MAIN_BODY textAlignment:NSTextAlignmentRight];
    [backGroundView addSubview:self.lowestRateLabel];
    [self.lowestRateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-12);
        make.top.equalTo(self.highestRateLabel.mas_bottom).offset(15);
    }];
    
    UILabel *showLowestRateLabel = [UILabel newWithText:@"(24h)最低" fontSize:12 textColor:SECOND_BODY textAlignment:NSTextAlignmentRight];
    [backGroundView addSubview:showLowestRateLabel];
    [showLowestRateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.lowestRateLabel.mas_left).offset(-6);
        make.centerY.equalTo(self.lowestRateLabel);
    }];
    
    UIImageView *partingLine = [UIImageView new];
    [partingLine setImage:[UIImage imageNamed:@"fengexian"]];
    [backGroundView addSubview:partingLine];
    [partingLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.equalTo(self.dropLabel.mas_bottom).offset(25);
    }];
    
    UIView *leftView = [UIView new];
    [backGroundView addSubview:leftView];
    [leftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.top.equalTo(partingLine.mas_bottom).offset(20);
        make.width.mas_offset(SCREEN_WIDTH/2 - 12);
        make.height.mas_offset(50);
    }];
    
    self.tendencyBtn = [UIButton newWithTitle:@"趋势" font:14 textColor:CLICK_BODY textAlignment:NSTextAlignmentCenter Image:nil];
    [self.tendencyBtn addTarget:self action:@selector(clickTendencyBtn:) forControlEvents:UIControlEventTouchUpInside];
    [leftView addSubview:self.tendencyBtn];
    [self.tendencyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(leftView);
        make.centerX.equalTo(leftView);
    }];
    
    UIView *rightView = [UIView new];
    [backGroundView addSubview:rightView];
    [rightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(0);
        make.top.equalTo(partingLine.mas_bottom).offset(20);
        make.width.mas_offset(SCREEN_WIDTH/2 - 12);
        make.height.mas_offset(50);
    }];
    
    self.kLineBtn = [UIButton newWithTitle:@"K线" font:14 textColor:MAIN_BODY textAlignment:NSTextAlignmentCenter Image:nil];
    [self.kLineBtn addTarget:self action:@selector(clickKLineBtn:) forControlEvents:UIControlEventTouchUpInside];
    [rightView addSubview:self.kLineBtn];
    [self.kLineBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(rightView);
        make.centerX.equalTo(rightView);
    }];
    
    self.collectionView = [UIView new];
    [backGroundView addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.equalTo(leftView.mas_bottom).offset(0);
        make.height.mas_offset(42);
    }];
    
    UIView *topLine = [UIView new];
    topLine.backgroundColor = LINE_COLOR;
    [backGroundView addSubview:topLine];
    [topLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(leftView.mas_bottom).offset(0);
        make.height.mas_offset(1);
        make.left.offset(10);
        make.right.offset(-10);
    }];
    
    UIView *bottomLine = [UIView new];
    bottomLine.backgroundColor = LINE_COLOR;
    [backGroundView addSubview:bottomLine];
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topLine.mas_bottom).offset(42);
        make.height.mas_offset(1);
        make.left.offset(10);
        make.right.offset(-10);
    }];
    
    self.showLineChartView = [UIView new];
    self.showLineChartView.backgroundColor = [UIColor clearColor];
    [backGroundView addSubview:self.showLineChartView];
    [self.showLineChartView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bottomLine.mas_bottom).offset(0);
        make.left.right.bottom.offset(0);
    }];
}

-(void)clickTendencyBtn:(UIButton *)sender{
    [self.tendencyBtn setTitleColor:CLICK_BODY forState:UIControlStateNormal];
    [self.kLineBtn setTitleColor:MAIN_BODY forState:UIControlStateNormal];
}

-(void)clickKLineBtn:(UIButton *)sender{
//    [self.tendencyBtn setTitleColor:MAIN_BODY forState:UIControlStateNormal];
//    [self.kLineBtn setTitleColor:CLICK_BODY forState:UIControlStateNormal];
}

@end
