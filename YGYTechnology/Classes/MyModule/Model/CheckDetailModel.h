//
//  CheckDetailModel.h
//  YGYTechnology
//
//  Created by 袁庭楷 on 2018/10/9.
//  Copyright © 2018年 YGY. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CheckDetailData,CheckDetailPageData;
@interface CheckDetailModel : NSObject
@property (nonatomic, copy) NSString *status;
@property (nonatomic, strong) CheckDetailData *data;
@property (nonatomic, copy) NSString *msg;
@end

@interface CheckDetailData : NSObject
@property (nonatomic, strong) NSArray<CheckDetailPageData *> * pageData;
@property (nonatomic, copy) NSString *total;
@property (nonatomic, copy) NSString *pageNum;
@end

@interface CheckDetailPageData : NSObject
@property (nonatomic, copy) NSString *date;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *number;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *desc;
@end
