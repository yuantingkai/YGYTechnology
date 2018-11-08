//
//  ContractDetailsVC.h
//  YGYTechnology
//
//  Created by 袁庭楷 on 2018/10/3.
//  Copyright © 2018年 YGY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TreasureGetAllModel.h"
#import "MyContractIndentModel.h"

@interface ContractDetailsVC : UIViewController
@property (nonatomic, strong) TreasureGetAllData * treasureGetAllData;
@property (nonatomic, strong) MyContractIndentPageData * myContractIndentPageData;
@property (nonatomic, strong) NSString * isMyStr;
@end
