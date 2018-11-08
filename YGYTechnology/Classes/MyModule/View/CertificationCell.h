//
//  CertificationCell.h
//  YGYTechnology
//
//  Created by 袁庭楷 on 2018/10/2.
//  Copyright © 2018年 YGY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CertificationCell : UITableViewCell<UITextFieldDelegate>
@property (nonatomic, strong) UIView * topView;
@property (nonatomic, strong) UITextField * nameTF;
@property (nonatomic, strong) UITextField *  identityCardTF;
@property (nonatomic, strong) UITextField * phoneTF;
@property (nonatomic, strong) UIView * identityCardView;
@property (nonatomic, strong) UILabel * identityCardlabel;
@property (nonatomic, strong) UIImageView * identityCardImageView;//身份证 正反面
@property (nonatomic, strong) UIView * picView;
@property (nonatomic, strong) NSIndexPath * indexPath;

@property(nonatomic,strong) void (^nameBlock)(NSString *nameStr);
@property(nonatomic,strong) void (^identityCardBlock)(NSString *identityCardStr);
@property(nonatomic,strong) void (^phoneBlock)(NSString *phoneStr);
@end
