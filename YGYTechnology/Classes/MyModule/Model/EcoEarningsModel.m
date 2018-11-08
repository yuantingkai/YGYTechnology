//
//  EcoEarningsModel.m
//  YGYTechnology
//
//  Created by 袁庭楷 on 2018/10/16.
//  Copyright © 2018年 YGY. All rights reserved.
//

#import "EcoEarningsModel.h"

@implementation EcoEarningsModel
YYModelOverrideMethod;
@end

@implementation EcoEarningsData
YYModelOverrideMethod;
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"pageData" : [EcoEarningsPageData class]};
}
@end

@implementation EcoEarningsPageData
YYModelOverrideMethod;
+ (NSDictionary *)modelCustomPropertyMapper
{
    return @{@"_id":@"id"};
}
@end
