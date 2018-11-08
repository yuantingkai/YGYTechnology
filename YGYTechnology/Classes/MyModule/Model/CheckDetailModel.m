//
//  CheckDetailModel.m
//  YGYTechnology
//
//  Created by 袁庭楷 on 2018/10/9.
//  Copyright © 2018年 YGY. All rights reserved.
//

#import "CheckDetailModel.h"

@implementation CheckDetailModel
YYModelOverrideMethod;
@end

@implementation CheckDetailData
YYModelOverrideMethod;
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"pageData" : [CheckDetailPageData class]};
}
@end

@implementation CheckDetailPageData
YYModelOverrideMethod;
@end
