//
//  ActivityView.h
//  YGYTechnology
//
//  Created by 袁庭楷 on 2018/10/4.
//  Copyright © 2018年 YGY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ActivityView : UIView
@property(nonatomic,strong) void (^cancelBtn)(UIButton *cancelBtn);
@property(nonatomic,strong) void (^OKBtn)(UIButton *OKBtn);
@end
