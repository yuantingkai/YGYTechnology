//
//  CheckClacModel.h
//  YGYTechnology
//
//  Created by 袁庭楷 on 2018/10/23.
//  Copyright © 2018年 YGY. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class CheckClacData;
@interface CheckClacModel : NSObject
@property (nonatomic, copy) NSString *status;
@property (nonatomic, strong) NSArray<CheckClacData *> *data;
@property (nonatomic, copy) NSString *msg;
@end

@interface CheckClacData : NSObject
@property (nonatomic, copy) NSString *_id;
@property (nonatomic, copy) NSString *userId;
@property (nonatomic, copy) NSString *behavior;
@property (nonatomic, copy) NSString *cloudCalc;
@property (nonatomic, copy) NSString *validTime;
@property (nonatomic, copy) NSString *invalidTime;
@end
NS_ASSUME_NONNULL_END
