//
//  MyTableViewCell.h
//  YGYTechnology
//
//  Created by 袁庭楷 on 2018/9/28.
//  Copyright © 2018年 YGY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyTableViewCell : UITableViewCell
@property (nonatomic, strong) UIImageView * backgroundImageView;//背景图
@property (nonatomic, strong) UIImageView * picimageView;//头像
@property (nonatomic, strong) UILabel * nameLabel;//姓名
@property (nonatomic, strong) UILabel * phoneNumberLabel;//电话号码
@property (nonatomic, strong) UILabel * SDTNumberLabel;//SDT
@property (nonatomic, strong) UILabel * cloudNumerLabel;//云力
-(void)setPicImageView:(NSString *)picImageStr name:(NSString *)name phoneNumberLabel:(NSString *)phoneNumberLabel SDTNumberLabel:(NSString *)SDTNumberLabel cloudNumerLabel:(NSString *)cloudNumerLabel;
@property(nonatomic,strong) void (^clickBtn)(UIButton *picBtn);

@end
