//
//  WithdrawDeatilsModel.m
//  YGYTechnology
//
//  Created by 袁庭楷 on 2018/10/18.
//  Copyright © 2018年 YGY. All rights reserved.
//

#import "WithdrawDeatilsModel.h"

@implementation WithdrawDeatilsModel
YYModelOverrideMethod;
@end

@implementation WithdrawDeatilsData
YYModelOverrideMethod;
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"pageData" : [WithdrawDeatilsPageData class]};
}
@end

@implementation WithdrawDeatilsPageData
YYModelOverrideMethod;
+ (NSDictionary *)modelCustomPropertyMapper
{
    return @{@"_id":@"id"};
}
@end
