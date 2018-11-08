//
//  MyContractIndentModel.h
//  YGYTechnology
//
//  Created by 袁庭楷 on 2018/10/16.
//  Copyright © 2018年 YGY. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class MyContractIndentData,MyContractIndentPageData,MyContractIndentProduct;
@interface MyContractIndentModel : NSObject
@property (nonatomic, copy) NSString *status;
@property (nonatomic, strong) MyContractIndentData *data;
@property (nonatomic, copy) NSString *msg;
@end

@interface MyContractIndentData : NSObject
@property (nonatomic, strong) NSArray<MyContractIndentPageData *> *pageData;

@end

@interface MyContractIndentPageData : NSObject
@property (nonatomic, copy) NSString *_id;
@property (nonatomic, copy) NSString *sumPrice;
@property (nonatomic, copy) NSString *proId;
@property (nonatomic, copy) NSString *proNumber;
@property (nonatomic, copy) NSString *status;//已支付的状态
@property (nonatomic, copy) NSString *orderNumber;
@property (nonatomic, copy) NSString *payType;
@property (nonatomic, copy) NSString *prepaid;
@property (nonatomic, copy) NSString *generateTime;
@property (nonatomic, copy) MyContractIndentProduct *product;
@property (nonatomic, copy) NSString *payStatus;//2代表已支付 0代表未支付
@property (nonatomic, copy) NSString *subTradeNo;
@end

@interface MyContractIndentProduct : NSObject
@property (nonatomic, copy) NSString *img;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *power;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *electricity;
@property (nonatomic, copy) NSString *maintenance;
@property (nonatomic, copy) NSString *earnings;
@property (nonatomic, copy) NSString *time;
@property (nonatomic, copy) NSString *cycle;
@property (nonatomic, copy) NSString *hint;
@property (nonatomic, copy) NSString *money;
@property (nonatomic, copy) NSString *Id;
@end
NS_ASSUME_NONNULL_END
