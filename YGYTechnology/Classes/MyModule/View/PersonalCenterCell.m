//
//  PersonalCenterCell.m
//  YGYTechnology
//
//  Created by 袁庭楷 on 2018/9/30.
//  Copyright © 2018年 YGY. All rights reserved.
//

#import "PersonalCenterCell.h"

@implementation PersonalCenterCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self setUI];
    }
    return self;
}

-(void)setUI{
    self.backgoundViewOne = [UIView new];
    self.backgoundViewOne.backgroundColor = [UIColor whiteColor];
    self.backgoundViewOne.layer.cornerRadius = 8;
    [self addSubview:self.backgoundViewOne];
    [self.backgoundViewOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_offset(50);
        make.left.offset(14);
        make.right.offset(-14);
        make.top.offset(0);
    }];
    
    UILabel *picLabel = [UILabel newWithText:@"头像" fontSize:14 textColor:MAIN_BODY textAlignment:NSTextAlignmentLeft];
    [self.backgoundViewOne addSubview:picLabel];
    [picLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(14);
        make.centerY.equalTo(self.backgoundViewOne);
    }];
    
    _photoImageView = [UIImageView new];
    _photoImageView.userInteractionEnabled = YES;
    _photoImageView.layer.masksToBounds = YES;
    _photoImageView.layer.cornerRadius = 20;
    [_photoImageView setImage:[UIImage imageNamed:@"touxiang"]];
//    _photoImageView.backgroundColor = [UIColor redColor];
    [self.backgoundViewOne addSubview:_photoImageView];
    [_photoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-14);
        make.centerY.equalTo(self.backgoundViewOne);
        make.width.height.mas_offset(40);
    }];
    
    UIButton *photoBtn = [UIButton new];
    [photoBtn addTarget:self action:@selector(photoBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.backgoundViewOne addSubview:photoBtn];
    [photoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.offset(0);
    }];
    
    self.backgoundViewTwo = [UIView new];
    self.backgoundViewTwo.backgroundColor = [UIColor whiteColor];
    self.backgoundViewTwo.layer.cornerRadius = 8;
    [self addSubview:self.backgoundViewTwo];
    [self.backgoundViewTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_offset(100);
        make.left.offset(14);
        make.right.offset(-14);
        make.top.offset(0);
    }];
    
    UIView *nickNameView = [UIView new];
    [self.backgoundViewTwo addSubview:nickNameView];
    [nickNameView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.right.offset(0);
        make.height.mas_offset(50);
        make.top.offset(0);
    }];
    
    UILabel *nickNameLabel = [UILabel newWithText:@"昵称" fontSize:14 textColor:MAIN_BODY textAlignment:NSTextAlignmentLeft];
    [nickNameView addSubview:nickNameLabel];
    [nickNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(14);
        make.centerY.equalTo(nickNameView);
    }];
    
    UIView *lineView = [UIView new];
    lineView.backgroundColor = LINE_COLOR;
    [nickNameView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(14);
        make.right.offset(-14);
        make.height.mas_offset(1);
        make.bottom.offset(0);
    }];
    
    UIImageView *nickNameRightImage = [UIImageView new];
    [nickNameRightImage setImage:[UIImage imageNamed:@"rightArrow"]];
    [nickNameView addSubview:nickNameRightImage];
    [nickNameRightImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(nickNameView).offset(-10);
        make.centerY.equalTo(nickNameView);
//        make.width.height.mas_offset(24);
    }];
    
    self.nameTF = [UITextField new];
    self.nameTF.textColor = SECOND_BODY;
    self.nameTF.font = [UIFont systemFontOfSize:16];
    self.nameTF.textAlignment = NSTextAlignmentRight;
    self.nameTF.placeholder = @"请填写姓名";
    self.nameTF.userInteractionEnabled = NO;
    [self.backgoundViewTwo addSubview:self.nameTF];
    [self.nameTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(nickNameRightImage.mas_left).offset(-10);
        make.centerY.equalTo(nickNameView);
    }];
    
    UIButton *nickNameBtn = [UIButton new];
    [nickNameBtn addTarget:self action:@selector(nickBtn:) forControlEvents:UIControlEventTouchUpInside];
    [nickNameView addSubview:nickNameBtn];
    [nickNameBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.offset(0);
    }];
    
    UIView *sexView = [UIView new];
    [self.backgoundViewTwo addSubview:sexView];
    [sexView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.right.offset(0);
        make.height.mas_offset(50);
        make.bottom.offset(0);
    }];
    
    UILabel *sexLabel = [UILabel newWithText:@"性别" fontSize:14 textColor:MAIN_BODY textAlignment:NSTextAlignmentLeft];
    [sexView addSubview:sexLabel];
    [sexLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(14);
        make.centerY.equalTo(sexView);
    }];
    
    UIImageView *sexRightImage = [UIImageView new];
    [sexRightImage setImage:[UIImage imageNamed:@"rightArrow"]];
    [sexView addSubview:sexRightImage];
    [sexRightImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(sexView).offset(-10);
        make.centerY.equalTo(sexView);
//        make.width.height.mas_offset(24);
    }];
    
    self.sexSelectLabel = [UILabel newWithText:@"男" fontSize:14 textColor:MAIN_BODY textAlignment:NSTextAlignmentLeft];
    [self.backgoundViewTwo addSubview:self.sexSelectLabel];
    [self.sexSelectLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(sexRightImage.mas_left).offset(-10);
        make.centerY.equalTo(sexView);
    }];
    
    UIButton *sexBtn = [UIButton new];
    [sexBtn addTarget:self action:@selector(sexBtn:) forControlEvents:UIControlEventTouchUpInside];
    [sexView addSubview:sexBtn];
    [sexBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.offset(0);
    }];
    
}

-(void)photoBtn:(UIButton *)sender{
    self.clickPicBtn(sender);
}

-(void)nickBtn:(UIButton *)sender{
    self.clickNickNameBtn(sender);
}

-(void)sexBtn:(UIButton *)sender{
    self.clickSexBtn(sender);
}

-(void)setIndexPath:(NSIndexPath *)indexPath{
    _indexPath = indexPath;
    if (_indexPath.section == 0) {
        self.backgoundViewTwo.hidden = YES;
        self.backgoundViewOne.hidden = NO;
    }else{
        self.backgoundViewTwo.hidden = NO;
        self.backgoundViewOne.hidden = YES;
    }
}


@end
