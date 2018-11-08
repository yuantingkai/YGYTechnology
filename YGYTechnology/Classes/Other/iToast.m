//
//  iToast.m
//  YTCoreFoundation
//
//  Created by huangfan on 15/5/18.
//  Copyright (c) 2015年 allkids. All rights reserved.
//

#import "iToast.h"

static iToastSettings *sharedSettings = nil;

@interface iToast(private)

- (iToast *)settings;

@end


@implementation iToast


- (id)initWithText:(NSString *)tex {
	if (self = [super init]) {
		text = [tex copy];
	}
	
	return self;
}

+ (void)showMessage:(NSString *)msg {
    iToast *toast = [iToast makeText:msg];
    [toast showWithStyle:iToastGravityCenter];
}

+ (void)showMessage:(NSString *)msg withStyle:(iToastGravity)style{
    iToast *toast = [iToast makeText:msg];
    [toast showWithStyle:iToastGravityCenter];
}

- (void)showWithStyle:(iToastGravity)style {
	[self theSettings].gravity = style;
    iToastSettings *theSettings = _settings;

	UIFont *font = [UIFont systemFontOfSize:16];
	CGSize textSize = [text boundingRectWithSize:CGSizeMake(280, 60)
                         options:(NSStringDrawingUsesFontLeading|NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin)
                      attributes:@{NSFontAttributeName:font}
                         context:NULL].size;
	
	UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, textSize.width + 5, 50)];
	label.backgroundColor = [UIColor clearColor];
    label.textAlignment = NSTextAlignmentCenter;
	label.textColor = [UIColor whiteColor];
	label.font = font;
	label.text = text;
	label.numberOfLines = 0;
//	label.shadowColor = [UIColor darkGrayColor];
	label.shadowOffset = CGSizeMake(1, 1);
	
	UIButton *v = [UIButton buttonWithType:UIButtonTypeCustom];
	v.frame = CGRectMake(0, 0, textSize.width + 34, textSize.height + 10);
	label.center = CGPointMake(v.frame.size.width / 2, v.frame.size.height / 2);
	[v addSubview:label];
	
	v.backgroundColor = [ColorFormatter hex2Color:0x000000 withAlpha:.7];
	v.layer.cornerRadius = 10;
	
	UIWindow *window = [[[UIApplication sharedApplication] windows] objectAtIndex:0];
	
	CGPoint point = CGPointZero;
	
	if (theSettings.gravity == iToastGravityTop) {
		point = CGPointMake(window.frame.size.width / 2, 45);
	}else if (theSettings.gravity == iToastGravityBottom) {
		point = CGPointMake(window.frame.size.width / 2, window.frame.size.height - 45);
	}else if (theSettings.gravity == iToastGravityCenter) {
		point = CGPointMake(window.frame.size.width/2, window.frame.size.height/2);
	}else{
		point = theSettings.postition;
	}
	
	point = CGPointMake(point.x + offsetLeft, point.y + offsetTop);
	v.center = point;
	
	NSTimer *timer1 = [NSTimer
					   timerWithTimeInterval:((float)theSettings.duration)/1000
					   target:self
					   selector:@selector(hideToast:)
					   userInfo:nil
					   repeats:NO];
	[[NSRunLoop mainRunLoop] addTimer:timer1 forMode:NSDefaultRunLoopMode];
	
	[window addSubview:v];
	
	view = v;
	
	[v addTarget:self action:@selector(hideToast:) forControlEvents:UIControlEventTouchDown];
}

- (void)showOnView:(UIView *)superView withStyle:(iToastGravity)style {
	[self theSettings].gravity = style;
    iToastSettings *theSettings = _settings;
    
	UIFont *font = [UIFont systemFontOfSize:16];
    CGSize textSize = [text boundingRectWithSize:CGSizeMake(280, 60)
                                         options:(NSStringDrawingUsesFontLeading|NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin)
                                      attributes:@{NSFontAttributeName:font}
                                         context:NULL].size;
	
	UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, textSize.width + 72, textSize.height + 5)];
	label.backgroundColor = [UIColor clearColor];
	label.textColor = [UIColor whiteColor];
	label.font = font;
	label.text = text;
	label.numberOfLines = 0;
//	label.shadowColor = [UIColor darkGrayColor];
	label.shadowOffset = CGSizeMake(1, 1);
    label.textAlignment = NSTextAlignmentCenter;
	UIButton *v = [UIButton buttonWithType:UIButtonTypeCustom];
	v.frame = CGRectMake(0, 0, textSize.width + 10, textSize.height + 10);
	label.center = CGPointMake(v.frame.size.width / 2, v.frame.size.height / 2);
	[v addSubview:label];
	
	v.backgroundColor = Color(0x7f7f7f);
	v.layer.cornerRadius = 5;
    v.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin |
    UIViewAutoresizingFlexibleTopMargin |UIViewAutoresizingFlexibleBottomMargin;
    
    UIView *containerView = nil;
    if (superView) {
        containerView = superView;
    }
    else {
        UIWindow *window = [[[UIApplication sharedApplication] windows] objectAtIndex:0];
        UIView *topView = [[window subviews] lastObject];
        containerView = topView;
    }
    
    CGPoint point = CGPointZero;
    if (theSettings.gravity == iToastGravityTop) {
        point = CGPointMake(containerView.bounds.size.width / 2, 45);
    }else if (theSettings.gravity == iToastGravityBottom) {
        point = CGPointMake(containerView.bounds.size.width / 2, containerView.bounds.size.height - 45);
    }else if (theSettings.gravity == iToastGravityCenter) {
        point = CGPointMake(containerView.bounds.size.width/2, containerView.bounds.size.height/2);
    }else{
        point = theSettings.postition;
    }
    
    point = CGPointMake(point.x + offsetLeft, point.y + offsetTop);
    v.center = point;
    
    NSTimer *timer1 = [NSTimer
                       timerWithTimeInterval:((float)theSettings.duration)/1000
                       target:self
                       selector:@selector(hideToast:)
                       userInfo:nil
                       repeats:NO];
    [[NSRunLoop mainRunLoop] addTimer:timer1 forMode:NSDefaultRunLoopMode];
    
    [containerView addSubview:v];
	
	view = v;
	
	[v addTarget:self action:@selector(hideToast:) forControlEvents:UIControlEventTouchDown];
}


- (void) hideToast:(NSTimer *)theTimer {
	[UIView beginAnimations:nil context:NULL];
	view.alpha = 0;
	[UIView commitAnimations];
	
	NSTimer *timer2 = [NSTimer
					   timerWithTimeInterval:500
					   target:self
					   selector:@selector(hideToast:)
					   userInfo:nil
					   repeats:NO];
	[[NSRunLoop mainRunLoop] addTimer:timer2 forMode:NSDefaultRunLoopMode];
}

- (void)removeToast:(NSTimer *)theTimer {
	[view removeFromSuperview];
}


+ (iToast *)makeText:(NSString *)_text {
	iToast *toast = [[iToast alloc] initWithText:_text];
	
	return toast;
}


- (iToast *)setDuration:(NSInteger)duration {
	[self theSettings].duration = duration;
	return self;
}

- (iToast *)setGravity:(iToastGravity)gravity
            offsetLeft:(NSInteger)left
             offsetTop:(NSInteger)top {
	[self theSettings].gravity = gravity;
	offsetLeft = left;
	offsetTop = top;
	return self;
}

- (iToast *)setGravity:(iToastGravity)gravity {
	[self theSettings].gravity = gravity;
	return self;
}

- (iToast *)setPostion:(CGPoint)_position {
	[self theSettings].postition = CGPointMake(_position.x, _position.y);
	
	return self;
}

- (iToastSettings *)theSettings {
	if (!_settings) {
		_settings = [[iToastSettings getSharedSettings] copy];
	}
	
	return _settings;
}

@end


@implementation iToastSettings
@synthesize duration;
@synthesize gravity;
@synthesize postition;
@synthesize images;

- (void)setImage:(UIImage *)img forType:(iToastType)type {
	if (!images) {
		images = [[NSMutableDictionary alloc] initWithCapacity:4];
	}
	
	if (img) {
		NSString *key = [NSString stringWithFormat:@"%i", type];
		[images setValue:img forKey:key];
	}
}


+ (iToastSettings *)getSharedSettings {
	if (!sharedSettings) {
		sharedSettings = [iToastSettings new];
		sharedSettings.gravity = iToastGravityBottom;
		sharedSettings.duration = iToastDurationShort;
	}
	
	return sharedSettings;
}

- (id)copyWithZone:(NSZone *)zone {
	iToastSettings *copy = [iToastSettings new];
	copy.gravity = self.gravity;
	copy.duration = self.duration;
	copy.postition = self.postition;
	
	NSArray *keys = [self.images allKeys];
	
	for (NSString *key in keys){
		[copy setImage:[images valueForKey:key] forType:[key intValue]];
	}
	
	return copy;
}

@end
