//
//  EcoPartnerEarningsCell.m
//  YGYTechnology
//
//  Created by 袁庭楷 on 2018/10/13.
//  Copyright © 2018年 YGY. All rights reserved.
//

#import "EcoPartnerEarningsCell.h"

@implementation EcoPartnerEarningsCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self setUI];
    }
    return self;
}

-(void)setUI{
    UIView *BackView = [UIView new];
    BackView.layer.cornerRadius = 8;
    BackView.backgroundColor = [UIColor whiteColor];
    [self addSubview:BackView];
    [BackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(12);
        make.right.offset(-12);
        make.top.bottom.offset(0);
    }];
    
    self.dateLabel = [UILabel newWithText:@"2018.10.15" fontSize:11 textColor:SECOND_BODY textAlignment:NSTextAlignmentRight];
    [BackView addSubview:self.dateLabel];
    [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.top.offset(5);
    }];
    
    UILabel *showEarningLabel = [UILabel newWithText:@"收益：" fontSize:12 textColor:MAIN_BODY textAlignment:NSTextAlignmentLeft];
    [BackView addSubview:showEarningLabel];
    [showEarningLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.top.equalTo(self.dateLabel.mas_bottom).offset(5);
    }];
    
    self.earningsNum = [UILabel newWithText:@"0.00000000" fontSize:12 textColor:Color(0x8682fa) textAlignment:NSTextAlignmentRight];
    [BackView addSubview:self.earningsNum];
    [self.earningsNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(showEarningLabel);
        make.right.offset(-10);
    }];
    
    UIView *centerView = [UIView new];
    centerView.backgroundColor = [UIColor clearColor];
    [BackView addSubview:centerView];
    [centerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.offset(48);
        make.height.mas_offset(28);
    }];
    
    UIView *lineOneView = [UIView new];
    lineOneView.backgroundColor = Color(0xf5f5f5);
    [centerView addSubview:lineOneView];
    [lineOneView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.right.offset(-10);
        make.height.mas_offset(1);
        make.top.equalTo(centerView.mas_top).offset(0);
    }];
    
    UIView *bottomView = [UIView new];
    bottomView.backgroundColor = [UIColor clearColor];
    [BackView addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.offset(0);
        make.top.equalTo(centerView.mas_bottom).offset(0);
    }];
    
    
    UIView *lineTwoView = [UIView new];
    lineTwoView.backgroundColor = Color(0xf5f5f5);
    [bottomView addSubview:lineTwoView];
    [lineTwoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.right.offset(-10);
        make.height.mas_offset(1);
        make.top.equalTo(centerView.mas_bottom).offset(0);
    }];
    
    UILabel *showelectricExpendLabel = [UILabel newWithText:@"电力支出：" fontSize:12 textColor:MAIN_BODY textAlignment:NSTextAlignmentLeft];
    [centerView addSubview:showelectricExpendLabel];
    [showelectricExpendLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.centerY.equalTo(centerView);
    }];
    
    self.electricExpendNum = [UILabel newWithText:@"0.00000000" fontSize:12 textColor:Color(0x8682fa) textAlignment:NSTextAlignmentRight];
    [centerView addSubview:self.electricExpendNum];
    [self.electricExpendNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(showelectricExpendLabel);
        make.right.offset(-10);
    }];
    
    UILabel *showmaintainExpendLabel = [UILabel newWithText:@"维护支出：" fontSize:12 textColor:MAIN_BODY textAlignment:NSTextAlignmentLeft];
    [bottomView addSubview:showmaintainExpendLabel];
    [showmaintainExpendLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.centerY.equalTo(bottomView);
    }];
    
    self.maintainExpendNum = [UILabel newWithText:@"0.00000000" fontSize:12 textColor:Color(0x8682fa) textAlignment:NSTextAlignmentRight];
    [bottomView addSubview:self.maintainExpendNum];
    [self.maintainExpendNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(showmaintainExpendLabel);
        make.right.offset(-10);
    }];
}



-(void)setIndexPath:(NSIndexPath *)indexPath withPageData:(EcoEarningsPageData *)pageData{
    _indexPath = indexPath;
    _pageData = pageData;
    _dateLabel.text = _pageData.time.length >= 10 ? [_pageData.time substringToIndex:10] : _pageData.time;
    _earningsNum.text = [NSString stringWithFormat:@"%.8f",[pageData.number doubleValue]];
    if (pageData.electricityBtc != nil  || pageData.electricityBtc != NULL) {
        _electricExpendNum.text = [NSString stringWithFormat:@"%.8f",[pageData.electricityBtc doubleValue]];
    }else{
        _electricExpendNum.text = @"0.00000000";
    }
    if (pageData.maintenanceBtc != nil  || pageData.maintenanceBtc != NULL) {
        
        _maintainExpendNum.text = [NSString stringWithFormat:@"%.8f",[pageData.maintenanceBtc doubleValue]];
    }else{
        _maintainExpendNum.text = @"0.00000000";
    }
}
@end
