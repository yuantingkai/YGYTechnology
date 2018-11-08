//
//  TreasureGetAllModel.h
//  YGYTechnology
//
//  Created by 袁庭楷 on 2018/10/5.
//  Copyright © 2018年 YGY. All rights reserved.
//

#import <Foundation/Foundation.h>
@class TreasureGetAllData;
@interface TreasureGetAllModel : NSObject
@property (nonatomic, copy) NSString *status;
@property (nonatomic, strong) NSArray <TreasureGetAllData*> *data;
@property (nonatomic, copy) NSString *msg;
@end

@interface TreasureGetAllData : NSObject
@property (nonatomic, copy) NSString *img;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *power;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *electricity;
@property (nonatomic, copy) NSString *maintenance;
@property (nonatomic, copy) NSString *earnings;
@property (nonatomic, copy) NSString *time;
@property (nonatomic, copy) NSString *cycle;
@property (nonatomic, copy) NSString *hint;
@property (nonatomic, copy) NSString *money;
@property (nonatomic, copy) NSString *_id;
@end
