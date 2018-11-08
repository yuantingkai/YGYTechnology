//
//  CNYEarningsDeatilsModel.m
//  YGYTechnology
//
//  Created by 袁庭楷 on 2018/10/19.
//  Copyright © 2018年 YGY. All rights reserved.
//

#import "CNYEarningsDeatilsModel.h"

@implementation CNYEarningsDeatilsModel
YYModelOverrideMethod;
@end

@implementation CNYEarningsDeatilsData
YYModelOverrideMethod;
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"pageData" : [CNYEarningsDeatilsPageData class]};
}
@end

@implementation CNYEarningsDeatilsPageData
YYModelOverrideMethod;
+ (NSDictionary *)modelCustomPropertyMapper
{
    return @{@"_id":@"id"};
}
@end
