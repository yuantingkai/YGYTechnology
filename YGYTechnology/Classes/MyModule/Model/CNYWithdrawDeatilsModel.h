//
//  CNYWithdrawDeatilsModel.h
//  YGYTechnology
//
//  Created by 袁庭楷 on 2018/10/19.
//  Copyright © 2018年 YGY. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class CNYWithdrawDeatilsData,CNYWithdrawDeatilsPageData;
@interface CNYWithdrawDeatilsModel : NSObject
@property (nonatomic, copy) NSString *status;
@property (nonatomic, strong) CNYWithdrawDeatilsData *data;
@property (nonatomic, copy) NSString *msg;
@end

@interface CNYWithdrawDeatilsData : NSObject
@property (nonatomic, strong) NSArray <CNYWithdrawDeatilsPageData *> *pageData;
@property (nonatomic, copy) NSString *total;
@property (nonatomic, copy) NSString *pageNum;
@end


@interface CNYWithdrawDeatilsPageData : NSObject
@property (nonatomic, copy) NSString *_id;
@property (nonatomic, copy) NSString *userId;
@property (nonatomic, copy) NSString *orderNumber;
@property (nonatomic, copy) NSString *cnyNumber;
@property (nonatomic, copy) NSString *accountType;
@property (nonatomic, copy) NSString *generateTime;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *sysUserId;
@property (nonatomic, copy) NSString *account;
@property (nonatomic, copy) NSString *beginExamineTime;
@property (nonatomic, copy) NSString *endExamineTime;
@property (nonatomic, copy) NSString *phone;
@end

NS_ASSUME_NONNULL_END
