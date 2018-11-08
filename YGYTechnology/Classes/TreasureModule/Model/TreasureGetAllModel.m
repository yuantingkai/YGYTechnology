//
//  TreasureGetAllModel.m
//  YGYTechnology
//
//  Created by 袁庭楷 on 2018/10/5.
//  Copyright © 2018年 YGY. All rights reserved.
//

#import "TreasureGetAllModel.h"

@implementation TreasureGetAllModel
YYModelOverrideMethod;
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"data" : [TreasureGetAllData class]};
}
@end

@implementation TreasureGetAllData
YYModelOverrideMethod;
+ (NSDictionary *)modelCustomPropertyMapper
{
    return @{@"_id":@"id"};
}
@end
