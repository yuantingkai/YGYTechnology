//
//  LoginModel.h
//  YGYTechnology
//
//  Created by 袁庭楷 on 2018/10/5.
//  Copyright © 2018年 YGY. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LoginData;

@interface LoginModel : NSObject
@property (nonatomic, copy) NSString *status;
@property (nonatomic, strong) LoginData *data;
@property (nonatomic, copy) NSString *msg;
@end

@interface LoginData : NSObject
@property (nonatomic, copy) NSString *_id;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *toKen;
@property (nonatomic, copy) NSString *password;
@property (nonatomic, copy) NSString *allCNY;
@property (nonatomic, copy) NSString *avatarImg;
@property (nonatomic, copy) NSString *calculate;
@property (nonatomic, copy) NSString *partnerUserId;
@property (nonatomic, copy) NSString *gender;
@property (nonatomic, copy) NSString *btcAddress;
@property (nonatomic, copy) NSString *aliAccount;
@property (nonatomic, copy) NSString *real;
@property (nonatomic, copy) NSString *partner;
@property (nonatomic, copy) NSString *assetsPwdExist;
@end
