//
//  RoamVC.m
//  YGYTechnology
//
//  Created by 袁庭楷 on 2018/9/25.
//  Copyright © 2018年 YGY. All rights reserved.
//

#import "RoamVC.h"
#import "HHRunLabelView.h"
#import "InviteExcavateVC.h"
#import "GetSdtListModel.h"
#import "GetClacModel.h"
#import "RuleStrategyVC.h"
#import "RunLabelModel.h"
#import "CheckClacVC.h"

#define kItemW 60 // 此60目前是测试数据，真实数据应该根据下方的文字计算出最大宽度
#define kItemH 70 // 此80目前是测试数据，真实数据应是：矿石高度+间距+下方文字高度

@interface RoamVC ()<UITabBarDelegate,UITabBarControllerDelegate>

@property (nonatomic, strong) AVAudioPlayer *player;
@property(nonatomic,strong) UIImageView *boomStatusAnimation;
@property (nonatomic, strong) UIImageView * backgroundView;//紫色背景图片
@property (nonatomic, strong) UIImageView *starImageView;//星球背景
@property (nonatomic, strong) UIView *topView;//自适应变换的顶部边框
@property (nonatomic, strong) UIView * NOKSView;//无矿石界面
@property (nonatomic, weak) UIView *sudokuView;//第一页矿石摆放视图
@property (nonatomic, weak) UIView *secondPageView;//第二页矿石摆放视图
@property (nonatomic, strong) NSArray *layouts; // 矿石预置布局二维数组
@property (nonatomic, assign) NSUInteger countNum;//判断点击视图的矿石是否全部点完
@property (nonatomic, assign) double allScore;//存储点击之后的积分之和
@property (nonatomic, assign) double requstAllScore;//请求完成之后的总积分
@property (nonatomic, strong) UICountingLabel *sumLabel;//展示总积分 为allScoreh与requestAllScore之和
@property (nonatomic, strong) NSString * isSecondPage;
@property (nonatomic, strong) NSArray *currentLayout;
@property (nonatomic, strong) NSString * clacStr;
@property (nonatomic, strong) UILabel *leftLabelNum;
@property (nonatomic, strong) NSArray * dataArr;//漂浮物数据数组
@property (nonatomic, strong) NSArray * dataIdArr;//悬浮物的对应id 数组
@property (nonatomic, strong) NSMutableArray * saveNumAndIdArr;//存储id和num的数组
@property (nonatomic, strong) HHRunLabelView *runLabel;//跑马灯str
@property (nonatomic, strong) UIButton * signImageBtn;//签到图标
@property (nonatomic, strong) UIImageView *noNetworkImageView;
@end

@implementation RoamVC

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [self.navigationController setHidesBottomBarWhenPushed:YES];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    [self reFreshBtn];
    
}

#pragma mark ----------- 进入界面调用的方法
-(void)enterPage{
    [self setUI];
    self.allScore = 0;
    NSString *str = [USER_DEFAULT objectForKey:@"LOGIN_SUCCESS"];
    if ([str isEqualToString:@"loginSuccess"]) {
        [self getClacRequest];
        [self requestWithAllData];
        self.isSecondPage = @"NO";
    }else{
        self.clacStr = @"";
        self.leftLabelNum.text = self.clacStr;
        self.requstAllScore = 0;
        [self nolLoginStatusRunLabelRequest];
        [self singleKSShow:@"登陆后领取"];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillResignActive:)
                                                 name:UIApplicationWillResignActiveNotification object:nil]; //监听是否触发home键挂起程序.
}

-(void)applicationWillResignActive:(NSNotification *)notification{
    SLog(@"home键 已就位");
    NSString *str = [USER_DEFAULT objectForKey:@"LOGIN_SUCCESS"];
    if ([str isEqualToString:@"loginSuccess"]) {
        [self sendFlotageRequest];
    }
}
#pragma mark -------- 第二页视图
-(void)setSecondPageView{
    [_sudokuView removeFromSuperview];
    [_secondPageView removeFromSuperview];
    UIView *secondPageView = [[UIView alloc] init];
    if (SCREEN == 1) {
        secondPageView.frame = CGRectMake(15, 130 - 40 + kStatusBarHeight, SCREEN_WIDTH - 30, 305);
    }else{
        secondPageView.frame = CGRectMake(15, 130+ kStatusBarHeight, SCREEN_WIDTH - 30, 305);
    }
    secondPageView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:secondPageView];
    _secondPageView = secondPageView;
    self.currentLayout = self.layouts[0];//固定第二个布局
    CGFloat itemX = 0;
    CGFloat itemY = 0;
    //根据后台返回数量生成多个矿石  超过十个点击完成另外一屏显示
    for (NSInteger index = 10; index < self.dataArr.count; index++) {
        self.countNum = index -10 + 1;//第二页的总数
        UIView *itemView = [self getSingleKuangShiItemViewWithScore:self.dataArr[index]];
        itemView.tag = 1000 + index;
        NSValue *pointValue = self.currentLayout[index -10];
        itemX = pointValue.CGPointValue.x;
        itemY = pointValue.CGPointValue.y;
        itemView.frame = CGRectMake(itemX, itemY, kItemW, kItemH);
        UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapSecondZuanShiItemView:)];
        [itemView addGestureRecognizer:tapGes];
        [secondPageView addSubview:itemView];
        // 做动画
        [UIView animateWithDuration:1 delay:0.2 options:UIViewAnimationOptionRepeat | UIViewAnimationOptionAutoreverse | UIViewAnimationOptionAllowUserInteraction animations:^{
            CGRect frame = itemView.frame;
            NSInteger tag = itemView.tag - 1000;
            if (tag == 11 || tag == 13 || tag == 15 || tag == 17 || tag == 19) {
                frame.origin.y = itemY - 5;
                itemView.frame = frame;
            }else{
                frame.origin.y = itemY - 10;
                itemView.frame = frame;
            }
            
        } completion:^(BOOL finished) {
        }];
    }
}

#pragma mark -------- 生成多个钻石图标 第一页视图
- (void)setUpRandomView {
    [_secondPageView removeFromSuperview];
    [_sudokuView removeFromSuperview];
    UIView *sudokuView = [[UIView alloc] init];
    if (SCREEN == 1) {
        sudokuView.frame = CGRectMake(15, 130 - 40 + kStatusBarHeight, SCREEN_WIDTH - 30, 305);
    }else{
        sudokuView.frame = CGRectMake(15, 130+ kStatusBarHeight, SCREEN_WIDTH - 30, 305);
    }
    sudokuView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:sudokuView];
    _sudokuView = sudokuView;
    self.currentLayout = self.layouts[1];//固定第一个布局
    CGFloat itemX = 0;
    CGFloat itemY = 0;
    //根据后台返回数量生成多个矿石  超过十个点击完成另外一屏显示
    for (NSInteger index = 0; index < self.dataArr.count; index++) {
        if (index < 10) {
            self.isSecondPage = @"NO";
            self.countNum = index +1;//第一页的总数
            UIView *itemView = [self getSingleKuangShiItemViewWithScore:self.dataArr[index]];
            itemView.tag = 1000 + index;
            NSValue *pointValue = self.currentLayout[index];
            itemX = pointValue.CGPointValue.x;
            itemY = pointValue.CGPointValue.y;
            itemView.frame = CGRectMake(itemX, itemY, kItemW, kItemH);
            UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapZuanShiItemView:)];
            [itemView addGestureRecognizer:tapGes];
            [sudokuView addSubview:itemView];
            // 做动画
            [UIView animateWithDuration:1 delay:0.2 options:UIViewAnimationOptionRepeat | UIViewAnimationOptionAutoreverse | UIViewAnimationOptionAllowUserInteraction animations:^{
                CGRect frame = itemView.frame;
                NSInteger tag = itemView.tag - 1000;
                if (tag == 1 || tag == 3 || tag == 5 || tag == 7 || tag == 9) {
                    frame.origin.y = itemY - 5;
                    itemView.frame = frame;
                }else{
                    frame.origin.y = itemY - 10;
                    itemView.frame = frame;
                }
                
            } completion:^(BOOL finished) {
            }];
        }else{
            self.isSecondPage = @"YES";
        }
    }
}

#pragma mark -------- 封装方法获取单个矿石视图
- (UIView *)getSingleKuangShiItemViewWithScore:(NSString *)scoreStr{
    // 矿石和分值的背景UIView
    UIView *kuangShiItemView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kItemW, kItemH)];
    [self.view addSubview:kuangShiItemView];
    
    // 矿石图标
    UIImage *kuangShiImage = [UIImage imageNamed:@"kuangshi"];
    CGFloat kuangShiW = kuangShiImage.size.width;
    CGFloat kuangShiH = kuangShiImage.size.height;
    CGFloat kuangShiX = (kItemW - kuangShiW) * 0.5;
    CGFloat kuangShiY = 0;
    UIImageView *kuangshiImageView = [[UIImageView alloc] initWithImage:kuangShiImage];
    kuangshiImageView.frame = CGRectMake(kuangShiX, kuangShiY, kuangShiW, kuangShiH);
    [kuangShiItemView addSubview:kuangshiImageView];
    
    // 分值
    CGFloat scoreX = 0;
    CGFloat scoreY = kuangShiH;
    CGFloat scoreW = kItemW;
    CGFloat scoreH = kItemH - kuangShiH;
    UILabel *scoreLabel = [UILabel newWithText:[NSString stringWithFormat:@"%.3f",[scoreStr doubleValue]] fontSize:13 textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter];
    scoreLabel.frame = CGRectMake(scoreX, scoreY, scoreW, scoreH);
    [kuangShiItemView addSubview:scoreLabel];
    
    return kuangShiItemView;
}

#pragma mark------------------ 无矿石展示界面
-(void)singleKSShow:(NSString *)isLogin{
    [_NOKSView removeFromSuperview];
    UIView *kuangShiItemView = [[UIView alloc]init];
    [self.starImageView addSubview:kuangShiItemView];
    [kuangShiItemView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.starImageView);
        make.centerY.equalTo(self.starImageView);
        make.width.mas_offset(kItemW);
        make.height.mas_offset(kItemH);
    }];
    _NOKSView = kuangShiItemView;
    
    UIButton *kuangshiBtn = [UIButton new];
    [kuangshiBtn addTarget:self action:@selector(clickKuangshiBtn) forControlEvents:UIControlEventTouchUpInside];
    [kuangShiItemView addSubview:kuangshiBtn];
    [kuangshiBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.bottom.left.offset(0);
    }];
    
    // 矿石图标
    UIImage *kuangShiImage = [UIImage imageNamed:@"kuangshi"];
    CGFloat kuangShiW = kuangShiImage.size.width;
    CGFloat kuangShiH = kuangShiImage.size.height;
    CGFloat kuangShiX = (kItemW - kuangShiW) * 0.5;
    CGFloat kuangShiY = 0;
    UIImageView *kuangshiImageView = [[UIImageView alloc] initWithImage:kuangShiImage];
    kuangshiImageView.frame = CGRectMake(kuangShiX, kuangShiY, kuangShiW, kuangShiH);
    [kuangShiItemView addSubview:kuangshiImageView];
    
    // 分值
    //    CGFloat scoreX = 0;
    //    CGFloat scoreY = kuangShiH;
    CGFloat scoreW = kItemW +50;
    CGFloat scoreH = kItemH - kuangShiH;
    UILabel *scoreLabel = [UILabel newWithText:isLogin fontSize:13 textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter];
    [kuangShiItemView addSubview:scoreLabel];
    [scoreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(kuangshiImageView);
        make.width.mas_offset(scoreW);
        make.height.mas_offset(scoreH);
        make.top.equalTo(kuangshiImageView.mas_bottom).offset(0);
    }];
    
    [UIView animateWithDuration:1 delay:0.2 options:UIViewAnimationOptionRepeat | UIViewAnimationOptionAutoreverse | UIViewAnimationOptionAllowUserInteraction animations:^{
        CGRect frame = kuangShiItemView.frame;
        frame.origin.y =  - 5;
        kuangShiItemView.frame = frame;
    } completion:^(BOOL finished) {
    }];
}
//未登录的矿石点击
-(void)clickKuangshiBtn{
    NSString *str = [USER_DEFAULT objectForKey:@"LOGIN_SUCCESS"];
    if ([str isEqualToString:@"loginSuccess"]) {}else{
        [self loginSuccess];
    }
    
}

#pragma mark ------------ 点击音效效果
-(void)soundEffect{
    
//    NSString *filepath = [[NSBundle mainBundle]pathForResource:@"ding" ofType:@"mp3"];
//    NSData *data = [[NSData data]initWithContentsOfFile:filepath];
    NSURL *fileUrl = [[NSBundle mainBundle] URLForResource:@"ding" withExtension:@"mp3"];
    self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:fileUrl error:nil];
//    self.player = [[AVAudioPlayer alloc]initWithData:data error:nil];
    if (self.player) {
        [self.player play];
    }
   
}

#pragma mark -------- 第一页点击矿石效果
- (void)tapZuanShiItemView:(UIGestureRecognizer *)ges {
    [self soundEffect];
    UIView *touchView = ges.view;
    //向上浮动效果
    [UIView animateWithDuration:1 animations:^{
        CGRect frame = touchView.frame;
        frame.origin.y = -1000;
        touchView.frame = frame;
    } completion:^(BOOL finished) {
        [touchView removeFromSuperview];
        
    }];
    //点击一次 计数器自减1
    self.countNum = self.countNum -1;
    double locationScore = [[NSString stringWithFormat:@"%.3f",[self.dataArr[touchView.tag -1000] doubleValue]] doubleValue];
    self.allScore = self.allScore + locationScore;
    double scrollNumSum = self.requstAllScore +self.allScore;
    [self.sumLabel countFrom:scrollNumSum - locationScore to:scrollNumSum withDuration:1.f];
    if (self.countNum == 0) {
        if ([self.isSecondPage isEqualToString:@"YES"]) {
            [self setSecondPageView];
        }else{//没数据后显示正在生成
            [self singleKSShow:@"正在生成中"];
        }
    }
    //    NSString *locationNum = self.dataArr[touchView.tag -1000];
    NSString *locationId = self.dataIdArr[touchView.tag -1000];
    [self.saveNumAndIdArr addObject:locationId];
    [USER_DEFAULT setObject:self.saveNumAndIdArr forKey:@"CLAC_ARR"];
    CGSize titleSize = [self.sumLabel.text sizeWithFont:Font(16) constrainedToSize:CGSizeMake(MAXFLOAT, 30)];
    [self.topView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_offset(59 + titleSize.width);
    }];
}

#pragma mark -------- 第二页点击矿石效果
-(void)tapSecondZuanShiItemView:(UIGestureRecognizer *)ges{
    [self soundEffect];
    UIView *touchView = ges.view;
    //向上浮动效果
    [UIView animateWithDuration:1 animations:^{
        CGRect frame = touchView.frame;
        frame.origin.y = -1000;
        touchView.frame = frame;
    } completion:^(BOOL finished) {
        [touchView removeFromSuperview];
        
    }];
    //单个积分
    double locationScore = [[NSString stringWithFormat:@"%.3f",[self.dataArr[touchView.tag -1000] doubleValue]] doubleValue];
    self.allScore = self.allScore + locationScore;
    double scrollNumSum = self.requstAllScore + self.allScore;
    [self.sumLabel countFrom:scrollNumSum - locationScore to:scrollNumSum withDuration:1.f];
    //点击一次 计数器自减1
    self.countNum = self.countNum -1;
    if (self.countNum == 0) {//没数据之后显示正在生成
        [self singleKSShow:@"正在生成中"];
    }
    //    NSString *locationNum = self.dataArr[touchView.tag -1000];
    NSString *locationId = self.dataIdArr[touchView.tag -1000];
    [self.saveNumAndIdArr addObject:locationId];
    [USER_DEFAULT setObject:self.saveNumAndIdArr forKey:@"CLAC_ARR"];
    
    CGSize titleSize = [self.sumLabel.text sizeWithFont:Font(16) constrainedToSize:CGSizeMake(MAXFLOAT, 30)];
    [self.topView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_offset(59 + titleSize.width);
    }];
}

- (NSArray *)layouts {
    if (!_layouts) {
        if (SCREEN == 1) {
            _layouts = @[@[
                             [NSValue valueWithCGPoint:CGPointMake(20, 30)],
                             [NSValue valueWithCGPoint:CGPointMake(240, 100)],
                             [NSValue valueWithCGPoint:CGPointMake(120, 120)],
                             [NSValue valueWithCGPoint:CGPointMake(25, 150)],
                             [NSValue valueWithCGPoint:CGPointMake(10, 220)],
                             [NSValue valueWithCGPoint:CGPointMake(220, 210)],
                             [NSValue valueWithCGPoint:CGPointMake(180, 115)],
                             [NSValue valueWithCGPoint:CGPointMake(150, 190)],
                             [NSValue valueWithCGPoint:CGPointMake(140, 20)],
                             [NSValue valueWithCGPoint:CGPointMake(70, 40)]
                             ],
                         @[
                             [NSValue valueWithCGPoint:CGPointMake(20, 50)],
                             [NSValue valueWithCGPoint:CGPointMake(160, 200)],
                             [NSValue valueWithCGPoint:CGPointMake(10, 245)],
                             [NSValue valueWithCGPoint:CGPointMake(200, 250)],
                             [NSValue valueWithCGPoint:CGPointMake(200, 20)],
                             [NSValue valueWithCGPoint:CGPointMake(100, 170)],
                             [NSValue valueWithCGPoint:CGPointMake(25, 150)],
                             [NSValue valueWithCGPoint:CGPointMake(120, 80)],
                             [NSValue valueWithCGPoint:CGPointMake(240, 100)],
                             [NSValue valueWithCGPoint:CGPointMake(90, 20)]]];
        }else if(SCREEN == 2){
            _layouts = @[@[
                             [NSValue valueWithCGPoint:CGPointMake(20, 30)],
                             [NSValue valueWithCGPoint:CGPointMake(240, 100)],
                             [NSValue valueWithCGPoint:CGPointMake(120, 120)],
                             [NSValue valueWithCGPoint:CGPointMake(25, 150)],
                             [NSValue valueWithCGPoint:CGPointMake(10, 220)],
                             [NSValue valueWithCGPoint:CGPointMake(200, 260)],
                             [NSValue valueWithCGPoint:CGPointMake(180, 115)],
                             [NSValue valueWithCGPoint:CGPointMake(150, 190)],
                             [NSValue valueWithCGPoint:CGPointMake(140, 20)],
                             [NSValue valueWithCGPoint:CGPointMake(70, 40)]
                             ],
                         @[
                             [NSValue valueWithCGPoint:CGPointMake(20, 50)],
                             [NSValue valueWithCGPoint:CGPointMake(10, 235)],
                             [NSValue valueWithCGPoint:CGPointMake(135, 200)],
                             [NSValue valueWithCGPoint:CGPointMake(200, 260)],
                             [NSValue valueWithCGPoint:CGPointMake(200, 20)],
                             [NSValue valueWithCGPoint:CGPointMake(90, 160)],
                             [NSValue valueWithCGPoint:CGPointMake(25, 165)],
                             [NSValue valueWithCGPoint:CGPointMake(120, 80)],
                             [NSValue valueWithCGPoint:CGPointMake(240, 100)],
                             [NSValue valueWithCGPoint:CGPointMake(190, 180)]]];
            
        }else{
            _layouts = @[@[
                             [NSValue valueWithCGPoint:CGPointMake(40, 30)],
                             [NSValue valueWithCGPoint:CGPointMake(260, 80)],
                             [NSValue valueWithCGPoint:CGPointMake(140, 180)],
                             [NSValue valueWithCGPoint:CGPointMake(45, 150)],
                             [NSValue valueWithCGPoint:CGPointMake(30, 220)],
                             [NSValue valueWithCGPoint:CGPointMake(250, 240)],
                             [NSValue valueWithCGPoint:CGPointMake(200, 115)],
                             [NSValue valueWithCGPoint:CGPointMake(170, 240)],
                             [NSValue valueWithCGPoint:CGPointMake(160, 20)],
                             [NSValue valueWithCGPoint:CGPointMake(90, 60)]
                             ],
                         @[
                             [NSValue valueWithCGPoint:CGPointMake(50, 50)],
                             [NSValue valueWithCGPoint:CGPointMake(40, 235)],
                             [NSValue valueWithCGPoint:CGPointMake(155, 270)],
                             [NSValue valueWithCGPoint:CGPointMake(230, 260)],
                             [NSValue valueWithCGPoint:CGPointMake(230, 20)],
                             [NSValue valueWithCGPoint:CGPointMake(130, 170)],
                             [NSValue valueWithCGPoint:CGPointMake(55, 165)],
                             [NSValue valueWithCGPoint:CGPointMake(150, 80)],
                             [NSValue valueWithCGPoint:CGPointMake(270, 100)],
                             [NSValue valueWithCGPoint:CGPointMake(220, 180)]]];
        }
    }
    return _layouts;
}

-(NSArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSArray array];
    }
    return _dataArr;
}

-(NSArray *)dataIdArr{
    if (!_dataIdArr) {
        _dataIdArr = [NSArray array];
    }
    return _dataIdArr;
}

-(NSMutableArray *)saveNumAndIdArr{
    if (!_saveNumAndIdArr) {
        _saveNumAndIdArr = [NSMutableArray array];
    }
    return _saveNumAndIdArr;
}

-(void)setUI{
    [self.backgroundView removeFromSuperview];
    self.backgroundView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [self.backgroundView setImage:[UIImage imageNamed:@"背景"]];
    self.backgroundView.userInteractionEnabled = YES;
    [self.view addSubview:self.backgroundView];
    
    UIView *runlabelView = [UIView new];
    runlabelView.layer.cornerRadius = 15;
    runlabelView.backgroundColor = Color(0x2A014E);
    [self.backgroundView addSubview:runlabelView];
    [runlabelView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(12);
        make.top.offset(kStatusBarHeight);
        make.right.offset(-79);
        make.height.mas_offset(30);
    }];
    
    UIImageView *bugleImageView = [UIImageView new];
    UIImage *sizeImage = [UIImage imageNamed:@"喇叭"];
    bugleImageView.userInteractionEnabled = YES;
    [bugleImageView setImage:sizeImage];
    [runlabelView addSubview:bugleImageView];
    [bugleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(runlabelView).offset(10);
        make.centerY.equalTo(runlabelView);
    }];
    //跑马灯 x轴距离
    float lfetSpace = 10 + 10 +sizeImage.size.width;
    //跑马灯
    self.runLabel = [[HHRunLabelView alloc] initWithFrame:CGRectMake(lfetSpace,0, SCREEN_WIDTH-lfetSpace -12 -79 -12, 30)];
    self.runLabel.backgroundColor = [UIColor clearColor];
    self.runLabel.textColor = [UIColor whiteColor];
    self.runLabel.font = Font(14);
    self.runLabel.speed = 0.5;
    self.runLabel.text = @"";
    [runlabelView addSubview:self.runLabel];
    
    
    //顶部积分
    self.topView = [UIView new];
    self.topView.layer.cornerRadius = 20;
    self.topView.backgroundColor = [UIColor clearColor];
    //边框颜色
    [self.topView.layer setBorderColor:UIColorFromRGB(0x633fa9).CGColor];
    [self.topView.layer setBorderWidth:1];
    [self.topView.layer setMasksToBounds:YES];
    [self.backgroundView addSubview:self.topView];
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(runlabelView.mas_bottom).offset(25);
        make.centerX.equalTo(self.backgroundView);
        make.height.mas_offset(40);
        make.width.mas_offset(59 + 50);
    }];
    
    //钻石图片
    UIImageView *jewelImageView = [UIImageView new];
    jewelImageView.userInteractionEnabled = YES;
    [jewelImageView setImage:[UIImage imageNamed:@"钻石"]];
    [self.topView addSubview:jewelImageView];
    [jewelImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.topView).offset(20);
        make.centerY.equalTo(self.topView);
        make.width.mas_offset(19);
        make.height.mas_offset(21);
    }];
    //总积分
    self.sumLabel = [[UICountingLabel alloc]init];
    self.sumLabel.font = Font(16);
    self.sumLabel.format = @"%.3f";
    self.sumLabel.text = @"0.000";
    self.sumLabel.textAlignment = NSTextAlignmentLeft;
    self.sumLabel.backgroundColor = [UIColor clearColor];
    self.sumLabel.textColor = [UIColor whiteColor];
    [self.topView addSubview:self.sumLabel];
    [self.sumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(jewelImageView.mas_right).offset(10);
        make.centerY.equalTo(jewelImageView);
        //        make.width.mas_offset(90);
    }];
    
    //星球
    self.starImageView = [UIImageView new];
    [self.starImageView setImage:[UIImage imageNamed:@"starBack"]];
    self.starImageView.userInteractionEnabled = YES;
    [self.backgroundView addSubview:self.starImageView];
    [self.starImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        if (SCREEN == 1) {
            make.top.equalTo(self.topView.mas_bottom).offset(0);
        }else{
            make.top.equalTo(self.topView.mas_bottom).offset(40);
        }
        
        make.width.height.mas_offset(305);
    }];
    
    self.signImageBtn = [UIButton newWithTitle:nil font:0 textColor:nil textAlignment:NSTextAlignmentLeft Image:[UIImage imageNamed:@"sign"]];
    [self.signImageBtn addTarget:self action:@selector(signBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.backgroundView addSubview:self.signImageBtn];
    [self.signImageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(0);
        make.width.mas_offset(63);
        make.height.mas_offset(24);
        make.centerY.equalTo(runlabelView);
    }];
    
    UILabel *leftLabel = [UILabel newWithText:@"云力：" fontSize:16 textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentLeft];
    [self.backgroundView addSubview:leftLabel];
    [leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(12);
        make.bottom.offset(-TabbarHeight - 30);
        //        make.width.mas_offset(60);
    }];
    
    
    self.leftLabelNum = [UILabel newWithText:@"" fontSize:16 textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentLeft];
    [self.backgroundView addSubview:self.leftLabelNum];
    [self.leftLabelNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(leftLabel.mas_right).offset(0);
        make.centerY.equalTo(leftLabel);
        make.width.mas_offset(50);
    }];
    
    UILabel *showRightLabel = [UILabel newWithText:@"规则攻略" fontSize:14 textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentRight];
    [self.backgroundView addSubview:showRightLabel];
    [showRightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-12);
        make.bottom.offset(-TabbarHeight - 30);
    }];
    
    UIButton *rightBtn = [UIButton newWithTitle:nil font:0 textColor:nil textAlignment:NSTextAlignmentLeft Image:[UIImage imageNamed:@"规则"]];
    [rightBtn addTarget:self action:@selector(clickRightBtn) forControlEvents:UIControlEventTouchUpInside];
    rightBtn.layer.cornerRadius = 50;
    [self.backgroundView addSubview:rightBtn];
    [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(showRightLabel);
        make.bottom.equalTo(showRightLabel.mas_top).offset(-8);
        make.height.width.mas_offset(50);
    }];
    
    UILabel *showLeftLabel = [UILabel newWithText:@"邀请好友" fontSize:14 textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentRight];
    [self.backgroundView addSubview:showLeftLabel];
    [showLeftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(showRightLabel.mas_left).offset(-14);
        make.bottom.offset(-TabbarHeight - 30);
    }];
    
    UIButton *leftBtn = [UIButton newWithTitle:nil font:0 textColor:nil textAlignment:NSTextAlignmentLeft Image:[UIImage imageNamed:@"邀请"]];
    [leftBtn addTarget:self action:@selector(leftBtn) forControlEvents:UIControlEventTouchUpInside];
    leftBtn.layer.cornerRadius = 50;
    [self.backgroundView addSubview:leftBtn];
    [leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(showLeftLabel);
        make.centerY.equalTo(rightBtn);
        make.height.width.mas_offset(50);
    }];
    
    UIButton *yunliBtn = [UIButton newWithTitle:nil font:0 textColor:nil textAlignment:NSTextAlignmentLeft Image:[UIImage imageNamed:@"云力"]];
    [yunliBtn addTarget:self action:@selector(yunliBtn) forControlEvents:UIControlEventTouchUpInside];
    yunliBtn.layer.cornerRadius = 50;
    [self.backgroundView addSubview:yunliBtn];
    [yunliBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15);
        make.centerY.equalTo(leftBtn);
        make.height.width.mas_offset(50);
    }];
    
    //    UIImageView *leftImageView = [UIImageView new];
    //    leftImageView.userInteractionEnabled = YES;
    //    leftImageView.layer.cornerRadius = 50;
    //    [leftImageView setImage:[UIImage imageNamed:@"云力"]];
    //    [self.backgroundView addSubview:leftImageView];
    //    [leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.left.offset(15);
    //        make.centerY.equalTo(leftBtn);
    //        make.height.width.mas_offset(50);
    //    }];
}
//云力点击
-(void)yunliBtn{
    SLog(@"云力");
    NSString *str = [USER_DEFAULT objectForKey:@"LOGIN_SUCCESS"];
    if ([str isEqualToString:@"loginSuccess"]) {
        [self sendFlotageRequest];
        CheckClacVC *vc = [CheckClacVC new];
        [vc setHidesBottomBarWhenPushed:YES];
        vc.clacStr = self.leftLabelNum.text;
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        [self loginSuccess];
    }
}

//邀请好友
-(void)leftBtn{
    NSString *str = [USER_DEFAULT objectForKey:@"LOGIN_SUCCESS"];
    if ([str isEqualToString:@"loginSuccess"]) {
        [self sendFlotageRequest];
        InviteExcavateVC * inviteExcavateVC = [[InviteExcavateVC alloc]init];
        [inviteExcavateVC setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:inviteExcavateVC animated:YES];
    }else{
        [self loginSuccess];
    }
    
}
//规则攻略
-(void)clickRightBtn{
    [self sendFlotageRequest];
    RuleStrategyVC *vc = [RuleStrategyVC new];
    [vc setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:vc animated:YES];
}

//签到按钮
-(void)signBtn:(UIButton *)sender{
    NSString *str = [USER_DEFAULT objectForKey:@"LOGIN_SUCCESS"];
    if ([str isEqualToString:@"loginSuccess"]) {
        [self sendFlotageRequest];
        [self updateClacRequest];
    }else{
        [self loginSuccess];
    }
}
//获得云力和sdt
-(void)getClacRequest{
    NSString *urlStr = [NSString stringWithFormat:@"%@uid=%@",GET_CLOUD_CLAC_URL,USER_ID];
    urlStr = [urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    [YGYBaseViewModel postRequestWithPath:urlStr parameters:nil responseDataModel:[GetClacModel class] success:^(id responseObject) {
        GetClacModel *model = responseObject;
        if ([model.status isEqualToString:@"200"]) {
            GetClacData *data = model.data;
            self.clacStr = data.calc;
            self.leftLabelNum.text = self.clacStr;
            self.requstAllScore = [[NSString stringWithFormat:@"%.3f",[data.sdt doubleValue]] doubleValue];
            self.sumLabel.text = [NSString stringWithFormat:@"%.3f",self.requstAllScore];
            self.runLabel.text = data.news;
            if ([data.sign isEqualToString:@"0"]) {//0表示未签到 可以签到
                self.signImageBtn.userInteractionEnabled = YES;
                [self.signImageBtn setImage:[UIImage imageNamed:@"sign"] forState:UIControlStateNormal];
            }else{
                self.signImageBtn.userInteractionEnabled = NO;
                [self.signImageBtn setImage:[UIImage imageNamed:@"sign_Grey"] forState:UIControlStateNormal];
            }
            CGSize titleSize = [self.sumLabel.text sizeWithFont:Font(16) constrainedToSize:CGSizeMake(MAXFLOAT, 30)];
            [self.topView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.mas_offset(59 + titleSize.width);
            }];
            
            [self.view layoutIfNeeded];
        }else{
            //            MBHUD(model.msg);
        }
        
    } failure:^(NSError *error) {
    }];
}
#pragma mark ------点击签到积分增长请求
-(void)updateClacRequest{
    NSString *urlStr = [NSString stringWithFormat:@"%@uid=%@&behavior=sign",UPDATE_CLOUD_CLAC_URL,USER_ID];
    urlStr = [urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    [YGYBaseViewModel postRequestWithPath:urlStr parameters:nil responseDataModel:[YGYBaseDataModel class] success:^(id responseObject) {
        YGYBaseDataModel *model = responseObject;
        if ([model.status isEqualToString:@"200"]) {
            self.signImageBtn.userInteractionEnabled = NO;
            [self.signImageBtn setImage:[UIImage imageNamed:@"sign_Grey"] forState:UIControlStateNormal];
            MBHUD(@"签到成功");
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

#pragma mark --- 获得云游所有漂浮物数据
-(void)requestWithAllData{
    NSString *urlStr = [NSString stringWithFormat:@"%@uid=%@",GET_SDT_LIST_URL,USER_ID];
    urlStr = [urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    [YGYBaseViewModel postRequestWithPath:urlStr parameters:nil responseDataModel:[GetSdtListModel class] success:^(id responseObject) {
        GetSdtListModel *model = responseObject;
        if ([model.status isEqualToString:@"200"]) {
            if (model.data.count > 0 ) {
                NSArray *sdtDataArr = model.data;
                NSMutableArray *numArr = [NSMutableArray array];
                NSMutableArray *idArr = [NSMutableArray array];
                for (int i = 0; i < sdtDataArr.count; i ++) {
                    GetSdtListData *data = sdtDataArr[i];
                    [numArr addObject:data.num];
                    [idArr addObject:data.score];
                }
                self.dataArr = numArr;
                self.dataIdArr = idArr;
                [self setUpRandomView];//数据请求成功 显示漂浮物
                [self.NOKSView removeFromSuperview];//移除未登录以及正在生成中的状态
                
            }else{
                [self singleKSShow:@"正在生成中"];
            }
        }else{
            [self singleKSShow:@"正在生成中"];
        }
        
    } failure:^(NSError *error) {
    }];
}

#pragma mark --- 未登录状态的跑马灯文案
-(void)nolLoginStatusRunLabelRequest{
    NSString * url = [NSString stringWithFormat:@"%@",GET_LATEST_INFO];
    url = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    [YGYBaseViewModel postRequestWithPath:url parameters:nil responseDataModel:[RunLabelModel class] success:^(id responseObject) {
        RunLabelModel *model = responseObject;
        RunLabelData *data = model.data;
        if ([model.status isEqualToString:@"200"]) {
            self.runLabel.text = data.content;
        }else{
            //                MBHUD(model.msg);
        }
    } failure:^(NSError *error) {
        
    }];
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

//未登录点击弹窗
-(void)loginSuccess{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"当前账号未登录，请登录" message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault  handler:^(UIAlertAction * action) {
    }];
    
    UIAlertAction* loginAction = [UIAlertAction actionWithTitle:@"立即登录" style:UIAlertActionStyleDefault  handler:^(UIAlertAction * action) {
        LoginVC *loginV = [[LoginVC alloc]init];
        [loginV setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:loginV animated:YES];
    }];
    [cancelAction setValue:SECOND_BODY forKey:@"titleTextColor"];
    [loginAction setValue:MAIN_BODY forKey:@"titleTextColor"];
    
    [alertController addAction:cancelAction];
    [alertController addAction:loginAction];
    
    [[[[UIApplication sharedApplication] keyWindow] rootViewController] presentViewController:alertController animated:YES completion:nil];
}




#pragma mark------------判断网络状态
-(NSString *)internetStatus {
    Reachability *reachability   = [Reachability reachabilityWithHostName:@"www.baidu.com"];
    NetworkStatus internetStatus = [reachability currentReachabilityStatus];
    NSString *net = @"WIFI";
    switch (internetStatus) {
        case ReachableViaWiFi:
            net = @"WIFI";
            break;
        case ReachableViaWWAN:
            net = @"蜂窝数据";
            //net = [self getNetType ];   //判断具体类型
            break;
            
        case NotReachable:
            net = @"无网络";
            
        default:
            break;
    }
    
    return net;
}

#pragma mark --------------无网络加载图
-(void)noNetworkBackImageView{
    self.noNetworkImageView = [UIImageView new];
    self.noNetworkImageView.userInteractionEnabled = YES;
    [self.noNetworkImageView setImage:[UIImage imageNamed:@"无网络加载图"]];
    [self.view addSubview:self.noNetworkImageView];
    [self.noNetworkImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.offset(0);
    }];
    
    UIButton *reFreshBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    CAGradientLayer * gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(__bridge id)[ColorFormatter hex2Color:0x6b4eff].CGColor, (__bridge id)[ColorFormatter hex2Color:0xc164ff].CGColor];
    gradientLayer.locations = @[@0.1, @1.0];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1, 0);
    gradientLayer.frame = CGRectMake(0, 0, 84,30);
    gradientLayer.cornerRadius = 15;
    [reFreshBtn.layer addSublayer:gradientLayer];
    
    UILabel *noNetLabel = [UILabel newWithText:@"目前没有网络，请检查网络设置" fontSize:14 textColor:SECOND_BODY textAlignment:NSTextAlignmentCenter];
    [self.noNetworkImageView addSubview:noNetLabel];
    [noNetLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.noNetworkImageView);
        make.centerX.equalTo(self.noNetworkImageView);
    }];
    
    
    reFreshBtn.titleLabel.font = Font(14);
    [reFreshBtn setTitleColor:YGYColor(255, 255, 255) forState:UIControlStateNormal];
    [reFreshBtn setTitle:@"刷新" forState:UIControlStateNormal];
    [reFreshBtn addTarget:self action:@selector(reFreshBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.noNetworkImageView addSubview:reFreshBtn];
    [reFreshBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(noNetLabel.mas_bottom).offset(14);
        make.height.mas_offset(30);
        make.width.mas_offset(84);
        make.centerX.equalTo(self.noNetworkImageView);
    }];
}
-(void)reFreshBtn{
    SLog(@"点击刷新");
    if (self.noNetworkImageView) {
        [self.noNetworkImageView removeFromSuperview];
        self.noNetworkImageView = nil;
    }

    if (self.backgroundView) {
        [self.backgroundView removeFromSuperview];
    }

    if ([[self internetStatus] isEqualToString:@"WIFI"] || [[self internetStatus] isEqualToString:@"蜂窝数据"]) {
        [self enterPage];
    }else{
        [self noNetworkBackImageView];
    }
}
@end
