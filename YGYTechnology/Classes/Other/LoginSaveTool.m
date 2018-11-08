//
//  LoginSaveTool.m
//  YGYTechnology
//
//  Created by 袁庭楷 on 2018/10/5.
//  Copyright © 2018年 YGY. All rights reserved.
//

#import "LoginSaveTool.h"

#define currentUserName @"currentAccount.data"//登陆账号返回的数据存储路径名
#define currentUserPath [kDocumentPath stringByAppendingPathComponent:currentUserName]//登陆路径

//#define currentInformationName @"currentInformation.data"//登陆个人信息
//#define currentInformationPath [kDocumentPath stringByAppendingPathComponent:currentInformationName]//个人信息保存路径
static LoginSaveTool *_instance;

@implementation LoginSaveTool

+ (LoginSaveTool *)sharedTool {
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        if (_instance == nil) {
            _instance = [self new];
        }
    });
    return _instance;
}

- (instancetype)init {
    _currentData = [NSKeyedUnarchiver unarchiveObjectWithFile:currentUserPath];
    return [super init];
}

- (void)addLoginData:(LoginData *)loginResult {
    _currentData = loginResult;
    [NSKeyedArchiver archiveRootObject:_currentData toFile:currentUserPath];
}

-(void)deleteCurrentLoginData{
    NSFileManager *manager = [NSFileManager defaultManager];
    if ([manager isDeletableFileAtPath:currentUserPath]) {
        [manager removeItemAtPath:currentUserPath error:nil];
        _currentData = nil;
    }
    
    [NSKeyedArchiver archiveRootObject:_currentData toFile:currentUserPath];
    
}

@end
