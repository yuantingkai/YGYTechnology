//
//  ColorFormatter.h
//  MyMarket
//
//  Created by chen on 16/3/13.
//  Copyright © 2016年 chen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define RGBA(r, g, b, a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define RGB(r, g, b)     [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]

@interface ColorFormatter : NSObject

/**
 hexValue 传值16进制数，eg：#f4f4f4    传值 0xf4f4f4, 首先将#f4f4f4转化为16进制数0xf4f4f4
 默认alpha为1.0
 */
+ (UIColor *)hex2Color:(NSInteger)hexValue;

/**
 hexValue 传值16进制数，eg：#f4f4f4    传值 0xf4f4f4, 首先将#f4f4f4转化为16进制数0xf4f4f4
 */
+ (UIColor *)hex2Color:(NSInteger)hexValue withAlpha:(CGFloat)a;

@end
