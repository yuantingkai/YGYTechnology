//
//  MyBottomTableViewCell.m
//  YGYTechnology
//
//  Created by 袁庭楷 on 2018/9/28.
//  Copyright © 2018年 YGY. All rights reserved.
//

#import "MyBottomTableViewCell.h"

@implementation MyBottomTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor  = [UIColor clearColor];
        _iconImageArr = @[@"invite",@"Eco-Partner",@"Groud",@"income",@"contract",@"Security center"];
        _nameArr = @[@"邀请挖矿",@"生态合伙人",@"星际存储",@"我的收益",@"我的合约",@"安全中心"];
        [self setUI];
    }
    return self;
}

-(void)setUI{
    self.backgroView = [[UIView alloc]initWithFrame:CGRectMake(12, 0, SCREEN_WIDTH - 24, 48)];
    self.backgroView.backgroundColor = [UIColor whiteColor];
//    self.backgroView.layer.masksToBounds =YES;
//    self.backgroView.layer.cornerRadius = 0;
    [self addSubview:self.backgroView];
//    [self.backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.offset(15);
//        make.right.offset(-15);
//        make.top.bottom.offset(0);
//    }];
    
    _leftImageView = [UIImageView new];
    [self.backgroView addSubview:_leftImageView];
    [_leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.centerY.equalTo(self.backgroView);
        make.width.height.mas_offset(24);
    }];
    
    _centerLabel = [UILabel newWithText:@"" fontSize:14 textColor:MAIN_BODY textAlignment:NSTextAlignmentLeft];
    [self.backgroView addSubview:_centerLabel];
    [_centerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.leftImageView.mas_right).offset(10);
        make.centerY.equalTo(self.backgroView);
    }];
    
    _rightImageView = [UIImageView new];
    [_rightImageView setImage:[UIImage imageNamed:@"rightArrow"]];
    [self.backgroView addSubview:_rightImageView];
    [_rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.backgroView).offset(-10);
        make.centerY.equalTo(self.backgroView);
//        make.width.height.mas_offset(24);
    }];
    
    _lineView = [UIView new];
    _lineView.backgroundColor = LINE_COLOR;
    _lineView.hidden = YES;
    [self.backgroView addSubview:_lineView];
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_offset(1);
        make.bottom.offset(0);
        make.right.offset(0);
        make.left.offset(5);
    }];
}


-(void)setIndexPath:(NSIndexPath *)indexPath{
    _indexPath = indexPath;
    if (_indexPath.section == 1) {
        self.backgroView.layer.cornerRadius = 8;
        [_leftImageView setImage:[UIImage imageNamed:_iconImageArr[0]]];
        _centerLabel.text = _nameArr[0];
    }else if (_indexPath.section == 2){
        if (_indexPath.row == 0) {
             _lineView.hidden = NO;
            [self topCornerRadiusView:self.backgroView];
            [_leftImageView setImage:[UIImage imageNamed:_iconImageArr[1]]];
            _centerLabel.text = _nameArr[1];
        }else if(_indexPath.row == 1){
            [self bottomCornerRadiusView:self.backgroView];
            [_leftImageView setImage:[UIImage imageNamed:_iconImageArr[2]]];
            _centerLabel.text = _nameArr[2];
        }
    }else if (_indexPath.section == 3){
        if (_indexPath.row == 0) {
            [self topCornerRadiusView:self.backgroView];
             _lineView.hidden = NO;
            [_leftImageView setImage:[UIImage imageNamed:_iconImageArr[3]]];
            _centerLabel.text = _nameArr[3];
        }else if (_indexPath.row == 1){
//             _lineView.hidden = NO;
            [self bottomCornerRadiusView:self.backgroView];
            [_leftImageView setImage:[UIImage imageNamed:_iconImageArr[4]]];
            _centerLabel.text = _nameArr[4];
        }
    }else if (_indexPath.section == 4){
        self.backgroView.layer.cornerRadius = 8;
        [_leftImageView setImage:[UIImage imageNamed:_iconImageArr[5]]];
        _centerLabel.text = _nameArr[5];
    }
}

-(void)topCornerRadiusView:(UIView *)cornerRadiusView{
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:cornerRadiusView.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(8, 8)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = cornerRadiusView.bounds;
    maskLayer.path = maskPath.CGPath;
    cornerRadiusView.layer.mask = maskLayer;
}

-(void)bottomCornerRadiusView:(UIView *)cornerRadiusView{
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:cornerRadiusView.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(8, 8)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = cornerRadiusView.bounds;
    maskLayer.path = maskPath.CGPath;
    cornerRadiusView.layer.mask = maskLayer;
}
@end
