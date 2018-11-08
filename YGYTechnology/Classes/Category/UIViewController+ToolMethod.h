//
//  UIViewController+ToolMethod.h
//  ConsultAPP
//
//  Created by StormVCC on 2017/10/12.
//  Copyright © 2017年 WD. All rights reserved.
//

#import <UIKit/UIKit.h>
#define LineColor UIColorFromRGB(0xf0f0f0)
#define kNavTitleViewTag 0x440
#define kNavViewTag 0x441
#define kNavViewLineViewTag 0x442
#define kNavViewBtnTag 0x550

#define kNavControlBottom -5
#define kNavControlImgBottom -10

@interface UIViewController (ToolMethod)
- (void)backToSuperiorVc;
- (UIView *)newWhiteBgBlackTitleNavBar:(NSString *)title;
- (UIView *)newWhiteBgBlackTitleNavBar:(NSString *)title action:(SEL)action;
- (UIView *)newWhiteBgBlackTitleNavBarNoLine:(NSString *)title;
- (void)uploadImageWithPath:(NSString *)path photos:(NSArray *)photos params:(NSDictionary *)params constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block success:(void(^)(id json))success failure:(void(^)(void))failure;
@end
