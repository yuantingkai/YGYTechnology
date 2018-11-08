//
//  WithdrawDeatilsCell.h
//  YGYTechnology
//
//  Created by 袁庭楷 on 2018/10/18.
//  Copyright © 2018年 YGY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WithdrawDeatilsModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface WithdrawDeatilsCell : UITableViewCell
@property (nonatomic, strong) UILabel * dateLabel;//提现时间
@property (nonatomic, strong) UILabel *showEarningLabel;//提现状态
@property (nonatomic, strong) UILabel * withdrawNum;//提现金额
@property (nonatomic, strong) NSIndexPath * indexPath;
@property (nonatomic, strong) WithdrawDeatilsPageData * pageData;
-(void)setIndexPath:(NSIndexPath *)indexPath withPageData:(WithdrawDeatilsPageData *)pageData;
@end

NS_ASSUME_NONNULL_END
