//
//  NSObject+VendorAFNetworking.m
//  dotaUnity
//
//  Created by admin on 16/4/26.
//  Copyright © 2016年 cc_company. All rights reserved.
//

#import "NSObject+VendorAFNetworking.h"

@implementation NSObject (VendorAFNetworking)

+ (void)GETNew:(NSString *)URLString parameters:(id)parameters completionHandler:(void (^)(id responsObject, NSError *error))completionHandler
{
    AFHTTPSessionManager *sm = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:BASEURL]];
    sm.requestSerializer = [AFHTTPRequestSerializer serializer];
    sm.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    sm.requestSerializer.timeoutInterval = 30;
    sm.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"text/plain", @"text/json", @"text/javascript", @"application/json", nil];
    [sm GET:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        SLog(@"请求链接：%@%@",BASEURL,URLString);
        completionHandler(responseObject, nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        completionHandler(nil, error);
    }];
}

+ (void)POSTNew:(NSString *)URLString parameters:(id)parameters completionHandler:(void (^)(id responsObject, NSError *error))completionHandler
{
    AFHTTPSessionManager *sm = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:BASEURL]];
    sm.requestSerializer = [AFHTTPRequestSerializer serializer];
    sm.requestSerializer.timeoutInterval = 30;
    [sm.requestSerializer setValue:@"application/x-www-form-urlencoded;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    sm.responseSerializer = [AFHTTPResponseSerializer serializer];
    sm.responseSerializer = [AFJSONResponseSerializer serializer];
    sm.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"text/plain", @"text/json", @"text/javascript", @"application/json", nil];
    
    [sm POST:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject){
        SLog(@"请求链接：%@%@",BASEURL,URLString);
        completionHandler(responseObject, nil);
    }
     failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         completionHandler(nil, error);
     }];
}



@end
