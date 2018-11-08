//
//  UIControl+NotReClick.h
//  HuaRen
//
//  Created by PG-Allen on 2016/10/18.
//  Copyright © 2016年 zhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>

@interface UIControl (NotReClick)

@property (nonatomic, assign) NSTimeInterval cs_acceptEventInterval; // 重复点击的间隔
@property (nonatomic, assign) NSTimeInterval cs_acceptEventTime;
@property (nonatomic, copy) NSString *event_id;//埋点事件的id

@end
