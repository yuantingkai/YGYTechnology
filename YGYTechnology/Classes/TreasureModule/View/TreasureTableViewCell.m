//
//  TreasureTableViewCell.m
//  YGYTechnology
//
//  Created by 袁庭楷 on 2018/9/29.
//  Copyright © 2018年 YGY. All rights reserved.
//

#import "TreasureTableViewCell.h"

@implementation TreasureTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUI];
    }
    return self;
}

-(void)setUI{
    self.backgroundColor = [UIColor clearColor];
    
    UIView *backgroupView = [UIView new];
    backgroupView.backgroundColor = [UIColor whiteColor];
    backgroupView.layer.masksToBounds =YES;
    backgroupView.layer.cornerRadius = 5;
    [self addSubview:backgroupView];
    [backgroupView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(0);
        make.left.offset(12);
        make.right.offset(-12);
        make.height.mas_offset(181);
    }];
    
    
    _picImageView = [UIImageView new];
//    _picImageView.backgroundColor = [UIColor purpleColor];
    [backgroupView addSubview:_picImageView];
    _picImageView.contentMode =UIViewContentModeScaleAspectFill;
    _picImageView.clipsToBounds = YES;
    [_picImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.top.offset(14);
//        if (SCREEN == 1) {
//            make.width.mas_offset(120);
//            make.height.mas_offset(120);
//        }else{
            make.width.mas_offset(142);
            make.height.mas_offset(120);
//        }
        
    }];
    
    _titleLabel = [UILabel newWithText:@"[BIQ-A1*云存储合约]" fontSize:16 textColor:MAIN_BODY textAlignment:NSTextAlignmentLeft];
    [backgroupView addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        if (SCREEN == 1) {
//            make.left.equalTo(self.picImageView.mas_right).offset(10);
//        }else{
            make.left.equalTo(self.picImageView.mas_right).offset(28);
//        }
        make.top.offset(14);
    }];
    
    UILabel *kjRegularLabel = [UILabel newWithText:@"矿机" fontSize:11 textColor:SECOND_BODY textAlignment:NSTextAlignmentLeft];
    [backgroupView addSubview:kjRegularLabel];
    [kjRegularLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(8);
    }];
    
    _kjLabel = [UILabel newWithText:@"*HDD云储服务AI*" fontSize:11 textColor:SECOND_BODY textAlignment:NSTextAlignmentRight];
    [backgroupView addSubview:_kjLabel];
    [_kjLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(kjRegularLabel);
        make.right.equalTo(backgroupView).offset(-10);
    }];
    
    
    
    
    
    UILabel *dfRegularLabel = [UILabel newWithText:@"电费" fontSize:10 textColor:SECOND_BODY textAlignment:NSTextAlignmentLeft];
    [backgroupView addSubview:dfRegularLabel];
    [dfRegularLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel);
        make.top.equalTo(kjRegularLabel.mas_bottom).offset(5);
    }];
    
    _dfLabel = [UILabel newWithText:@"0.45CNY/KWH" fontSize:10 textColor:SECOND_BODY textAlignment:NSTextAlignmentRight];
    [backgroupView addSubview:_dfLabel];
    [_dfLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(dfRegularLabel);
        make.right.equalTo(backgroupView).offset(-10);
    }];
    
    
    
    
    
    UILabel *whfRegularLabel = [UILabel newWithText:@"维护费" fontSize:10 textColor:SECOND_BODY textAlignment:NSTextAlignmentLeft];
    [backgroupView addSubview:whfRegularLabel];
    [whfRegularLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel);
        make.top.equalTo(dfRegularLabel.mas_bottom).offset(5);
    }];
    
    _whfLabel = [UILabel newWithText:@"5%云算力收益" fontSize:10 textColor:SECOND_BODY textAlignment:NSTextAlignmentRight];
    [backgroupView addSubview:_whfLabel];
    [_whfLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(whfRegularLabel);
        make.right.equalTo(backgroupView).offset(-10);
    }];
    
    
    
    
    UILabel *priceRegularLabel = [UILabel newWithText:@"价格" fontSize:12 textColor:MAIN_BODY textAlignment:NSTextAlignmentLeft];
    [backgroupView addSubview:priceRegularLabel];
    [priceRegularLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel);
        make.top.equalTo(whfRegularLabel.mas_bottom).offset(14);
    }];
    
    _priceLabel = [UILabel newWithText:@"7500.00CNY(算力*)" fontSize:12 textColor:MAIN_BODY textAlignment:NSTextAlignmentLeft];
    [backgroupView addSubview:_priceLabel];
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(priceRegularLabel);
        make.right.equalTo(backgroupView).offset(-10);
    }];
    
    self.contractBtn = [UIButton newWithTitle:@"" font:0 textColor:nil textAlignment:NSTextAlignmentCenter Image:[UIImage imageNamed:@"Contract details"]];
    [self.contractBtn addTarget:self action:@selector(contractBtn:) forControlEvents:UIControlEventTouchUpInside];
    [backgroupView addSubview:self.contractBtn];
    [self.contractBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.offset(-16);
        make.right.equalTo(backgroupView).offset(-10);
        make.width.mas_offset(66);
        make.height.mas_offset(24);
    }];
    
    self.buyBtnN = [UIButton newWithTitle:@"" font:0 textColor:nil textAlignment:NSTextAlignmentCenter Image:[UIImage imageNamed:@"buy"]];
    [self.buyBtnN addTarget:self action:@selector(buyBtn:) forControlEvents:UIControlEventTouchUpInside];
    [backgroupView addSubview:self.buyBtnN];
    [self.buyBtnN mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contractBtn.mas_left).offset(-21);
        make.bottom.offset(-16);
        make.width.mas_offset(73);
        make.height.mas_offset(24);
    }];
    
    
    
}

-(void)contractBtn:(UIButton *)sender{
    self.contractInfoBtn(sender);
}

-(void)buyBtn:(UIButton *)sender{
    self.buyBtn(sender);
}

-(void)setIndexPath:(NSIndexPath *)indexPath getAlldata:(TreasureGetAllData *)getAlldata{
    _indexPath = indexPath;
    _getAlldata = getAlldata;
    _buyBtnN.tag = indexPath.section;
    _contractBtn.tag = indexPath.section;
    if (SCREEN == 1) {
        self.titleLabel.font = Font(13);
        self.kjLabel.font = Font(9);
        self.dfLabel.font = Font(9);
        self.whfLabel.font = Font(9);
    }
    self.titleLabel.text =  _getAlldata.title;
    self.kjLabel.text = _getAlldata.name;
    self.dfLabel.text = _getAlldata.electricity;
    self.whfLabel.text = _getAlldata.maintenance;
    self.priceLabel.text = [NSString stringWithFormat:@"%.2fCNY",[_getAlldata.money floatValue]];
    NSString *urlStr = _getAlldata.img;
    urlStr = [urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    [self.picImageView sd_setImageWithURL:[NSURL URLWithString:urlStr]];
}


@end
