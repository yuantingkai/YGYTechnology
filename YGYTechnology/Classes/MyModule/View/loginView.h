//
//  loginView.h
//  YGYTechnology
//
//  Created by 袁庭楷 on 2018/9/27.
//  Copyright © 2018年 YGY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface loginView : UIView<UITextFieldDelegate>
{
    
    UITextField *telPhoneTextField;
    UITextField *pwdTextField;
}
@property (nonatomic, strong) UIButton * verifyLoginBtn;
@property (nonatomic, strong) UIButton * getVerifyBtn;
@property(nonatomic,strong) void (^login)(NSString *telPhone,NSString *pwd);
//@property(nonatomic,strong) void (^getVerifyCode)(NSString *telPhone);
@property(nonatomic,strong) void (^getVerifyCodeBtn)(UIButton *getVerifyCodeBtn,NSString *telPhone);
@property (nonatomic, strong) void (^isChangeStr)(NSString *isChangeStr);
@end
