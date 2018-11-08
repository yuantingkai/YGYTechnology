//
//  YGYBaseViewModel.m
//  YGYTechnology
//
//  Created by 袁庭楷 on 2018/9/26.
//  Copyright © 2018年 YGY. All rights reserved.
//

#import "YGYBaseViewModel.h"

@implementation YGYBaseViewModel

/** 发送post请求
 @param urlStr 请求的url
 @param params 请求的参数
 @param responseDataModel 返回数据被解析成的数据
 */
+(void) postRequestWithPath:(NSString *)path parameters:(NSDictionary *)params responseDataModel:(Class)responseDataModel success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure{
    
    if (![self getNetStatus]) {
        //网络断开时，直接返回
        NSError *error = [[NSError alloc] initWithDomain:NO_Network code:WDNetError userInfo:nil];
        if (failure) {
            failure(error);
        }
        return;
    }
    SLog(@"request post params is   %@",params);
    
    [NSObject POSTNew:path parameters:params completionHandler:^(id responsObject, NSError *error)
     {
         if (error == nil)
         {
             //             id jsonObject = [NSJSONSerialization JSONObjectWithData:responsObject
             //                                                             options:NSJSONReadingAllowFragments
             //                                                               error:nil];
             id response = [responseDataModel modelFromJson:responsObject];
             success(response);
         }
         else
         {
             if (failure) {
                 failure(error);
             }
         }
     }];
}

/** 发送get请求
 @param urlStr 请求的url
 @param params 请求的参数
 @param responseDataModel 返回数据被解析成的数据
 */
+(void)getRequestWithPath:(NSString *)path parameters:(NSDictionary *)params responseDataModel:(Class)responseDataModel success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure{
    
    if (![self getNetStatus]) {
        //网络断开时，直接返回
        NSError *error = [[NSError alloc] initWithDomain:NO_Network code:WDNetError userInfo:nil];
        if (failure) {
            failure(error);
        }
        return;
    }
    //    SLog(@"请求链接%@%@ %@",BASEURL,path, params);
    
    [NSObject GETNew:path parameters:params completionHandler:^(id responsObject, NSError *error)
     {
         if (error == nil)
         {
             //             id jsonObject = [NSJSONSerialization JSONObjectWithData:responsObject
             //                                                             options:NSJSONReadingAllowFragments
             //                                                               error:nil];
             id resonse = [responseDataModel modelFromJson:responsObject];
             success(resonse);
         }
         else
         {
             if (failure) {
                 failure(error);
             }
         }
     }];
}

#pragma mark --网络状态
+ (BOOL)getNetStatus {
    return [Reachability reachabilityForInternetConnection].currentReachabilityStatus;
}

@end
