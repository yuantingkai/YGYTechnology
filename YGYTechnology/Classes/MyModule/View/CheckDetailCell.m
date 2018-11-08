//
//  CheckDetailCell.m
//  YGYTechnology
//
//  Created by 袁庭楷 on 2018/10/4.
//  Copyright © 2018年 YGY. All rights reserved.
//

#import "CheckDetailCell.h"

@implementation CheckDetailCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        [self setUI];
    }
    return self;
}

-(void)setUI{
    UIView *backView = [[UIView alloc]init];
    backView.backgroundColor = [UIColor whiteColor];
    backView.layer.cornerRadius = 8;
    [self addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(12);
        make.right.offset(-12);
        make.top.bottom.offset(0);
    }];
    
    self.timeLabel = [UILabel newWithText:@"2018-10-20" fontSize:13 textColor:MAIN_BODY textAlignment:NSTextAlignmentLeft];
    [backView addSubview:self.timeLabel];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(14);
        make.centerY.equalTo(backView);
        make.width.mas_offset(90);
    }];
    
    UIView *lineView = [UIView new];
    lineView.backgroundColor = Color(0xe5e5e5);
    [backView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_offset(1);
        make.height.mas_offset(20);
        make.centerY.equalTo(backView);
        make.left.equalTo(self.timeLabel.mas_right).offset(0);
    }];
    
    self.showInfoLabel = [UILabel newWithText:@"" fontSize:13 textColor:Color(0x333333) textAlignment:NSTextAlignmentLeft];
    [backView addSubview:self.showInfoLabel];
    self.showInfoLabel.numberOfLines = 0;
    [self.showInfoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lineView.mas_right).offset(13);
        make.centerY.equalTo(backView);
        make.right.offset(-14);
    }];
}

-(void)setIndexPath:(NSIndexPath *)indexPath phoneNum:(NSString *)phoneNumStr timeStr:(NSString *)timeStr showStr:(NSString *)showStr numStr:(NSString *)numStr{
    _indexPath = indexPath;
    self.timeLabel.text = timeStr;
    if (phoneNumStr.length == 11) {
        if ([showStr containsString:@"一名用户"]) {
            showStr = [showStr substringFromIndex:4];
            NSString *str = [NSString stringWithFormat:@"%@****%@%@,获得了%@SDT,已存入钱包!",[phoneNumStr substringToIndex:3],[phoneNumStr substringFromIndex:7],showStr,[NSString stringWithFormat:@"%.3f",[numStr doubleValue]]];
            SLog(@"%@",str);
//            float sumLength = str.length;
//            float num = [NSString stringWithFormat:@"%.3f",[numStr doubleValue]].length;
//            NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:str];
//            [attrStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 11)];
//            [attrStr addAttribute:NSForegroundColorAttributeName value:[UIColor brownColor] range:NSMakeRange(sumLength - 10 - num, num)];
//            self.showInfoLabel.attributedText = attrStr;
            self.showInfoLabel.text = str;
        }else{
            self.showInfoLabel.text = showStr;
        }
        
    }else{
        self.showInfoLabel.text = showStr;
    }
    
}
@end
