//
//  PropertyListCell.m
//  YGYTechnology
//
//  Created by 袁庭楷 on 2018/10/11.
//  Copyright © 2018年 YGY. All rights reserved.
//

#import "PropertyListCell.h"

@implementation PropertyListCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self setUI];
    }
    return self;
}

-(void)setUI{
    UIView *backgroudview = [UIView new];
    backgroudview.backgroundColor = [UIColor whiteColor];
    backgroudview.layer.cornerRadius = 8;
    [self addSubview:backgroudview];
    [backgroudview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(12);
        make.right.offset(-12);
        make.top.bottom.offset(0);
    }];
    
    self.iconImageView = [UIImageView new];
//    self.iconImageView.backgroundColor = [UIColor yellowColor];
    [backgroudview addSubview:self.iconImageView];
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_offset(28);
        make.left.offset(10);
        make.top.offset(5);
    }];
    
    self.titleLable = [UILabel newWithText:@"" fontSize:16 textColor:MAIN_BODY textAlignment:NSTextAlignmentLeft];
    [backgroudview addSubview:self.titleLable];
    [self.titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImageView.mas_right).offset(5);
        make.centerY.equalTo(self.iconImageView);
    }];
    
    self.rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.rightBtn.titleLabel.font = Font(10);
    self.rightBtn.layer.cornerRadius = 10;
    [self.rightBtn addTarget:self action:@selector(clickRightBtn:) forControlEvents:UIControlEventTouchUpInside];
    [backgroudview addSubview:self.rightBtn];
    [self.rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-10);
        make.centerY.equalTo(self.iconImageView);
        make.width.mas_offset(50);
        make.height.mas_offset(20);
    }];
    
    UIView *lineView = [UIView new];
    lineView.backgroundColor = LINE_COLOR;
    [backgroudview addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_offset(1);
        make.left.offset(10);
        make.right.offset(-10);
        make.top.equalTo(self.iconImageView.mas_bottom).offset(5);
    }];
    
    UILabel *showRemainingLabel = [UILabel newWithText:@"可用余额：" fontSize:12 textColor:NO_CLICK_BODY textAlignment:NSTextAlignmentLeft];
    [backgroudview addSubview:showRemainingLabel];
    [showRemainingLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.top.equalTo(lineView.mas_bottom).offset(4);
    }];
    
    self.remainingSumLabel = [UILabel newWithText:[NSString stringWithFormat:@"%@BTC",@"0"] fontSize:12 textColor:NO_CLICK_BODY textAlignment:NSTextAlignmentLeft];
    [backgroudview addSubview:self.remainingSumLabel];
    [self.remainingSumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(showRemainingLabel.mas_right).offset(0);
        make.centerY.equalTo(showRemainingLabel);
    }];
    
    UILabel *showfrostLabelLabel = [UILabel newWithText:@"冻结：" fontSize:12 textColor:NO_CLICK_BODY textAlignment:NSTextAlignmentLeft];
    [backgroudview addSubview:showfrostLabelLabel];
    [showfrostLabelLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.top.equalTo(showRemainingLabel.mas_bottom).offset(4);
    }];
    
    self.frostLabel = [UILabel newWithText:[NSString stringWithFormat:@"%@ETH",@"0"] fontSize:12 textColor:NO_CLICK_BODY textAlignment:NSTextAlignmentLeft];
    [backgroudview addSubview:self.frostLabel];
    [self.frostLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(showfrostLabelLabel.mas_right).offset(0);
        make.centerY.equalTo(showfrostLabelLabel);
    }];
    
}

-(void)clickRightBtn:(UIButton *)sender{
    self.getBtnBtn(sender);
}


-(void)setIndexPath:(NSIndexPath *)indexPath withModel:(GetAssetInfoData *)getAssetInfoData{
    _indexPath = indexPath;
    _getAssetInfoData = getAssetInfoData;//数据
    self.rightBtn.tag = indexPath.section;
    self.titleLable.text = self.titleArr[indexPath.section];
    [self.iconImageView setImage:[UIImage imageNamed:self.iconArr[indexPath.section]]];
    if (_indexPath.section == 0) {
        [self.rightBtn setBackgroundColor:Color(0x8286fa)];
        [self.rightBtn setTitle:@"我要提币" forState:UIControlStateNormal];
        [self.rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.remainingSumLabel.text = [NSString stringWithFormat:@"%.8fBTC",[_getAssetInfoData.btcUsable doubleValue]];
        self.frostLabel.text = [NSString stringWithFormat:@"%.8fBTC",[_getAssetInfoData.btcFreeze doubleValue]];
        
    }else if(_indexPath.section == 1){
        [self.rightBtn setBackgroundColor:[UIColor clearColor]];
        [self.rightBtn setTitle:@"敬请期待" forState:UIControlStateNormal];
        [self.rightBtn setTitleColor:Color(0x8286fa) forState:UIControlStateNormal];
        [self.rightBtn.layer setBorderColor:Color(0x8286fa).CGColor];
        [self.rightBtn.layer setBorderWidth:1];
        [self.rightBtn.layer setMasksToBounds:YES];
        self.remainingSumLabel.text = [NSString stringWithFormat:@"%@ETH",@"0"];
        self.frostLabel.text = [NSString stringWithFormat:@"%@ETH",@"0"];
    }else if(_indexPath.section == 2){
        [self.rightBtn setBackgroundColor:[UIColor clearColor]];
        [self.rightBtn setTitle:@"敬请期待" forState:UIControlStateNormal];
        [self.rightBtn setTitleColor:Color(0x8286fa) forState:UIControlStateNormal];
        [self.rightBtn.layer setBorderColor:Color(0x8286fa).CGColor];
        [self.rightBtn.layer setBorderWidth:1];
        [self.rightBtn.layer setMasksToBounds:YES];
        self.remainingSumLabel.text = [NSString stringWithFormat:@"%@FILE",@"0"];
        self.frostLabel.text = [NSString stringWithFormat:@"%@FILE",@"0"];
    }else if(_indexPath.section == 3){
        [self.rightBtn setBackgroundColor:[UIColor clearColor]];
        [self.rightBtn setTitle:@"敬请期待" forState:UIControlStateNormal];
        [self.rightBtn setTitleColor:Color(0x8286fa) forState:UIControlStateNormal];
        [self.rightBtn.layer setBorderColor:Color(0x8286fa).CGColor];
        [self.rightBtn.layer setBorderWidth:1];
        [self.rightBtn.layer setMasksToBounds:YES];
        self.remainingSumLabel.text = [NSString stringWithFormat:@"%.3fSDT",[_getAssetInfoData.sdtUsable doubleValue]];
        self.frostLabel.text = [NSString stringWithFormat:@"%.3fSDT",[_getAssetInfoData.sdtFreeze doubleValue]];
    }
}

-(NSArray *)titleArr{
    if (!_titleArr) {
        _titleArr = @[@"BTC",@"ETH",@"FILE",@"SDT"];
    }
    return _titleArr;
}

-(NSArray *)iconArr{
    if (!_iconArr) {
        _iconArr = @[@"BTC",@"ETH",@"FILE",@"SDTA"];
    }
    return _iconArr;
}
@end
