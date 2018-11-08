//
//  NSDictionary+MyDictionary.m
//  ConsultAPP
//
//  Created by sansa on 12/06/2017.
//  Copyright © 2017 WD. All rights reserved.
//

#import "NSDictionary+MyDictionary.h"

@implementation NSMutableDictionary (MyDictionary)

-(void)setMyObject:(NSObject *)obj forKey:(NSString *)key{
    if (obj) {
        [self setObject:obj forKey:key];
    }
}

@end
