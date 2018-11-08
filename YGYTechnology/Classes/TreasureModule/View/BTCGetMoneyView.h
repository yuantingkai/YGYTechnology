//
//  BTCGetMoneyView.h
//  YGYTechnology
//
//  Created by 袁庭楷 on 2018/10/13.
//  Copyright © 2018年 YGY. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BTCGetMoneyView : UIView<UITextFieldDelegate>
@property (nonatomic, strong) UITextField *accountTextField;
@property (nonatomic, strong) UITextField *numTextField;
@property (nonatomic, strong) UITextField *pwdTextField;
@property(nonatomic,strong) void (^cancelBtn)(UIButton *cancelBtn);
@property(nonatomic,strong) void (^returnTextField)(NSString *accountTextField,NSString *numTextField,NSString *pwdTextField);

@end

NS_ASSUME_NONNULL_END
