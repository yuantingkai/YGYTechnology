//
//  GetAssetInfoModel.m
//  YGYTechnology
//
//  Created by 袁庭楷 on 2018/10/17.
//  Copyright © 2018年 YGY. All rights reserved.
//

#import "GetAssetInfoModel.h"

@implementation GetAssetInfoModel
YYModelOverrideMethod;
@end

@implementation GetAssetInfoData
YYModelOverrideMethod;
+ (NSDictionary *)modelCustomPropertyMapper
{
    return @{@"_id":@"id"};
}
@end
