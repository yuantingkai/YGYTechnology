//
//  MyContractCollectionCell.m
//  YGYTechnology
//
//  Created by 袁庭楷 on 2018/10/9.
//  Copyright © 2018年 YGY. All rights reserved.
//

#import "MyContractCollectionCell.h"

@implementation MyContractCollectionCell
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setUI];
    }
    return self;
}

-(void)setUI{
    self.titleLabel = [UILabel newWithText:@"" fontSize:14 textColor:Color(0x666666) textAlignment:NSTextAlignmentLeft];
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.centerY.equalTo(self);
    }];
}

-(void)setIndexPath:(NSIndexPath *)indexPath{
    _indexPath = indexPath;
    self.titleLabel.text = self.titleArr[indexPath.row];
//        CGSize singleSize = [self.titleArr[indexPath.row] sizeWithAttributes:@{NSFontAttributeName : Font(14)}];
//    if (indexPath.row > 0) {
//        CGSize topTextSize = [self.titleArr[indexPath.row -1] sizeWithAttributes:@{NSFontAttributeName : Font(14)}];
//        CGFloat width = singleSize.width;
//        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.offset(width);
//            make.centerY.equalTo(self);
//        }];

//    }
}

-(NSArray *)titleArr{
    if (!_titleArr) {
        _titleArr = @[@"全部",@"未支付",@"尚未处理",@"正在采购",@"正在部署",@"正在运行",@"停机维护"];
    }
    return _titleArr;
}
@end
