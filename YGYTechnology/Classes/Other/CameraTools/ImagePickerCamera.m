//
//  ImagePickerCamera.m
//  YGYTechnology
//
//  Created by 袁庭楷 on 2018/10/11.
//  Copyright © 2018年 YGY. All rights reserved.
//

#import "ImagePickerCamera.h"

//如果有Debug这个宏的话,就允许log输出...可变参数
#ifdef DEBUG
#define DWLog(...) NSLog(__VA_ARGS__)
#else
#define DWLog(...)
#endif


@implementation ImagePickerCamera

static ImagePickerCamera *sharedManager = nil;

+ (ImagePickerCamera *)sharedManager {
    
    @synchronized (self) {
        
        if (!sharedManager) {
            
            sharedManager = [[[self class] alloc] init];
            
        }
        
    }
    
    return sharedManager;
}

#pragma mark ---设置根控制器 弹框添加视图位置 所需图片样式 默认为UIImagePickerControllerEditedImage
- (void)dwSetPresentDelegateVC:(id)vc SheetShowInView:(UIView *)view InfoDictionaryKeys:(NSInteger)integer {
    
    picker = [[UIImagePickerController alloc]init];
    
    picker.delegate = self;
    
    self.integer = integer;
    
    //    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles: @"相机",@"从相册中选择",nil];
    //
    //    [sheet showInView:view];
    
    picker.allowsEditing = YES;
    
    self.allowsEditing = picker.allowsEditing;
    
    self.vc = vc;
    
    //    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    //    {
    //
    //        self.typeStr = @"支持相机";
    //
    //    }
    //    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
    //    {
    //
    //        self.typeStr = @"支持图库";
    //
    //    }
    //    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum])
    //    {
    //
    //        self.typeStr = @"支持相片库";
    //
    //    }
    
    //    iOS 判断应用是否有使用相机的权限
    
    NSString *mediaType = AVMediaTypeVideo;//读取媒体类型
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];//读取设备授权状态
    if(authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied){
        NSString *errorStr = @"应用相机权限受限,请在设置中启用";
        [iToast showMessage:errorStr];
        return;
    }else{
        if (TARGET_IPHONE_SIMULATOR) {
            [iToast showMessage:@"模拟器不支持该操作"];
        }else{
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self.vc presentViewController:picker animated:YES completion:nil];
        }
        
    }
    
}

#pragma mark ---获取设备支持的类型与选中之后的图片
- (void)dwGetpickerTypeStr:(pickerTypeStr)pickerTypeStr pickerImagePic:(pickerImagePic)pickerImagePic {
    
    if (pickerTypeStr) {
        
        pickerTypeStr(self.typeStr);
        
    }
    
    self.pickerImagePic = ^(UIImage *image) {
        
        pickerImagePic(image);
        
    };
    
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    UIImage *image = [[UIImage alloc] init];
    
    NSArray *array = @[@"UIImagePickerControllerMediaType",
                       @"UIImagePickerControllerOriginalImage",
                       @"UIImagePickerControllerEditedImage",
                       @"UIImagePickerControllerCropRect",
                       @"UIImagePickerControllerMediaURL",
                       @"UIImagePickerControllerReferenceURL",
                       @"UIImagePickerControllerMediaMetadata",
                       @"UIImagePickerControllerLivePhoto"];
    
    if (self.integer) {
        
        image = [info objectForKey:array[self.integer]];
        
    }else {
        
        image = [info objectForKey:array[2]];
        
    }
    
    if (self.pickerImagePic) {
        
        self.pickerImagePic(image);
        
    }
    
    [self.vc dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [self.vc dismissViewControllerAnimated:YES completion:nil];
    
}

//- (void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
//
//    if (buttonIndex == 0) {
//
//        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
//        [actionSheet setTintColor:[UIColor blueColor]];
//#pragma clang diagnostic push
//#pragma clang diagnostic ignored "-Wunicode-whitespace"
//
//        [self.vc presentViewController:picker animated:YES completion:nil];
//
//#pragma clang diagnostic pop
//
//
//    }else if (buttonIndex == 1) {
//
//        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
//
//#pragma clang diagnostic push
//#pragma clang diagnostic ignored "-Wunicode-whitespace"
//
//        [self.vc presentViewController:picker animated:YES completion:nil];
//
//#pragma clang diagnostic pop
//
//    }

//}

@end
