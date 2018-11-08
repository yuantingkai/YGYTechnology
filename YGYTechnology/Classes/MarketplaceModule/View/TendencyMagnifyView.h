//
//  TendencyMagnifyView.h
//  YGYTechnology
//
//  Created by 袁庭楷 on 2018/10/31.
//  Copyright © 2018年 YGY. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TendencyMagnifyView : UIView
@property (nonatomic, strong) NSArray * tendencyArr;
@property (nonatomic, strong) UIButton * selectBtn;
@property (nonatomic, strong) void (^clickBtn)(UIButton *tendencyBtn,UIView *selfView);
@property (nonatomic, strong) UIView * showTendencyChartView;//用来展示放大趋势图
@property (nonatomic, assign) NSInteger  num;//记录上一个界面所点击的tag
-(void)setNum:(NSInteger)Num;
@end

NS_ASSUME_NONNULL_END
