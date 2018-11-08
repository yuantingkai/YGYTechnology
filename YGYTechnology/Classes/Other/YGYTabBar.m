//
//  YGYTabBar.m
//  YGYTechnology
//
//  Created by 袁庭楷 on 2018/9/25.
//  Copyright © 2018年 YGY. All rights reserved.
//

#import "YGYTabBar.h"
#import "NewsInfomationVC.h"
#import "TreasureVC.h"
#import "MarketplaceVC.h"
#import "RoamVC.h"
#import "MyVC.h"
#import "YGYNavVC.h"

@implementation YGYTabBar

+ (UITabBarController *)creatTabBarController{
    
    NewsInfomationVC *newsInfoVC = [[NewsInfomationVC alloc] init];
    YGYNavVC *newsInfoNav = [[YGYNavVC alloc] initWithRootViewController:newsInfoVC];
    UITabBarItem *newsInfoItem = [[UITabBarItem alloc] initWithTitle:@"资讯" image:nil tag:1];
    newsInfoVC.tabBarItem = newsInfoItem;
    
    
    TreasureVC *treasureVC = [[TreasureVC alloc] init];
    YGYNavVC *treasureNav = [[YGYNavVC alloc]initWithRootViewController:treasureVC];
    UITabBarItem *treasureItem = [[UITabBarItem alloc] initWithTitle:@"财富" image:nil tag:2];
    treasureVC.tabBarItem = treasureItem;

    

    RoamVC *roamVC = [[RoamVC alloc] init];
    YGYNavVC *roamNav = [[YGYNavVC alloc] initWithRootViewController:roamVC];
    UITabBarItem *roamItem = [[UITabBarItem alloc] initWithTitle:@"" image:nil tag:3];
    roamVC.tabBarItem = roamItem;

    MarketplaceVC *marketplaceVC = [[MarketplaceVC alloc] init];
    YGYNavVC *marketplaceNav = [[YGYNavVC alloc]initWithRootViewController:marketplaceVC];
    UITabBarItem * marketplaceItem = [[UITabBarItem alloc]initWithTitle:@"市场" image:nil tag:4];
    marketplaceVC.tabBarItem = marketplaceItem;
    
    MyVC *myVC = [[MyVC alloc] init];
    YGYNavVC *myNav = [[YGYNavVC alloc] initWithRootViewController:myVC];
    UITabBarItem *myItem = [[UITabBarItem alloc] initWithTitle:@"我" image:nil tag:5];
    myVC.tabBarItem = myItem;
    
    
    newsInfoItem.image = [[UIImage imageNamed:@"资讯"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    newsInfoItem.selectedImage = [[UIImage imageNamed:@"资讯 copy"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    treasureItem.image = [[UIImage imageNamed:@"caifu1"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    treasureItem.selectedImage = [[UIImage imageNamed:@"caifu"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    roamItem.image = [[UIImage imageNamed:@"yunyou"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    roamItem.selectedImage = [[UIImage imageNamed:@"yunyou"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    marketplaceItem.image = [[UIImage imageNamed:@"shangcheng-1"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    marketplaceItem.selectedImage = [[UIImage imageNamed:@"shangcheng"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    myItem.image = [[UIImage imageNamed:@"我的"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    myItem.selectedImage = [[UIImage imageNamed:@"我的 copy"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UITabBarController *Tab = [[UITabBarController alloc] init];
    Tab.viewControllers = @[newsInfoNav,treasureNav,roamNav,marketplaceNav,myNav];
    Tab.tabBar.barTintColor = UIColorFromRGB(0x01051);
//    Tab.barTintColor = RGBCOLOR(rgbValue: 0x01051)
//        Tab.tabBar.tintColor = UIColorFromRGB(0x336efd);
//    Tab.tabBar.barTintColor = [UIColor blackColor];
    return Tab;
}


@end
