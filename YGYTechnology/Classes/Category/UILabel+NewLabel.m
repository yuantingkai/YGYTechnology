//
//  UILabel+NewLabel.m
//  QATeacher
//
//  Created by sansa on 17/06/01.
//  Copyright © 2017年 wenduing. All rights reserved.
//

#import "UILabel+NewLabel.h"

@implementation UILabel (NewLabel)

#define  UILABEL_LINE_SPACE (6)
+ (UILabel *)newWithText:(NSString *)text fontSize:(CGFloat)fontSize textColor:(UIColor *)textColor textAlignment:(NSTextAlignment)textAlignment {
    UILabel *new = [UILabel new];
    new.text = text;
    new.numberOfLines = 0;
    new.font = Font(fontSize);
    new.textColor = textColor;
//    new.lineBreakMode = NSLineBreakByTruncatingTail;
    new.textAlignment = textAlignment;
    return new;
}

- (CGFloat)getWidthWithSize:(CGSize)size font:(CGFloat)fontsize {
    return [self.text boundingRectWithSize:CGSizeMake(size.width, size.height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontsize]} context:nil].size.width;
}

- (CGFloat)getHeightWithSize:(CGSize)size font:(CGFloat)fontsize {
    return [self.text boundingRectWithSize:CGSizeMake(size.width, size.height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontsize]} context:nil].size.height;
}

//给UILabel设置行间距和字间距
-(void)setLabelSpaceWithValue:(NSString*)str withFont:(UIFont*)font {
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paraStyle.alignment = NSTextAlignmentLeft;
    paraStyle.lineSpacing = UILABEL_LINE_SPACE; //设置行间距
//    paraStyle.hyphenationFactor = 0.0;
    paraStyle.firstLineHeadIndent = 0.0;
    paraStyle.paragraphSpacingBefore = 0.0;
    paraStyle.headIndent = 0;
    paraStyle.tailIndent = 0;
    //设置字间距 NSKernAttributeName:@1.5f
    NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paraStyle, NSKernAttributeName:@0.5f
                          };
    
    NSAttributedString *attributeStr = [[NSAttributedString alloc] initWithString:str attributes:dic];
    self.attributedText = attributeStr;
}

-(CGFloat)getSpaceLabelHeight:(NSString*)str withFont:(UIFont*)font withWidth:(CGFloat)width {
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paraStyle.alignment = NSTextAlignmentLeft;
    paraStyle.lineSpacing = UILABEL_LINE_SPACE;
//    paraStyle.hyphenationFactor = 1.0;//单词截断
    paraStyle.firstLineHeadIndent = 0.0;//首行缩进
    paraStyle.paragraphSpacingBefore = 0.0;//段与段之间的间距
    paraStyle.headIndent = 0;
    paraStyle.tailIndent = 0;
    NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paraStyle, NSKernAttributeName:@0.5f
                          };
    
    if (str  == nil) {
        str = @"";
    }
    NSAttributedString *attributeStr = [[NSAttributedString alloc] initWithString:str attributes:dic];
    self.attributedText = attributeStr;
    
    CGSize size = [str boundingRectWithSize:CGSizeMake(width, kSize.height) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    
    if (size.height <= 20 + UILABEL_LINE_SPACE) {
        //sing line
        paraStyle.lineSpacing = 0;
        NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paraStyle, NSKernAttributeName:@0.5f
                              };
    
        NSAttributedString *attributeStr = [[NSAttributedString alloc] initWithString:str attributes:dic];
        self.attributedText = attributeStr;
        
        CGSize size = [str boundingRectWithSize:CGSizeMake(width, kSize.height) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
        return size.height;
    }
    
    return size.height+.9;
}

-(CGFloat)getSpaceLabelWidth:(NSString*)str withFont:(UIFont*)font withMaxWidth:(CGFloat)maxwidth {
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paraStyle.alignment = NSTextAlignmentLeft;
    paraStyle.lineSpacing = UILABEL_LINE_SPACE;
    paraStyle.hyphenationFactor = 1.0;//单词截断
    paraStyle.firstLineHeadIndent = 0.0;//首行缩进
    paraStyle.paragraphSpacingBefore = 0.0;//段与段之间的间距
    paraStyle.headIndent = 0;
    paraStyle.tailIndent = 0;
    NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paraStyle, NSKernAttributeName:@0.5f
                          };
    CGSize size = [str boundingRectWithSize:CGSizeMake(maxwidth, kSize.height) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    return size.width;
}

+ (CGFloat)getLabelHeight:(NSString*)str withFont:(UIFont*)font withWidth:(CGFloat)width {
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paraStyle.alignment = NSTextAlignmentLeft;
    paraStyle.lineSpacing = UILABEL_LINE_SPACE;
    paraStyle.firstLineHeadIndent = 0.0;//首行缩进
    paraStyle.paragraphSpacingBefore = 0.0;//段与段之间的间距
    paraStyle.headIndent = 0;
    paraStyle.tailIndent = 0;
    NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paraStyle, NSKernAttributeName:@0.5f
                          };
    
    if (str  == nil) {
        str = @"";
    }
    //NSAttributedString *attributeStr = [[NSAttributedString alloc] initWithString:str attributes:dic];
    
    CGSize size = [str boundingRectWithSize:CGSizeMake(width, kSize.height) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    
    if (size.height <= 20 + UILABEL_LINE_SPACE) {
        //sing line
        paraStyle.lineSpacing = 0;
        NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paraStyle, NSKernAttributeName:@0.5f
                              };
        
        //NSAttributedString *attributeStr = [[NSAttributedString alloc] initWithString:str attributes:dic];
        
        CGSize size = [str boundingRectWithSize:CGSizeMake(width, kSize.height) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
        return size.height;
    }
    
    return size.height+.9;
}

@end
