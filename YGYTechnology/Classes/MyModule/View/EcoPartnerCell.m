//
//  EcoPartnerCell.m
//  YGYTechnology
//
//  Created by 袁庭楷 on 2018/10/4.
//  Copyright © 2018年 YGY. All rights reserved.
//

#import "EcoPartnerCell.h"

@implementation EcoPartnerCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self setUI];
    }
    return self;
}

-(void)setUI{
    self.topBackView = [UIView new];
    self.topBackView.layer.cornerRadius = 8;
    self.topBackView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.topBackView];
    [self.topBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(12);
        make.right.offset(-12);
        make.top.bottom.offset(0);
    }];

    UILabel *myGetLabel = [UILabel newWithText:@"我的权益：" fontSize:16 textColor:MAIN_BODY textAlignment:NSTextAlignmentLeft];
    [self.topBackView addSubview:myGetLabel];
    [myGetLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.centerY.equalTo(self.topBackView);
    }];
    
    UILabel *myGetNumLabel = [UILabel newWithText:@"6" fontSize:16 textColor:MAIN_BODY textAlignment:NSTextAlignmentRight];
    [self.topBackView addSubview:myGetNumLabel];
    [myGetNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-10);
        make.centerY.equalTo(self.topBackView);
    }];
    
    
    
    
    
    
    
    
    
    
    self.bottomBackView = [UIView new];
    self.bottomBackView.layer.cornerRadius = 8;
    self.bottomBackView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.bottomBackView];
    [self.bottomBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(17);
        make.right.offset(-17);
        make.top.bottom.offset(0);
    }];
    
    
    
    self.iconImageView = [UIImageView new];
    self.iconImageView.backgroundColor = [UIColor blueColor];
    self.iconImageView.layer.cornerRadius = 8;
    [self.bottomBackView addSubview:self.iconImageView];
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.centerY.equalTo(self.bottomBackView);
        make.height.width.mas_offset(34);
    }];
    
    
    self.titleLabel = [UILabel newWithText:@"" fontSize:13 textColor:MAIN_BODY textAlignment:NSTextAlignmentLeft];
    [self.bottomBackView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(10);
        make.left.equalTo(self.iconImageView.mas_right).offset(10);
    }];
    
    
    self.detailLabel = [UILabel newWithText:@"" fontSize:10 textColor:SECOND_BODY textAlignment:NSTextAlignmentLeft];
    self.detailLabel.numberOfLines = 0;
    [self.bottomBackView addSubview:self.detailLabel];
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(5);
        make.left.equalTo(self.iconImageView.mas_right).offset(10);
        make.right.offset(-15);
    }];
    
}


-(void)setIndexPath:(NSIndexPath *)indexPath{
    _indexPath = indexPath;
    if (_indexPath.section == 0) {
        self.bottomBackView.hidden = YES;
        self.topBackView.hidden = NO;
        
    }else{
        self.topBackView.hidden = YES;
        self.bottomBackView.hidden = NO;
        UIImage *image = [UIImage imageNamed:self.leftImageArr[indexPath.section -1]];
        self.iconImageView.image = image;
        self.titleLabel.text = self.centerTitleArr[indexPath.section -1];
        self.detailLabel.text = self.centerDetailArr[indexPath.section -1];
    }
}

-(NSArray *)leftImageArr{
    if (!_leftImageArr) {
        _leftImageArr = @[@"qudao",@"shengtai",@"SDT",@"shouyi",@"kaocha",@"qidai"];
    }
    return _leftImageArr;
}

-(NSArray *)centerTitleArr{
    if (!_centerTitleArr) {
        _centerTitleArr = @[@"渠道共享",@"生态共享",@"SDT赠送",@"收益分成",@"实地考察",@"敬请期待"];
    }
    return _centerTitleArr;
}

-(NSArray *)centerDetailArr{
    if (!_centerDetailArr) {
        _centerDetailArr = @[@"共享有关云生态圈渠道，共同提升双方合作项目，强化市场占有率。",@"通过有关云生态圈共享区块链发展机遇，创造区块链财富神话",@"按成交订单1：1映射赠送有关云生态共享通证，二倍邀请挖矿收益，共享生态发展愿景。",@"按成交订单1：1映射赠送有关云生态共享通证，二倍邀请挖矿收益，共享生态发展愿景。",@"可享受新疆、四川等国矿场的考察机会，实地探访矿机生产基地。",@"更多有关权益请留意......"];
    }
    return _centerDetailArr;
}
@end
