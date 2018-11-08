//
//  LoginGetTool.h
//  YGYTechnology
//
//  Created by 袁庭楷 on 2018/10/5.
//  Copyright © 2018年 YGY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LoginModel.h"
#import "LoginSaveTool.h"

@interface LoginGetTool : NSObject
+ (LoginData *)getUserInfo;
//+ (WDExaminePersonalInfoResult *)getUserInformation;//获取个人信息
@end
