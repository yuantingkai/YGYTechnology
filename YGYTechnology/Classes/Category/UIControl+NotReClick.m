//
//  UIControl+NotReClick.m
//  HuaRen
//
//  Created by PG-Allen on 2016/10/18.
//  Copyright © 2016年 zhang. All rights reserved.
//

#import "UIControl+NotReClick.h"

@implementation UIControl (NotReClick)

// 因category不能添加属性，只能通过关联对象的方式。
static const char *UIControl_acceptEventInterval = "UIControl_acceptEventInterval";

- (NSTimeInterval)cs_acceptEventInterval {
    return  [objc_getAssociatedObject(self, UIControl_acceptEventInterval) doubleValue];
}

- (void)setCs_acceptEventInterval:(NSTimeInterval)cs_acceptEventInterval {
    objc_setAssociatedObject(self, UIControl_acceptEventInterval, @(cs_acceptEventInterval), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

static const char *UIControl_acceptEventTime = "UIControl_acceptEventTime";

- (NSTimeInterval)cs_acceptEventTime {
    return  [objc_getAssociatedObject(self, UIControl_acceptEventTime) doubleValue];
}

- (void)setCs_acceptEventTime:(NSTimeInterval)cs_acceptEventTime {
    objc_setAssociatedObject(self, UIControl_acceptEventTime, @(cs_acceptEventTime), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

static const char *UIControl_event_id = "event_id";

- (NSString *)event_id{
    return objc_getAssociatedObject(self, UIControl_event_id);
}

- (void)setEvent_id:(NSString *)event_id{
    objc_setAssociatedObject(self, UIControl_event_id, event_id, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

// 在load时执行hook
+ (void)load {
    Method before   = class_getInstanceMethod(self, @selector(sendAction:to:forEvent:));
    Method after    = class_getInstanceMethod(self, @selector(cs_sendAction:to:forEvent:));
    method_exchangeImplementations(before, after);
}

- (void)cs_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event {
    if (![NSStringFromSelector(action) hasPrefix:@"growingHook"]) {
        if ([NSDate date].timeIntervalSince1970 - self.cs_acceptEventTime < self.cs_acceptEventInterval) {
            return;
        }
        
        if (self.cs_acceptEventInterval > 0) {
            self.cs_acceptEventTime = [NSDate date].timeIntervalSince1970;
        }
    }
   
    [self cs_sendAction:action to:target forEvent:event];
    
    if (self.event_id.length > 0) {
        NSLog(@"event id is %@",self.event_id);
    }
}

@end
