//
//  LoginGetTool.m
//  YGYTechnology
//
//  Created by 袁庭楷 on 2018/10/5.
//  Copyright © 2018年 YGY. All rights reserved.
//

#import "LoginGetTool.h"

@implementation LoginGetTool
+ (LoginData *)getUserInfo {
    LoginData *result = [LoginSaveTool sharedTool].currentData;
    return result;
}

//+ (WDExaminePersonalInfoResult *)getUserInformation//获取个人信息
//{
//    WDExaminePersonalInfoResult *result = [LoginSaveTool sharedTool].currentInformationData;
//    return result;
//}
@end
