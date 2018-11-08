//
//  ShoppingMallCell.m
//  YGYTechnology
//
//  Created by 袁庭楷 on 2018/11/2.
//  Copyright © 2018年 YGY. All rights reserved.
//

#import "ShoppingMallCell.h"

@implementation ShoppingMallCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor  = [UIColor clearColor];
        [self setUI];
    }
    return self;
}

-(void)setUI{
    //sdt dingdan
    self.topView = [[UIView alloc]initWithFrame:CGRectMake(12, 0, SCREEN_WIDTH - 24, 52)];;
    self.topView.backgroundColor = [UIColor whiteColor];
    self.topView.layer.cornerRadius = 5;
    [self addSubview:self.topView];
    
    UIView *lineView = [UIView new];
    lineView.backgroundColor = LINE_COLOR;
    [self.topView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_offset(1);
        make.centerX.equalTo(self.topView);
        make.top.offset(10);
        make.bottom.offset(-10);
    }];
    
    UIImageView *leftImageView = [UIImageView new];
    [leftImageView setImage:[UIImage imageNamed:@"sdt"]];
    [self.topView addSubview:leftImageView];
    [leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(36);
        make.centerY.equalTo(self.topView);
        make.height.width.mas_offset(32);
    }];
    
    UILabel *sdtLabel = [UILabel newWithText:@"SDT" fontSize:12 textColor:MAIN_BODY textAlignment:NSTextAlignmentLeft];
    [self.topView addSubview:sdtLabel];
    [sdtLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.topView);
        make.left.equalTo(leftImageView.mas_right).offset(10);
    }];
    
    self.sdtNumLabel = [UILabel newWithText:@"5751" fontSize:12 textColor:CLICK_BODY textAlignment:NSTextAlignmentLeft];
    [self.topView addSubview:self.sdtNumLabel];
    [self.sdtNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.topView);
        make.left.equalTo(sdtLabel.mas_right).offset(10);
    }];
    
    UIImageView *rightImageView = [UIImageView new];
    [rightImageView setImage:[UIImage imageNamed:@"dingdan"]];
    [self.topView addSubview:rightImageView];
    [rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lineView.mas_right).offset(36);
        make.centerY.equalTo(self.topView);
        make.height.width.mas_offset(32);
    }];
    
    UILabel *indentLabel = [UILabel newWithText:@"我的订单" fontSize:12 textColor:MAIN_BODY textAlignment:NSTextAlignmentLeft];
    [self.topView addSubview:indentLabel];
    [indentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.topView);
        make.left.equalTo(rightImageView.mas_right).offset(10);
    }];
    
    
    self.bottomView = [[UIView alloc]initWithFrame:CGRectMake(12, 0, SCREEN_WIDTH - 24, 105)];;
    self.bottomView.backgroundColor = [UIColor whiteColor];
//    self.bottomView.layer.cornerRadius = 5;
    [self addSubview:self.bottomView];
    
    self.bottomLine = [UIView new];
    self.bottomLine.hidden = NO;
    self.bottomLine.backgroundColor = LINE_COLOR;
    [self.bottomView addSubview:self.bottomLine];
    [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_offset(1);
        make.left.offset(10);
        make.right.offset(-10);
        make.bottom.offset(0);
    }];
    
    UIImageView *goodsImageView = [UIImageView new];
    goodsImageView.backgroundColor = [UIColor greenColor];
    goodsImageView.layer.cornerRadius = 5;
    [self.bottomView addSubview:goodsImageView];
    [goodsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.height.mas_offset(85);
        make.width.mas_offset(95);
        make.centerY.equalTo(self.bottomView);
    }];
    
    UILabel *goodsNumLabel = [UILabel newWithText:@"苹果iPhone X128G 全网通手机" fontSize:14 textColor:MAIN_BODY textAlignment:NSTextAlignmentLeft];
    [self.bottomView addSubview:goodsNumLabel];
    [goodsNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(goodsImageView.mas_right).offset(15);
        make.top.offset(20);
    }];
    
    UILabel *goodsMoneyLabel = [UILabel newWithText:@"原价：7888.00" fontSize:12 textColor:SECOND_BODY textAlignment:NSTextAlignmentLeft];
    [self.bottomView addSubview:goodsMoneyLabel];
    [goodsMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(goodsImageView.mas_right).offset(15);
        make.top.equalTo(goodsNumLabel.mas_bottom).offset(10);
    }];
    
    UIImageView *iconImageView = [UIImageView new];
    [iconImageView setImage:[UIImage imageNamed:@"sdt-1"]];
    [self.bottomView addSubview:iconImageView];
    [iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(goodsImageView.mas_right).offset(15);
        make.height.width.mas_offset(10);
        make.bottom.offset(-20);
    }];
    
    UILabel *sdtScoreLabel = [UILabel newWithText:@"1000" fontSize:14 textColor:ORANGE_BODY textAlignment:NSTextAlignmentLeft];
    [self.bottomView addSubview:sdtScoreLabel];
    [sdtScoreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(iconImageView.mas_right).offset(4);
        make.centerY.equalTo(iconImageView);
    }];
    
    UILabel *symbolLabel = [UILabel newWithText:@"+ ￥" fontSize:10 textColor:ORANGE_BODY textAlignment:NSTextAlignmentLeft];
    [self.bottomView addSubview:symbolLabel];
    [symbolLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(sdtScoreLabel.mas_right).offset(4);
        make.centerY.equalTo(iconImageView);
    }];
    
    UILabel *discountsPriceLabel = [UILabel newWithText:@"6800.00" fontSize:14 textColor:ORANGE_BODY textAlignment:NSTextAlignmentLeft];
    [self.bottomView addSubview:discountsPriceLabel];
    [discountsPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(symbolLabel.mas_right).offset(0);
        make.centerY.equalTo(iconImageView);
    }];
}

-(void)setIndexPath:(NSIndexPath *)indexPath{
    _indexPath = indexPath;
    if (_indexPath.section == 0) {
        self.topView.hidden = NO;
        self.bottomView.hidden = YES;
    }else if (_indexPath.section == 1){
        self.topView.hidden = YES;
        self.bottomView.hidden = NO;
        if (_indexPath.row == 0) {
            [self topCornerRadiusView:self.bottomView];
        }else if (_indexPath.row == 9){
            self.bottomLine.hidden = YES;
            [self bottomCornerRadiusView:self.bottomView];
        }else{
            self.bottomLine.hidden = NO;
        }
    }
}


-(void)topCornerRadiusView:(UIView *)cornerRadiusView{
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:cornerRadiusView.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(5, 5)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = cornerRadiusView.bounds;
    maskLayer.path = maskPath.CGPath;
    cornerRadiusView.layer.mask = maskLayer;
}

-(void)bottomCornerRadiusView:(UIView *)cornerRadiusView{
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:cornerRadiusView.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(5, 5)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = cornerRadiusView.bounds;
    maskLayer.path = maskPath.CGPath;
    cornerRadiusView.layer.mask = maskLayer;
}
@end
