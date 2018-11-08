//
//  PersonalCenterVC.m
//  YGYTechnology
//
//  Created by 袁庭楷 on 2018/9/30.
//  Copyright © 2018年 YGY. All rights reserved.
//

#import "PersonalCenterVC.h"
#import "PersonalCenterCell.h"
#import "personalCenterVerifyNameVC.h"
#import "ImagePicker.h"
#import "ImagePickerCamera.h"
#import "UpLoadImage.h"

@interface PersonalCenterVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UITextField * nickNameTF;
@property (nonatomic, strong) UIImage * picImage;
@property (nonatomic, strong) NSString *isMan;
@property (nonatomic, strong) ImagePicker *imagePicker;
@property (nonatomic, strong) ImagePickerCamera *imagePickerCamera;
@property (nonatomic, strong) NSString * isClickPhoto;
@end

static NSString * const identifier = @"personalCenterCell";

@implementation PersonalCenterVC

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor  = Color(0xf2f2f2);
    self.isMan = [USER_DEFAULT objectForKey:@"GENDER_STR"];
    self.isClickPhoto = @"NO";
    [self topNavigation];
    [self.view addSubview:self.tableView];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 50;
    }else{
        return 100;
        
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.001;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PersonalCenterCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[PersonalCenterCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    [cell setIndexPath:indexPath];
    if (self.nickNameTF.text.length > 0) {
        cell.nameTF.text = self.nickNameTF.text;
    }else{
        cell.nameTF.placeholder = [USER_DEFAULT objectForKey:@"NAME_STR"];
    }
    
    if (self.picImage) {
        cell.photoImageView.image = self.picImage;
    }else{
        [cell.photoImageView sd_setImageWithURL:[NSURL URLWithString:[USER_DEFAULT objectForKey:@"IMAGE_STR"]]];
    }
    
    cell.sexSelectLabel.text = self.isMan;
    
    WeakSelf(self);
    
    UIButton *photoButton = [UIButton new];
    [photoButton addTarget:self action:@selector(photoButton:) forControlEvents:UIControlEventTouchUpInside];
    [cell setClickPicBtn:^(UIButton *clickPicBtn) {
        [weakSelf photoButton:clickPicBtn];
    }];
    
    UIButton *nickButton = [UIButton new];
    [nickButton addTarget:self action:@selector(nickButton:) forControlEvents:UIControlEventTouchUpInside];
    [cell setClickNickNameBtn:^(UIButton *clickNickNameBtn) {
        [weakSelf nickButton:clickNickNameBtn];
    }];
    
    UIButton *sexButton = [UIButton new];
    [sexButton addTarget:self action:@selector(sexButton:) forControlEvents:UIControlEventTouchUpInside];
    [cell setClickSexBtn:^(UIButton *clickSexBtn) {
        [weakSelf sexButton:clickSexBtn];
    }];
    return cell;
}


//添加照片
-(void)clickPhotoFrame{
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    switch (status) {
        case AVAuthorizationStatusNotDetermined: {
            // 许可对话没有出现，发起授权许可
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                if (granted) {
                    //第一次用户接受
                    [self clickCamera];
                }else{
                    //用户拒绝
                    [self userReject];
                }
            }];
            break;
        }
        case AVAuthorizationStatusAuthorized:{
            // 已经开启授权，可继续
            [self clickCamera];
            break;
        }
        case AVAuthorizationStatusDenied:
        case AVAuthorizationStatusRestricted:
            // 用户明确地拒绝授权，或者相机设备无法访问
            [self userReject];
            break;
        default:
            break;
    }
}

- (void)userReject {
    NSString *tips = @"请为有关云开放相机权限:手机设置-隐私-相机-有关云(打开)";
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:tips message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
    }]];
    [self presentViewController:alert animated:YES completion:nil];
}

//点击拍照
-(void)clickCamera{
    self.imagePickerCamera = [ImagePickerCamera sharedManager];
    //设置主要参数
    [self.imagePickerCamera dwSetPresentDelegateVC:self SheetShowInView:self.view InfoDictionaryKeys:(long)nil];
    //回调
    [self.imagePickerCamera dwGetpickerTypeStr:^(NSString *pickerTypeStr) {
        SLog(@"%@",pickerTypeStr);
    } pickerImagePic:^(UIImage *pickerImagePic) {
        self.isClickPhoto = @"YES";
        self.picImage = pickerImagePic;
        [self.tableView reloadData];
    }];
}
//点击相册
-(void)clickPhoto{
    self.imagePicker = [ImagePicker sharedManager];
    //设置主要参数
    [self.imagePicker dwSetPresentDelegateVC:self SheetShowInView:self.view InfoDictionaryKeys:(long)nil];
    
    //回调
    [self.imagePicker dwGetpickerTypeStr:^(NSString *pickerTypeStr) {
        SLog(@"%@",pickerTypeStr);
    } pickerImagePic:^(UIImage *pickerImagePic) {
        self.isClickPhoto = @"YES";
        self.picImage = pickerImagePic;
        [self.tableView reloadData];
    }];
}
-(void)photoButton:(UIButton *)sender{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction* cameraAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault  handler:^(UIAlertAction * action) {
        [self clickCamera];
    }];
    
    UIAlertAction* photoAction = [UIAlertAction actionWithTitle:@"从相册中选择" style:UIAlertActionStyleDefault  handler:^(UIAlertAction * action) {
        [self clickPhoto];
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

-(void)nickButton:(UIButton *)sender{
    SLog(@"点击的昵称");
    personalCenterVerifyNameVC *verifyName = [[personalCenterVerifyNameVC alloc]init];
    [verifyName setNickNameTextFiled:^(UITextField *nickNameTextFiled) {
        self.nickNameTF = nickNameTextFiled;
        [self.tableView reloadData];
    }];
    [self.navigationController pushViewController:verifyName animated:YES];
}

-(void)sexButton:(UIButton *)sender{
    SLog(@"点击的性别");
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction* manAction = [UIAlertAction actionWithTitle:@"男" style:UIAlertActionStyleDefault  handler:^(UIAlertAction * action) {
        self.isMan = @"男";
        [self.tableView reloadData];
    }];
    
    UIAlertAction* womenAction = [UIAlertAction actionWithTitle:@"女" style:UIAlertActionStyleDefault  handler:^(UIAlertAction * action) {
        self.isMan = @"女";
        [self.tableView reloadData];
    }];
    UIAlertAction* canclePhotoAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel  handler:^(UIAlertAction * action) {}];
    
    [manAction setValue:MAIN_BODY forKey:@"titleTextColor"];
    [womenAction setValue:MAIN_BODY forKey:@"titleTextColor"];
    [canclePhotoAction setValue:MAIN_BODY forKey:@"titleTextColor"];
    
    [alertController addAction:manAction];
    [alertController addAction:womenAction];
    [alertController addAction:canclePhotoAction];
    
    [[[[UIApplication sharedApplication] keyWindow] rootViewController] presentViewController:alertController animated:YES completion:nil];
}


-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kNavHeight, SCREEN_WIDTH, SCREEN_HEIGHT-kNavHeight) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
                _tableView.backgroundColor = [UIColor clearColor];
//                _tableView.separatorColor = [UIColor clearColor];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
        //        _tableView.allowsSelection = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        //        _tableView.userInteractionEnabled = NO;
    }
    return _tableView;
}

//pragma mark 创建导航栏
-(void)topNavigation{
    UIView * topView = [ViewTools createGradientLayerNav_BarViewWithString:@"个人中心"];
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
    
}

-(void)returnTopVC {
    [self EditPersonInfoRequest];
}

//上传头像请求
-(void)upLoadPicRequest{
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",BASEURL,UPLOAD_AVATAR_URL];
    urlStr = [urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:0];
    [params setMyObject:USER_ID forKey:@"uid"];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",
                                                         @"text/html",
                                                         @"image/jpeg",
                                                         @"image/png",
                                                         @"application/octet-stream",
                                                         @"text/json",
                                                         nil];
    
    manager.requestSerializer= [AFHTTPRequestSerializer serializer];
    manager.responseSerializer= [AFHTTPResponseSerializer serializer];
    
    [manager POST:urlStr parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSData *data = UIImageJPEGRepresentation(self.picImage,0.28);
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        formatter.dateFormat =@"yyyyMMddHH";
        NSString *str = [formatter stringFromDate:[NSDate date]];
        NSString *fileName = [NSString stringWithFormat:@"%@.png", str];
        SLog(@"正面的大小=====%ld",[data length]/1000);
        //上传的参数(上传图片，以文件流的格式)
        [formData appendPartWithFileData:data
                                    name:@"img"
                                fileName:fileName
                                mimeType:@"image/png"];
        
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:responseObject
                                                                   options:NSJSONReadingAllowFragments
                                                                     error:nil];
        
        if ([jsonObject[@"status"] intValue] == 200) {
            [USER_DEFAULT setObject:jsonObject[@"data"] forKey:@"IMAGE_STR"];
            
            MBHUD(@"修改成功");
            [self performSelector:@selector(delayMethod) withObject:nil afterDelay:1.0f];
            //success
            SLog(@"上传成功%@",responseObject);
        }else {
            MBHUD(jsonObject[@"msg"]);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        SLog(@"上传失败%@",error);
        MBHUD(@"error");
    }];
    
}

-(void)delayMethod{
    [self.navigationController popViewControllerAnimated:YES];
}

//修改个人信息请求
-(void)EditPersonInfoRequest{
    NSString *genderStr = [USER_DEFAULT objectForKey:@"GENDER_STR"];
    //无变化不请求
    if ([genderStr isEqualToString:self.isMan] && !(self.nickNameTF.text.length > 0)) {
        if ([self.isClickPhoto isEqualToString:@"NO"]) {//未拍照 或 选照片 直接返回 只改姓名与性别
            [self delayMethod];
        }else{
            [self upLoadPicRequest];
        }
    }else{
        NSString *urlStr;
        if (self.nickNameTF.text.length > 0) {
            if ([self.isMan isEqualToString:@"男"]) {
                urlStr = [NSString stringWithFormat:@"%@gender=1&name=%@&uid=%@",EDIT_USER_INFO_URL,self.nickNameTF.text,USER_ID];
            }else{
                urlStr = [NSString stringWithFormat:@"%@gender=0&name=%@&uid=%@",EDIT_USER_INFO_URL,self.nickNameTF.text,USER_ID];
            }
        }else{
            if ([self.isMan isEqualToString:@"男"]) {
                urlStr = [NSString stringWithFormat:@"%@gender=0&name=%@&uid=%@",EDIT_USER_INFO_URL,[USER_DEFAULT objectForKey:@"NAME_STR"],USER_ID];
            }else{
                urlStr = [NSString stringWithFormat:@"%@gender=1&name=%@&uid=%@",EDIT_USER_INFO_URL,[USER_DEFAULT objectForKey:@"NAME_STR"],USER_ID];
            }
        }
        
        urlStr = [urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        [YGYBaseViewModel postRequestWithPath:urlStr parameters:nil responseDataModel:[YGYBaseDataModel class] success:^(id responseObject) {
            YGYBaseDataModel *model = responseObject;
            if ([model.status isEqualToString:@"200"]) {
                if ([self.isClickPhoto isEqualToString:@"NO"]) {//未拍照 或 选照片 直接返回 只改姓名与性别
                    [self delayMethod];
                }else{
                    [self upLoadPicRequest];
                }
                if (self.nickNameTF.text > 0) {
                    [USER_DEFAULT setObject:self.nickNameTF.text forKey:@"NAME_STR"];
                }
                [USER_DEFAULT setObject:self.isMan forKey:@"GENDER_STR"];
            }else{
                MBHUD(model.msg);
            }
            
        } failure:^(NSError *error) {
            if (error.code == WDNetError) {
                [iToast showMessage:NO_Network];
            }else{
                [iToast showMessage:NO_Service];
            }
        }];
    }
    
}

@end
