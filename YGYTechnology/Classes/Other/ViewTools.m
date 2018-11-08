//
//  ViewTools.m
//  YGYTechnology
//
//  Created by 袁庭楷 on 2018/9/29.
//  Copyright © 2018年 YGY. All rights reserved.
//

#import "ViewTools.h"

@implementation ViewTools

#pragma mark 手机号码
+ (BOOL)validatePhone:(NSString *)phone
{
    if (phone.length != 11) {
        return NO;
    }else{
        return YES;
    }
    //    NSString *numberRegex = @"[1][34578]\\d{9}";
    //    NSPredicate *numberPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",numberRegex];
    //    return [numberPredicate evaluateWithObject:mobileNum];
    
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    //    NSString * MOBILE = @"^1(3[0-9]|4[0-9]|5[0-9]|7[0-9]|8[02345-9])\\d{8}$";
    //    /**
    //     10         * 中国移动：China Mobile
    //     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,178,182,187,188
    //     12         */
    //    NSString * CM = @"^1(34[0-9]|(3[5-9]|5[017-9]|7[16]|8[278])\\d)\\d{7}$";
    //    /**
    //     15         * 中国联通：China Unicom
    //     16         * 130,131,132,152,155,156,185,186,171,176
    //     17         */
    //    NSString * CU = @"^1(3[0-2]|5[256]|7[0-9]|8[56])\\d{8}$";
    //    /**
    //     20         * 中国电信：China Telecom
    //     21         * 133,1349,153,180,181,189,170,172,177
    //     22         */
    //    NSString * CT = @"^1((33|53|8[019])[0-9]|349)\\d{7}$";
    //    /**
    //     25         * 大陆地区固话及小灵通
    //     26         * 区号：010,020,021,022,023,024,025,027,028,029
    //     27         * 号码：七位或八位
    //     28         */
    //    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    //
    //    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    //    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    //    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    //    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    //
    //    if (([regextestmobile evaluateWithObject:phone] == YES)
    //        || ([regextestcm evaluateWithObject:phone] == YES)
    //        || ([regextestct evaluateWithObject:phone] == YES)
    //        || ([regextestcu evaluateWithObject:phone] == YES))
    //    {
    //        if([regextestcm evaluateWithObject:phone] == YES) {
    //            //NSLog(@"China Mobile");
    //        } else if([regextestct evaluateWithObject:phone] == YES) {
    //            //NSLog(@"China Telecom");
    //        } else if ([regextestcu evaluateWithObject:phone] == YES) {
    //            //NSLog(@"China Unicom");
    //        } else {
    //            //NSLog(@"Unknow");
    //        }
    //
    //        return YES;
    //    }
    //    else
    //    {
    //        return NO;
    //    }
}

#pragma mark 判断屏幕尺寸
+(NSInteger )screenFrame
{
    if (SCREEN_WIDTH==320.000000 && SCREEN_HEIGHT==480.000000)
    {
        return 0;
    }
    else if (SCREEN_WIDTH==320.000000 && SCREEN_HEIGHT==568.000000)
    {
        return 1;
    }
    else if (SCREEN_WIDTH==375.000000 && SCREEN_HEIGHT==667.000000)
    {
        return 2;
    }
    else if(SCREEN_WIDTH==414.000000 &&SCREEN_HEIGHT == 736.000000)
    {
        return 3;
    }else{
        return 4;
    }
    return 0;
}


#pragma mark  渐变色导航栏
+ (UIView *)createGradientLayerNav_BarViewWithString:(NSString *)title
{
    UIView * topView = [[UIView alloc]init];
    topView.frame=CGRectMake(0, 0, SCREEN_WIDTH, kStatusBarHeight+44);
    //初始化渐变色
    CAGradientLayer * gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(__bridge id)[ColorFormatter hex2Color:0x6F8AF9].CGColor, (__bridge id)[ColorFormatter hex2Color:0x8033CB].CGColor];
    gradientLayer.locations = @[@0.1, @1.0];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1, 0);
    gradientLayer.frame = CGRectMake(0, 0, SCREEN_WIDTH,kStatusBarHeight+44);
    [topView.layer addSublayer:gradientLayer];
    
    UILabel * dealLabel = [[UILabel alloc]init];
    [topView addSubview:dealLabel];
    
    dealLabel.text = title;
    dealLabel.textAlignment = NSTextAlignmentCenter;
    dealLabel.textColor = [UIColor whiteColor];
    dealLabel.font = Font(16);
    
//    topView.backgroundColor = [UIColor blueColor];
    topView.userInteractionEnabled=YES;
    topView.frame=CGRectMake(0, 0, SCREEN_WIDTH, kStatusBarHeight+44);
    dealLabel.frame=CGRectMake((SCREEN_WIDTH-200)/2, kStatusBarHeight, 200, 44);

    
    return topView;
}

#pragma mark  导航栏
+ (UIView *)createNav_BarViewWithString:(NSString *)title
{
    UIView * topView = [[UIView alloc]init];
    topView.frame=CGRectMake(0, 0, SCREEN_WIDTH, kStatusBarHeight+44);
    UILabel * dealLabel = [[UILabel alloc]init];
    [topView addSubview:dealLabel];
    dealLabel.text = title;
    dealLabel.textAlignment = NSTextAlignmentCenter;
    dealLabel.textColor = [UIColor whiteColor];
    dealLabel.font = Font(16);
    
//        topView.backgroundColor = [UIColor blueColor];
    topView.userInteractionEnabled=YES;
    topView.frame=CGRectMake(0, 0, SCREEN_WIDTH, kStatusBarHeight+44);
    dealLabel.frame=CGRectMake((SCREEN_WIDTH-200)/2, kStatusBarHeight, 200, 44);
    
    
    return topView;
}

@end
