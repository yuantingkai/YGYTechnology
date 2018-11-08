//
//  securityCenterCell.m
//  YGYTechnology
//
//  Created by 袁庭楷 on 2018/9/29.
//  Copyright © 2018年 YGY. All rights reserved.
//

#import "securityCenterCell.h"

@implementation securityCenterCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.leftArr = @[@"实名认证",@"密码修改",@"资产密码",@"退出当前账号"];
        [self setUI];
    }
    return self;
}

-(void)setUI{
    self.backgroundColor = [UIColor clearColor];
    
    self.backView = [[UIView alloc]initWithFrame:CGRectMake(12, 0, SCREEN_WIDTH - 24, 48)];
    self.backView.backgroundColor = [UIColor whiteColor];
//    self.backView.layer.cornerRadius = 0;
    [self addSubview:self.backView];
//    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.offset(14);
//        make.right.offset(-14);
//        make.top.bottom.offset(0);
//    }];
    
    self.leftLabel = [UILabel newWithText:@"" fontSize:14 textColor:YGYColor(51, 51, 51) textAlignment:NSTextAlignmentLeft];
    [self.backView addSubview:self.leftLabel];
    [self.leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.centerY.equalTo(self.backView);
    }];
    
    UIImageView *rightArrowImage = [UIImageView new];
    [rightArrowImage setImage:[UIImage imageNamed:@"rightArrow"]];
    [self.backView addSubview:rightArrowImage];
    [rightArrowImage mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.height.width.mas_offset(24);
        make.right.offset(-10);
        make.centerY.equalTo(self.backView);
    }];
    
    self.lineView = [UIView new];
    self.lineView.backgroundColor = LINE_COLOR;
    self.lineView.hidden = YES;
    [self.backView addSubview:self.lineView];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(14);
        make.bottom.offset(0);
        make.right.offset(-14);
        make.height.mas_offset(1);
    }];
}

-(void)setIndexpath:(NSIndexPath *)indexpath{
    _indexpath = indexpath;
    if (_indexpath.section == 0) {
        self.backView.layer.cornerRadius = 8;
        self.leftLabel.text = self.leftArr[0];
        self.lineView.hidden = YES;
    }else if (_indexpath.section == 1){
        
        if (_indexpath.row == 0) {
            [self topCornerRadiusView:self.backView];
            self.leftLabel.text = self.leftArr[1];
            self.lineView.hidden = NO;
        }else if(_indexpath.row == 1){
            [self bottomCornerRadiusView:self.backView];
            self.leftLabel.text = self.leftArr[2];
            self.lineView.hidden = YES;
            
        }
    }else{
        self.backView.layer.cornerRadius = 8;
        self.leftLabel.text = self.leftArr[3];
        self.lineView.hidden = YES;
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
