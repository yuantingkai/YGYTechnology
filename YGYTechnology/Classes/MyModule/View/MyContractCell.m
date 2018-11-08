//
//  MyContractCell.m
//  YGYTechnology
//
//  Created by 袁庭楷 on 2018/10/9.
//  Copyright © 2018年 YGY. All rights reserved.
//

#import "MyContractCell.h"

@implementation MyContractCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self setUI];
    }
    return self;
}

-(void)setUI{
    UIView *backView = [UIView new];
    backView.layer.cornerRadius = 8;
    backView.backgroundColor = [UIColor whiteColor];
    [self addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(12);
        make.right.offset(-12);
        make.top.bottom.offset(0);
    }];
    
    self.leftImageView = [UIImageView new];
    self.leftImageView.layer.cornerRadius = 8;
    self.leftImageView.userInteractionEnabled = YES;
    [backView addSubview:self.leftImageView];
    [self.leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_offset(100);
        make.left.top.offset(10);
    }];
    
    self.titleLabel = [UILabel newWithText:@"bbbbbbbbb" fontSize:14 textColor:MAIN_BODY textAlignment:NSTextAlignmentLeft];
    [backView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(10);
        make.left.equalTo(self.leftImageView.mas_right).offset(18);
    }];
    
    UILabel *showDealTime = [UILabel newWithText:@"交易时间：" fontSize:11 textColor:SECOND_BODY textAlignment:NSTextAlignmentLeft];
    [backView addSubview:showDealTime];
    [showDealTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.leftImageView.mas_right).offset(18);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(2);
    }];
    
    self.dealTimeLabel = [UILabel newWithText:@"2018.10.08 9:18" fontSize:11 textColor:SECOND_BODY textAlignment:NSTextAlignmentLeft];
    [backView addSubview:self.dealTimeLabel];
    [self.dealTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(showDealTime.mas_right).offset(2);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(2);
    }];
    
    
    
    UILabel *showDealNum = [UILabel newWithText:@"数量：" fontSize:11 textColor:SECOND_BODY textAlignment:NSTextAlignmentLeft];
    [backView addSubview:showDealNum];
    [showDealNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.leftImageView.mas_right).offset(18);
        make.top.equalTo(showDealTime.mas_bottom).offset(2);
    }];
    
    
    self.dealNumLabel = [UILabel newWithText:@"1" fontSize:11 textColor:SECOND_BODY textAlignment:NSTextAlignmentLeft];
    [backView addSubview:self.dealNumLabel];
    [self.dealNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(showDealNum.mas_right).offset(2);
        make.top.equalTo(showDealTime.mas_bottom).offset(2);
    }];
    
    
    UILabel *showDealStatus = [UILabel newWithText:@"状态：" fontSize:11 textColor:NO_CLICK_BODY textAlignment:NSTextAlignmentLeft];
    [backView addSubview:showDealStatus];
    [showDealStatus mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.leftImageView.mas_right).offset(18);
        make.top.equalTo(showDealNum.mas_bottom).offset(2);
    }];
    
    
    self.dealStatusLabel = [UILabel newWithText:@"未支付" fontSize:11 textColor:NO_CLICK_BODY textAlignment:NSTextAlignmentLeft];
    [backView addSubview:self.dealStatusLabel];
    [self.dealStatusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(showDealStatus.mas_right).offset(2);
        make.top.equalTo(showDealNum.mas_bottom).offset(2);
    }];
    
    
    self.showDealMoney = [UILabel newWithText:@"应付：" fontSize:11 textColor:Color(0xED7633) textAlignment:NSTextAlignmentLeft];
    [backView addSubview:self.showDealMoney];
    [self.showDealMoney mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.leftImageView.mas_right).offset(18);
        make.top.equalTo(showDealStatus.mas_bottom).offset(7);
    }];
    
    
    self.dealMoenyLabel = [UILabel newWithText:@"￥17500.0" fontSize:16 textColor:Color(0xED7633) textAlignment:NSTextAlignmentLeft];
    [backView addSubview:self.dealMoenyLabel];
    [self.dealMoenyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.showDealMoney.mas_right).offset(2);
        make.top.equalTo(showDealStatus.mas_bottom).offset(3);
    }];
    
    UILabel *showCNY = [UILabel newWithText:@"CNY" fontSize:12 textColor:Color(0xED7633) textAlignment:NSTextAlignmentLeft];
    [backView addSubview:showCNY];
    [showCNY mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.dealMoenyLabel.mas_right).offset(0);
        make.bottom.equalTo(self.dealMoenyLabel.mas_bottom);
    }];
    
    
    UIView *lineView = [UIView new];
    lineView.backgroundColor = LINE_COLOR;
    [backView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_offset(1);
        make.left.offset(10);
        make.right.offset(-10);
        make.top.equalTo(self.leftImageView.mas_bottom).offset(10);
    }];
    
    UIView *bottomView = [UIView new];
    [backView addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView.mas_bottom).offset(0);
        make.left.right.bottom.offset(0);
    }];
    
    self.moreBtn = [UIButton newWithTitle:@"更多>" font:12 textColor:NO_CLICK_BODY textAlignment:NSTextAlignmentCenter Image:nil];
    [self.moreBtn addTarget:self action:@selector(moreBtn:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:self.moreBtn];
    [self.moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(bottomView);
        make.right.offset(-10);
    }];
    
    self.cancelBtn = [UIButton newWithTitle:@"取消订单" font:12 textColor:NO_CLICK_BODY textAlignment:NSTextAlignmentCenter Image:nil];
    self.cancelBtn.hidden = NO;
    self.cancelBtn.layer.cornerRadius = 5;
    [self.cancelBtn.layer setBorderColor:NO_CLICK_BODY.CGColor];
    [self.cancelBtn.layer setBorderWidth:1];
    [self.cancelBtn.layer setMasksToBounds:YES];
    [self.cancelBtn addTarget:self action:@selector(cancelBtn:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:self.cancelBtn];
    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(bottomView);
        make.right.equalTo(self.moreBtn.mas_left).offset(-10);
        make.height.mas_offset(24);
        make.width.mas_offset(70);
    }];
    
    self.payBtn = [UIButton newWithTitle:@"立即支付" font:12 textColor:Color(0x8286FA) textAlignment:NSTextAlignmentCenter Image:nil];
    self.payBtn.hidden = NO;
    [self.payBtn setBackgroundImage:[UIImage imageNamed:@"btnGradient"] forState:UIControlStateNormal];
    [self.payBtn addTarget:self action:@selector(payBtn:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:self.payBtn];
    [self.payBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(bottomView);
        make.right.equalTo(self.cancelBtn.mas_left).offset(-10);
        make.height.mas_offset(24);
        make.width.mas_offset(70);
    }];
    
}

-(void)moreBtn:(UIButton *)sender{
    self.Block_moreBtn(sender);
}

-(void)cancelBtn:(UIButton *)sender{
    self.Block_IDStr(_IDStr);
    self.Block_cancelBtn(sender);
}

-(void)payBtn:(UIButton *)sender{
    self.Block_payBtn(sender);
}

-(void)setIndexPath:(NSIndexPath *)indexPath withPageData:(MyContractIndentPageData *)pageData{
    _indexPath = indexPath;
    _pageData = pageData;
    self.payBtn.tag = [_indexPath section];
    self.cancelBtn.tag = [_indexPath section];
    self.moreBtn.tag = [_indexPath section];
    _IDStr = pageData._id;
    MyContractIndentProduct *product = _pageData.product;
    [self.leftImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",product.img]]];
    self.titleLabel.text = product.title;
    NSString *timeStr = [_pageData.generateTime substringFromIndex:11];
    NSString *dateStr = [NSString stringWithFormat:@"%@ %@",[_pageData.generateTime substringToIndex:10],[timeStr substringToIndex:8]];
    self.dealTimeLabel.text = dateStr;
    self.dealNumLabel.text = _pageData.proNumber;
    if ([_pageData.payStatus isEqualToString:@"0"]) {
        self.showDealMoney.text = @"应付";
        self.dealStatusLabel.text = @"未支付";
        self.cancelBtn.hidden = NO;
        self.payBtn.hidden = NO;
    }else if ([_pageData.payStatus isEqualToString:@"2"]){
        self.showDealMoney.text = @"已付";
        self.dealStatusLabel.text = @"已支付";
        if ([_pageData.status isEqualToString:@"1"]) {
            self.dealStatusLabel.text = @"已支付:尚未处理";
            self.payBtn.hidden = YES;
        }else if ([_pageData.status isEqualToString:@"2"]){
            self.dealStatusLabel.text = @"已支付:正在采购";
            self.payBtn.hidden = YES;
        }else if ([_pageData.status isEqualToString:@"3"]){
            self.dealStatusLabel.text = @"已支付:正在部署";
            self.payBtn.hidden = YES;
        }else if ([_pageData.status isEqualToString:@"4"]){
            self.dealStatusLabel.text = @"已支付:正在运行";
            self.payBtn.hidden = YES;
        }else if ([_pageData.status isEqualToString:@"5"]){
            self.dealStatusLabel.text = @"已支付:停机维护";
            self.payBtn.hidden = YES;
        }
        self.cancelBtn.hidden = YES;
        
    }
    
    
    self.dealMoenyLabel.text = [NSString stringWithFormat:@"%.2f",[_pageData.sumPrice doubleValue]];
}
@end
