//
//  CertificationVC.m
//  YGYTechnology
//
//  Created by 袁庭楷 on 2018/9/29.
//  Copyright © 2018年 YGY. All rights reserved.
//

#import "CertificationVC.h"
#import "CertificationCell.h"
#import "ImagePicker.h"
#import "CertificationModel.h"
#import "ImagePickerCamera.h"

@interface CertificationVC ()<UITableViewDelegate,UITableViewDataSource>
{
    ImagePicker *imagePicker1;//正面照相册
    ImagePicker *imagePicker2;//反面照相册
    ImagePickerCamera *imagePickerCamera1;//正面照拍照
    ImagePickerCamera *imagePickerCamera2;//反面照拍照
}
@property (nonatomic, strong) NSString *nameStr;
@property (nonatomic, strong) NSString *cardIdStr;
@property (nonatomic, strong) NSString *phoneStr;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIImage * positiveImage;
@property (nonatomic, strong) UIImage * reverseImage;
@property (nonatomic, strong) CertificationData * certificationData;

@end
static NSString * const Identifier = @"certificationCell";
@implementation CertificationVC


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [self certificationInfoRequest];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = Color(0xf2f2f2);
    [self.view endEditing:YES];
    [self topNavigation];
    [self.view addSubview:self.tableView];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 150;
    }else{
        return 194;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 2) {
        return 14;
    }else{
        return 60;
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.0001;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [UIView new];
    view.backgroundColor = Color(0xf2f2f2);
    
    UILabel *headerLabel = [UILabel newWithText:@"" fontSize:14 textColor:SECOND_BODY textAlignment:NSTextAlignmentLeft];
    if (section == 0) {
        headerLabel.text = @"请填写身份证信息资料";
    }else if(section == 1){
        headerLabel.text = @"上传身份证";
    }else{
        headerLabel.text = @"";
    }
    [view addSubview:headerLabel];
    [headerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(20);
        make.centerY.equalTo(view);
    }];
    
    return view;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        
    }else if(indexPath.section == 1){
        [self popWindow:@"1"];
    }else if (indexPath.section == 2){
        [self popWindow:@"2"];
    }
    
}


//身份证正面照点击拍照
-(void)prosClickCamera{
    imagePickerCamera1 = [ImagePickerCamera sharedManager];
    //设置主要参数
    [imagePickerCamera1 dwSetPresentDelegateVC:self SheetShowInView:self.view InfoDictionaryKeys:(long)nil];
    //回调
    [imagePickerCamera1 dwGetpickerTypeStr:^(NSString *pickerTypeStr) {
        SLog(@"%@",pickerTypeStr);
    } pickerImagePic:^(UIImage *pickerImagePic) {
        self.positiveImage = pickerImagePic;
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:1];
        [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
    }];
}
//身份证正面点击相册
-(void)prosClickPhoto{
    imagePicker1 = [ImagePicker sharedManager];
    //设置主要参数
    [imagePicker1 dwSetPresentDelegateVC:self SheetShowInView:self.view InfoDictionaryKeys:(long)nil];
    
    //回调
    [imagePicker1 dwGetpickerTypeStr:^(NSString *pickerTypeStr) {
        SLog(@"%@",pickerTypeStr);
    } pickerImagePic:^(UIImage *pickerImagePic) {
        self.positiveImage = pickerImagePic;
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:1];
        [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
    }];
}

//身份证反面照点击拍照
-(void)consClickCamera{
    imagePickerCamera2 = [ImagePickerCamera sharedManager];
    //设置主要参数
    [imagePickerCamera2 dwSetPresentDelegateVC:self SheetShowInView:self.view InfoDictionaryKeys:(long)nil];
    //回调
    [imagePickerCamera2 dwGetpickerTypeStr:^(NSString *pickerTypeStr) {
        SLog(@"%@",pickerTypeStr);
    } pickerImagePic:^(UIImage *pickerImagePic) {
        self.reverseImage = pickerImagePic;
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:2];
        [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
    }];
}
//身份证反面点击相册
-(void)consClickPhoto{
    imagePicker2 = [ImagePicker sharedManager];
    //设置主要参数
    [imagePicker2 dwSetPresentDelegateVC:self SheetShowInView:self.view InfoDictionaryKeys:(long)nil];
    
    //回调
    [imagePicker2 dwGetpickerTypeStr:^(NSString *pickerTypeStr) {
        SLog(@"%@",pickerTypeStr);
    } pickerImagePic:^(UIImage *pickerImagePic) {
        self.reverseImage = pickerImagePic;
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:2];
        [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
    }];
}


-(void)popWindow:(NSString *)str{//弹窗 str为1的时候是正面照 为2是反面
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction* cameraAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault  handler:^(UIAlertAction * action) {
        if ([str isEqualToString:@"1"]) {
            [self prosClickCamera];
        }else{
            [self consClickCamera];
        }
    }];
    UIAlertAction* photoAction = [UIAlertAction actionWithTitle:@"从相册中选择" style:UIAlertActionStyleDefault  handler:^(UIAlertAction * action) {
        if ([str isEqualToString:@"1"]) {
            [self prosClickPhoto];
        }else{
            [self consClickPhoto];
        }
    }];
    UIAlertAction* canclePhotoAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel  handler:^(UIAlertAction * action) {}];
    [cameraAction setValue:MAIN_BODY forKey:@"titleTextColor"];
    [photoAction setValue:MAIN_BODY forKey:@"titleTextColor"];
    [canclePhotoAction setValue:MAIN_BODY forKey:@"titleTextColor"];
    [alertController addAction:cameraAction];
    [alertController addAction:photoAction];
    [alertController addAction:canclePhotoAction];
    [[[[UIApplication sharedApplication] keyWindow] rootViewController] presentViewController:alertController animated:YES completion:nil];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CertificationCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    if (cell == nil) {
        cell = [[CertificationCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
    }
    [cell setIndexPath:indexPath];
    if (indexPath.section == 0) {
        if (self.certificationData.realName.length > 0) {
            cell.nameTF.text = self.certificationData.realName;
        }else if (self.certificationData.cardId.length > 0){
            cell.identityCardTF.text = self.certificationData.cardId;
        }else if (self.certificationData.phone.length > 0){
            cell.phoneTF.text = self.certificationData.phone;
        }
        
        WeakSelf(self);
        [cell setNameBlock:^(NSString *nameStr) {
            [weakSelf nameStr:nameStr];
        }];
        [cell setIdentityCardBlock:^(NSString *identityCardStr) {
            [weakSelf identifyCardStr:identityCardStr];
        }];
        [cell setPhoneBlock:^(NSString *phoneStr) {
            [weakSelf phoneStr:phoneStr];
        }];
    }
    if (indexPath.section == 1) {
        if (self.positiveImage == nil) {
            if (self.certificationData.frontImg) {
                NSString *urlStr = [NSString stringWithFormat:@"%@",self.certificationData.frontImg];
                urlStr = [urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
                [cell.identityCardImageView sd_setImageWithURL:[NSURL URLWithString:urlStr]];
                cell.picView.hidden = YES;
            }
        }else{
            cell.identityCardImageView.image = self.positiveImage;
            cell.picView.hidden = YES;
        }
    }else if (indexPath.section == 2){
        if (self.reverseImage == nil) {
            if (self.certificationData.backImg) {
                NSString *urlStr = [NSString stringWithFormat:@"%@",self.certificationData.backImg];
                urlStr = [urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
                [cell.identityCardImageView sd_setImageWithURL:[NSURL URLWithString:urlStr]];
                cell.picView.hidden = YES;
            }
        }else{
            cell.identityCardImageView.image = self.reverseImage;
            cell.picView.hidden = YES;
        }
    }
    return cell;
}

-(void)nameStr:(NSString *)str{
    if (str.length > 0) {
        self.nameStr = str;
    }
}

-(void)identifyCardStr:(NSString *)str{
    if (str.length >0) {
        self.cardIdStr = str;
    }
}

-(void)phoneStr:(NSString *)str{
    if (str.length >0) {
        self.phoneStr = str;
    }
}

-(void)returnTopVC {
    [self.navigationController popViewControllerAnimated:YES];
}

-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kNavHeight, SCREEN_WIDTH, SCREEN_HEIGHT - kNavHeight) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
                _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
    }
    return _tableView;
}



//pragma mark 创建导航栏
-(void)topNavigation{
    UIView * topView = [ViewTools createGradientLayerNav_BarViewWithString:@"实名认证"];
    [self.view addSubview:topView];
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setImage:[UIImage imageNamed:@"leftArrow"] forState:UIControlStateNormal];
    [leftBtn sizeToFit];
    leftBtn.expandHitEdgeInsets = UIEdgeInsetsMake(15, 15, 15, 15);
    [leftBtn addTarget:self action:@selector(returnTopVC) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:leftBtn];
    [leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(12);
        make.bottom.mas_offset(kNavControlImgBottom);
    }];
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rightBtn setTitle:@"提交" forState:UIControlStateNormal];
    rightBtn.titleLabel.font = Font(14);
    [rightBtn sizeToFit];
    rightBtn.expandHitEdgeInsets = UIEdgeInsetsMake(15, 15, 15, 15);
    [rightBtn addTarget:self action:@selector(submitBtn) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:rightBtn];
    [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-12);
        make.bottom.mas_offset(kNavControlImgBottom);
    }];
    
}

-(void)submitBtn{
    if (self.nameStr.length >0) {}else{
        MBHUD(@"姓名不能为空");
        return;
    }
    if (self.cardIdStr.length >0) {}else{
        MBHUD(@"身份证号不能为空");
        return;
    }
    if (self.phoneStr.length >0) {}else{
        MBHUD(@"手机号码不能为空");
        return;
    }
    [self certificationRequest];
}

#pragma mark - 请求方法
-(void)certificationRequest {
    //    cardId       //身份证号                                  String     必填
    //    phone        //手机号                                    String     必填
    //    realName     //姓名                                      String     必填
    //    frontImg     //身份证图
    //    backImg      //身份证背面
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:0];
    NSString *urlStr = [NSString stringWithFormat:@"%@userId=%@",CERTIFICATION_URL,USER_ID];
    [params setMyObject:self.cardIdStr forKey:@"cardId"];
    [params setMyObject:self.nameStr forKey:@"realName"];
    [params setMyObject:self.phoneStr forKey:@"phone"];
    urlStr = [urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    SLog(@"%@",params);
    
    if (self.positiveImage && self.reverseImage) {
        AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:BASEURL]];
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        manager.requestSerializer.timeoutInterval = 30;
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html",@"image/jpeg",@"image/png",@"application/octet-stream",@"text/json",nil];
        
        [manager POST:urlStr parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            NSArray *imageArr = [NSArray arrayWithObjects:self.positiveImage,self.reverseImage, nil];
            NSArray *strArr = [NSArray arrayWithObjects:@"frontImg",@"backImg", nil];
            for (int i = 0; i<2; i++) {
                NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
                formatter.dateFormat =@"yyyyMMddHHmmss";
                NSString *str = [formatter stringFromDate:[NSDate date]];
                NSString *fileName = [NSString stringWithFormat:@"%@.jpg", str];
                UIImage *image = imageArr[i];
                //上传的参数(上传图片，以文件流的格式)
                NSData *imageData = UIImageJPEGRepresentation(image, 0.28);
                [formData appendPartWithFileData:imageData name:strArr[i] fileName:fileName mimeType:@"image/jpeg"];
                SLog(@"反面的大小=====%ld",[imageData length]/1000);
            }
        } progress:^(NSProgress * _Nonnull uploadProgress) {
            SLog(@"uploadProgress is %lld,总字节 is %lld",uploadProgress.completedUnitCount,uploadProgress.totalUnitCount);
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:responseObject
                                                                       options:NSJSONReadingAllowFragments
                                                                         error:nil];
            if ([jsonObject[@"status"] intValue] == 200) {
                //success
                [self.navigationController popViewControllerAnimated:YES];
                SLog(@"上传成功%@",responseObject);
            }else {
                MBHUD(jsonObject[@"msg"]);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            SLog(@"上传失败%@",error);
        }];
    }else{
        if (self.certificationData.frontImg && self.certificationData.backImg) {
            AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:BASEURL]];
            manager.requestSerializer = [AFHTTPRequestSerializer serializer];
            manager.responseSerializer = [AFHTTPResponseSerializer serializer];
            manager.requestSerializer.timeoutInterval = 30;
            manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html",@"image/jpeg",@"image/png",@"application/octet-stream",@"text/json",nil];
            
            [manager POST:urlStr parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
                //将返回的身份证 转换为image流传给后台
                NSString *urlStr = [NSString stringWithFormat:@"%@",self.certificationData.frontImg];
                urlStr = [urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
                UIImageView *imageView = [UIImageView new];
                [imageView sd_setImageWithURL:[NSURL URLWithString:urlStr]];
                //将返回的身份证 转换为image流传给后台
                NSString *urlStr1 = [NSString stringWithFormat:@"%@",self.certificationData.backImg];
                urlStr1 = [urlStr1 stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
                UIImageView *imageView1 = [UIImageView new];
                [imageView1 sd_setImageWithURL:[NSURL URLWithString:urlStr1]];
                

                NSArray *imageArr = [NSArray arrayWithObjects:imageView.image,imageView1.image, nil];
                NSArray *strArr = [NSArray arrayWithObjects:@"frontImg",@"backImg", nil];
                for (int i = 0; i<2; i++) {
                    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
                    formatter.dateFormat =@"yyyyMMddHHmmss";
                    NSString *str = [formatter stringFromDate:[NSDate date]];
                    NSString *fileName = [NSString stringWithFormat:@"%@.jpg", str];
                    UIImage *image = imageArr[i];
                    //上传的参数(上传图片，以文件流的格式)
                    NSData *imageData = UIImageJPEGRepresentation(image, 0.28);
                    [formData appendPartWithFileData:imageData name:strArr[i] fileName:fileName mimeType:@"image/jpeg"];
                    SLog(@"反面的大小=====%ld",[imageData length]/1000);
                }
            } progress:^(NSProgress * _Nonnull uploadProgress) {
                SLog(@"uploadProgress is %lld,总字节 is %lld",uploadProgress.completedUnitCount,uploadProgress.totalUnitCount);
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:responseObject
                                                                           options:NSJSONReadingAllowFragments
                                                                             error:nil];
                if ([jsonObject[@"status"] intValue] == 200) {
                    //success
                    [self.navigationController popViewControllerAnimated:YES];
                    SLog(@"上传成功%@",responseObject);
                    [iToast showMessage:@"上传成功"];
                }else {
                    [iToast showMessage:jsonObject[@"msg"]];
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                SLog(@"上传失败%@",error);
            }];
        }else{
            MBHUD(@"身份证照片不能为空");
        }
    }

    
    
}

#pragma mark --- request
-(void)certificationInfoRequest{
    NSString *urlStr = [NSString stringWithFormat:@"%@uid=%@",GET_REAL_INFO,USER_ID];
    urlStr = [urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    [YGYBaseViewModel postRequestWithPath:urlStr parameters:nil responseDataModel:[CertificationModel class] success:^(id responseObject) {
        CertificationModel *model = responseObject;
        if ([model.status isEqualToString:@"200"]) {
            self.certificationData = model.data;
            self.nameStr = self.certificationData.realName;
            self.cardIdStr = self.certificationData.cardId;
            self.phoneStr = self.certificationData.phone;
            [self.tableView reloadData];
        }else{
//            MBHUD(model.msg);
        }
        
    } failure:^(NSError *error) {
        if (error.code == WDNetError) {
            [iToast showMessage:NO_Network];
        }else{
            [iToast showMessage:NO_Service];
        }
    }];
}
@end
