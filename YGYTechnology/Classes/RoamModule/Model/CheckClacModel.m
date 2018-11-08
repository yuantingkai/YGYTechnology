//
//  CheckClacModel.m
//  YGYTechnology
//
//  Created by 袁庭楷 on 2018/10/23.
//  Copyright © 2018年 YGY. All rights reserved.
//

#import "CheckClacModel.h"

@implementation CheckClacModel
YYModelOverrideMethod;
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"data" : [CheckClacData class]};
}
@end

@implementation CheckClacData
YYModelOverrideMethod;
+ (NSDictionary *)modelCustomPropertyMapper
{
    return @{@"_id":@"id"};
}
@end
