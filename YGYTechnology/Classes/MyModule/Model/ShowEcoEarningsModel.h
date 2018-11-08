//
//  ShowEcoEarningsModel.h
//  YGYTechnology
//
//  Created by 袁庭楷 on 2018/10/16.
//  Copyright © 2018年 YGY. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class ShowEcoEarningsData;
@interface ShowEcoEarningsModel : NSObject
@property (nonatomic, copy) NSString *status;
@property (nonatomic, strong) ShowEcoEarningsData *data;
@property (nonatomic, copy) NSString *msg;
@end

@interface ShowEcoEarningsData : NSObject
@property (nonatomic, copy) NSString *incomeTotal;
@property (nonatomic, copy) NSString *withdrawTotal;
@property (nonatomic, copy) NSString *balance;
@end
NS_ASSUME_NONNULL_END
