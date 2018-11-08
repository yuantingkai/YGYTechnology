//
//  ExamineClacRecordCell.m
//  YGYTechnology
//
//  Created by 袁庭楷 on 2018/10/23.
//  Copyright © 2018年 YGY. All rights reserved.
//

#import "ExamineClacRecordCell.h"

@implementation ExamineClacRecordCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self setUI];
    }
    return self;
}

-(void)setUI{
    self.topBackgroundView = [UIView new];
    self.topBackgroundView.layer.cornerRadius = 8;
    self.topBackgroundView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.topBackgroundView];
    [self.topBackgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(12);
        make.right.offset(-12);;
        make.top.bottom.offset(0);
    }];
    
    UILabel *clacTitleLabel = [UILabel newWithText:@"云力简介" fontSize:16 textColor:MAIN_BODY textAlignment:NSTextAlignmentLeft];
    [self.topBackgroundView addSubview:clacTitleLabel];
    [clacTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.top.offset(10);
    }];
    
    UIView *lineView = [UIView new];
    lineView.backgroundColor = LINE_COLOR;
    [self.topBackgroundView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(5);
        make.right.offset(-5);
        make.height.mas_offset(1);
        make.top.equalTo(clacTitleLabel.mas_bottom).offset(10);
    }];
    
    UILabel *clacDeatilLabel = [UILabel newWithText:@"云力是用户获取SDT的影响因子，同一时段内，云力越高，获取的SDT越多，云力分为无极云力和星辰云力两种类型，无极云力长期生效，星辰云力一般数值较大，但有固定生效期，仅在生效期内可参与SDT分配，超过期限将自动失效。在有关云进行浏览、学习、社交等所有活动，可以增加云力值，由于目前有关云基地正在前期搭建中，未来将支持更多获取云力的方式。" fontSize:12 textColor:SECOND_BODY textAlignment:NSTextAlignmentLeft];
    [self.topBackgroundView addSubview:clacDeatilLabel];
    [clacDeatilLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.right.offset(-10);
        make.top.equalTo(lineView.mas_bottom).offset(10);
    }];
    
    // 调整行间距
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:clacDeatilLabel.text];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:5];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [clacDeatilLabel.text length])];
    [attributedString addAttribute:NSForegroundColorAttributeName value:CLICK_BODY range:NSMakeRange(40, 4)];
    [attributedString addAttribute:NSForegroundColorAttributeName value:CLICK_BODY range:NSMakeRange(45 ,4)];
    [attributedString addAttribute:NSForegroundColorAttributeName value:CLICK_BODY range:NSMakeRange(54, 4)];
    [attributedString addAttribute:NSForegroundColorAttributeName value:CLICK_BODY range:NSMakeRange(63 , 4)];
    clacDeatilLabel.attributedText = attributedString;
    clacDeatilLabel.lineBreakMode = NSLineBreakByCharWrapping;

    
    
    self.bottomBackgroundView = [UIView new];
    self.bottomBackgroundView.layer.cornerRadius = 8;
    self.bottomBackgroundView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.bottomBackgroundView];
    [self.bottomBackgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.offset(0);
        make.left.offset(12);
        make.right.offset(-12);
    }];
    
    self.signOrNewsLabel = [UILabel newWithText:@"签到:" fontSize:12 textColor:MAIN_BODY textAlignment:NSTextAlignmentLeft];
    [self.bottomBackgroundView addSubview:self.signOrNewsLabel];
    [self.signOrNewsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.top.offset(5);
    }];
    
    self.rightLabel = [UILabel newWithText:@"星辰云力+3" fontSize:12 textColor:CLICK_BODY textAlignment:NSTextAlignmentRight];
    [self.bottomBackgroundView addSubview:self.rightLabel];
    [self.rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-10);
        make.top.offset(5);
    }];
    
    self.successTimeLabel = [UILabel newWithText:@"2018.10.15 20:00:00 生效" fontSize:11 textColor:SECOND_BODY textAlignment:NSTextAlignmentLeft];
    [self.bottomBackgroundView addSubview:self.successTimeLabel];
    [self.successTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.bottom.offset(-5);
    }];
    
    self.failedTimeLabel = [UILabel newWithText:@"2018.10.15 20:00:00 失效" fontSize:11 textColor:SECOND_BODY textAlignment:NSTextAlignmentRight];
    [self.bottomBackgroundView addSubview:self.failedTimeLabel];
    [self.failedTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-10);
        make.bottom.offset(-5);
    }];
}

-(void)setIndexPath:(NSIndexPath *)indexPath data:(CheckClacData *)data{
    _indexPath = indexPath;
    _data = data;
    if (indexPath.section == 0) {
        self.topBackgroundView.hidden = NO;
        self.bottomBackgroundView.hidden = YES;
    }else{
        self.topBackgroundView.hidden = YES;
        self.bottomBackgroundView.hidden = NO;
        if ([_data.behavior isEqualToString:@"sign"]) {
            self.signOrNewsLabel.text = @"签到：";
            self.rightLabel.text = [NSString stringWithFormat:@"星辰云力+%@",_data.cloudCalc];
        }else{
            self.signOrNewsLabel.text = @"资讯：";
            self.rightLabel.text = [NSString stringWithFormat:@"无极云力+%@",_data.cloudCalc];
        }
        if (_data.validTime.length > 0) {
            self.successTimeLabel.text = [NSString stringWithFormat:@"%@ 生效",_data.validTime];
        }else{
            self.successTimeLabel.text = @"";
        }
        if (_data.invalidTime.length > 0) {
            self.failedTimeLabel.text = [NSString stringWithFormat:@"%@ 失效",_data.invalidTime];
        }else{
            self.failedTimeLabel.text = @"";
        }
        
    }
}
@end
