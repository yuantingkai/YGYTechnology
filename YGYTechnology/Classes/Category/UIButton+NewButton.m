//
//  UIButton+NewButton.m
//  ConsultAPP
//
//  Created by StormVCC on 2017/8/21.
//  Copyright © 2017年 WD. All rights reserved.
//

#import "UIButton+NewButton.h"

@implementation UIButton (NewButton)

+(UIButton *)newWithTitle:(NSString *)text font:(float)font textColor:(UIColor *)textColor textAlignment:(NSTextAlignment)textAlignment Image:(UIImage *)image
{
    UIButton *new = [UIButton buttonWithType:UIButtonTypeCustom];
    [new setImage:image forState:UIControlStateNormal];
    [new setTitle:text forState:UIControlStateNormal];
    [new setTitleColor:textColor forState:UIControlStateNormal];
    new.font = Font(font);
    
    new.lineBreakMode = NSLineBreakByTruncatingTail;
    new.titleLabel.textAlignment = textAlignment;
    return new;
}

@end
