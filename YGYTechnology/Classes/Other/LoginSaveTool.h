//
//  LoginSaveTool.h
//  YGYTechnology
//
//  Created by 袁庭楷 on 2018/10/5.
//  Copyright © 2018年 YGY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LoginModel.h"

@interface LoginSaveTool : NSObject
+ (LoginSaveTool *)sharedTool;

@property(nonatomic,strong) LoginData *currentData;
//@property(nonatomic,strong) WDExaminePersonalInfoResult *currentInformationData;

//存储登陆返回值 对象
- (void)addLoginData:(LoginData *)loginResult;
//删除登陆数据
- (void)deleteCurrentLoginData;

//存储个人信息
//- (void)addInformationData:(WDExaminePersonalInfoResult *)loginResult;
////删除个人信息数据
//- (void)deleteCurrentInformationData;

//-(void)deleteAllLocalInformation;
@end
