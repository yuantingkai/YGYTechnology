//
//  TendencyMagnifyView.m
//  YGYTechnology
//
//  Created by 袁庭楷 on 2018/10/31.
//  Copyright © 2018年 YGY. All rights reserved.
//

#import "TendencyMagnifyView.h"

@implementation TendencyMagnifyView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    self.backgroundColor = YGYColor(245, 245, 245);
    
    return self;
}

-(void)createUI{
    UIView *backView = [UIView new];
    backView.layer.cornerRadius = 10;
    backView.layer.masksToBounds = YES;
    backView.backgroundColor = [UIColor whiteColor];
    [self addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.offset(12);
        make.right.bottom.offset(-12);
    }];
    
    UIImageView *imageView = [UIImageView new];
    [imageView setImage:[UIImage imageNamed:@"AppIcon"]];
    [backView addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(31);
        make.top.offset(10);
        make.width.height.mas_offset(20);
    }];
    
    UILabel *showLabel = [UILabel newWithText:@"有关行情" fontSize:16 textColor:MAIN_BODY textAlignment:NSTextAlignmentLeft];
    [backView addSubview:showLabel];
    [showLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(imageView.mas_right).offset(10);
        make.centerY.equalTo(imageView);
    }];
    
    //31 10 12  70  40 20
    for (int i = 0; i < 6; i++) {
        UIButton *btn = [[UIButton alloc]init];
        [btn setTitleColor:MAIN_BODY forState:UIControlStateNormal];
        btn.layer.cornerRadius = 10;
        btn.titleLabel.font = Font(14);
        btn.tag = i + 10000;
        [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
        [backView addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            if (i == 5) {
                make.right.offset(-31);
            }else{
                make.left.offset(31 + 31 * i + i * 50);
            }
            make.top.equalTo(imageView.mas_bottom).offset(12);
            make.height.mas_offset(20);
            make.width.mas_offset(40);
        }];
        if (i == _num) {
            _selectBtn = btn;
            [btn setBackgroundColor:CLICK_BODY];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }
        if (i == 5) {
            [btn setTitle:@"" forState:UIControlStateNormal];
            [btn setImage:self.tendencyArr[i] forState:UIControlStateNormal];
        }else{
            [btn setBackgroundImage:nil forState:UIControlStateNormal];
            [btn setTitle:self.tendencyArr[i] forState:UIControlStateNormal];
        }
    }
    
    UIView *lineView = [UIView new];
    lineView.backgroundColor = LINE_COLOR;
    [backView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.right.offset(-10);
        make.top.equalTo(imageView.mas_bottom).offset(44);
        make.height.mas_offset(1);
    }];
    
    self.showTendencyChartView = [UIView new];
    [backView addSubview:self.showTendencyChartView];
    [self.showTendencyChartView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.offset(0);
        make.top.equalTo(lineView.mas_bottom).offset(0);
    }];
}

-(void)clickBtn:(UIButton *)sender{
    if (_selectBtn == sender) {}else{
        [sender setBackgroundColor:CLICK_BODY];
        [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_selectBtn setBackgroundColor:[UIColor clearColor]];
        [_selectBtn setTitleColor:MAIN_BODY forState:UIControlStateNormal];
    }
    _selectBtn = sender;
    self.clickBtn(sender, self);
}

-(NSArray *)tendencyArr{
    if (!_tendencyArr) {
        _tendencyArr = @[@"2周",@"1月",@"3月",@"6月",@"1年",[UIImage imageNamed:@"quanping"]];
    }
    return _tendencyArr;
}

-(void)setNum:(NSInteger)Num{
    _num = Num;
    [self createUI];
}

@end
