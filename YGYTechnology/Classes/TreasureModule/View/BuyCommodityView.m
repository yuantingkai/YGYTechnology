//
//  BuyCommodityView.m
//  YGYTechnology
//
//  Created by 袁庭楷 on 2018/10/3.
//  Copyright © 2018年 YGY. All rights reserved.
//

#import "BuyCommodityView.h"
@implementation BuyCommodityView
#define MAX_NUM_LENGTH 3
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self){
        self.backgroundColor = [UIColor clearColor];
        num = 1;
        [self setUI];
        [self addNameTFMethod];
    }
    return self;
}


-(void)setUI{
    UIView *backView = [UIView new];
    [self addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.offset(0);
    }];
    
    //    UIView *ecoView = [UIView new];
    //    [backView addSubview:ecoView];
    //    [ecoView mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.left.top.right.offset(0);
    //        make.height.mas_offset(50);
    //    }];
    
    UILabel *ecoLabel = [UILabel newWithText:@"购买" fontSize:15 textColor:MAIN_BODY textAlignment:NSTextAlignmentLeft];
    [backView addSubview:ecoLabel];
    [ecoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(18);
        make.top.offset(14);
    }];
    
    UIButton *cancelBtn = [UIButton newWithTitle:@"" font:14 textColor:nil textAlignment:NSTextAlignmentCenter Image:[UIImage imageNamed:@"guanbi"]];
    [cancelBtn addTarget:self action:@selector(cancelBtn:) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:cancelBtn];
    [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-18);
        make.centerY.equalTo(ecoLabel);
    }];
    
    UIView *topLine = [UIView new];
    topLine.backgroundColor = LINE_COLOR;
    [backView addSubview:topLine];
    [topLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.right.offset(-10);
        make.height.mas_offset(1);
        make.top.equalTo(ecoLabel.mas_bottom).offset(14);
    }];
    
    
    
    
    UIButton *payBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    CAGradientLayer * gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(__bridge id)[ColorFormatter hex2Color:0x5b9afb].CGColor, (__bridge id)[ColorFormatter hex2Color:0x8f7afd].CGColor];
    gradientLayer.locations = @[@0.1, @1.0];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1, 0);
    gradientLayer.frame = CGRectMake(0, 0, SCREEN_WIDTH - 24 - 36,50);
    gradientLayer.cornerRadius = 5;
    [payBtn.layer addSublayer:gradientLayer];
    
    payBtn.titleLabel.font = Font(16);
    [payBtn setTitleColor:YGYColor(255, 255, 255) forState:UIControlStateNormal];
    [payBtn setTitle:@"立即支付" forState:UIControlStateNormal];
    [payBtn addTarget:self action:@selector(payBtn:) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:payBtn];
    [payBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(18);
        make.right.offset(-18);
        make.height.mas_offset(50);
        make.bottom.offset(-20);
    }];
    
    
    
    
    UIView *bottomLine = [UIView new];
    bottomLine.backgroundColor = LINE_COLOR;
    [backView addSubview:bottomLine];
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.right.offset(-10);
        make.height.mas_offset(1);
        make.bottom.equalTo(payBtn.mas_top).offset(-20);
    }];
    
    
    self.checkProBtn = [UIButton new];
    [self.checkProBtn setImage:[UIImage imageNamed:@"checkIcon"] forState:UIControlStateNormal];
    [self.checkProBtn addTarget:self action:@selector(checkBtn:) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:self.checkProBtn];
    [self.checkProBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(18);
        make.bottom.equalTo(bottomLine.mas_top).offset(-15);
        make.width.height.mas_offset(20);
    }];
    
    UILabel *label = [UILabel newWithText:@"我已订阅合约详情并同意" fontSize:14 textColor:SECOND_BODY textAlignment:NSTextAlignmentLeft];
    [backView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.checkProBtn.mas_right).offset(8);
        make.centerY.equalTo(self.checkProBtn);
    }];
    
    UIButton *contractBtn = [UIButton newWithTitle:@"《产品合约》" font:14 textColor:Color(0x8286FA) textAlignment:NSTextAlignmentLeft Image:nil];
    [contractBtn addTarget:self action:@selector(contractBtn:) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:contractBtn];
    [contractBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label.mas_right).offset(0);
        make.centerY.equalTo(self.checkProBtn);
    }];
    
    UILabel *showBuyNumLabel = [UILabel newWithText:@"购买数量" fontSize:14 textColor:MAIN_BODY textAlignment:NSTextAlignmentLeft];
    [backView addSubview:showBuyNumLabel];
    [showBuyNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(18);
        make.bottom.equalTo(label.mas_top).offset(-39);
    }];
    
    //加
    UIButton *appendBtn = [UIButton newWithTitle:@"+" font:14 textColor:[UIColor blackColor] textAlignment:NSTextAlignmentCenter Image:nil];
    [appendBtn.layer setBorderColor:SECOND_BODY.CGColor];
    [appendBtn.layer setBorderWidth:1];
    [appendBtn.layer setMasksToBounds:YES];
    [appendBtn addTarget:self action:@selector(appendBtn:) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:appendBtn];
    [appendBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-18);
        make.centerY.equalTo(showBuyNumLabel);
        make.width.mas_offset(38);
        make.height.mas_offset(26);
    }];
    
    self.numSumTF = [UITextField new];
    self.numSumTF.text = [NSString stringWithFormat:@"%ld",num];
    self.numSumTF.font = Font(14);
    self.numSumTF.keyboardType = UIKeyboardTypeNumberPad;
    self.numSumTF.textAlignment = NSTextAlignmentCenter;
    self.numSumTF.textColor= MAIN_BODY;
    [backView addSubview:self.numSumTF];
    [self.numSumTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(appendBtn.mas_left).offset(0);
        make.centerY.equalTo(appendBtn);
        make.height.mas_offset(26);
        make.width.mas_offset(30);
    }];
    
    UIView *numSumTopLine = [UIView new];
    numSumTopLine.backgroundColor = SECOND_BODY;
    [self.numSumTF addSubview:numSumTopLine];
    [numSumTopLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.offset(0);
        make.height.mas_offset(1);
    }];
    
    UIView *numSumBottomLine = [UIView new];
    numSumBottomLine.backgroundColor = SECOND_BODY;
    [self.numSumTF addSubview:numSumBottomLine];
    [numSumBottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.offset(0);
        make.height.mas_offset(1);
    }];
    
    //减
    UIButton *subtractBtn = [UIButton newWithTitle:@"-" font:14 textColor:[UIColor blackColor] textAlignment:NSTextAlignmentCenter Image:nil];
    [subtractBtn.layer setBorderColor:SECOND_BODY.CGColor];
    [subtractBtn.layer setBorderWidth:1];
    [subtractBtn.layer setMasksToBounds:YES];
    [subtractBtn addTarget:self action:@selector(subtractBtn:) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:subtractBtn];
    [subtractBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_offset(38);
        make.height.mas_offset(26);
        make.right.equalTo(self.numSumTF.mas_left).offset(0);
        make.centerY.equalTo(appendBtn);
    }];
    
    UIView *productView = [UIView new];
    productView.backgroundColor = [UIColor clearColor];
    [backView addSubview:productView];
    [productView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(showBuyNumLabel.mas_top).offset(-8);
        make.left.offset(18);
        make.height.width.mas_offset(100);
    }];
    
    self.productImageView = [UIImageView new];
    self.productImageView.contentMode =UIViewContentModeScaleAspectFill;
    self.productImageView.clipsToBounds = YES;
    [productView addSubview:self.productImageView];
    [self.productImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_offset(120 / 1.42);
        make.width.mas_offset(142 / 1.42);
        make.top.offset(5);
        make.left.offset(0);
    }];
    
    self.productNameLabel = [UILabel newWithText:@"BIQ-S91*云储存合约" fontSize:14 textColor:SECOND_BODY textAlignment:NSTextAlignmentLeft];
    [backView addSubview:self.productNameLabel];
    [self.productNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(productView.mas_right).offset(13);
        make.top.equalTo(productView).offset(5);
    }];
    //    @"￥3550.0 CNY"
    self.priceLabel = [UILabel newWithText:@"" fontSize:24 textColor:Color(0xFB972E) textAlignment:NSTextAlignmentLeft];
    [backView addSubview:self.priceLabel];
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(productView.mas_right).offset(16);
        make.top.equalTo(self.productNameLabel.mas_bottom).offset(10);
    }];
    
    
    UILabel *cnyLabel = [UILabel newWithText:@"CNY" fontSize:14 textColor:Color(0xFB972E) textAlignment:NSTextAlignmentLeft];
    [backView addSubview:cnyLabel];
    [cnyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.priceLabel.mas_right).offset(0);
        make.bottom.equalTo(self.priceLabel).offset(0);
    }];
    
    
    
    
    
    
    
    
}

//勾选
-(void)checkBtn:(UIButton *)sender{
    self.checkBtn(sender);
}

//产品合约阅读
-(void)contractBtn:(UIButton *)sender{
    self.contractBtn(sender);
}

//取消
-(void)cancelBtn:(UIButton *)sender{
    self.cancelBtn(sender);
}

//减
-(void)subtractBtn:(UIButton *)sender{
    if (num > 1) {
        num = num - 1;
        sumPriceNum = sumPriceNum - priceNum;
        self.numSumTF.text = [NSString stringWithFormat:@"%ld",num];
        self.priceLabel.text = [NSString stringWithFormat:@"%.2f",sumPriceNum];
    }else{
        num = 1;
        priceNum = sumPriceNum;
        self.numSumTF.text = [NSString stringWithFormat:@"%ld",num];
        self.priceLabel.text = [NSString stringWithFormat:@"%.2f",sumPriceNum];
    }
    
    self.sumNumStr(self.numSumTF.text);
    self.IdStr(self.treasureGetAllData._id);
}

//加
-(void)appendBtn:(UIButton *)sender{
    num = num +1;
    sumPriceNum = priceNum + sumPriceNum;
    self.numSumTF.text = [NSString stringWithFormat:@"%ld",num];
    self.priceLabel.text = [NSString stringWithFormat:@"%.2f",sumPriceNum];
    
    self.sumNumStr(self.numSumTF.text);
    self.IdStr(self.treasureGetAllData._id);
}

//支付
-(void)payBtn:(UIButton *)sender{
    self.payBtn(sender);
}

-(void)setTreasureData:(TreasureGetAllData *)treasureGetAllData{
    _treasureGetAllData = treasureGetAllData;
    //总价
    sumPriceNum = [self.treasureGetAllData.money floatValue];
    //单个价格
    priceNum = sumPriceNum;
    self.productNameLabel.text = _treasureGetAllData.title;
    self.priceLabel.text = [NSString stringWithFormat:@"%.2f",sumPriceNum];
    [self.productImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",_treasureGetAllData.img]]];
}

#pragma mark - 监听数量变化方法
-(void)addNameTFMethod{
    
    [self.numSumTF addTarget:self action:@selector(NumTFChange:) forControlEvents:UIControlEventEditingChanged];
}

-(void)NumTFChange:(UITextField *)textField{
    if (textField.markedTextRange == nil) {
        //正则表达式 不允许有特殊字符和字母
        NSString * regex = @"^[0-9\u4E00-\u9FA5_-]+$";
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
        BOOL isMatch = [pred evaluateWithObject:textField.text];
        if (textField.text.length > 0 ) {
            if (isMatch) {
                if (textField.text.length >= MAX_NUM_LENGTH) {
                    textField.text = [textField.text substringToIndex:MAX_NUM_LENGTH];
                }
            }else{
                textField.text = [textField.text substringToIndex:(textField.text.length - 1)];
            }
        }
    }

    //    SLog(@"textField1 - 输入框内容改变,当前内容为: %@",textField.text);
    if ([textField.text isEqualToString:@""]) {
        textField.text = @"1";
        num = 1;
    }else{
        num = [textField.text integerValue];
        sumPriceNum = [self.treasureGetAllData.money floatValue] * num;
        self.priceLabel.text = [NSString stringWithFormat:@"%.2f",sumPriceNum];
    }
    
    
}
//必须销毁
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
