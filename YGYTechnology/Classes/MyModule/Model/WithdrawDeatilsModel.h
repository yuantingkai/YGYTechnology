//
//  WithdrawDeatilsModel.h
//  YGYTechnology
//
//  Created by 袁庭楷 on 2018/10/18.
//  Copyright © 2018年 YGY. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class WithdrawDeatilsData,WithdrawDeatilsPageData;
@interface WithdrawDeatilsModel : NSObject
@property (nonatomic, copy) NSString *status;
@property (nonatomic, strong) WithdrawDeatilsData *data;
@property (nonatomic, copy) NSString *msg;
@end

@interface WithdrawDeatilsData : NSObject
@property (nonatomic, strong) NSArray <WithdrawDeatilsPageData *> *pageData;
@property (nonatomic, copy) NSString *total;
@property (nonatomic, copy) NSString *pageNum;
@end


@interface WithdrawDeatilsPageData : NSObject
@property (nonatomic, copy) NSString *_id;
@property (nonatomic, copy) NSString *userId;
@property (nonatomic, copy) NSString *generateTime;
@property (nonatomic, copy) NSString *btcNumber;
@property (nonatomic, copy) NSString *orderNumber;
@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *orderType;
@end

NS_ASSUME_NONNULL_END
