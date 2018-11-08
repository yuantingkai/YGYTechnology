//
//  YGYCustomGuideVC.m
//  YGYTechnology
//
//  Created by 袁庭楷 on 2018/10/17.
//  Copyright © 2018年 YGY. All rights reserved.
//

#import "YGYCustomGuideVC.h"
#import "YGYPageControl.h"
#import "AppDelegate.h"
#import "YGYTabBar.h"

@interface YGYCustomGuideVC (){
    UIButton *_skipButton;
    UIButton *_experienceButton;
    YGYPageControl *_pageControl;
}

@end

@implementation YGYCustomGuideVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    
    self.view.backgroundColor = [UIColor whiteColor];
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _scrollView.bounces = YES;
    _scrollView.pagingEnabled = YES;
    _scrollView.scrollEnabled = YES;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.delegate  = self;
    _scrollView.contentSize = CGSizeMake(3 * SCREEN_WIDTH, SCREEN_HEIGHT);
    [self.view addSubview:_scrollView];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    NSArray *array = [NSArray arrayWithObjects:[UIImage imageNamed:@"引导页"],[UIImage imageNamed:@"引导页2"],[UIImage imageNamed:@"引导页3"],nil];
    if (Is_Iphone_X) {
        array = [NSArray arrayWithObjects:[UIImage imageNamed:@"引导页"],[UIImage imageNamed:@"引导页2"],[UIImage imageNamed:@"引导页3"],nil];
    }
    
    for (int i = 0; i < array.count; i++) {
        UIImageView *view = [[UIImageView alloc]initWithFrame:CGRectMake(i * SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        view.image = array[i];
        [self.scrollView addSubview:view];
    }
    
    _skipButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_skipButton setTitle:@"跳过" forState:UIControlStateNormal];
    [_skipButton setTitleColor:UIColorFromRGB(0x8b97a7) forState:UIControlStateNormal];
    [_skipButton.titleLabel setFont: [UIFont systemFontOfSize:15.0]];
    _skipButton.frame = CGRectMake(SCREEN_WIDTH - 74, 23, 74, 45);
    [_skipButton addTarget:self action:@selector(skipBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_skipButton];
    
    _experienceButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    _experienceButton.backgroundColor = TABBAR_COLOR;
    _experienceButton.layer.cornerRadius = 5.0;
//    [_experienceButton setTitle:@"立即体验" forState:UIControlStateNormal];
    [_experienceButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_experienceButton.titleLabel setFont: [UIFont systemFontOfSize:18.0]];
    _experienceButton.frame = CGRectMake(SCREEN_WIDTH*2 + (SCREEN_WIDTH/2.0 - 70), SCREEN_HEIGHT - 80 - 42, 140, 70);
    [_experienceButton addTarget:self action:@selector(skipBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:_experienceButton];
    
//    _pageControl = [[YGYPageControl alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 78)/2.0, SCREEN_HEIGHT - 60 - 42, 78, 5)];
//    _pageControl.pageIndicatorTintColor = UIColorFromRGB(0xe7e7e7);
////    _pageControl.currentPageIndicatorTintColor = TABBAR_COLOR;
//    [_pageControl setNumberOfPages:3];
//    [_pageControl setCurrentPage:0];
//    [self.view addSubview:_pageControl];
}

- (void)skipBtnClick:(UIButton *)sender{
    
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    [AppDelegate gotoMainPage];
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"abc"];
}

////goto首页
//- (void)gotoMainPage{
//    [[UIApplication sharedApplication] setStatusBarHidden:NO];
//    [AppDelegate gotoMainPage];
//}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [_pageControl setCurrentPage:((scrollView.contentOffset.x)/SCREEN_WIDTH)];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if ((scrollView.contentOffset.x) > SCREEN_WIDTH) {
        [_skipButton setHidden:YES];
        _pageControl.hidden = YES;
    }else{
        [_skipButton setHidden:NO];
        _pageControl.hidden = YES;

    }
}

@end
