//
//  CNYWithDrawDetailsCell.h
//  YGYTechnology
//
//  Created by 袁庭楷 on 2018/10/19.
//  Copyright © 2018年 YGY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CNYWithdrawDeatilsModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface CNYWithDrawDetailsCell : UITableViewCell
@property (nonatomic, strong) UILabel * dateLabel;//提现时间
@property (nonatomic, strong) UILabel *showEarningLabel;//提现状态
@property (nonatomic, strong) UILabel * withdrawNum;//提现金额
@property (nonatomic, strong) NSIndexPath * indexPath;
@property (nonatomic, strong) CNYWithdrawDeatilsPageData * pageData;
-(void)setIndexPath:(NSIndexPath *)indexPath withPageData:(CNYWithdrawDeatilsPageData *)pageData;
@end

NS_ASSUME_NONNULL_END
