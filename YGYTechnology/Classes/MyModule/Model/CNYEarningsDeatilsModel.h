//
//  CNYEarningsDeatilsModel.h
//  YGYTechnology
//
//  Created by 袁庭楷 on 2018/10/19.
//  Copyright © 2018年 YGY. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class CNYEarningsDeatilsData,CNYEarningsDeatilsPageData;
@interface CNYEarningsDeatilsModel : NSObject
@property (nonatomic, copy) NSString *status;
@property (nonatomic, strong) CNYEarningsDeatilsData *data;
@property (nonatomic, copy) NSString *msg;
@end

@interface CNYEarningsDeatilsData : NSObject
@property (nonatomic, strong) NSArray <CNYEarningsDeatilsPageData *> *pageData;
@property (nonatomic, copy) NSString *total;
@property (nonatomic, copy) NSString *pageNum;
@end


@interface CNYEarningsDeatilsPageData : NSObject
@property (nonatomic, copy) NSString *_id;
@property (nonatomic, copy) NSString *time;
@property (nonatomic, copy) NSString *number;
@property (nonatomic, copy) NSString *desc;
@property (nonatomic, copy) NSString *recordType;
@end
NS_ASSUME_NONNULL_END
