//
//  MarketCollectionViewCell.h
//  YGYTechnology
//
//  Created by 袁庭楷 on 2018/10/31.
//  Copyright © 2018年 YGY. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MarketCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong) UILabel * titleLabel;
@property (nonatomic, strong) NSIndexPath * indexPath;
@property (nonatomic, strong) NSArray * tendencyArr;
@property (nonatomic, strong) UIImageView * fullScreenImageView;
@end

NS_ASSUME_NONNULL_END
