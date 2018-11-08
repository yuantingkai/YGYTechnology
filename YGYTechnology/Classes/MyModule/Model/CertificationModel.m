//
//  CertificationModel.m
//  YGYTechnology
//
//  Created by 袁庭楷 on 2018/10/13.
//  Copyright © 2018年 YGY. All rights reserved.
//

#import "CertificationModel.h"

@implementation CertificationModel
YYModelOverrideMethod;
@end

@implementation CertificationData
YYModelOverrideMethod;
+ (NSDictionary *)modelCustomPropertyMapper
{
    return @{@"_id":@"id"};
}

@end
