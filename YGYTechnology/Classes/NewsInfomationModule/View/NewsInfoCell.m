//
//  NewsInfoCell.m
//  YGYTechnology
//
//  Created by 袁庭楷 on 2018/10/4.
//  Copyright © 2018年 YGY. All rights reserved.
//

#import "NewsInfoCell.h"

@implementation NewsInfoCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self setUI];
    }
    return self;
}

-(void)setUI{
    UIView *backView = [UIView new];
    backView.backgroundColor = [UIColor whiteColor];
    backView.layer.cornerRadius = 8;
    [self addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(12);
        make.right.offset(-12);
        make.height.mas_offset(82);
        make.top.offset(0);
    }];
    
    self.rightPicView = [UIImageView new];
    self.rightPicView.layer.cornerRadius = 5;
    self.rightPicView.layer.masksToBounds = YES;
    self.rightPicView.userInteractionEnabled = YES;
    self.rightPicView.contentMode =UIViewContentModeScaleAspectFill;
    self.rightPicView.clipsToBounds = YES;
//    self.rightPicView.backgroundColor = [UIColor redColor];
    [backView addSubview:self.rightPicView];
    [self.rightPicView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-8);
        make.centerY.equalTo(backView);
        make.width.mas_offset(98);
        make.height.mas_offset(66);
    }];
    
    self.readerNameLabel = [UILabel newWithText:@"我是阅读者" fontSize:11 textColor:Color(0x999999) textAlignment:NSTextAlignmentLeft];
    [backView addSubview:self.readerNameLabel];
    [self.readerNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(8);
        make.bottom.offset(-8);
    }];
    
    self.timeLabel = [UILabel newWithText:[NSString stringWithFormat:@"时间·%@",@"2018.01.01"] fontSize:11 textColor:Color(0x999999) textAlignment:NSTextAlignmentRight];
    [backView addSubview:self.timeLabel];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.rightPicView.mas_left).offset(-8);
        make.bottom.offset(-8);
    }];
    
    
    
    self.titleLabel = [UILabel newWithText:@"你好我是title哦呵呵呵😑你好我是title哦呵呵呵🙃🙃😆😆你好我是title哦呵呵呵😑你好我是title哦呵呵呵🙃🙃😆😆" fontSize:14 textColor:YGYColor(51, 51, 51) textAlignment:NSTextAlignmentLeft];
    [backView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(8);
        make.top.offset(8);
        make.right.equalTo(self.rightPicView.mas_left).offset(-8);
        make.bottom.equalTo(self.readerNameLabel.mas_top).offset(-8);
    }];
    
}

-(void)setIndexPath:(NSIndexPath *)indexPath dataArr:(NewsInfoPageData *)newsInfoPageData{
    _indexPath = indexPath;
    _newsInfoPageData = newsInfoPageData;
    self.titleLabel.text = _newsInfoPageData.title;
    self.readerNameLabel.text = _newsInfoPageData.content.length >= 10 ? [NSString stringWithFormat:@"%@...",[_newsInfoPageData.content substringToIndex:10]] : _newsInfoPageData.content;
    self.timeLabel.text = _newsInfoPageData.time.length >= 10 ? [_newsInfoPageData.time substringToIndex:10] : _newsInfoPageData.time;
    NSString *urlStr = [NSString stringWithFormat:@"%@",_newsInfoPageData.img];
    urlStr = [urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    [self.rightPicView sd_setImageWithURL:[NSURL URLWithString:urlStr]];
}






@end
