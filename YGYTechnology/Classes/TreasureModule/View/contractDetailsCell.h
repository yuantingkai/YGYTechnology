//
//  contractDetailsCell.h
//  YGYTechnology
//
//  Created by 袁庭楷 on 2018/10/3.
//  Copyright © 2018年 YGY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface contractDetailsCell : UITableViewCell

@property (nonatomic, strong) UIView * backView;
@property (nonatomic, strong) UILabel * leftLabel;
@property (nonatomic, strong) CustomLabel * rightLabel;
@property (nonatomic, strong) UIView * lineView;
@property (nonatomic, strong) NSIndexPath * indexPath;
-(void)setIndexPath:(NSIndexPath *)indexPath leftName:(NSArray *)lenftNameArr rightName:(NSMutableArray *)rightNameMutArr;
@end
