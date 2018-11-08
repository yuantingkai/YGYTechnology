//
//  WithdrawDeatilsCell.m
//  YGYTechnology
//
//  Created by 袁庭楷 on 2018/10/18.
//  Copyright © 2018年 YGY. All rights reserved.
//

#import "WithdrawDeatilsCell.h"

@implementation WithdrawDeatilsCell

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
        make.height.mas_offset(48);
    }];
    
    self.dateLabel = [UILabel newWithText:@"2018.10.15" fontSize:11 textColor:SECOND_BODY textAlignment:NSTextAlignmentRight];
    [BackView addSubview:self.dateLabel];
    [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.top.offset(5);
    }];
    
    self.showEarningLabel = [UILabel newWithText:@"提现：" fontSize:12 textColor:MAIN_BODY textAlignment:NSTextAlignmentLeft];
    [BackView addSubview:self.showEarningLabel];
    [self.showEarningLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.top.equalTo(self.dateLabel.mas_bottom).offset(5);
    }];
    
    self.withdrawNum = [UILabel newWithText:@"0.00000000" fontSize:12 textColor:Color(0x8682fa) textAlignment:NSTextAlignmentRight];
    [BackView addSubview:self.withdrawNum];
    [self.withdrawNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.showEarningLabel);
        make.right.offset(-10);
    }];
    
}



-(void)setIndexPath:(NSIndexPath *)indexPath withPageData:(WithdrawDeatilsPageData *)pageData{
    _indexPath = indexPath;
    _pageData = pageData;
    _dateLabel.text = _pageData.generateTime.length >= 10 ? [_pageData.generateTime substringToIndex:10] : _pageData.generateTime;
    
    _withdrawNum.text = [NSString stringWithFormat:@"%.8f",[pageData.btcNumber doubleValue]];
    if ([_pageData.status isEqualToString:@"0"]) {//正在申请
        _showEarningLabel.text = @"正在申请";
    }else if ([_pageData.status isEqualToString:@"1"]) {//审核中
        _showEarningLabel.text = @"审核中";
    }else if ([_pageData.status isEqualToString:@"2"]) {//申请成功
        _showEarningLabel.text = @"申请成功";
    }else if ([_pageData.status isEqualToString:@"3"]) {//申请失败
        _showEarningLabel.text = @"申请失败";
    }
}

@end
