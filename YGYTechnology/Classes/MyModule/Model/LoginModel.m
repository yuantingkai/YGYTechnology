//
//  LoginModel.m
//  YGYTechnology
//
//  Created by 袁庭楷 on 2018/10/5.
//  Copyright © 2018年 YGY. All rights reserved.
//

#import "LoginModel.h"

@implementation LoginModel
YYModelOverrideMethod;
@end

@implementation LoginData
YYModelOverrideMethod;
// 数组才需要解析
//+ (NSDictionary *)modelContainerPropertyGenericClass {
//    return @{@"nodes" : [WDChildNodesStaffNodes class],@"users" : [WDChildNodesStaffUsers class]};
//}
//替换系统关键字
+ (NSDictionary *)modelCustomPropertyMapper
{
    return @{@"_id":@"id"};
}
@end
