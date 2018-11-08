//
//  MarketCollectionViewCell.m
//  YGYTechnology
//
//  Created by 袁庭楷 on 2018/10/31.
//  Copyright © 2018年 YGY. All rights reserved.
//

#import "MarketCollectionViewCell.h"

@implementation MarketCollectionViewCell
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setUI];
    }
    return self;
}

-(void)setUI{
    self.titleLabel = [UILabel newWithText:@"" fontSize:14 textColor:Color(0x666666) textAlignment:NSTextAlignmentCenter];
    self.titleLabel.layer.cornerRadius = 9;
    self.titleLabel.layer.masksToBounds = YES;
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.centerY.equalTo(self);
        if (SCREEN == 3) {
            make.width.mas_offset(33);
        }else{
            make.width.mas_offset(27);
        }
        make.height.mas_offset(18);
    }];
    self.fullScreenImageView = [UIImageView new];
    [self addSubview:self.fullScreenImageView];
    [self.fullScreenImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-17);
        make.centerY.equalTo(self);
    }];
}

-(void)setIndexPath:(NSIndexPath *)indexPath{
    _indexPath = indexPath;
    if (_indexPath.row == 5) {
        [self.fullScreenImageView setImage:self.tendencyArr[indexPath.row]];
        self.titleLabel.text = @"";
    }else{
        [self.fullScreenImageView setImage:nil];
        self.titleLabel.text = self.tendencyArr[indexPath.row];
    }
}

-(NSArray *)tendencyArr{
    if (!_tendencyArr) {
        _tendencyArr = @[@"2周",@"1月",@"3月",@"6月",@"1年",[UIImage imageNamed:@"quanping"]];
    }
    return _tendencyArr;
}
@end
