//
//  personalCenterVerifyNameVC.h
//  YGYTechnology
//
//  Created by 袁庭楷 on 2018/9/30.
//  Copyright © 2018年 YGY. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface personalCenterVerifyNameVC : UIViewController

@property (nonatomic, strong) void (^nickNameTextFiled)(UITextField * nickNameTextFiled);
@property (nonatomic, strong) UITextField * nickName;
@end
