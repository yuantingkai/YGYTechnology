//
//  PersonalCenterCell.h
//  YGYTechnology
//
//  Created by 袁庭楷 on 2018/9/30.
//  Copyright © 2018年 YGY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PersonalCenterCell : UITableViewCell
@property (nonatomic, strong) UIView *backgoundViewOne;
@property (nonatomic, strong) UIView *backgoundViewTwo;
@property (nonatomic, strong) UIImageView * photoImageView;
@property (nonatomic, strong) UILabel *sexSelectLabel;
@property (nonatomic, strong) NSIndexPath * indexPath;
@property (nonatomic, strong) UITextField * nameTF;
@property(nonatomic,strong) void (^clickPicBtn)(UIButton *clickPicBtn);
@property(nonatomic,strong) void (^clickNickNameBtn)(UIButton *clickNickNameBtn);
@property(nonatomic,strong) void (^clickSexBtn)(UIButton *clickSexBtn);
@end
