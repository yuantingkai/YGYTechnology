//
//  EcoPartnerModel.h
//  YGYTechnology
//
//  Created by 袁庭楷 on 2018/10/9.
//  Copyright © 2018年 YGY. All rights reserved.
//

#import <Foundation/Foundation.h>
@class EcoPartnerData;
@interface EcoPartnerModel : NSObject
@property (nonatomic, copy) NSString *status;
@property (nonatomic, strong) EcoPartnerData *data;
@property (nonatomic, copy) NSString *msg;
@end

@interface EcoPartnerData : NSObject
@property (nonatomic, copy) NSString *cnyNumber;
@property (nonatomic, copy) NSString *proxyAddress;
@property (nonatomic, copy) NSString *nodeNumber;
@end
