//
//  NewsInfoModel.h
//  YGYTechnology
//
//  Created by 袁庭楷 on 2018/10/5.
//  Copyright © 2018年 YGY. All rights reserved.
//

#import <Foundation/Foundation.h>
@class NewsInfoData,NewsInfoPageData;
@interface NewsInfoModel : NSObject
@property (nonatomic, copy) NSString *status;
@property (nonatomic, strong) NewsInfoData *data;
@property (nonatomic, copy) NSString *msg;
@end

@interface NewsInfoData : NSObject
@property (nonatomic, copy) NSString *total;
@property (nonatomic, copy) NSString *pageNum;
@property (nonatomic, strong) NSArray<NewsInfoPageData *> *pageData;
@end

@interface NewsInfoPageData : NSObject
@property (nonatomic, copy) NSString *_id;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *img;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *time;
@property (nonatomic, copy) NSString *styleType;
@end
