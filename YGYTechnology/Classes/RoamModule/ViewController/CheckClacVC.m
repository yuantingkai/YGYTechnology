//
//  CheckClacVC.m
//  YGYTechnology
//
//  Created by 袁庭楷 on 2018/10/23.
//  Copyright © 2018年 YGY. All rights reserved.
//

#import "CheckClacVC.h"
#import "ExamineClacRecordCell.h"
#import "CheckClacModel.h"
@interface CheckClacVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView * topNavView;
@property (nonatomic, strong) UIView *topBackView;
@property (nonatomic, strong) UILabel *centerLabel;
@property (nonatomic, strong) NSArray * dataSourceArr;//数据源数组
@end
static NSString * const Identifier = @"CheckClacCell";
@implementation CheckClacVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = Color(0xf2f2f2);
    [self creatNav];
    self.centerLabel.text = self.clacStr;
    [self.view addSubview:self.tableView];
    [self checkUserClacListRequest];
}

-(void)creatNav{
    //初始化渐变色
    CAGradientLayer * gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(__bridge id)[ColorFormatter hex2Color:0x6F8AF9].CGColor, (__bridge id)[ColorFormatter hex2Color:0x8033CB].CGColor];
    gradientLayer.locations = @[@0.1, @1.0];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1, 0);
    gradientLayer.frame = CGRectMake(0, 0, SCREEN_WIDTH,159);
    [self.view.layer addSublayer:gradientLayer];
    
    self.topBackView = [UIView new];
    self.topBackView.backgroundColor = [UIColor clearColor];
    self.topBackView.userInteractionEnabled = YES;
    [self.view addSubview:self.topBackView];
    [self.topBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.offset(0);
        make.height.mas_offset(159);
    }];
    
    self.topNavView = [ViewTools createNav_BarViewWithString:@"云力记录"];
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
    
    self.centerLabel = [UILabel newWithText:@"" fontSize:35 textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter];
    [self.topBackView addSubview:self.centerLabel];
    [self.centerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topNavView.mas_bottom).offset(20);
        make.centerX.equalTo(self.topNavView);
    }];
}
-(void)returnTopVC {
    [self.navigationController popViewControllerAnimated:YES];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1 + self.dataSourceArr.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (SCREEN == 1) {
            return 174;
        }else{
            return 194;
        }
    }else{
        return 48;
    }
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
    ExamineClacRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    if (cell == nil) {
        cell = [[ExamineClacRecordCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
    }
    if (indexPath.section == 0) {
        CheckClacData *data;
        [cell setIndexPath:indexPath data:data];
    }else{
        if (self.dataSourceArr.count > 0) {
            CheckClacData *data = self.dataSourceArr[indexPath.section - 1];
            [cell setIndexPath:indexPath data:data];
        }
    }
    
    
    return cell;
}


-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 159, SCREEN_WIDTH, SCREEN_HEIGHT - 159) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

#pragma mark --lazy Data && func
-(NSArray *)dataSourceArr{
    if (!_dataSourceArr) {
        _dataSourceArr = [NSArray array];
    }
    return _dataSourceArr;
}

#pragma mark --- 请求
-(void)checkUserClacListRequest{
    LOADING
    NSString * url = [NSString stringWithFormat:@"%@uid=%@",CHECK_USER_CLAC_LIST,USER_ID];
    url = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    [YGYBaseViewModel postRequestWithPath:url parameters:nil responseDataModel:[CheckClacModel class] success:^(id responseObject) {
        STOP_LOADING
        CheckClacModel *model = responseObject;
        if ([model.status isEqualToString:@"200"]) {
            self.dataSourceArr = model.data;
            [self.tableView reloadData];
        }else{
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

@end
