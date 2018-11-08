//
//  NewsInfoCell.h
//  YGYTechnology
//
//  Created by 袁庭楷 on 2018/10/4.
//  Copyright © 2018年 YGY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsInfoModel.h"

@interface NewsInfoCell : UITableViewCell
@property (nonatomic, strong) UILabel * titleLabel;
@property (nonatomic, strong) UIImageView * rightPicView;
@property (nonatomic, strong) UILabel * readerNameLabel;
@property (nonatomic, strong) UILabel * timeLabel;
@property (nonatomic, strong) NSIndexPath * indexPath;
@property (nonatomic, strong) NewsInfoPageData * newsInfoPageData;
-(void)setIndexPath:(NSIndexPath *)indexPath dataArr:(NewsInfoPageData *)newsInfoPageData;
@end
