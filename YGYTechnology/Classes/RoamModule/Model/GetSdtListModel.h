//
//  GetSdtListModel.h
//  YGYTechnology
//
//  Created by 袁庭楷 on 2018/10/15.
//  Copyright © 2018年 YGY. All rights reserved.
//

#import <Foundation/Foundation.h>
@class GetSdtListData;
@interface GetSdtListModel : NSObject
@property (nonatomic, copy) NSString *status;
@property (nonatomic, strong) NSArray<GetSdtListData *> *data;
@property (nonatomic, copy) NSString *msg;
@end

@interface GetSdtListData : NSObject
@property (nonatomic, copy) NSString *num;
@property (nonatomic, copy) NSString *score;
@end
