//
//  EcoEarningsModel.h
//  YGYTechnology
//
//  Created by 袁庭楷 on 2018/10/16.
//  Copyright © 2018年 YGY. All rights reserved.
//

#import <Foundation/Foundation.h>

@class EcoEarningsData,EcoEarningsPageData;

@interface EcoEarningsModel : NSObject
@property (nonatomic, copy) NSString *status;
@property (nonatomic, strong) EcoEarningsData *data;
@property (nonatomic, copy) NSString *msg;
@end


@interface EcoEarningsData : NSObject
@property (nonatomic, strong) NSArray <EcoEarningsPageData *> *pageData;
@property (nonatomic, copy) NSString *total;
@property (nonatomic, copy) NSString *pageNum;
@end


@interface EcoEarningsPageData : NSObject
@property (nonatomic, copy) NSString *_id;
@property (nonatomic, copy) NSString *userId;
@property (nonatomic, copy) NSString *time;
@property (nonatomic, copy) NSString *number;
@property (nonatomic, copy) NSString *recordType;
@property (nonatomic, copy) NSString *involveId;
@property (nonatomic, copy) NSString *electricityBtc;
@property (nonatomic, copy) NSString *maintenanceBtc;
@end
