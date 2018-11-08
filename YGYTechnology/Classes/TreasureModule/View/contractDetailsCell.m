//
//  contractDetailsCell.m
//  YGYTechnology
//
//  Created by 袁庭楷 on 2018/10/3.
//  Copyright © 2018年 YGY. All rights reserved.
//

#import "contractDetailsCell.h"

@implementation contractDetailsCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUI];
    }
    return self;
}

-(void)setUI{
    self.backgroundColor = [UIColor clearColor];
    
    self.backView = [[UIView alloc]initWithFrame:CGRectMake(12, 0, SCREEN_WIDTH - 24, 48)];
    self.backView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.backView];
    
    self.leftLabel = [UILabel newWithText:@"test" fontSize:14 textColor:SECOND_BODY textAlignment:NSTextAlignmentLeft];
    [self.backView addSubview:self.leftLabel];
    [self.leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.top.offset(14);
    }];
    
//    self.rightLabel = [UILabel newWithText:@"test" fontSize:14 textColor:MAIN_BODY textAlignment:NSTextAlignmentLeft];
    self.rightLabel = [CustomLabel new];
    self.rightLabel.text = @"";
    self.rightLabel.font = Font(14);
    self.rightLabel.textColor = MAIN_BODY;
    self.rightLabel.textAlignment = NSTextAlignmentLeft;
    self.rightLabel.numberOfLines = 0;
//    self.rightLabel.textInsets = UIEdgeInsetsMake(0.f, 15.f, 0.f, 0.f); // 设置左内边距
    [self.backView addSubview:self.rightLabel];
    [self.rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-10);
        make.top.offset(0);
        make.left.equalTo(self.backView).offset(100);
        make.bottom.offset(0);
    }];
    
    
    self.lineView = [UIView new];
    self.lineView.backgroundColor = LINE_COLOR;
    [self.backView addSubview:self.lineView];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(5);
        make.right.offset(-5);
        make.height.mas_offset(1);
        make.bottom.offset(0);
    }];
}

-(void)setIndexPath:(NSIndexPath *)indexPath leftName:(NSArray *)lenftNameArr rightName:(NSMutableArray *)rightNameMutArr{
    _indexPath = indexPath;
    NSArray *arr = [NSArray array];
    NSMutableArray *mutableArr = [NSMutableArray array];
    if (lenftNameArr.count > 0) {
        arr = lenftNameArr[_indexPath.section];
    }
    if (rightNameMutArr.count > 0) {
        mutableArr = rightNameMutArr[_indexPath.section];
    }
    if (_indexPath.section == 0) {
        //传值
        self.leftLabel.text = arr[_indexPath.row];
        self.rightLabel.text = mutableArr[_indexPath.row];
        [self rightTextHeight:self.rightLabel.text];
        //设置圆角
        if (_indexPath.row == 0) {
            [self topCornerRadiusView:self.backView];

        }else if (_indexPath.row == 4){
            [self bottomCornerRadiusView:self.backView];
        }
        
        
    }else if (_indexPath.section == 1){
        //传值
        self.leftLabel.text = arr[_indexPath.row];
        self.rightLabel.text = mutableArr[_indexPath.row];
        self.rightLabel.font = Font(13);
        [self rightTextHeight:self.rightLabel.text];
        //设置圆角
        if (_indexPath.row == 0) {
            [self topCornerRadiusView:self.backView];
        }else if (_indexPath.row == 3){
            [self bottomCornerRadiusView:self.backView];
        }
        // 调整行间距
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self.rightLabel.text];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:5];
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [self.rightLabel.text length])];
        self.rightLabel.attributedText = attributedString;
        self.rightLabel.lineBreakMode = NSLineBreakByCharWrapping;
        
    }
    //计算rightLabel的宽度是否超过设置的宽度 不超过右对齐
    CGSize labelTextSize = [self.rightLabel.text sizeWithAttributes:@{NSFontAttributeName : Font(13)}];
    CGRect temp = self.backView.frame;
    CGFloat leftIntervalWidth = temp.size.width - 100;
    if (labelTextSize.width > leftIntervalWidth) {
        self.rightLabel.textAlignment = NSTextAlignmentLeft;
    }else{
        self.rightLabel.textAlignment = NSTextAlignmentRight;
    }
}

//计算文本高度是否超过固定高度 超过增加高度
-(void)rightTextHeight:(NSString *)rightStr{
    float rowHeight = [contractDetailsCell heightForReduceStringWith:rightStr  font:13 width:self.backView.frame.size.width - 100];
    CGRect temp = self.backView.frame;
    
    if (rowHeight > 48) {
        temp.size.height = rowHeight + 35;
        self.backView.frame = temp;
    }else{
        temp.size.height = 48;
        self.backView.frame = temp;
    }
}
+(float)heightForReduceStringWith:(NSString *)content font:(float)font width:(CGFloat)width{
    
    CGSize titleSize = [content boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:Font(font)} context:nil].size;
    return titleSize.height;
}

-(void)topCornerRadiusView:(UIView *)cornerRadiusView{
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:cornerRadiusView.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(8, 8)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = cornerRadiusView.bounds;
    maskLayer.path = maskPath.CGPath;
    cornerRadiusView.layer.mask = maskLayer;
}

-(void)bottomCornerRadiusView:(UIView *)cornerRadiusView{
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:cornerRadiusView.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(8, 8)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = cornerRadiusView.bounds;
    maskLayer.path = maskPath.CGPath;
    cornerRadiusView.layer.mask = maskLayer;
}

@end
