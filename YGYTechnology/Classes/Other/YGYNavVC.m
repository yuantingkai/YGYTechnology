//
//  YGYNavVC.m
//  YGYTechnology
//
//  Created by 袁庭楷 on 2018/9/25.
//  Copyright © 2018年 YGY. All rights reserved.
//

#import "YGYNavVC.h"

@interface YGYNavVC ()

@end

@implementation YGYNavVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavBar];
}

- (void)setNavBar {
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:18],NSForegroundColorAttributeName:MAIN_BODY}];
    self.navigationBar.translucent = NO;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(0, 0, 80, 20);
    [leftButton setImage:[UIImage imageNamed:@"icon_backarrow"] forState:UIControlStateNormal];
    [leftButton setImage:[UIImage imageNamed:@"icon_backarrow_h"] forState:UIControlStateHighlighted];
    leftButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [leftButton addTarget:self action:@selector(backViewcontroller) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    // 设置边框距离，个人习惯设为-16，可以根据需要调节
    leftItem.width = -14;
    viewController.navigationItem.leftBarButtonItem = leftItem;
    
    [super pushViewController:viewController animated:animated];
    // 修改tabBra的frame
    CGRect frame = self.tabBarController.tabBar.frame;
    frame.origin.y = [UIScreen mainScreen].bounds.size.height - frame.size.height;
    self.tabBarController.tabBar.frame = frame;
}
-(void)backViewcontroller{
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;//设置全部为白色；
    [self popViewControllerAnimated:YES];
    
}

@end
