//
//  NewsInfoModel.m
//  YGYTechnology
//
//  Created by 袁庭楷 on 2018/10/5.
//  Copyright © 2018年 YGY. All rights reserved.
//

#import "NewsInfoModel.h"

@implementation NewsInfoModel
YYModelOverrideMethod;
@end

@implementation NewsInfoData
YYModelOverrideMethod;
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"pageData" : [NewsInfoPageData class]};
}
@end

@implementation NewsInfoPageData
YYModelOverrideMethod;
+ (NSDictionary *)modelCustomPropertyMapper
{
    return @{@"_id":@"id"};
}
@end

