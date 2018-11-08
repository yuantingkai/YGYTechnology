//
//  GetClacModel.h
//  YGYTechnology
//
//  Created by 袁庭楷 on 2018/10/15.
//  Copyright © 2018年 YGY. All rights reserved.
//

#import <Foundation/Foundation.h>
@class GetClacData;
@interface GetClacModel : NSObject
@property (nonatomic, copy) NSString *status;
@property (nonatomic, strong) GetClacData *data;
@property (nonatomic, copy) NSString *msg;
@end

@interface GetClacData : NSObject
@property (nonatomic, copy) NSString *sdt;
@property (nonatomic, copy) NSString *calc;
@property (nonatomic, copy) NSString *news;
@property(nonatomic, copy) NSString * sign;//0代表未签到 1代表已签到
@end
