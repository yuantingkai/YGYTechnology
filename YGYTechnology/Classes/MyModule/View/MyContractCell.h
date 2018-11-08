//
//  MyContractCell.h
//  YGYTechnology
//
//  Created by 袁庭楷 on 2018/10/9.
//  Copyright © 2018年 YGY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyContractIndentModel.h"

@interface MyContractCell : UITableViewCell
@property (nonatomic, strong) UIImageView * leftImageView;
@property (nonatomic, strong) UILabel * titleLabel;
@property (nonatomic, strong) UILabel * dealTimeLabel;
@property (nonatomic, strong) UILabel * dealNumLabel;
@property (nonatomic, strong) UILabel * dealStatusLabel;
@property (nonatomic, strong) UILabel * dealMoenyLabel;
@property (nonatomic, strong) UIButton *payBtn;
@property (nonatomic, strong) UIButton *cancelBtn;
@property (nonatomic, strong) UIButton *moreBtn;
@property (nonatomic, strong) NSString * IDStr;
@property (nonatomic, strong) UILabel *showDealMoney;
@property(nonatomic,strong) void (^Block_payBtn)(UIButton *payBtn);
@property(nonatomic,strong) void (^Block_cancelBtn)(UIButton *cancelBtn);
@property(nonatomic,strong) void (^Block_moreBtn)(UIButton *moreBtn);
@property(nonatomic,strong) void (^Block_IDStr)(NSString *idStr);
@property (nonatomic, strong) NSIndexPath * indexPath;
@property (nonatomic, strong) MyContractIndentPageData * pageData;
-(void)setIndexPath:(NSIndexPath *)indexPath withPageData:(MyContractIndentPageData *)pageData;
@end
