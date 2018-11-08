//
//  MyBottomTableViewCell.h
//  YGYTechnology
//
//  Created by 袁庭楷 on 2018/9/28.
//  Copyright © 2018年 YGY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyBottomTableViewCell : UITableViewCell
@property (nonatomic, strong) UIView *backgroView;
@property (nonatomic, strong) UIImageView * leftImageView;
@property (nonatomic, strong) UILabel * centerLabel;
@property (nonatomic, strong) UIImageView * rightImageView;
@property (nonatomic, strong) UIView * lineView;
@property (nonatomic, strong) NSArray * iconImageArr;
@property (nonatomic, strong) NSArray * nameArr;
@property (nonatomic, strong) NSIndexPath * indexPath;
@end
