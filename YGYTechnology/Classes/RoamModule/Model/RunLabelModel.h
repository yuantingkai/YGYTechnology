//
//  RunLabelModel.h
//  YGYTechnology
//
//  Created by 袁庭楷 on 2018/10/19.
//  Copyright © 2018年 YGY. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class RunLabelData;
@interface RunLabelModel : NSObject
@property (nonatomic, copy) NSString *status;
@property (nonatomic, strong) RunLabelData *data;
@property (nonatomic, copy) NSString *msg;
@end

@interface RunLabelData : NSObject
@property (nonatomic, copy) NSString *_id;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *jumpUrl;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *generateTime;
@end
NS_ASSUME_NONNULL_END
