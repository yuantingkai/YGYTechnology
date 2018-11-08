//
//  PropertyListCell.h
//  YGYTechnology
//
//  Created by 袁庭楷 on 2018/10/11.
//  Copyright © 2018年 YGY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GetAssetInfoModel.h"
@interface PropertyListCell : UITableViewCell
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *titleLable;
@property (nonatomic, strong) UIButton * rightBtn;
@property (nonatomic, strong) UILabel * remainingSumLabel;//可用余额
@property (nonatomic, strong) UILabel * frostLabel;//冻结
@property (nonatomic, strong) NSArray * titleArr;
@property (nonatomic, strong) NSArray * iconArr;
@property (nonatomic, strong) NSIndexPath * indexPath;
@property(nonatomic,strong) void (^getBtnBtn)(UIButton *getBtnBtn);
@property (nonatomic, strong) GetAssetInfoData * getAssetInfoData;
-(void)setIndexPath:(NSIndexPath *)indexPath withModel:(GetAssetInfoData *)getAssetInfoData;
@end
