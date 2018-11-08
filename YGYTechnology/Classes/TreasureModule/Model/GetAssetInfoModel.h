//
//  GetAssetInfoModel.h
//  YGYTechnology
//
//  Created by 袁庭楷 on 2018/10/17.
//  Copyright © 2018年 YGY. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class GetAssetInfoData;
@interface GetAssetInfoModel : NSObject
@property (nonatomic, copy) NSString *status;
@property (nonatomic, strong) GetAssetInfoData *data;
@property (nonatomic, copy) NSString *msg;
@end

@interface GetAssetInfoData : NSObject
@property (nonatomic, copy) NSString *_id;
@property (nonatomic, copy) NSString *userId;
@property (nonatomic, copy) NSString *sdtFreeze;
@property (nonatomic, copy) NSString *sdtUsable;
@property (nonatomic, copy) NSString *btcFreeze;
@property (nonatomic, copy) NSString *btcUsable;
@property (nonatomic, copy) NSString *allCNY;
@end
NS_ASSUME_NONNULL_END
