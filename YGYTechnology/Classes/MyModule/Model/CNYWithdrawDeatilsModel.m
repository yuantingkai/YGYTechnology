//
//  CNYWithdrawDeatilsModel.m
//  YGYTechnology
//
//  Created by 袁庭楷 on 2018/10/19.
//  Copyright © 2018年 YGY. All rights reserved.
//

#import "CNYWithdrawDeatilsModel.h"

@implementation CNYWithdrawDeatilsModel
YYModelOverrideMethod;
@end

@implementation CNYWithdrawDeatilsData
YYModelOverrideMethod;
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"pageData" : [CNYWithdrawDeatilsPageData class]};
}
@end

@implementation CNYWithdrawDeatilsPageData
YYModelOverrideMethod;
+ (NSDictionary *)modelCustomPropertyMapper
{
    return @{@"_id":@"id"};
}
@end

