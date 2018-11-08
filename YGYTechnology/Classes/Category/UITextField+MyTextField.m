//
//  UITextField+MyTextField.m
//  QATeacher
//
//  Created by sansa on 06/06/2017.
//  Copyright © 2017 sansa. All rights reserved.
//

#import "UITextField+MyTextField.h"

@implementation UITextField (myTextField)

+(MyTextField *)createTextFieldWithPlace:(NSString *)place withColor:(UIColor *)color{
    MyTextField *textField = [MyTextField new];
    textField.textColor = color;
    textField.placeholder = place;
    [textField setValue:Color(0x999999) forKeyPath:@"_placeholderLabel.textColor"];
    textField.font = Font(14);
    return textField;
}

@end

@implementation MyTextField

//- (CGRect)rightViewRectForBounds:(CGRect)bounds{
//    CGRect rightRect = [super rightViewRectForBounds:bounds];
//    rightRect.origin.x -= 10; //左边偏10
//    return rightRect;
//}
//
//- (CGRect)textRectForBounds:(CGRect)bounds{
//    CGRect textRect = [super textRectForBounds:bounds];
//    textRect.origin.x += 10; //右边偏10
//    return textRect;
//}

@end
