//
//  MyContractIndentModel.m
//  YGYTechnology
//
//  Created by 袁庭楷 on 2018/10/16.
//  Copyright © 2018年 YGY. All rights reserved.
//

#import "MyContractIndentModel.h"

@implementation MyContractIndentModel
YYModelOverrideMethod;
@end

@implementation MyContractIndentData
YYModelOverrideMethod;
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"pageData" : [MyContractIndentPageData class]};
}
@end

@implementation MyContractIndentPageData
YYModelOverrideMethod;
+ (NSDictionary *)modelCustomPropertyMapper
{
    return @{@"_id":@"id"};
}
@end

@implementation MyContractIndentProduct
YYModelOverrideMethod;
+ (NSDictionary *)modelCustomPropertyMapper
{
    return @{@"Id":@"id"};
}
@end
