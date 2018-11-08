//
//  MyVC.m
//  YGYTechnology
//
//  Created by 袁庭楷 on 2018/9/25.
//  Copyright © 2018年 YGY. All rights reserved.
//

#import "MyVC.h"
#import "MyTableViewCell.h"
#import "MyBottomTableViewCell.h"
#import "securityCenterVC.h"
#import "PersonalCenterVC.h"
#import "EcoPartnerView.h"
#import "InviteExcavateVC.h"
#import "EcoPartnerVC.h"
#import "MyContractVC.h"
#import "GetClacModel.h"
#import "EcoPartnerEarningsVC.h"
#import "InterstellarSaveVC.h"

@interface MyVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView * coverView;
@property (nonatomic, strong) EcoPartnerView * ecoPartnerView;
@property (nonatomic, strong) NSString * SDTScoreStr;
@property (nonatomic, strong) NSString * clacStr;
@property (nonatomic, strong) UIImageView *noNetworkImageView;
@property (nonatomic, strong) UIImageView *imageView;

@end

static NSString * const MyIdentifier = @"MyCell";

@implementation MyVC

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [self reFreshBtn];
}
#pragma mark ----------- 进入界面调用的方法
-(void)enterPage{
    [self sendFlotageRequest];
    [self setImageBackView];
    [self.view addSubview:self.tableView];
    NSString *str = [USER_DEFAULT objectForKey:@"LOGIN_SUCCESS"];
    if ([str isEqualToString:@"loginSuccess"]) {
        [self getClacRequest];
    }else{
        self.clacStr = @"";
        self.SDTScoreStr = @"";
        [self.tableView reloadData];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = Color(0xf2f2f2);
    SLog(@"id===%@",USER_ID);
    // Do any additional setup after loading the view.
    WeakSelf(self);
    self.navigationController.interactivePopGestureRecognizer.delegate = weakSelf;
    self.navigationController.interactivePopGestureRecognizer.enabled=YES;
}

-(void)setImageBackView{
    self.imageView = [[UIImageView alloc]init];
    [self.imageView setImage:[UIImage imageNamed:@"myBackgroud"]];
    [self.view addSubview:self.imageView];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(0);
        make.left.right.offset(0);
        make.height.mas_offset(225);
    }];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 2) {
        return 2;
    }else if (section == 3){
        return 2;
    }else{
        return 1;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 180;
    }else{
        return 48;
        
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 79;
    }else{
        return 10;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.001;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString *str = [USER_DEFAULT objectForKey:@"LOGIN_SUCCESS"];
    if ([str isEqualToString:@"loginSuccess"]) {
        if (indexPath.section == 1) {
            //邀请挖矿
            InviteExcavateVC * inviteExcavateVC = [[InviteExcavateVC alloc]init];
            [inviteExcavateVC setHidesBottomBarWhenPushed:YES];
            [self.navigationController pushViewController:inviteExcavateVC animated:YES];
        }else if (indexPath.section == 2) {
            if (indexPath.row == 0) {
                //生态合伙人
//                if ([[LoginGetTool getUserInfo].partner isEqualToString:@"0"]) {
//                    [self coverCreat];
//                }else{
                    EcoPartnerVC *vc = [[EcoPartnerVC alloc]init];
                    [vc setHidesBottomBarWhenPushed:YES];
                    [self.navigationController pushViewController:vc animated:YES];
//                }
            }else{
                InterstellarSaveVC *vc = [InterstellarSaveVC new];
                [vc setHidesBottomBarWhenPushed:YES];
                [self.navigationController pushViewController:vc animated:YES];
            }
        }else if (indexPath.section == 3){
            if (indexPath.row == 0) {
                EcoPartnerEarningsVC *vc = [[EcoPartnerEarningsVC alloc]init];
                [vc setHidesBottomBarWhenPushed:YES];
                [self.navigationController pushViewController:vc animated:YES];
            }else if (indexPath.row == 1) {
                //我的合约
                MyContractVC *vc = [[MyContractVC alloc]init];
                [vc setHidesBottomBarWhenPushed:YES];
                [self.navigationController pushViewController:vc animated:YES];
            }
        }else if (indexPath.section == 4) {
            //安全中心
            securityCenterVC *securityVC = [[securityCenterVC alloc]init];
            [securityVC setHidesBottomBarWhenPushed:YES];
            [self.navigationController pushViewController:securityVC animated:YES];
            
        }
    }else{
        if (indexPath.section == 2){
            if (indexPath.row == 1) {
                InterstellarSaveVC *vc = [InterstellarSaveVC new];
                [vc setHidesBottomBarWhenPushed:YES];
                [self.navigationController pushViewController:vc animated:YES];
            }else{
                [self loginSuccess];
            }
        }else{
            [self loginSuccess];
        }
        
    }
    
    
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0) {
        MyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
        if (cell == nil) {
            cell = [[MyTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyIdentifier];
        }
        cell.backgroundColor = [UIColor clearColor];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        [cell setPicImageView:[USER_DEFAULT objectForKey:@"IMAGE_STR"] name:[USER_DEFAULT objectForKey:@"NAME_STR"] phoneNumberLabel:[LoginGetTool getUserInfo].phone SDTNumberLabel:self.SDTScoreStr cloudNumerLabel:self.clacStr];
        
        WeakSelf(self);
        [cell setClickBtn:^(UIButton *picBtn) {
            [weakSelf clickBtnn:picBtn];
        }];
        
        return cell;
        
    }else{
        MyBottomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
        if (cell == nil) {
            cell = [[MyBottomTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyIdentifier];
        }
        cell.backgroundColor = [UIColor clearColor];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        [cell setIndexPath:indexPath];
        return cell;
    }
    
    
}

#pragma mark -----------点击头像
-(void)clickBtnn:(UIButton *)clickBtn{
    NSString *str = [USER_DEFAULT objectForKey:@"LOGIN_SUCCESS"];
    if ([str isEqualToString:@"loginSuccess"]) {
        PersonalCenterVC *personalCenterVC = [[PersonalCenterVC alloc]init];
        [personalCenterVC setHidesBottomBarWhenPushed:YES];
        [self.tableView reloadData];
        [self.navigationController pushViewController:personalCenterVC animated:YES];
    }else{
        [self loginSuccess];
    }
    
}



-(UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
        //        _tableView.separatorColor = YGYColor(245, 245, 245);
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
        //        _tableView.allowsSelection = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        //        _tableView.userInteractionEnabled = NO;
    }
    return _tableView;
}

-(void)coverCreat{
    self.coverView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.coverView.backgroundColor = [UIColor blackColor];
    self.coverView.alpha = 0.5;
    [self.coverView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(coverViewTouchUpInside)]];
    [self.view addSubview:self.coverView];
    
    self.ecoPartnerView = [[EcoPartnerView alloc]init];
    self.ecoPartnerView.backgroundColor = [UIColor whiteColor];
    self.ecoPartnerView.layer.cornerRadius = 8;
    [self.view addSubview:self.ecoPartnerView];
    [self.ecoPartnerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.right.offset(-10);
        if (SCREEN == 1) {
            make.top.offset(50 + kNavBarHeight);
        }else if(SCREEN == 2){
            make.top.offset(130 + kNavBarHeight);
        }else{
            make.top.offset(180 + kNavBarHeight);
        }
        
        make.bottom.offset(-10 -TabbarHeight);
    }];
 
    WeakSelf(self);
    [self.ecoPartnerView setCancelBtn:^(UIButton *cancelBtn) {
        [weakSelf cancelBtn:cancelBtn];
    }];
}

-(void)cancelBtn:(UIButton *)sender{
    SLog(@"取消");
    [self hiddenCoverView];
}

-(void)hiddenCoverView{
    [self.ecoPartnerView removeFromSuperview];
    [self.coverView removeFromSuperview];
    self.ecoPartnerView.hidden = YES;
    self.coverView.hidden = YES;
}
- (void)coverViewTouchUpInside {
    [UIView animateWithDuration:0.25 animations:^{
        [self hiddenCoverView];
    }completion:^(BOOL finished) {
        self.ecoPartnerView.hidden = YES;
        self.coverView.hidden = YES;
    }];
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
            self.SDTScoreStr = data.sdt;
            
            [self.tableView reloadData];
        }else{
            //            MBHUD(model.msg);
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
                MBHUD(model.msg);
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
    
    if (self.tableView) {
        [self.tableView removeFromSuperview];
    }
    
    if (self.imageView) {
        [self.imageView removeFromSuperview];
    }
    if ([[self internetStatus] isEqualToString:@"WIFI"] || [[self internetStatus] isEqualToString:@"蜂窝数据"]) {
        [self enterPage];
    }else{
        [self noNetworkBackImageView];
    }
}

@end
