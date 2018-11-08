//
//  SetSafePwdView.h
//  YGYTechnology
//
//  Created by 袁庭楷 on 2018/10/2.
//  Copyright © 2018年 YGY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SetSafePwdView : UIView<UITextFieldDelegate>
// 密码输入文本框
@property (nonatomic, strong) UITextField *pswTextField;
// 用于存放加密黑色点
@property (nonatomic, strong) NSMutableArray *dotArr;

@property(nonatomic,strong) void (^passwordDidChangeBlock)(NSString *password);
@end
