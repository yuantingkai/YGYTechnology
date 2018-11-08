//
//  EcoPartnerEarningsCell.h
//  YGYTechnology
//
//  Created by 袁庭楷 on 2018/10/13.
//  Copyright © 2018年 YGY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EcoEarningsModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface EcoPartnerEarningsCell : UITableViewCell
@property (nonatomic, strong) UILabel * dateLabel;//明细时间
@property (nonatomic, strong) UILabel * earningsNum;//收益
@property (nonatomic, strong) UILabel * electricExpendNum;//电力支出
@property (nonatomic, strong) UILabel * maintainExpendNum;//维护支出
@property (nonatomic, strong) NSIndexPath * indexPath;
@property (nonatomic, strong) EcoEarningsPageData * pageData;

-(void)setIndexPath:(NSIndexPath *)indexPath withPageData:(EcoEarningsPageData *)pageData;
@end

NS_ASSUME_NONNULL_END
