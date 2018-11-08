//
//  YGYBaseViewModel.h
//  YGYTechnology
//
//  Created by 袁庭楷 on 2018/9/26.
//  Copyright © 2018年 YGY. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    WDNetError = -1000
}NetError;

@interface YGYBaseViewModel : NSObject

/** 发送post请求 不用缓存～～～
 @param path 请求的url
 @param params 请求的参数
 @param responseDataModel 返回数据被解析成的数据
 */
+(void) postRequestWithPath:(NSString *)path parameters:(NSDictionary *)params responseDataModel:(Class)responseDataModel success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;

/** 发送get请求  不用缓存～～～
 @param path 请求的url
 @param params 请求的参数
 @param responseDataModel 返回数据被解析成的数据
 */
+(void) getRequestWithPath:(NSString *)path parameters:(NSDictionary *)params responseDataModel:(Class)responseDataModel success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;

@end
