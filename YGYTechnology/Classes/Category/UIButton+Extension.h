//
//  UIButton+Extension.h
//  qaStudent
//
//  Created by Peter on 2017/6/23.
//  Copyright © 2017年 WD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Extension)

/**
 *  扩大按钮的响应范围（insets必须不被button的superview给挡住）
 */
@property (assign, nonatomic) UIEdgeInsets expandHitEdgeInsets;

@end
