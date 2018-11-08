//
//  WithdrawDepositView.h
//  YGYTechnology
//
//  Created by 袁庭楷 on 2018/10/5.
//  Copyright © 2018年 YGY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WithdrawDepositView : UIView<UITextFieldDelegate>

@property (nonatomic, strong) UITextField *accountTextField;
@property (nonatomic, strong) UITextField *numTextField;
@property(nonatomic,strong) void (^cancelBtn)(UIButton *cancelBtn);
@property(nonatomic,strong) void (^OKBtn)(UIButton *OKBtn);
@property(nonatomic,strong) void (^accountAndNum)(NSString *accountText,NSString *numText);
@end
