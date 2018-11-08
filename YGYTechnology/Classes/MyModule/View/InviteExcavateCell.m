//
//  InviteExcavateCell.m
//  YGYTechnology
//
//  Created by 袁庭楷 on 2018/10/4.
//  Copyright © 2018年 YGY. All rights reserved.
//

#import "InviteExcavateCell.h"

@implementation InviteExcavateCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self setUI];
        [self QRCreat];
    }
    return self;
}

-(void)setUI{
    UIView *bottomView = [UIView new];
    bottomView.backgroundColor = [UIColor whiteColor];
    bottomView.layer.cornerRadius = 8;
    [self addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(12);
        make.right.offset(-12);
        make.bottom.offset(0);
        make.top.offset(0);
    }];
    
    UILabel *bottomTopLabel = [UILabel newWithText:@"* 邀请即挖矿 换了换购矿机 *" fontSize:14 textColor:MAIN_BODY textAlignment:NSTextAlignmentCenter];
    bottomTopLabel.numberOfLines = 0;
    [bottomView addSubview:bottomTopLabel];
    [bottomTopLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(35);
        make.centerX.equalTo(bottomView);
    }];
    
    UILabel *bottomCenterLabel = [UILabel newWithText:@"      邀请好友注册，成功注册即挖SDT，邀请第一个好友挖1SDT，邀请第二个好友挖矿2枚SDT，邀请N个好友挖矿N枚SDT，直至第100名好友为止，后续将保持为100SDT奖励，挖矿收益数列递增，无限可能。" fontSize:13 textColor:SECOND_BODY textAlignment:NSTextAlignmentLeft];
    [bottomView addSubview:bottomCenterLabel];
    [bottomCenterLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bottomTopLabel.mas_bottom).offset(20);
        make.left.offset(28.5);
        make.right.offset(-28.5);
        make.centerX.equalTo(bottomView);
    }];
    // 调整行间距
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:bottomCenterLabel.text];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:7];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [bottomCenterLabel.text length])];
    bottomCenterLabel.attributedText = attributedString;
    bottomCenterLabel.lineBreakMode = NSLineBreakByCharWrapping;
    
    
    self.QRCodeImageView = [UIImageView new];
    [self.QRCodeImageView setImage:[UIImage imageNamed:@"huodong"]];
    self.QRCodeImageView.userInteractionEnabled = YES;
    [bottomView addSubview:self.QRCodeImageView];
    [self.QRCodeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(bottomView);
        make.width.height.mas_offset(120);
        make.top.equalTo(bottomCenterLabel.mas_bottom).offset(10);
    }];
    
    UILabel *QRLabel = [UILabel newWithText:@"扫海报注册即获得365SDT" fontSize:11 textColor:MAIN_BODY textAlignment:NSTextAlignmentCenter];
    [bottomView addSubview:QRLabel];
    [QRLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.QRCodeImageView.mas_bottom).offset(10);
        make.centerX.equalTo(bottomView);
    }];
    
    UIButton *inviteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    CAGradientLayer * gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(__bridge id)[ColorFormatter hex2Color:0x6593fb].CGColor, (__bridge id)[ColorFormatter hex2Color:0xad84f8].CGColor];
    gradientLayer.locations = @[@0.1, @1.0];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1, 0);
    gradientLayer.frame = CGRectMake(0, 0, 218,38);
    gradientLayer.cornerRadius = 19;
    [inviteBtn.layer addSublayer:gradientLayer];
    inviteBtn.titleLabel.font = Font(16);
    [inviteBtn setTitleColor:YGYColor(255, 255, 255) forState:UIControlStateNormal];
    [inviteBtn setTitle:@"保存邀请海报" forState:UIControlStateNormal];
    [inviteBtn addTarget:self action:@selector(saveBtn:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:inviteBtn];
    [inviteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_offset(218);
        make.top.equalTo(QRLabel.mas_bottom).offset(27);
        make.height.mas_offset(38);
        make.centerX.equalTo(bottomView);
    }];
    
}

-(void)saveBtn:(UIButton *)sender{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction* sessionAction = [UIAlertAction actionWithTitle:@"分享至微信" style:UIAlertActionStyleDefault  handler:^(UIAlertAction * action) {
      [self shareSession];
    }];
    
    UIAlertAction* timeLineAction = [UIAlertAction actionWithTitle:@"分享至微信朋友圈" style:UIAlertActionStyleDefault  handler:^(UIAlertAction * action) {
        [self shareTimeLine];
    }];
    UIAlertAction* photoAction = [UIAlertAction actionWithTitle:@"保存至相册" style:UIAlertActionStyleDefault  handler:^(UIAlertAction * action) {
        UIImageView *imageView = [UIImageView new];
        [imageView setImage:[UIImage imageNamed:@"SharePic"]];
        [self addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.bottom.offset(0);
        }];
        
        UIImageView *QRimageView = [UIImageView new];
        [QRimageView setImage:self.QRCodeImageView.image];
        [imageView addSubview:QRimageView];
        [QRimageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.offset(200);
            make.centerX.equalTo(imageView);
            make.width.height.mas_offset(120);
        }];
        
        UIImage *image =  [self addImage:imageView.image toImage:QRimageView.image];
        
        UIImageWriteToSavedPhotosAlbum(image, self, @selector(imageSavedToPhotosAlbum:didFinishSavingWithError:contextInfo:), nil);
        [imageView removeFromSuperview];
    }];
    UIAlertAction* cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel  handler:^(UIAlertAction * action) {}];
    
    [sessionAction setValue:MAIN_BODY forKey:@"titleTextColor"];
    [timeLineAction setValue:MAIN_BODY forKey:@"titleTextColor"];
    [photoAction setValue:MAIN_BODY forKey:@"titleTextColor"];
//    [cancleAction setValue:MAIN_BODY forKey:@"titleTextColor"];
    
    [alertController addAction:sessionAction];
    [alertController addAction:timeLineAction];
    [alertController addAction:photoAction];
    [alertController addAction:cancleAction];
    
    [[[[UIApplication sharedApplication] keyWindow] rootViewController] presentViewController:alertController animated:YES completion:nil];
}

- (void)imageSavedToPhotosAlbum:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    NSString *message;
    if (!error) {
        message = @"成功保存到相册";
        [iToast showMessage:message];
    }else
    {
        message = @"请打开相册权限";
        [iToast showMessage:message];
    }
}

-(void)QRCreat{
    //1. 实例化二维码滤镜
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    // 2. 恢复滤镜的默认属性
    [filter setDefaults];
        NSString *phoneStr;
        if ([LoginGetTool getUserInfo].phone.length > 0) {
            phoneStr = [NSString stringWithFormat:@"%@****%@",[[LoginGetTool getUserInfo].phone substringToIndex:3],[[LoginGetTool getUserInfo].phone substringFromIndex:7]];
        }
    
    // 3. 将字符串转换成NSData
    NSString *urlStr = [NSString stringWithFormat:@"http://www.inoath.net/resources/share/index.html?&uid=%@&phone=%@",USER_ID,phoneStr];
    NSData *data = [urlStr dataUsingEncoding:NSUTF8StringEncoding];
    // 4. 通过KVO设置滤镜inputMessage数据
    [filter setValue:data forKey:@"inputMessage"];
    // 5. 获得滤镜输出的图像
    CIImage *outputImage = [filter outputImage];
    // 6. 将CIImage转换成UIImage，并显示于imageView上 (此时获取到的二维码比较模糊,所以需要用下面的createNonInterpolatedUIImageFormCIImage方法重绘二维码)
    //    self.QRCodeImageView = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-170)/2, CGRectGetMaxY(nameLabel.frame) + 10, 170, 170)];
    self.QRCodeImageView.image = [self createNonInterpolatedUIImageFormCIImage:outputImage withSize:120];
    //重绘二维码,使其显示清晰
    //    [self addSubview:self.QRCodeImageView];
}

- (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size {
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    // 1.创建bitmap;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    // 2.保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    return [UIImage imageWithCGImage:scaledImage];
}

- (UIImage *)addImage:(UIImage *)image1 toImage:(UIImage *)image2 {
    //将底部的一张的大小作为所截取的合成图的尺寸
    UIGraphicsBeginImageContext(image1.size);
    
    // Draw image2，底下的
    [image1 drawInRect:CGRectMake(0, 0, image1.size.width, image1.size.height)];
    
    // Draw image1，上面的，坐标适当的调整
    //[image1 drawInRect:CGRectMake(image2.size.width/2-image2.size.width*0.2/2,image2.size.height/2-image2.size.height*0.2/2, image2.size.width*0.2, image2.size.height*0.2)];
    [image2 drawInRect:CGRectMake(image1.size.width/2 - 150,image1.size.height - 500, 300, 300)];
    
    UIImage *resultingImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return resultingImage;
}

-(void)shareSession{//分享对话框
    //    SharePic
    
    UIImageView *imageView = [UIImageView new];
    [imageView setImage:[UIImage imageNamed:@"SharePic"]];
    [self addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.offset(0);
    }];
    
    UIImageView *QRimageView = [UIImageView new];
    [QRimageView setImage:self.QRCodeImageView.image];
    [imageView addSubview:QRimageView];
    [QRimageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.offset(200);
        make.centerX.equalTo(imageView);
        make.width.height.mas_offset(120);
    }];
    
    UIImage *image =  [self addImage:imageView.image toImage:QRimageView.image];
    
    if ([WXApi isWXAppInstalled]) {
        //判断是否有微信
        SLog(@"有微信");
    }else{
        [iToast showMessage:@"未检测到微信"];
    }
    NSData *data = UIImagePNGRepresentation(image);
    WXMediaMessage *message = [WXMediaMessage message];
    WXImageObject *imageObject = [WXImageObject object];
    imageObject.imageData = [NSData dataWithData:data];
    message.mediaObject = imageObject;
    SendMessageToWXReq *req = [[SendMessageToWXReq alloc]init];
    //    WXSceneSession  对话框
    //    WXSceneTimeline 朋友圈
    req.message = message;
    req.scene = WXSceneSession;
    [WXApi sendReq:req];
    SLog(@"%d",[WXApi sendReq:req]);
    [imageView removeFromSuperview];
}


-(void)shareTimeLine{//分享朋友圈
    //    SharePic
    
    UIImageView *imageView = [UIImageView new];
    [imageView setImage:[UIImage imageNamed:@"SharePic"]];
    [self addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.offset(0);
    }];
    
    UIImageView *QRimageView = [UIImageView new];
    [QRimageView setImage:self.QRCodeImageView.image];
    [imageView addSubview:QRimageView];
    [QRimageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.offset(200);
        make.centerX.equalTo(imageView);
        make.width.height.mas_offset(120);
    }];
    
    UIImage *image =  [self addImage:imageView.image toImage:QRimageView.image];
    
    if ([WXApi isWXAppInstalled]) {
        //判断是否有微信
        SLog(@"有微信");
    }else{
        [iToast showMessage:@"未检测到微信"];
    }
    NSData *data = UIImagePNGRepresentation(image);
    WXMediaMessage *message = [WXMediaMessage message];
    WXImageObject *imageObject = [WXImageObject object];
    imageObject.imageData = [NSData dataWithData:data];
    message.mediaObject = imageObject;
    SendMessageToWXReq *req = [[SendMessageToWXReq alloc]init];
    //    WXSceneSession  对话框
    //    WXSceneTimeline 朋友圈
    req.message = message;
    req.scene = WXSceneTimeline;
    [WXApi sendReq:req];
    SLog(@"%d",[WXApi sendReq:req]);
    [imageView removeFromSuperview];
}

@end
