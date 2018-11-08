//
//  UILabel+NewLabel.h
//  QATeacher
//
//  Created by sansa on 17/06/01.
//  Copyright © 2017年 wenduing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (NewLabel)

//crate label
+ (UILabel *)newWithText:(NSString *)text fontSize:(CGFloat)fontSize textColor:(UIColor *)textColor textAlignment:(NSTextAlignment)textAlignment;

- (CGFloat)getWidthWithSize:(CGSize)size font:(CGFloat)fontsize;

- (CGFloat)getHeightWithSize:(CGSize)size font:(CGFloat)fontsize;

-(CGFloat)getSpaceLabelHeight:(NSString*)str withFont:(UIFont*)font withWidth:(CGFloat)width;

//给UILabel设置行间距和字间距
//-(void)setLabelSpaceWithValue:(NSString*)str withFont:(UIFont*)font;
-(CGFloat)getSpaceLabelWidth:(NSString*)str withFont:(UIFont*)font withMaxWidth:(CGFloat)maxwidth ;
+ (CGFloat)getLabelHeight:(NSString*)str withFont:(UIFont*)font withWidth:(CGFloat)width;
@end
