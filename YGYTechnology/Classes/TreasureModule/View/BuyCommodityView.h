//
//  BuyCommodityView.h
//  YGYTechnology
//
//  Created by 袁庭楷 on 2018/10/3.
//  Copyright © 2018年 YGY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TreasureGetAllModel.h"

@interface BuyCommodityView : UIView
{
    NSUInteger num;
    float priceNum;
    float sumPriceNum;
}
@property (nonatomic, strong) UIImageView * productImageView;
@property (nonatomic, strong) UILabel *productNameLabel;
@property (nonatomic, strong) UILabel * priceLabel;
@property (nonatomic, strong) UITextField *numSumTF;
@property (nonatomic, strong) UIButton *checkProBtn;
@property(nonatomic,strong) void (^cancelBtn)(UIButton *cancelBtn);
@property(nonatomic,strong) void (^payBtn)(UIButton *payBtn);
@property(nonatomic,strong) void (^checkBtn)(UIButton *checkBtn);
@property(nonatomic,strong) void (^contractBtn)(UIButton *contractBtn);
@property(nonatomic,strong) void (^sumNumStr)(NSString *sumNumStr);
@property(nonatomic,strong) void (^IdStr)(NSString *IdStr);
@property (nonatomic, strong) TreasureGetAllData * treasureGetAllData;
-(void)setTreasureData:(TreasureGetAllData *)treasureGetAllData;
@end
