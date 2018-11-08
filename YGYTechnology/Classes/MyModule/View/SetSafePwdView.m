//
//  SetSafePwdView.m
//  YGYTechnology
//
//  Created by 袁庭楷 on 2018/10/2.
//  Copyright © 2018年 YGY. All rights reserved.
//

#import "SetSafePwdView.h"
#define kDotSize CGSizeMake (10, 10) // 密码点的大小
#define kDotCount 6 // 密码个数
#define K_Field_Height self.frame.size.height // 每一个输入框的高度等于当前view的高度

@implementation SetSafePwdView
#pragma mark - 懒加载

- (NSMutableArray *)dotArr {
    if (!_dotArr) {
        _dotArr = [NSMutableArray array];
        
    }
    return _dotArr;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self){
        self.backgroundColor = [UIColor whiteColor];
        [self setupWithPswTextField];
        
    }
    return self;
}

- (void)setupWithPswTextField {
    // 每个密码输入框的宽度
    CGFloat width = self.frame.size.width / kDotCount;
    // 生成分割线
    for (int i = 0; i < kDotCount - 1; i++) {
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.pswTextField.frame) + (i + 1) * width, 0, 1, K_Field_Height)];
        lineView.backgroundColor = LINE_COLOR;
        [self addSubview:lineView];
    }
    self.dotArr = [[NSMutableArray alloc] init];
    // 生成中间的黑点
    for (int i = 0; i < kDotCount; i++) {
        UIView *dotView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.pswTextField.frame) + (width - kDotCount) / 2 + i * width, CGRectGetMinY(self.pswTextField.frame) + (K_Field_Height - kDotSize.height) / 2, kDotSize.width, kDotSize.height)];
        dotView.backgroundColor = [UIColor blackColor];
        dotView.layer.cornerRadius = kDotSize.width / 2.0f;
        dotView.clipsToBounds = YES;
        dotView.hidden = YES;// 首先隐藏
        [self addSubview:dotView];
        // 把创建的黑色点加入到存放数组中
        [self.dotArr addObject:dotView];
    }
}

#pragma mark - init
- (UITextField *)pswTextField {
    if (!_pswTextField) {
        _pswTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, K_Field_Height)];
        _pswTextField.backgroundColor = [UIColor clearColor]; // 输入的文字颜色为无色
        _pswTextField.textColor = [UIColor clearColor]; // 输入框光标的颜色为无色
        _pswTextField.tintColor = [UIColor clearColor]; _pswTextField.delegate = self;
        _pswTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        _pswTextField.keyboardType = UIKeyboardTypeNumberPad;
        _pswTextField.layer.borderColor = [LINE_COLOR CGColor];
        _pswTextField.layer.borderWidth = 1;
        [_pswTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        [self addSubview:_pswTextField];
    }
    return _pswTextField;
    
}

#pragma mark - 文本框内容改变 /** * 重置显示的点 */
- (void)textFieldDidChange:(UITextField *)textField {
    NSLog(@"目前输入显示----%@", textField.text);
    for (UIView *dotView in self.dotArr) {
        dotView.hidden = YES;
        
    }
    for (int i = 0; i < textField.text.length; i++) {
        ((UIView *)[self.dotArr objectAtIndex:i]).hidden = NO;
        
    }
    if (textField.text.length == kDotCount) {
        NSLog(@"---输入完毕---");
        [self.pswTextField resignFirstResponder];
        
    }
    // 获取用户输入密码
    !self.passwordDidChangeBlock ? : self.passwordDidChangeBlock(textField.text);
    
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSLog(@"输入变化%@", string);
    if([string isEqualToString:@"\n"]) {
        // 按回车关闭键盘
        [textField resignFirstResponder]; return NO;
    } else if(string.length == 0) {
        // 判断是不是删除键
        return YES;
    } else if(textField.text.length >= kDotCount) {
        // 输入的字符个数大于6，则无法继续输入，返回NO表示禁止输入
        NSLog(@"输入的字符个数大于6，后面禁止输入则忽略输入");
        return NO;
    } else {
        return YES;
    }
    
}

#pragma mark - publick method /** * 清除密码 */
- (void)clearUpPassword {
    [self.pswTextField resignFirstResponder];
    self.pswTextField.text = nil;
    [self textFieldDidChange:self.pswTextField];
    
}
@end

