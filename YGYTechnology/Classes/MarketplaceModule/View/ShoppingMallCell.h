//
//  ShoppingMallCell.h
//  YGYTechnology
//
//  Created by 袁庭楷 on 2018/11/2.
//  Copyright © 2018年 YGY. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ShoppingMallCell : UITableViewCell
@property (nonatomic, strong) UIView * topView;
@property (nonatomic, strong) UILabel *sdtNumLabel;
@property (nonatomic, strong) UIView * bottomView;
@property (nonatomic, strong) UIView *bottomLine;
@property (nonatomic, strong) NSIndexPath * indexPath;
-(void)setIndexPath:(NSIndexPath *)indexPath;
@end

NS_ASSUME_NONNULL_END
