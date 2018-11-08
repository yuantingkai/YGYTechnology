//
//  ColorFormatter.m
//  MyMarket
//
//  Created by chen on 16/3/13.
//  Copyright © 2016年 chen. All rights reserved.
//

#import "ColorFormatter.h"

@implementation ColorFormatter

+ (UIColor *)hex2Color:(NSInteger)hexValue
{
    return [self hex2Color:hexValue withAlpha:1.0];
}

+ (UIColor *)hex2Color:(NSInteger)hexValue withAlpha:(CGFloat)a
{
    return [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0
                           green:((float)((hexValue & 0xFF00) >> 8))/255.0
                            blue:((float)(hexValue & 0xFF))/255.0 alpha:a];
}

@end
