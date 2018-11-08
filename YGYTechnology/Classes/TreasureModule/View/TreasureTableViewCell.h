//
//  TreasureTableViewCell.h
//  YGYTechnology
//
//  Created by 袁庭楷 on 2018/9/29.
//  Copyright © 2018年 YGY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TreasureGetAllModel.h"

@interface TreasureTableViewCell : UITableViewCell
@property (nonatomic, strong) UIButton *buyBtnN;
@property (nonatomic, strong) UIButton *contractBtn;
@property (nonatomic, strong) UIImageView * picImageView;
@property (nonatomic, strong) UILabel * titleLabel;
@property (nonatomic, strong) UILabel * kjLabel;
@property (nonatomic, strong) UILabel * dfLabel;
@property (nonatomic, strong) UILabel * whfLabel;
@property (nonatomic, strong) UILabel * priceLabel;
@property(nonatomic,strong) void (^contractInfoBtn)(UIButton *contractInfoBtn);
@property(nonatomic,strong) void (^buyBtn)(UIButton *buyBtn);

@property (nonatomic, strong) NSIndexPath * indexPath;
@property (nonatomic, strong) TreasureGetAllData * getAlldata;
-(void)setIndexPath:(NSIndexPath *)indexPath getAlldata:(TreasureGetAllData *)getAlldata;
@end
