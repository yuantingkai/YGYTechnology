//
//  GetSdtListModel.m
//  YGYTechnology
//
//  Created by 袁庭楷 on 2018/10/15.
//  Copyright © 2018年 YGY. All rights reserved.
//

#import "GetSdtListModel.h"

@implementation GetSdtListModel
YYModelOverrideMethod;
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"data" : [GetSdtListData class]};
}
@end

@implementation GetSdtListData
YYModelOverrideMethod;

@end
