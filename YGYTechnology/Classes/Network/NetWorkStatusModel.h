//
//  NetWorkStatusModel.h
//  YGYTechnology
//
//  Created by 袁庭楷 on 2018/10/5.
//  Copyright © 2018年 YGY. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, NetWorkType) {
    NetWorkTypeWifi,  // wifi
    NetWorkTypeWan,   // 移动
    NetWorkTypeUnconnect // 未连接
};

// 网络状态单例模型
@interface NetWorkStatusModel : NSObject

// 连接状态 YES表示当前已连接
@property (nonatomic, assign) BOOL connected;
// 网络连接类型
@property (nonatomic, assign) NetWorkType type;

single_interface(NetWorkStatusModel)

@end
