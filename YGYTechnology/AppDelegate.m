//
//  AppDelegate.m
//  YGYTechnology
//
//  Created by 袁庭楷 on 2018/9/25.
//  Copyright © 2018年 YGY. All rights reserved.
//

#import "AppDelegate.h"
#import "YGYTabBar.h"
#import "YGYCustomGuideVC.h"
#import <Bugly/Bugly.h>
@interface AppDelegate ()<WXApiDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    //重新登录 判断是否有云有数据
    [self flotagePackaging];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
    [self versionRequest];//版本号请求 更新下载逻辑  加上第一次登录的引导页逻辑
    [self.window makeKeyAndVisible];
    
    [WXApi registerApp:@"wx800f4bf27a8fbd1f"];//微信平台 appid配置
    [Bugly startWithAppId:@"76af8e15d5"];//bugly appid配置
    
    return YES;
}

//- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
//{
//    return  [WXApi handleOpenURL:url delegate:self];
//}
//
//- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
//{
//    BOOL isSuc = [WXApi handleOpenURL:url delegate:self];
//    NSLog(@"url %@ isSuc %d",url,isSuc == YES ? 1 : 0);
//    return  isSuc;
//}
//
//-(void)onReq:(BaseReq*)reqonReq{
//    
//}

-(void)onResp:(BaseResp*)resp{
    //把返回的类型转换成与发送时相对于的返回类型,这里为SendMessageToWXResp
//    SendMessageToWXResp *sendResp = (SendMessageToWXResp *)resp;
//    //使用UIAlertView 显示回调信息
//    NSString *str = [NSString stringWithFormat:@"%d",sendResp.errCode];
//    UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:@"回调信息" message:str delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
//    [alertview show];
}

+(void)gotoMainPage{//进入主界面
    UITabBarController *tabBarController = [YGYTabBar creatTabBarController];
    AppDelegate *appdelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    appdelegate.window.rootViewController = tabBarController;
    tabBarController.selectedIndex = 2;
    
}

-(void)gotoMainPage{
    UITabBarController *tabBarController = [YGYTabBar creatTabBarController];
    self.window.rootViewController = tabBarController;
    tabBarController.selectedIndex = 2;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    SLog(@"进入后台，applicationDidEnterBackground");
    [self flotagePackaging];
}

//- 程序从后台回到前台
- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    SLog(@"程序被杀死，applicationWillTerminate");
}

-(void)flotagePackaging{//漂浮物封装
    NSString *str = [USER_DEFAULT objectForKey:@"LOGIN_SUCCESS"];
    if ([str isEqualToString:@"loginSuccess"]) {
        [self sendFlotageRequest];
    }
}
#pragma mark --- 发送点击的漂浮物数据给后台
-(void)sendFlotageRequest{
    NSArray *arr = [USER_DEFAULT objectForKey:@"CLAC_ARR"];
    if (arr.count > 0) {
        NSString *appendStr = @"";
        for (int i = 0; i < arr.count; i++) {
            NSString *str = arr[i];
            if (i == 0) {
                appendStr = str;
            }else{
                appendStr = [appendStr stringByAppendingFormat:@",%@",str];
            }
        }
        NSString * url = [NSString stringWithFormat:@"%@sdtScore=%@&uid=%@",VERIFY_SDT_URL,appendStr,USER_ID];
        url = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        [YGYBaseViewModel postRequestWithPath:url parameters:nil responseDataModel:[YGYBaseDataModel class] success:^(id responseObject) {
            YGYBaseDataModel *model = responseObject;
            if ([model.status isEqualToString:@"200"]) {
                [USER_DEFAULT removeObjectForKey:@"CLAC_ARR"];
            }else{
                //                MBHUD(model.msg);
            }
        } failure:^(NSError *error) {
        }];
    }else{
        SLog(@"数组为空~~~~不用传值");
    }
}

#pragma mark --- 版本号请求
-(void)versionRequest{
    //先找到plist文件中版本号所对应的键值
    NSString * bundleVersionKey = (NSString *)kCFBundleVersionKey;
    //从plist文件中取出该键值所对应的版本号
    NSString *bundleVersion = [NSBundle mainBundle].infoDictionary[bundleVersionKey];
    //当前版本号为8
    NSString * url = [NSString stringWithFormat:@"/system/appVersion?version=%@",bundleVersion];
    url = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    [YGYBaseViewModel postRequestWithPath:url parameters:nil responseDataModel:[YGYBaseDataModel class] success:^(id responseObject) {
        YGYBaseDataModel *model = responseObject;
        if ([model.status isEqualToString:@"200"]) {
            SLog(@"版本为最新");
            if (![USER_DEFAULT boolForKey:@"abc"]) {//第一次登录
                YGYCustomGuideVC *guideVC = [[YGYCustomGuideVC alloc] init];
                self.window.rootViewController = guideVC;
            }else{
                [self gotoMainPage];
            }
        }else if([model.status isEqualToString:@"250"]){
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"发现新版本，前往更新" message:nil preferredStyle:UIAlertControllerStyleAlert];

            UIAlertAction* okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault  handler:^(UIAlertAction * action) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://www.pgyer.com/1tLb"]];
                [self removeAllUserDeafultKey];
            }];
            [okAction setValue:MAIN_BODY forKey:@"titleTextColor"];
            [alertController addAction:okAction];

            [[[[UIApplication sharedApplication] keyWindow] rootViewController] presentViewController:alertController animated:YES completion:nil];
        }
        
    } failure:^(NSError *error) {
        if (![USER_DEFAULT boolForKey:@"abc"]) {//第一次登录
            YGYCustomGuideVC *guideVC = [[YGYCustomGuideVC alloc] init];
            self.window.rootViewController = guideVC;
        }else{
            [self gotoMainPage];
        }
    }];
}

#pragma mark-------------------清空数据
-(void)removeAllUserDeafultKey{
    [[LoginSaveTool sharedTool] deleteCurrentLoginData];
    [USER_DEFAULT removeObjectForKey:@"CLAC_ARR"];
    [USER_DEFAULT removeObjectForKey:@"IMAGE_STR"];
    [USER_DEFAULT removeObjectForKey:@"NAME_STR"];
    [USER_DEFAULT removeObjectForKey:@"OLDPWD"];
    [USER_DEFAULT removeObjectForKey:@"GENDER_STR"];
    [USER_DEFAULT removeObjectForKey:@"AS_SETS_PWD_EXIST"];
    [USER_DEFAULT removeObjectForKey:@"LOGIN_SUCCESS"];
    [USER_DEFAULT removeObjectForKey:@"abc"];
}
@end
