//
//  NSObject+VendorYYModel.m
//  dotaUnity
//
//  Created by admin on 16/4/26.
//  Copyright © 2016年 cc_company. All rights reserved.
//

#import "NSObject+VendorYYModel.h"

@implementation NSObject (VendorYYModel)

+ (id)modelFromJson:(id)json
{
    if ([json isKindOfClass:[NSArray class]]) {
        return [NSArray yy_modelArrayWithClass:[self class] json:json];
    } else {
        return [[self class] yy_modelWithJSON:json];
    }
    
    return json;
}

+ (id)jsonFromModel:(id)model
{
    return [model yy_modelToJSONObject];
}



+ (NSString*)dictionaryToJson:(NSDictionary *)dic

{
    
    NSError *parseError = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:0 error:&parseError];
    NSString *str = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];

    return str;
    
}

+ (NSString*)mutableArrayToJson:(NSMutableArray *)arr

{
    
    NSError *parseError = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:arr options:0 error:&parseError];
    NSString *str = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    return str;
    
}

@end
