//
//  CheckDetailCell.h
//  YGYTechnology
//
//  Created by 袁庭楷 on 2018/10/4.
//  Copyright © 2018年 YGY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CheckDetailCell : UITableViewCell
@property (nonatomic, strong) UILabel * timeLabel;
@property (nonatomic, strong) UILabel * showInfoLabel;
@property (nonatomic, strong) NSIndexPath * indexPath;
-(void)setIndexPath:(NSIndexPath *)indexPath phoneNum:(NSString *)phoneNumStr timeStr:(NSString *)timeStr showStr:(NSString *)showStr numStr:(NSString *)numStr;
@end
