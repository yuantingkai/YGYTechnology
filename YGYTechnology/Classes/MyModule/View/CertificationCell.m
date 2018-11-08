//
//  CertificationCell.m
//  YGYTechnology
//
//  Created by 袁庭楷 on 2018/10/2.
//  Copyright © 2018年 YGY. All rights reserved.
//

#import "CertificationCell.h"
#define MAX_NAME_LENGTH 10
@implementation CertificationCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUI];
        [self addNameTFMethod];
        
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textFieldchanged:) name:UITextFieldTextDidChangeNotification object:_identityCardTF];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textFieldchanged:) name:UITextFieldTextDidChangeNotification object:_phoneTF];
    }
    return self;
}

-(void)setUI{
    self.backgroundColor = Color(0xf2f2f2);
    _topView = [UIView new];
    _topView.layer.cornerRadius = 8;
    _topView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_topView];
    [_topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(14);
        make.right.offset(-14);
        make.height.mas_offset(150);
        make.top.offset(0);
    }];
    
    UIView *nameView = [UIView new];
    nameView.backgroundColor = [UIColor clearColor];
    [_topView addSubview:nameView];
    [nameView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.offset(0);
        make.height.mas_offset(50);
    }];
    
    UILabel *nameLabel = [UILabel newWithText:@"真实姓名" fontSize:14 textColor:MAIN_BODY textAlignment:NSTextAlignmentLeft];
    [nameView addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(nameView);
        make.left.offset(14);
        make.width.mas_offset(70);
    }];
    
    _nameTF = [UITextField createTextFieldWithPlace:@"请输入真实姓名" withColor:[ColorFormatter hex2Color:0x8890a4 withAlpha:1]];
    [_nameTF setValue:[ColorFormatter hex2Color:0x8890a4 withAlpha:1] forKeyPath:@"_placeholderLabel.textColor"];
    _nameTF.backgroundColor = [UIColor clearColor];
    _nameTF.borderStyle = UITextBorderStyleNone;
    _nameTF.delegate = self;
    //    pwdTextField.secureTextEntry = YES;
    [nameView addSubview:_nameTF];
    [_nameTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(nameLabel.mas_right).offset(15);
        make.right.equalTo(nameView).offset(-10);
        make.centerY.equalTo(nameView);
    }];
    
    
    
    
    UIView *nameLineView = [UIView new];
    nameLineView.backgroundColor = LINE_COLOR;
    [nameView addSubview:nameLineView];
    [nameLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.offset(0);
        make.height.mas_offset(1);
        make.left.offset(14);
        make.right.offset(-14);
    }];
    
    UIView *positiveView = [UIView new];
    nameView.backgroundColor = [UIColor clearColor];
    [_topView addSubview:positiveView];
    [positiveView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.height.mas_offset(50);
        make.top.equalTo(nameView.mas_bottom).offset(0);
    }];
    
    UILabel *positiveLabel = [UILabel newWithText:@"身份证号" fontSize:14 textColor:MAIN_BODY textAlignment:NSTextAlignmentLeft];
    [positiveView addSubview:positiveLabel];
    [positiveLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(positiveView);
        make.left.offset(14);
        make.width.mas_offset(70);
    }];
    
    _identityCardTF = [UITextField createTextFieldWithPlace:@"请输入身份证号" withColor:[ColorFormatter hex2Color:0x8890a4 withAlpha:1]];
    [_identityCardTF setValue:[ColorFormatter hex2Color:0x8890a4 withAlpha:1] forKeyPath:@"_placeholderLabel.textColor"];
    _identityCardTF.backgroundColor = [UIColor clearColor];
    _identityCardTF.borderStyle = UITextBorderStyleNone;
    _identityCardTF.keyboardType = UIKeyboardTypeNumberPad;
    _identityCardTF.delegate = self;
    //    pwdTextField.secureTextEntry = YES;
    [positiveView addSubview:_identityCardTF];
    [_identityCardTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(positiveLabel.mas_right).offset(15);
        make.right.offset(-10);
        make.centerY.equalTo(positiveLabel);
    }];
    
    
    
    UIView *positiveLineView = [UIView new];
    positiveLineView.backgroundColor = LINE_COLOR;
    [positiveView addSubview:positiveLineView];
    [positiveLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.offset(0);
        make.height.mas_offset(1);
        make.left.offset(14);
        make.right.offset(-14);
    }];
    
    UIView *phoneView = [UIView new];
    nameView.backgroundColor = [UIColor clearColor];
    [_topView addSubview:phoneView];
    [phoneView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.height.mas_offset(50);
        make.top.equalTo(positiveView.mas_bottom).offset(0);
    }];
    
    UILabel *phoneLabel = [UILabel newWithText:@"手机号码" fontSize:14 textColor:MAIN_BODY textAlignment:NSTextAlignmentLeft];
    [phoneView addSubview:phoneLabel];
    [phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(phoneView);
        make.width.mas_offset(70);
        make.left.offset(14);
    }];
    
    _phoneTF = [UITextField createTextFieldWithPlace:@"请输入手机号码" withColor:[ColorFormatter hex2Color:0x8890a4 withAlpha:1]];
    [_phoneTF setValue:[ColorFormatter hex2Color:0x8890a4 withAlpha:1] forKeyPath:@"_placeholderLabel.textColor"];
    _phoneTF.backgroundColor = [UIColor clearColor];
    _phoneTF.borderStyle = UITextBorderStyleNone;
    _phoneTF.keyboardType = UIKeyboardTypeNumberPad;
    _phoneTF.delegate = self;
    //    pwdTextField.secureTextEntry = YES;
    [phoneView addSubview:_phoneTF];
    [_phoneTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(phoneLabel.mas_right).offset(15);
        make.right.offset(-10);
        make.centerY.equalTo(phoneLabel);
    }];
    
    //194 144
    _identityCardView = [UIView new];
    _identityCardView.layer.cornerRadius = 8;
    _identityCardView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_identityCardView];
    [_identityCardView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(0);
        make.left.offset(14);
        make.right.offset(-14);
        make.height.mas_offset(194);
    }];
    
    _identityCardlabel = [UILabel newWithText:@"身份证正面照" fontSize:14 textColor:MAIN_BODY textAlignment:NSTextAlignmentLeft];
    [_identityCardView addSubview:_identityCardlabel];
    [_identityCardlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(10);
        make.left.offset(14);
    }];
    
    _identityCardImageView = [UIImageView new];
    _identityCardImageView.backgroundColor = YGYColor(245, 245, 245);
    _identityCardImageView.layer.cornerRadius = 8;
    _identityCardImageView.layer.masksToBounds = YES;
    _identityCardImageView.contentMode =UIViewContentModeScaleAspectFill;
    _identityCardImageView.clipsToBounds = YES;
    [_identityCardView addSubview:_identityCardImageView];
    [_identityCardImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(14);
        make.right.offset(-14);
        make.height.mas_offset(144);
        make.bottom.offset(-10);
    }];
    _picView = [UIView new];
    [_identityCardImageView addSubview:_picView];
    [_picView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.offset(0);
    }];;
    
    UIImageView *picImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"xiangji"]];
    [_picView addSubview:picImage];
    [picImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.identityCardImageView);
        make.centerY.equalTo(self.identityCardImageView).offset(-14);
    }];
    
    UILabel *uploadLabel = [UILabel newWithText:@"点击上传" fontSize:14 textColor:MAIN_BODY textAlignment:NSTextAlignmentCenter];
    [_picView addSubview:uploadLabel];
    [uploadLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(picImage.mas_bottom).offset(14);
        make.centerX.equalTo(picImage);
    }];
    
}

-(void)setIndexPath:(NSIndexPath *)indexPath{
    _indexPath = indexPath;
    if (_indexPath.section == 0) {
        _topView.hidden = NO;
        _identityCardView.hidden = YES;
    }else if (_indexPath.section == 1){
        _topView.hidden = YES;
        _identityCardView.hidden = NO;
        _identityCardlabel.text = @"身份证正面照";
    }else if (_indexPath.section == 2){
        _topView.hidden = YES;
        _identityCardView.hidden = NO;
        _identityCardlabel.text = @"身份证反面照";
    }
}


-(void)textFieldchanged:(NSNotification *)notification{
    //限制符号输入
    //    NSString *characterStr = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    NSString *characterStr = @"";
    UITextField *textField = (UITextField *)notification.object;
    if (textField == _identityCardTF){
        characterStr = @"0123456789";
        if (textField.text.length > 18) {
            textField.text = [textField.text substringToIndex:18];
        }
        //回调身份证号
        self.identityCardBlock(textField.text);
    }else if (textField == _phoneTF){
        characterStr = @"0123456789";
        if (textField.text.length > 11) {
            textField.text = [textField.text substringToIndex:11];
        }
        //回调手机号码
        self.phoneBlock(textField.text);
    }
    NSCharacterSet *nameCharacters = [[NSCharacterSet characterSetWithCharactersInString:characterStr] invertedSet];
    if (textField.text.length < 1){
        return;
    }
    //取出最后一位
    NSString *lastStr = [textField.text substringFromIndex:textField.text.length-1];
    NSRange userNameRange = [lastStr rangeOfCharacterFromSet:nameCharacters];
    //最后一位是特殊字符
    if (userNameRange.location != NSNotFound) {
        textField.text = [textField.text substringToIndex:(textField.text.length - 1)];
    }
    
}

#pragma mark - 监听姓名方法
-(void)addNameTFMethod{
    
    [_nameTF addTarget:self action:@selector(NameTFChange:) forControlEvents:UIControlEventEditingChanged];
}

-(void)NameTFChange:(UITextField *)textField{
    if (textField.markedTextRange == nil) {
        //正则表达式 不允许有特殊字符
        NSString * regex = @"^[A-Za-z0-9\u4E00-\u9FA5_-]+$";
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
        BOOL isMatch = [pred evaluateWithObject:textField.text];
        if (textField.text.length > 0 ) {
            if (isMatch) {
                if (textField.text.length >= MAX_NAME_LENGTH) {
                    textField.text = [textField.text substringToIndex:MAX_NAME_LENGTH];
                }
            }else{
                textField.text = [textField.text substringToIndex:(textField.text.length - 1)];
            }
        }
    }
    //回调姓名
    self.nameBlock(textField.text);
//    SLog(@"textField1 - 输入框内容改变,当前内容为: %@",textField.text);
}

//必须销毁
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}





@end
