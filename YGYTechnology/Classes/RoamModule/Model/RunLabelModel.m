//
//  RunLabelModel.m
//  YGYTechnology
//
//  Created by 袁庭楷 on 2018/10/19.
//  Copyright © 2018年 YGY. All rights reserved.
//

#import "RunLabelModel.h"

@implementation RunLabelModel
YYModelOverrideMethod;
@end

@implementation RunLabelData
YYModelOverrideMethod;
+ (NSDictionary *)modelCustomPropertyMapper
{
    return @{@"_id":@"id"};
}
@end
