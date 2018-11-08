//
//  iToast.h
//  YTCoreFoundation
//
//  Created by huangfan on 15/5/18.
//  Copyright (c) 2015年 allkids. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

typedef enum iToastGravity {
	iToastGravityTop = 1000001,
	iToastGravityBottom,
	iToastGravityCenter
}iToastGravity;

typedef enum iToastDuration {
	iToastDurationLong = 10000,
	iToastDurationShort = 1000,
	iToastDurationNormal = 3000
}iToastDuration;

typedef enum iToastType {
	iToastTypeInfo = -100000,
	iToastTypeNotice,
	iToastTypeWarning,
	iToastTypeError
}iToastType;


@class iToastSettings;

@interface iToast : NSObject {
	iToastSettings *_settings;
	NSInteger offsetLeft;
	NSInteger offsetTop;
	NSTimer *timer;
	UIView *view;
	NSString *text;
}

/**
 显示消息，默认底部
 */
+ (void)showMessage:(NSString *)msg;
+ (void)showMessage:(NSString *)msg withStyle:(iToastGravity)style;

- (void)showWithStyle:(iToastGravity)style;
- (void)showOnView:(UIView *)superView withStyle:(iToastGravity)style;
- (iToast *)setDuration:(NSInteger)duration;
- (iToast *)setGravity:(iToastGravity)gravity
            offsetLeft:(NSInteger)left
             offsetTop:(NSInteger)top;
- (iToast *)setGravity:(iToastGravity)gravity;
- (iToast *)setPostion:(CGPoint)position;

+ (iToast *)makeText:(NSString *)text;

- (iToastSettings *)theSettings;

@end

@interface iToastSettings : NSObject<NSCopying> {
	NSInteger duration;
	iToastGravity gravity;
	CGPoint postition;
	iToastType toastType;
	
	NSDictionary *images;
	
	BOOL positionIsSet;
}

@property(assign) NSInteger duration;
@property(assign) iToastGravity gravity;
@property(assign) CGPoint postition;
@property(readonly) NSDictionary *images;


- (void)setImage:(UIImage *)img forType:(iToastType)type;
+ (iToastSettings *)getSharedSettings;

@end
