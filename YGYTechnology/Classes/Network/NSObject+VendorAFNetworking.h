//
//  NSObject+VendorAFNetworking.h
//  dotaUnity
//
//  Created by admin on 16/4/26.
//  Copyright © 2016年 cc_company. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (VendorAFNetworking)

+ (void)GETNew:(NSString *)URLString parameters:(id)parameters completionHandler:(void (^)(id responsObject, NSError *error))completionHandler;


+ (void)POSTNew:(NSString *)URLString parameters:(id)parameters completionHandler:(void (^)(id responsObject, NSError *error))completionHandler;


@end
