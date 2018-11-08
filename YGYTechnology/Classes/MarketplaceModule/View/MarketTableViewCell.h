//
//  MarketTableViewCell.h
//  YGYTechnology
//
//  Created by 袁庭楷 on 2018/10/30.
//  Copyright © 2018年 YGY. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MarketTableViewCell : UITableViewCell
@property (nonatomic, strong) UILabel * btcLocationMoneyLabel;//当前单价
@property (nonatomic, strong) UILabel * dropLabel;//降幅率
@property (nonatomic, strong) UILabel * amplificationLabel;//增幅绿
@property (nonatomic, strong) UILabel * averageRateLabel;//均成交价
@property (nonatomic, strong) UILabel * highestRateLabel;//最高成交价
@property (nonatomic, strong) UILabel * lowestRateLabel;//最低成单率
@property (nonatomic, strong) UIButton * tendencyBtn;//趋势图按钮
@property (nonatomic, strong) UIButton * kLineBtn;//k线图按钮
@property (nonatomic, strong) UIView * collectionView;//用collection展示数据
@property (nonatomic, strong) UIView * showLineChartView;//用来展示趋势图与K线图
@end

NS_ASSUME_NONNULL_END
