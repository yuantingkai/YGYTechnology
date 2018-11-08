//
//  ViewTools.h
//  YGYTechnology
//
//  Created by 袁庭楷 on 2018/9/29.
//  Copyright © 2018年 YGY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ViewTools : NSObject
#pragma mark 手机号码
+ (BOOL)validatePhone:(NSString *)phone;
#pragma mark 判断手机屏幕
+(NSInteger )screenFrame;
#pragma mark  渐变色导航栏
+ (UIView *)createGradientLayerNav_BarViewWithString:(NSString *)title;
#pragma mark 导航栏
+ (UIView *)createNav_BarViewWithString:(NSString *)title;
@end
