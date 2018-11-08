//
//  CertificationModel.h
//  YGYTechnology
//
//  Created by 袁庭楷 on 2018/10/13.
//  Copyright © 2018年 YGY. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CertificationData;

@interface CertificationModel : NSObject
@property (nonatomic, copy) NSString *status;
@property (nonatomic, strong) CertificationData *data;
@property (nonatomic, copy) NSString *msg;
@end

@interface CertificationData : NSObject
@property (nonatomic, copy) NSString *_id;
@property (nonatomic, copy) NSString *userId;
@property (nonatomic, copy) NSString *cardId;
@property (nonatomic, copy) NSString *backImg;
@property (nonatomic, copy) NSString *frontImg;
@property (nonatomic, copy) NSString *realName;
@property (nonatomic, copy) NSString *realSteps;
@property (nonatomic, copy) NSString *realTime;
@property (nonatomic, copy) NSString *phone;
@end
