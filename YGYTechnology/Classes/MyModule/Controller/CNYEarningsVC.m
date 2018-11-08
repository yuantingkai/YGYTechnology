//
//  CNYEarningsVC.m
//  YGYTechnology
//
//  Created by 袁庭楷 on 2018/10/19.
//  Copyright © 2018年 YGY. All rights reserved.
//

#import "CNYEarningsVC.h"
#import "CNYEarningsCell.h"
#import "CNYEarningsModel.h"
#import "CNYWithdrawDeatilsModel.h"
#import "CNYEarningsDeatilsModel.h"
#import "CNYWithDrawDetailsCell.h"

@interface CNYEarningsVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UITableView *withdrawDeatilsTableView;
@property (nonatomic, strong) UIView * topNavView;
@property (nonatomic, strong) UIView *topBackView;
@property (nonatomic, strong) UILabel *SDTScoreLabel;
@property (nonatomic, strong) UILabel *earningSumLabel;
@property (nonatomic, strong) UILabel *getSumLabel;
@property (nonatomic, strong) UILabel *earningDetailLabel;//收益明细 用于点击变色
@property (nonatomic, strong) UILabel *getDetailLabel;//提现明细 用于提现变色
@property (nonatomic, assign) NSInteger refreshNum;//记录上拉加载页数 用于下拉刷新使用
@property (nonatomic, strong) NSString * totalStr;//总数
@property (nonatomic, strong) NSArray * dataSourceArr;//数据源数组
@property (nonatomic, strong) NSArray * withdrawDataSourceArr;
@property (nonatomic, strong) CNYEarningsDeatilsPageData * pageData;
@property (nonatomic, strong) CNYWithdrawDeatilsPageData * CNYWithdrawPageData;
@property (nonatomic, strong) NSString * isEarningList;
@property (nonatomic, strong)  UIImageView *noDataImageView;
@end
static NSString * const earningIdentifier = @"CNYEarningsDeatilsCell";
static NSString * const withDrawIdentifier = @"CNYWithDrawDetailsCell";
@implementation CNYEarningsVC



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = Color(0xf2f2f2);
    [self setUI];
    self.isEarningList = @"YES";
    [self.view addSubview:self.tableView];
    [self getEarningsRequest];
    [self earningListRequest];
}

-(void)setUI{
    //初始化渐变色
    CAGradientLayer * gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(__bridge id)[ColorFormatter hex2Color:0x6F8AF9].CGColor, (__bridge id)[ColorFormatter hex2Color:0x8033CB].CGColor];
    gradientLayer.locations = @[@0.1, @1.0];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1, 0);
    gradientLayer.frame = CGRectMake(0, 0, SCREEN_WIDTH,218);
    [self.view.layer addSublayer:gradientLayer];
    
    self.topBackView = [UIView new];
    self.topBackView.backgroundColor = [UIColor clearColor];
    self.topBackView.userInteractionEnabled = YES;
    [self.view addSubview:self.topBackView];
    [self.topBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.offset(0);
        make.height.mas_offset(218);
    }];
    
    self.topNavView = [ViewTools createNav_BarViewWithString:@"我的收益"];
    self.topNavView.backgroundColor = [UIColor clearColor];
    [self.topBackView addSubview:self.topNavView];
    
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setImage:[UIImage imageNamed:@"leftArrow"] forState:UIControlStateNormal];
    [leftBtn sizeToFit];
    leftBtn.expandHitEdgeInsets = UIEdgeInsetsMake(15, 15, 15, 15);
    [leftBtn addTarget:self action:@selector(returnTopVC) forControlEvents:UIControlEventTouchUpInside];
    [self.topNavView addSubview:leftBtn];
    [leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(12);
        make.bottom.mas_offset(kNavControlImgBottom);
    }];
    
    UILabel *showLabel = [UILabel newWithText:@"账户余额（CNY）" fontSize:12 textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter];
    [self.topBackView addSubview:showLabel];
    [showLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topNavView.mas_bottom).offset(23);
        make.centerX.equalTo(self.topBackView);
    }];
    
    self.SDTScoreLabel = [UILabel newWithText:@"0.00" fontSize:35 textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter];
    [self.topBackView addSubview:self.SDTScoreLabel];
    [self.SDTScoreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(showLabel.mas_bottom).offset(10);
        make.centerX.equalTo(self.topBackView);
    }];
    
    
    
    UIView *centerView = [UIView new];
    centerView.backgroundColor = [UIColor whiteColor];
    centerView.layer.cornerRadius = 8;
    [self.view addSubview:centerView];
    [centerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(12);
        make.right.offset(-12);
        make.height.mas_offset(62);
        if (Is_Iphone_X) {
            make.top.equalTo(self.topBackView.mas_bottom).offset(-11);
        }else{
            make.top.equalTo(self.topBackView.mas_bottom).offset(-31);
        }
    }];
    
    UIView *lineView = [UIView new];
    lineView.backgroundColor = MAIN_BODY;
    [centerView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(centerView);
        make.width.mas_offset(1);
        make.height.mas_offset(30);
        make.centerY.equalTo(centerView);
    }];
    
    
    
    UIImageView *leftImageView = [UIImageView new];
    [leftImageView setImage:[UIImage imageNamed:@"earning_icon"]];
    leftImageView.userInteractionEnabled = YES;
    [centerView addSubview:leftImageView];
    [leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(centerView);
        make.left.offset(44);
        make.top.offset(19);
        make.bottom.offset(-19);
    }];
    
    self.earningDetailLabel = [UILabel newWithText:@"收益明细" fontSize:14 textColor:CLICK_BODY textAlignment:NSTextAlignmentCenter];
    [centerView addSubview:self.earningDetailLabel];
    [self.earningDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(centerView);
        make.left.equalTo(leftImageView.mas_right).offset(6);
    }];
    
    
    
    self.getDetailLabel = [UILabel newWithText:@"提现明细" fontSize:14 textColor:MAIN_BODY textAlignment:NSTextAlignmentCenter];
    [centerView addSubview:self.getDetailLabel];
    [self.getDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(centerView);
        make.right.offset(-44);
    }];
    
    UIImageView *rightImageView = [UIImageView new];
    [rightImageView setImage:[UIImage imageNamed:@"getMoney_icon"]];
    rightImageView.userInteractionEnabled = YES;
    [centerView addSubview:rightImageView];
    [rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(centerView);
        make.right.equalTo(self.getDetailLabel.mas_left).offset(-6);
        make.top.offset(19);
        make.bottom.offset(-19);
    }];
    
    UIButton *centerLeftBtn = [UIButton new];
    centerLeftBtn.cs_acceptEventInterval = 2;
    [centerLeftBtn addTarget:self action:@selector(clickCenterLeftBtn) forControlEvents:UIControlEventTouchUpInside];
    [centerView addSubview:centerLeftBtn];
    [centerLeftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.offset(0);
        make.right.equalTo(lineView.mas_left).offset(0);
    }];
    
    
    self.earningSumLabel = [UILabel newWithText:@"总收益：0.00" fontSize:12 textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter];
    [self.topBackView addSubview:self.earningSumLabel];
    [self.earningSumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(centerLeftBtn);
        make.bottom.equalTo(centerLeftBtn.mas_top).offset(-6);
    }];
    
    UIButton *centerRightBtn = [UIButton new];
    centerRightBtn.cs_acceptEventInterval = 2;
    [centerRightBtn addTarget:self action:@selector(clickCenterRightBtn) forControlEvents:UIControlEventTouchUpInside];
    [centerView addSubview:centerRightBtn];
    [centerRightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.offset(0);
        make.left.equalTo(lineView.mas_right).offset(0);
    }];
    
    self.getSumLabel = [UILabel newWithText:@"总提现：0.00" fontSize:12 textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter];
    [self.topBackView addSubview:self.getSumLabel];
    [self.getSumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(centerRightBtn);
        make.bottom.equalTo(centerRightBtn.mas_top).offset(-6);
    }];
}
#pragma mark -------------收益明细
-(void)clickCenterLeftBtn{
    self.earningDetailLabel.textColor = CLICK_BODY;
    self.getDetailLabel.textColor = MAIN_BODY;
    [self.withdrawDeatilsTableView removeFromSuperview];
    [self.view addSubview:self.tableView];
    [self earningListRequest];
}
#pragma mark -------------提现明细
-(void)clickCenterRightBtn{
    self.getDetailLabel.textColor = CLICK_BODY;
    self.earningDetailLabel.textColor = MAIN_BODY;
    [self.tableView removeFromSuperview];
    [self.view addSubview:self.withdrawDeatilsTableView];
    [self withdrawListRequest];
}

-(void)returnTopVC {
    [self.navigationController popViewControllerAnimated:YES];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if ([tableView isEqual:self.tableView]){
        return self.dataSourceArr.count;
    }else  if([tableView isEqual:self.withdrawDeatilsTableView]){
       return self.withdrawDataSourceArr.count;
    }
    return 0;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 48;
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

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isEqual:self.tableView]){
        CNYEarningsCell *cell = [tableView dequeueReusableCellWithIdentifier:earningIdentifier];
        if (cell == nil) {
            cell = [[CNYEarningsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:earningIdentifier];
        }
        if (self.dataSourceArr.count > 0) {
            self.pageData = self.dataSourceArr[indexPath.section];
            [cell setIndexPath:indexPath withPageData:self.pageData];
        }
        
        return cell;
    }else  if([tableView isEqual:self.withdrawDeatilsTableView]){
        CNYWithDrawDetailsCell *cell = [tableView dequeueReusableCellWithIdentifier:withDrawIdentifier];
        if (cell == nil) {
            cell = [[CNYWithDrawDetailsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:withDrawIdentifier];
        }
        if (self.withdrawDataSourceArr.count > 0) {
            self.CNYWithdrawPageData = self.withdrawDataSourceArr[indexPath.section];
            [cell setIndexPath:indexPath withPageData:self.CNYWithdrawPageData];
        }
        
        return cell;
    }

    return nil;
}


-(UITableView *)tableView
{
    if (!_tableView) {
        if (Is_Iphone_X) {
            _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 218 + 51, SCREEN_WIDTH, SCREEN_HEIGHT - 218 - 51) style:UITableViewStyleGrouped];
        }else{
            _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 218 + 31, SCREEN_WIDTH, SCREEN_HEIGHT - 218 - 31) style:UITableViewStyleGrouped];
        }
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = Color(0xf2f2f2);
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        NSMutableArray *ary=[NSMutableArray new];
        for(int I = 0;I < 31;I ++){
            //通过for 循环,把我所有的 图片存到数组里面
            NSString *imageName=[NSString stringWithFormat:@"合成%d",I];
            UIImage *image=[UIImage imageNamed:imageName];
            [ary addObject:image];
        }
        MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(earningLoadNewData)];
        header.lastUpdatedTimeLabel.hidden = YES;
        //        header.stateLabel.hidden = YES;
        [header setImages:ary forState:MJRefreshStateIdle];
        [header setImages:ary forState:MJRefreshStatePulling];
        [header setImages:ary forState:MJRefreshStateRefreshing];
        // Set header
        self.tableView.mj_header = header;
        _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(earningTopPushLoading)];//上拉加载
    }
    return _tableView;
}


-(UITableView *)withdrawDeatilsTableView
{
    if (!_withdrawDeatilsTableView) {
        if (Is_Iphone_X) {
            _withdrawDeatilsTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 218 + 51, SCREEN_WIDTH, SCREEN_HEIGHT - 218 - 51) style:UITableViewStyleGrouped];
        }else{
            _withdrawDeatilsTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 218 + 31, SCREEN_WIDTH, SCREEN_HEIGHT - 218 - 31) style:UITableViewStyleGrouped];
        }
        _withdrawDeatilsTableView.delegate = self;
        _withdrawDeatilsTableView.dataSource = self;
        _withdrawDeatilsTableView.backgroundColor = Color(0xf2f2f2);
        _withdrawDeatilsTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        NSMutableArray *ary=[NSMutableArray new];
        for(int I = 0;I < 31;I ++){
            //通过for 循环,把我所有的 图片存到数组里面
            NSString *imageName=[NSString stringWithFormat:@"合成%d",I];
            UIImage *image=[UIImage imageNamed:imageName];
            [ary addObject:image];
        }
        MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(withdrawLoadNewData)];
        header.lastUpdatedTimeLabel.hidden = YES;
        //        header.stateLabel.hidden = YES;
        [header setImages:ary forState:MJRefreshStateIdle];
        [header setImages:ary forState:MJRefreshStatePulling];
        [header setImages:ary forState:MJRefreshStateRefreshing];
        // Set header
        self.withdrawDeatilsTableView.mj_header = header;
        _withdrawDeatilsTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(withdrawTopPushLoading)];//上拉加载
    }
    return _withdrawDeatilsTableView;
}

#pragma mark --lazy Data && func
-(NSArray *)dataSourceArr{
    if (!_dataSourceArr) {
        _dataSourceArr = [NSArray array];
    }
    return _dataSourceArr;
}

-(NSArray *)withdrawDataSourceArr{
    if (!_withdrawDataSourceArr) {
        _withdrawDataSourceArr = [NSArray array];
    }
    return _withdrawDataSourceArr;
}

//总收益 总提现 账户余额数据呈现
-(void)getEarningsRequest{
    NSString *urlStr = [NSString stringWithFormat:@"%@uid=%@",CNY_ORDER_GET_EARNINGS,USER_ID];
    urlStr = [urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    [YGYBaseViewModel getRequestWithPath:urlStr parameters:nil responseDataModel:[CNYEarningsModel class] success:^(id responseObject) {
        CNYEarningsModel *model = responseObject;
        CNYEarningsData *data = model.data;
        if ([model.status isEqualToString:@"200"]) {
            self.SDTScoreLabel.text = [NSString stringWithFormat:@"%.2f",[data.balance doubleValue]];
            self.earningSumLabel.text = [NSString stringWithFormat:@"总收益:%.2f",[data.incomeTotal doubleValue]];
            self.getSumLabel.text = [NSString stringWithFormat:@"总提现:%.2f",[data.withdrawTotal doubleValue]];
        }else{
            MBHUD(model.msg);
        }
        
    } failure:^(NSError *error) {
    }];
}


#pragma mark ----------------- CNY收益明细列表请求
-(void)earningListRequest{
    LOADING
    [self removeNoDataImage];
    self.refreshNum = 10;
        NSString *urlStr = [NSString stringWithFormat:@"%@userId=%@&index=1&size=%ld",CNY_ORDER_GET_EARNING_LIST,USER_ID,self.refreshNum];
        urlStr = [urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        [YGYBaseViewModel getRequestWithPath:urlStr parameters:nil responseDataModel:[CNYEarningsDeatilsModel class] success:^(id responseObject) {
            STOP_LOADING
            CNYEarningsDeatilsModel *model = responseObject;
            CNYEarningsDeatilsData *data = model.data;
            if ([model.status isEqualToString:@"200"]) {
                self.dataSourceArr = data.pageData;
                if (self.dataSourceArr.count > 0) {
                    self.totalStr = data.total;
                }else{
                    self.noDataImageView = [[UIImageView alloc]init];
                    [self.noDataImageView setImage:[UIImage imageNamed:@"暂无数据"]];
                    self.noDataImageView.layer.cornerRadius = 8;
                    self.noDataImageView.clipsToBounds = YES;
                    [self.tableView addSubview:self.noDataImageView];
                    [self.noDataImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.left.offset(12);
                        make.right.equalTo(self.view).offset(-12);
                        make.top.offset(10);
                        make.bottom.offset(0);
                    }];
                }
                [self.tableView reloadData];
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
#pragma mark  -----------CNY收益明细下拉刷新
-(void)earningLoadNewData{
    [self.tableView.mj_header beginRefreshing];
        NSString *urlStr = [NSString stringWithFormat:@"%@userId=%@&index=1&size=%ld",CNY_ORDER_GET_EARNING_LIST,USER_ID,self.refreshNum];
        urlStr = [urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        [YGYBaseViewModel getRequestWithPath:urlStr parameters:nil responseDataModel:[CNYEarningsDeatilsModel class] success:^(id responseObject) {
            [self.tableView.mj_header endRefreshing];
            CNYEarningsDeatilsModel *model = responseObject;
            CNYEarningsDeatilsData *data = model.data;
            if ([model.status isEqualToString:@"200"]) {
                self.dataSourceArr = data.pageData;
                [self.tableView reloadData];
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

#pragma mark  -----------CNY收益明细上拉加载
-(void)earningTopPushLoading{
    [self.tableView.mj_footer beginRefreshing];
    if (self.refreshNum > [self.totalStr integerValue]) {
    }else{
        self.refreshNum = self.refreshNum + 10;
    }
        NSString *urlStr = [NSString stringWithFormat:@"%@userId=%@&index=1&size=%ld",CNY_ORDER_GET_EARNING_LIST,USER_ID,self.refreshNum];
        urlStr = [urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        [YGYBaseViewModel getRequestWithPath:urlStr parameters:nil responseDataModel:[CNYEarningsDeatilsModel class] success:^(id responseObject) {
            CNYEarningsDeatilsModel *model = responseObject;
            CNYEarningsDeatilsData *data = model.data;
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







#pragma mark ----------------- CNY提现明细列表请求
-(void)withdrawListRequest{
    STOP_LOADING
    LOADING
    [self removeNoDataImage];
    self.refreshNum = 10;
        NSString *urlStr = [NSString stringWithFormat:@"%@userId=%@&index=1&size=%ld",CNY_ORDER_GET_CNY_MENTIONLIST,USER_ID,self.refreshNum];
        urlStr = [urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        [YGYBaseViewModel getRequestWithPath:urlStr parameters:nil responseDataModel:[CNYWithdrawDeatilsModel class] success:^(id responseObject) {
            STOP_LOADING
            CNYWithdrawDeatilsModel *model = responseObject;
            CNYWithdrawDeatilsData *data = model.data;
            if ([model.status isEqualToString:@"200"]) {
                self.withdrawDataSourceArr = data.pageData;
                if (self.withdrawDataSourceArr.count > 0) {
                    self.totalStr = data.total;
                }else{
                    self.noDataImageView = [[UIImageView alloc]init];
                    [self.noDataImageView setImage:[UIImage imageNamed:@"暂无数据"]];
                    self.noDataImageView.layer.cornerRadius = 8;
                    self.noDataImageView.clipsToBounds = YES;
                    [self.withdrawDeatilsTableView addSubview:self.noDataImageView];
                    [self.noDataImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.left.offset(12);
                        make.right.equalTo(self.view).offset(-12);
                        make.top.offset(10);
                        make.bottom.offset(0);
                    }];
                }
                [self.withdrawDeatilsTableView reloadData];
                
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
#pragma mark  -----------CNY提现明细下拉刷新
-(void)withdrawLoadNewData{
    [self.withdrawDeatilsTableView.mj_header beginRefreshing];
        NSString *urlStr = [NSString stringWithFormat:@"%@userId=%@&index=1&size=%ld",CNY_ORDER_GET_CNY_MENTIONLIST,USER_ID,self.refreshNum];
        urlStr = [urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        [YGYBaseViewModel getRequestWithPath:urlStr parameters:nil responseDataModel:[CNYWithdrawDeatilsModel class] success:^(id responseObject) {
            [self.withdrawDeatilsTableView.mj_header endRefreshing];
            CNYWithdrawDeatilsModel *model = responseObject;
            CNYWithdrawDeatilsData *data = model.data;
            if ([model.status isEqualToString:@"200"]) {
                self.withdrawDataSourceArr = data.pageData;
                [self.withdrawDeatilsTableView reloadData];
            }else{
                MBHUD(model.msg);
            }
        } failure:^(NSError *error) {
            [self.withdrawDeatilsTableView.mj_header endRefreshing];
            if (error.code == WDNetError) {
                [iToast showMessage:NO_Network];
            }else{
                [iToast showMessage:NO_Service];
            }
        }];
}

#pragma mark  -----------CNY提现明细上拉加载
-(void)withdrawTopPushLoading{
    [self.withdrawDeatilsTableView.mj_footer beginRefreshing];
    if (self.refreshNum > [self.totalStr integerValue]) {
    }else{
        self.refreshNum = self.refreshNum + 10;
    }
        NSString *urlStr = [NSString stringWithFormat:@"%@userId=%@&index=1&size=%ld",CNY_ORDER_GET_CNY_MENTIONLIST,USER_ID,self.refreshNum];
        urlStr = [urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        [YGYBaseViewModel getRequestWithPath:urlStr parameters:nil responseDataModel:[CNYWithdrawDeatilsModel class] success:^(id responseObject) {
            CNYWithdrawDeatilsModel *model = responseObject;
            CNYWithdrawDeatilsData *data = model.data;
            if ([model.status isEqualToString:@"200"]) {
                self.withdrawDataSourceArr = data.pageData;
                if (self.withdrawDataSourceArr.count > 0) {
                    [self.withdrawDeatilsTableView reloadData];
                }
                if (self.withdrawDataSourceArr.count == [data.total integerValue]) {
                    [self.withdrawDeatilsTableView.mj_footer endRefreshingWithNoMoreData];
                }else{
                    [self.withdrawDeatilsTableView.mj_footer endRefreshing];
                }
            }else{
                MBHUD(model.msg);
            }
        } failure:^(NSError *error) {
            [self.withdrawDeatilsTableView.mj_footer endRefreshing];
            if (error.code == WDNetError) {
                [iToast showMessage:NO_Network];
            }else{
                [iToast showMessage:NO_Service];
            }
        }];
}


-(void)removeNoDataImage{
    [self.noDataImageView removeFromSuperview];
}
@end
