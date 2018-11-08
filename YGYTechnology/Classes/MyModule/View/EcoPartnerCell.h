//
//  EcoPartnerCell.h
//  YGYTechnology
//
//  Created by 袁庭楷 on 2018/10/4.
//  Copyright © 2018年 YGY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EcoPartnerCell : UITableViewCell
@property (nonatomic, strong) UIView * topBackView;
@property (nonatomic, strong) UIView * bottomBackView;
@property (nonatomic, strong) UIImageView * iconImageView;
@property (nonatomic, strong) UILabel * titleLabel;
@property (nonatomic, strong) UILabel * detailLabel;
@property (nonatomic, strong) NSIndexPath * indexPath;
@property (nonatomic, strong) NSArray * leftImageArr;
@property (nonatomic, strong) NSArray * centerTitleArr;
@property (nonatomic, strong) NSArray * centerDetailArr;
@end
