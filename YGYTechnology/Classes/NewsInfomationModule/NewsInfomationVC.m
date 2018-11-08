//
//  NewsInfomationVC.m
//  YGYTechnology
//
//  Created by 袁庭楷 on 2018/9/25.
//  Copyright © 2018年 YGY. All rights reserved.
//

#import "NewsInfomationVC.h"
#import "NewsInfoCell.h"
#import "NewsInfoModel.h"
#import "NewsInfoDeatilsVC.h"

@interface NewsInfomationVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray * dataSourceArr;//数据源数组
@property (nonatomic, strong) UIView * topView;
@property (nonatomic, strong) NewsInfoPageData * newsInfoPageData;
@property (nonatomic, assign) NSInteger refreshNum;//记录上拉加载页数 用于下拉刷新使用
@property (nonatomic, strong) NSString * totalStr;//总数
@property (nonatomic, strong)  UIImageView *noDataImageView;
@property (nonatomic, strong) UIImageView *noNetworkImageView;
@property (nonatomic, strong) NSString * recordFirstEnterNewsPage;
@end

static NSString * const Identifier = @"newsInfoCell";
@implementation NewsInfomationVC

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [self.navigationController setHidesBottomBarWhenPushed:YES];

    [self reFreshBtn];
}

#pragma mark ----------- 进入界面调用的方法
-(void)enterPage{
    [self sendFlotageRequest];
    [self setNav];
    [self requestWithNewPwd];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = Color(0xf2f2f2);
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    
    [self enterPage];
}



-(void)setNav{
    self.topView = [ViewTools createGradientLayerNav_BarViewWithString:@"资讯"];
    [self.view addSubview:self.topView];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataSourceArr.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 82;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.0001;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.dataSourceArr.count > 0) {
        self.newsInfoPageData = self.dataSourceArr[indexPath.section];
        NewsInfoDeatilsVC * inviteExcavateVC = [[NewsInfoDeatilsVC alloc]init];
        inviteExcavateVC.webUrlStr = self.newsInfoPageData.url;
        [inviteExcavateVC setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:inviteExcavateVC animated:YES];
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NewsInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    if (cell == nil) {
        cell = [[NewsInfoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
    }if (self.dataSourceArr.count > 0) {
        self.newsInfoPageData = self.dataSourceArr[indexPath.section];
        [cell setIndexPath:indexPath dataArr:self.newsInfoPageData];
    }
    return cell;
}

-(UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kNavHeight, SCREEN_WIDTH, SCREEN_HEIGHT - kNavHeight - TabbarHeight) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
        //        _tableView.separatorColor = YGYColor(245, 245, 245);
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
        //        _tableView.allowsSelection = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        NSMutableArray *ary=[NSMutableArray new];
        for(int I = 0;I < 31;I ++){
            //通过for 循环,把我所有的 图片存到数组里面
            NSString *imageName=[NSString stringWithFormat:@"合成%d",I];
            UIImage *image=[UIImage imageNamed:imageName];
            [ary addObject:image];
        }
        MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
        header.lastUpdatedTimeLabel.hidden = YES;
        //        header.stateLabel.hidden = YES;
        [header setImages:ary forState:MJRefreshStateIdle];
        [header setImages:ary forState:MJRefreshStatePulling];
        [header setImages:ary forState:MJRefreshStateRefreshing];
        // Set header
        self.tableView.mj_header = header;
        _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(topPushLoading)];//上拉加载
    }
    return _tableView;
}

#pragma mark --- request
-(void)requestWithNewPwd{
    STOP_LOADING
    LOADING
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
    [self removeNoDataImage];
    self.refreshNum = 10;
    NSString *urlStr = [NSString stringWithFormat:@"%@index=1&size=%ld",NEWS_INFO_URL,(long)self.refreshNum];
    urlStr = [urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    [YGYBaseViewModel getRequestWithPath:urlStr parameters:nil responseDataModel:[NewsInfoModel class] success:^(id responseObject) {
        STOP_LOADING
        NewsInfoModel *model = responseObject;
        NewsInfoData *data = model.data;
        if ([model.status isEqualToString:@"200"]) {
            self.dataSourceArr = data.pageData;
            self.totalStr = data.total;
            if (self.dataSourceArr.count > 0) {
                [self.view addSubview:self.tableView];
            }else{
                self.noDataImageView = [[UIImageView alloc]init];
                [self.noDataImageView setImage:[UIImage imageNamed:@"暂无数据"]];
                [self.tableView addSubview:self.noDataImageView];
                [self.noDataImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.right.top.bottom.offset(0);
                }];
            }
            [self.tableView reloadData];
            SLog(@"ok");
        }else{
            MBHUD(model.msg);
        }
        
    } failure:^(NSError *error) {
        STOP_LOADING
        if (error.code == WDNetError) {
            [iToast showMessage:NO_Network];
        }else{
            [iToast showMessage:NO_Service];
        }
    }];
}

#pragma mark --lazy Data && func
-(NSArray *)dataSourceArr{
    if (!_dataSourceArr) {
        _dataSourceArr = [NSArray array];
    }
    return _dataSourceArr;
}


#pragma mark  -----------下拉刷新
-(void)loadNewData{
    [self.tableView.mj_header beginRefreshing];
    NSString *urlStr = [NSString stringWithFormat:@"%@index=1&size=%ld",NEWS_INFO_URL,(long)self.refreshNum];
    urlStr = [urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    [YGYBaseViewModel getRequestWithPath:urlStr parameters:nil responseDataModel:[NewsInfoModel class] success:^(id responseObject) {
        [self.tableView.mj_header endRefreshing];
        NewsInfoModel *model = responseObject;
        NewsInfoData *data = model.data;
        if ([model.status isEqualToString:@"200"]) {
            self.dataSourceArr = data.pageData;
            if (self.dataSourceArr.count > 0) {
                [self.tableView reloadData];
            }
            SLog(@"ok");
        }else{
            MBHUD(model.msg);
        }
        
    } failure:^(NSError *error) {
        [self.tableView.mj_header endRefreshing];
        if (error.code == WDNetError) {
            [iToast showMessage:NO_Network];
        }else{
            [iToast showMessage:NO_Service];
        }
    }];
}
#pragma mark  -----------上拉加载
-(void)topPushLoading{
    [self.tableView.mj_footer beginRefreshing];
    if (self.refreshNum > [self.totalStr integerValue]) {
    }else{
        self.refreshNum = self.refreshNum + 10;
    }
    NSString *urlStr = [NSString stringWithFormat:@"%@index=1&size=%ld",NEWS_INFO_URL,(long)self.refreshNum];
    urlStr = [urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    [YGYBaseViewModel getRequestWithPath:urlStr parameters:nil responseDataModel:[NewsInfoModel class] success:^(id responseObject) {
        NewsInfoModel *model = responseObject;
        NewsInfoData *data = model.data;
        if ([model.status isEqualToString:@"200"]) {
            self.dataSourceArr = data.pageData;
            if (self.dataSourceArr.count > 0) {
                [self.tableView reloadData];
            }
            if (self.dataSourceArr.count == [data.total integerValue]) {
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
            }else{
                [self.tableView.mj_footer endRefreshing];
            }
            SLog(@"ok");
        }else{
            MBHUD(model.msg);
        }
        
    } failure:^(NSError *error) {
        [self.tableView.mj_footer endRefreshing];
        if (error.code == WDNetError) {
            [iToast showMessage:NO_Network];
        }else{
            [iToast showMessage:NO_Service];
        }
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
                MBHUD(model.msg);
            }
            
        } failure:^(NSError *error) {
            
        }];
    }else{
        SLog(@"数组为空~~~~不用传值");
    }
}
-(void)removeNoDataImage{
    [self.noDataImageView removeFromSuperview];
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
//    if (self.dataSourceArr.count > 0) {
//        self.dataSourceArr = nil;
//    }
//    if (self.tableView) {
//        [self.tableView removeFromSuperview];
//    }
//    if (self.topView) {
//        [self.topView removeFromSuperview];
//    }
    if ([[self internetStatus] isEqualToString:@"WIFI"] || [[self internetStatus] isEqualToString:@"蜂窝数据"]) {
        if ([self.recordFirstEnterNewsPage isEqualToString:@"YES"]) {
            self.recordFirstEnterNewsPage = @"NO";
            [self enterPage];
        }
    }else{
        self.recordFirstEnterNewsPage = @"YES";
        [self noNetworkBackImageView];
    }
}

@end
