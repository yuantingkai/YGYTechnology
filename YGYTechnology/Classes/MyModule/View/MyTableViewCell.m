//
//  MyTableViewCell.m
//  YGYTechnology
//
//  Created by 袁庭楷 on 2018/9/28.
//  Copyright © 2018年 YGY. All rights reserved.
//

#import "MyTableViewCell.h"

@implementation MyTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
//        self.phoneNumberStr = @"1111";
        self.backgroundColor = [UIColor clearColor];
        [self setUI];
    }
    return self;
}

-(void)setUI{
    //背景图
    _backgroundImageView = [UIImageView new];
    [_backgroundImageView setImage:[UIImage imageNamed:@"touxiangBottomBackGroud"]];
    _backgroundImageView.userInteractionEnabled = YES;
    [self addSubview:_backgroundImageView];
    [_backgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.offset(0);
        make.left.offset(12);
        make.right.offset(-12);
//        make.width.mas_offset(722/2);
//        make.height.mas_offset(380/2);
    }];

    //头像
    _picimageView = [UIImageView new];
    [_picimageView setImage:[UIImage imageNamed:@"touxiang"]];
//    _picImageView.backgroundColor = [UIColor blackColor];
    _picimageView.layer.cornerRadius =71/2;
    _picimageView.layer.masksToBounds = YES;
    _picimageView.userInteractionEnabled = YES;
    [_backgroundImageView addSubview:_picimageView];
    [_picimageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_offset(71);
        make.top.equalTo(self.backgroundImageView).offset(-30);
        make.centerX.equalTo(self.backgroundImageView);
    }];
    
    UIButton *picBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [picBtn addTarget:self action:@selector(clickPic:) forControlEvents:UIControlEventTouchUpInside];
    [_backgroundImageView addSubview:picBtn];
    [picBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_offset(158/2);
        make.top.equalTo(self.backgroundImageView).offset(-15);
        make.centerX.equalTo(self.picimageView);
    }];
    
    _nameLabel = [UILabel newWithText:@"游客" fontSize:16 textColor:[UIColor blackColor] textAlignment:NSTextAlignmentCenter];
    [_backgroundImageView addSubview:_nameLabel];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.backgroundImageView);
        make.top.equalTo(self.picimageView.mas_bottom).offset(7);
    }];
    
    
    _phoneNumberLabel = [UILabel newWithText:@"" fontSize:14 textColor:[UIColor blackColor] textAlignment:NSTextAlignmentCenter];
    [_backgroundImageView addSubview:_phoneNumberLabel];
    [_phoneNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.picimageView);
        make.top.equalTo(self.nameLabel.mas_bottom).offset(7);
    }];
    
    
    UIView *centerLine = [UIView new];
    centerLine.backgroundColor = [UIColor blackColor];
    [_backgroundImageView addSubview:centerLine];
    [centerLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.backgroundImageView);
        make.top.equalTo(self.phoneNumberLabel.mas_bottom).offset(26);
        make.height.mas_offset(32);
        make.width.mas_offset(1);
    }];
    
    UIView *leftView = [UIView new];
    [_backgroundImageView addSubview:leftView];
    [leftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.offset(0);
        make.right.equalTo(centerLine.mas_left).offset(0);
        make.height.mas_offset(68);
    }];
    
    UIImageView *SDTImageView = [UIImageView new];
    [SDTImageView setImage:[UIImage imageNamed:@"ore"]];
    [leftView addSubview:SDTImageView];
    [SDTImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(leftView).offset(-20);
        make.top.equalTo(leftView).offset(10);
    }];
    
    UILabel *SDTLabel = [UILabel newWithText:@"SDT" fontSize:14 textColor:MAIN_BODY textAlignment:NSTextAlignmentLeft];
    [leftView addSubview:SDTLabel];
    [SDTLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(SDTImageView.mas_right).offset(5);
        make.centerY.equalTo(SDTImageView);
    }];
    
    _SDTNumberLabel = [UILabel newWithText:@"" fontSize:16 textColor:SECOND_BODY textAlignment:NSTextAlignmentCenter];
    [leftView addSubview:_SDTNumberLabel];
    [_SDTNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(leftView);
        make.bottom.equalTo(leftView).offset(-20);
    }];
    
    UIView *rightView = [UIView new];
    [_backgroundImageView addSubview:rightView];
    [rightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.offset(0);
        make.left.equalTo(centerLine.mas_right).offset(0);
        make.height.mas_offset(68);
    }];
    
    UIImageView *cloudImageView = [UIImageView new];
    [cloudImageView setImage:[UIImage imageNamed:@"Yunli"]];
    [rightView addSubview:cloudImageView];
    [cloudImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(rightView).offset(-20);
        make.top.equalTo(rightView).offset(10);
    }];
    
    UILabel *cloudLabel = [UILabel newWithText:@"云力" fontSize:14 textColor:MAIN_BODY textAlignment:NSTextAlignmentLeft];
    [rightView addSubview:cloudLabel];
    [cloudLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(cloudImageView.mas_right).offset(5);
        make.centerY.equalTo(cloudImageView);
        
    }];
    
    _cloudNumerLabel = [UILabel newWithText:@"" fontSize:16 textColor:SECOND_BODY textAlignment:NSTextAlignmentCenter];
    [rightView addSubview:_cloudNumerLabel];
    [_cloudNumerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(rightView);
        make.bottom.equalTo(rightView).offset(-20);
    }];
}

-(void)setPicImageView:(NSString *)picImageStr name:(NSString *)name phoneNumberLabel:(NSString *)phoneNumberLabel SDTNumberLabel:(NSString *)SDTNumberLabel cloudNumerLabel:(NSString *)cloudNumerLabel{
    
    if (picImageStr.length > 0) {
        [self.picimageView sd_setImageWithURL:[NSURL URLWithString:picImageStr]];
    }else{
        [self.picimageView setImage:[UIImage imageNamed:@"touxiang"]];
    }
    
    if (name.length > 0) {
        _nameLabel.text = name;
    }else{
        _nameLabel.text = @"有关云用户";
    }
    if (phoneNumberLabel.length > 0) {
        _phoneNumberLabel.text =[NSString stringWithFormat:@"手机号：%@****%@",[phoneNumberLabel substringToIndex:3],[phoneNumberLabel substringFromIndex:7]];
    }else{
        _phoneNumberLabel.text =[NSString stringWithFormat:@"登陆后获取"];
    }
    
    _SDTNumberLabel.text = SDTNumberLabel;
    _cloudNumerLabel.text = cloudNumerLabel;
}

-(void)clickPic:(UIButton *)picBtn{
    self.clickBtn(picBtn);
}
@end
