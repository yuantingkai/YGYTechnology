//
//  PCH.h
//  YGYTechnology
//
//  Created by 袁庭楷 on 2018/9/25.
//  Copyright © 2018年 YGY. All rights reserved.
//

#ifndef PCH_h
#define PCH_h
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <Masonry.h>
#import "ColorFormatter.h"
#import "UIButton+NewButton.h"
#import "UILabel+NewLabel.h"
#import "AFNetworking.h"
#import "YYModel.h"
#import "NSObject+VendorAFNetworking.h"
#import "NSObject+VendorYYModel.h"
#import "Reachability.h"
#import "UIViewController+ToolMethod.h"
#import "UIButton+Extension.h"
#import "UITextField+MyTextField.h"
#import "iToast.h"
#import "ViewTools.h"
#import <MBProgressHUD.h>
#import "LoginVC.h"
#import "UIControl+NotReClick.h"
#import "YGYBaseDataModel.h"
#import "InterFaceDefine.h"
#import "YGYBaseViewModel.h"
#import "LoginSaveTool.h"
#import "LoginGetTool.h"
#import "UIImageView+WebCache.h"
#import "NSString+MD5.h"
#import "IQKeyboardManager.h"
#import "NSDictionary+MyDictionary.h"
#import "CustomLabel.h"
#import "UICountingLabel.h"
#import "MJRefresh.h"
#import "NSDictionary+MyDictionary.h"
#import "LoginVC.h"
#import <UMShare/UMShare.h>
#import <WXApi.h>
#import <UShareUI/UShareUI.h>
#import <Photos/PHPhotoLibrary.h>
#import "DWPromptAnimation.h"
//正文颜色
#define MAIN_BODY [ColorFormatter hex2Color:0x333333]
//次文颜色
#define SECOND_BODY [ColorFormatter hex2Color:0x999999]
//提示／不可点击文字 颜色
#define NO_CLICK_BODY [ColorFormatter hex2Color:0x666666]
//点击文字颜色
#define CLICK_BODY [ColorFormatter hex2Color:0x8286fa]
//线条颜色
#define LINE_COLOR [ColorFormatter hex2Color:0xe5e5e5]
//橘色文字
#define ORANGE_BODY [ColorFormatter hex2Color:0xFF5C00]












#define STOKEN  [LoginGetTool getUserInfo].toKen
#define USER_ID  [LoginGetTool getUserInfo]._id

//加载动画
//#define HIDDEN_NAV_VIEW UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, kNavHeight, SCREEN_WIDTH, SCREEN_HEIGHT - kNavHeight)];\
//[self.view addSubview:view];

#define LOADING  [DWPromptAnimation dw_ShowPromptAnimation:self.view imageName:@"合成" imageCount:31 imageType:@".png" maskView:NO];

#define STOP_LOADING [DWPromptAnimation dw_stopPromptAnimation];

#define NO_Network @"网络无法连接"
#define NO_Service @"哎呀~服务器不小心连到火星去啦"


#define USER_DEFAULT  [NSUserDefaults standardUserDefaults]

#define SCREEN [ViewTools screenFrame]

//获得Documents目录路径
#define kDocumentPath ([NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject])

//警告框封装
#define ALERT(tit)  UIAlertController * alert = [UIAlertController alertControllerWithTitle:tit message:nil preferredStyle:UIAlertControllerStyleAlert];\
[alert addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){}]];\
[self presentViewController:alert animated:YES completion:nil];

//MBprogressHUD
#define MBHUD(title) MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];\
hud.mode = MBProgressHUDModeText;\
hud.label.text =title;\
hud.bezelView.color = [UIColor blackColor];\
hud.label.textColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1];\
hud.margin = 10.f;\
hud.removeFromSuperViewOnHide = YES;\
[hud hideAnimated:YES afterDelay:1.2];

#define WeakSelf(type)  __weak typeof(type) weakSelf = type;

// 根据十六进制生成的颜色 参数格式：0xffffff
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16)) / 255.0 green:((float)((rgbValue & 0xFF00) >> 8)) / 255.0 blue:((float)(rgbValue & 0xFF)) / 255.0 alpha:1.0f]
#define YGYColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define Color(x) ([ColorFormatter hex2Color:x])
/**********************多屏适配 start**********************/

#define kSize ([UIScreen mainScreen].bounds.size)
#define kScale ([UIScreen mainScreen].scale)
#define SCREEN_HEIGHT kSize.height//屏幕高度
#define SCREEN_WIDTH kSize.width// 屏幕宽度
//以iPhone6为基准
#define XMGiPhone6W 375.0
#define XMGiPhone6H 667.0
// 计算比例
// x比例
#define XMGScaleX SCREEN_WIDTH / XMGiPhone6W
// y比例

#define XMGScaleY SCREEN_HEIGHT / XMGiPhone6H
// X坐标
#define LineX(l) l*XMGScaleX
// Y坐标
#define LineY(l) l*XMGScaleY
// 字体
#define Font(x) [UIFont systemFontOfSize:x*XMGScaleX]
#define BoldFont(x) [UIFont boldSystemFontOfSize:x*XMGScaleX]
#define YGYFont(value) [UIFont fontWithName:@"PingFang-SC-Regular" size:value]
// 状态栏(statusbar)
#define kStatusBarHeight  [[UIApplication sharedApplication] statusBarFrame].size.height

//标题栏
#define kNavBarHeight   44.0

#define kTopHeight   (kStatusBarHeight+kNavBarHeight)//导航栏高

#define kTabbarHeight 49
#define kSpace 10

//判断iPhoneX
#define isiPhone (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)

#define Is_Iphone_X  [UIScreen mainScreen].bounds.size.width == 375 && [UIScreen mainScreen].bounds.size.height >= 812.0f && isiPhone

#define kNavHeight   ((Is_Iphone_X) ? 88 : 64)
#define TabbarHeight ((Is_Iphone_X) ? 83 : 49)
#define BottomHeight ((Is_Iphone_X) ? 34 : 0)


/**********************多屏适配 end**********************/

#define NO_Network @"网络无法连接"
#define NO_Service @"哎呀~服务器不小心连到火星去啦"


#ifdef DEBUG
#define SLog(format, ...) printf("class: <%p %s:(%d) > method: %s \n%s\n", self, [[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, __PRETTY_FUNCTION__, [[NSString stringWithFormat:(format), ##__VA_ARGS__] UTF8String] )
#else
#define SLog(format, ...)
#endif

// .h
#define single_interface(class)  + (class *)shared##class;

// .m
// \ 代表下一行也属于宏
// ## 是分隔符
#define single_implementation(class) \
static class *_instance; \
\
+ (class *)shared##class \
{ \
if (_instance == nil) { \
_instance = [[self alloc] init]; \
} \
return _instance; \
} \
\
+ (id)allocWithZone:(NSZone *)zone \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instance = [super allocWithZone:zone]; \
}); \
return _instance; \
}


#define YYModelOverrideMethod \
- (void)encodeWithCoder:(NSCoder *)aCoder { [self yy_modelEncodeWithCoder:aCoder]; } \
- (id)initWithCoder:(NSCoder *)aDecoder { self = [super init]; return [self yy_modelInitWithCoder:aDecoder]; } \
- (id)copyWithZone:(NSZone *)zone { return [self yy_modelCopy]; } \
- (NSUInteger)hash { return [self yy_modelHash]; } \
- (BOOL)isEqual:(id)object { return [self yy_modelIsEqual:object]; } \
- (NSString *)description { return [self yy_modelDescription]; }


#endif /* PCH_h */
