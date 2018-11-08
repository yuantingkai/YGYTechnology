//
//  ExamineClacRecordCell.h
//  YGYTechnology
//
//  Created by 袁庭楷 on 2018/10/23.
//  Copyright © 2018年 YGY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CheckClacModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ExamineClacRecordCell : UITableViewCell
@property (nonatomic, strong) UIView * topBackgroundView;
@property (nonatomic, strong) UIView * bottomBackgroundView;
@property (nonatomic, strong) UILabel * signOrNewsLabel;
@property (nonatomic, strong) UILabel * successTimeLabel;
@property (nonatomic, strong) UILabel * failedTimeLabel;
@property (nonatomic, strong) UILabel * rightLabel;
@property (nonatomic, strong) NSIndexPath * indexPath;
@property (nonatomic, strong) CheckClacData * data;
-(void)setIndexPath:(NSIndexPath *)indexPath data:(CheckClacData *)data;
@end

NS_ASSUME_NONNULL_END
