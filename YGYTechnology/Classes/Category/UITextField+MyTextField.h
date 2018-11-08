//
//  UITextField+MyTextField.h
//  QATeacher
//
//  Created by sansa on 06/06/2017.
//  Copyright © 2017 sansa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyTextField : UITextField

@end

@interface UITextField (myTextField)

+(MyTextField *)createTextFieldWithPlace:(NSString *)place withColor:(UIColor *)color;

@end
