//
//  EcoPartnerVC.m
//  YGYTechnology
//
//  Created by 袁庭楷 on 2018/10/4.
//  Copyright © 2018年 YGY. All rights reserved.
//

#import "EcoPartnerVC.h"
#import "EcoPartnerCell.h"
#import "WithdrawDepositView.h"
#import "EcoPartnerModel.h"
#import "EcoPartnerEarningsVC.h"
#import "CNYEarningsVC.h"
#import "PayTypeView.h"
#import "WXWithdrawDepositView.h"

@interface EcoPartnerVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UIView * topNavView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *topBackView;
@property (nonatomic, strong) UIView * coverPayView;//支付方式选择 蒙层创建
@property (nonatomic, strong) PayTypeView * payTypeView;//支付方式 视图创建

@property (nonatomic, strong) UIView * coverView;//支付宝蒙层创建
@property (nonatomic, strong) WithdrawDepositView * withdrawDepositView;//支付宝视图创建
@property (nonatomic, strong) NSString * CNYWithdrawAccount;//支付账号
@property (nonatomic, strong) NSString * CNYWithdrawNum;//支付数量

@property (nonatomic, strong) UIView * coverWXPayView;//微信 蒙层创建
@property (nonatomic, strong) WXWithdrawDepositView * WXPayView;//微信 视图创建
@property (nonatomic, strong) NSString * WXWithdrawAccount;//支付账号
@property (nonatomic, strong) NSString * WXWithdrawNum;//支付数量

@property (nonatomic, strong) UILabel *SDTScoreLabel;
@property (nonatomic, strong) UILabel *deleteAreaNameLabel;
@property (nonatomic, strong) UILabel *partNumLabel;


@end
static NSString * const Identifier = @"ecoPartnerCell";
@implementation EcoPartnerVC

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    //    self.navigationController.navigationBar.hidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = Color(0xf2f2f2);
    [self setUI];
    [self.view addSubview:self.tableView];
    [self checkDetailRequest];
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
    
    self.topNavView = [ViewTools createNav_BarViewWithString:@"生态合伙人"];
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
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rightBtn setTitle:@"收益明细" forState:UIControlStateNormal];
    rightBtn.titleLabel.font = Font(12);
    [rightBtn sizeToFit];
    rightBtn.expandHitEdgeInsets = UIEdgeInsetsMake(15, 15, 15, 15);
    [rightBtn addTarget:self action:@selector(getMoneyDetailBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.topNavView addSubview:rightBtn];
    [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-12);
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
    
    UIButton *getSDTBtn = [UIButton newWithTitle:@"提现" font:12 textColor:Color(0x8682fa) textAlignment:NSTextAlignmentCenter Image:nil];
    [getSDTBtn addTarget:self action:@selector(getSDTBtn:) forControlEvents:UIControlEventTouchUpInside];
    [getSDTBtn setBackgroundColor:[UIColor whiteColor]];
    getSDTBtn.layer.cornerRadius = 4;
    [self.topBackView addSubview:getSDTBtn];
    [getSDTBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.SDTScoreLabel.mas_right).offset(20);
        make.centerY.equalTo(self.SDTScoreLabel);
        make.height.mas_offset(30);
        make.width.mas_offset(56);
    }];
    
    
    
    UIView *centerView = [UIView new];
    centerView.backgroundColor = [UIColor whiteColor];
    centerView.layer.cornerRadius = 8;
    [self.view addSubview:centerView];
    [centerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(31);
        make.right.offset(-31);
        make.height.mas_offset(62);
        make.top.equalTo(self.SDTScoreLabel.mas_bottom).offset(26);
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
    
    UIView *centerLeftView = [UIView new];
    [centerView addSubview:centerLeftView];
    [centerLeftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.offset(0);
        make.right.equalTo(lineView.mas_left).offset(0);
    }];
    
    UILabel *deleteAreaLabel = [UILabel newWithText:@"代理区域" fontSize:14 textColor:Color(0x666666) textAlignment:NSTextAlignmentCenter];
    [centerLeftView addSubview:deleteAreaLabel];
    [deleteAreaLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(centerLeftView);
        make.top.offset(12);
    }];
    
    self.deleteAreaNameLabel = [UILabel newWithText:@"深圳" fontSize:14 textColor:Color(0x8286fa) textAlignment:NSTextAlignmentCenter];
    [centerLeftView addSubview:self.deleteAreaNameLabel];
    [self.deleteAreaNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(centerLeftView);
        make.top.equalTo(deleteAreaLabel.mas_bottom).offset(6);
    }];
    
    UIView *centerRightView = [UIView new];
    [centerView addSubview:centerRightView];
    [centerRightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.offset(0);
        make.left.equalTo(lineView.mas_right).offset(0);
    }];
    
    UILabel *partLabel = [UILabel newWithText:@"生态节点" fontSize:14 textColor:Color(0x666666) textAlignment:NSTextAlignmentCenter];
    [centerRightView addSubview:partLabel];
    [partLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(centerRightView);
        make.top.offset(12);
    }];
    
    self.partNumLabel = [UILabel newWithText:@"0" fontSize:14 textColor:Color(0x8286fa) textAlignment:NSTextAlignmentCenter];
    [centerRightView addSubview:self.partNumLabel];
    [self.partNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(centerRightView);
        make.top.equalTo(partLabel.mas_bottom).offset(6);
    }];
}








#pragma mark ----------------生态合伙人提现
-(void)getSDTBtn:(UIButton *)sender{
    SLog(@"提现");
    [self selectAliPayOrWXPayViewCreat];
}


-(void)returnTopVC {
    [self.navigationController popViewControllerAnimated:YES];
}
//查看收益明细
-(void)getMoneyDetailBtn{
    CNYEarningsVC *vc = [[CNYEarningsVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark ----------------TABLEVIEW 代理方法创建
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 7;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 48;
    }else{
        return 60;
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    EcoPartnerCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    if (cell == nil) {
        cell = [[EcoPartnerCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
    }
    [cell setIndexPath:indexPath];
    return cell;
}


-(UITableView *)tableView
{
    
    if (!_tableView) {
        if (Is_Iphone_X) {
            _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 218 + 50, SCREEN_WIDTH, SCREEN_HEIGHT - 218 - 31) style:UITableViewStyleGrouped];
        }else{
            _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 218 + 31, SCREEN_WIDTH, SCREEN_HEIGHT - 218 - 31) style:UITableViewStyleGrouped];
        }
        
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = Color(0xf2f2f2);
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
    }
    return _tableView;
}

#pragma mark ------------- 微信 支付宝 支付方式 选择视图 创建 START-----------
-(void)selectAliPayOrWXPayViewCreat{
    self.coverPayView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.coverPayView.backgroundColor = Color(0x333333);
    self.coverPayView.alpha = 0.5;
    [self.coverPayView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(paycoverViewTouchUpInside)]];
    //    [self.view addSubview:self.coverView];
    UIWindow * window = [UIApplication sharedApplication].windows[0];
    [window addSubview:self.coverPayView];
    
    
    self.payTypeView = [PayTypeView new];
    self.payTypeView.layer.cornerRadius = 8;
    self.payTypeView.backgroundColor = [UIColor whiteColor];
    [window addSubview:self.payTypeView];
    [self.payTypeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.offset(-100);
        make.left.offset(12);
        make.right.offset(-12);
        make.height.mas_offset(168);
    }];
    
    WeakSelf(self);
    [self.payTypeView setCancelBtn:^(UIButton * _Nonnull cancelBtn) {
        [weakSelf payCancelBtn:cancelBtn];
    }];
    [self.payTypeView setZfbBtn:^(UIButton * _Nonnull zfbBtn) {
        [weakSelf zfbPay:zfbBtn];
    }];
    [self.payTypeView setWxBtn:^(UIButton * _Nonnull wxBtn) {
        [weakSelf wxPay:wxBtn];
    }];
}

-(void)payCancelBtn:(UIButton *)sender{
    [self payhiddenCoverView];
}
-(void)zfbPay:(UIButton *)sender{
    //    [iToast showMessage:@"暂未开通支付宝支付"];
    //    [self payRequest:@"2"];
    [self payhiddenCoverView];
    [self aliPayViewCreat];
}

-(void)wxPay:(UIButton *)sender{
//    [iToast showMessage:@"暂未开通微信支付"];
    //    [self payRequest:@"1"];
    [self payhiddenCoverView];
    [self WXPayViewCreat];
    
}

-(void)payhiddenCoverView{
    [self.payTypeView removeFromSuperview];
    [self.coverPayView removeFromSuperview];
    self.payTypeView.hidden = YES;
    self.coverPayView.hidden = YES;
}

- (void)paycoverViewTouchUpInside {
    [UIView animateWithDuration:0.25 animations:^{
        [self hiddenCoverView];
    }completion:^(BOOL finished) {
        self.payTypeView.hidden = YES;
        self.coverPayView.hidden = YES;
    }];
}
#pragma mark ------------- 微信 支付宝 支付方式 选择视图 创建 END-----------

#pragma mark ----------------------支付宝  支付视图创建   ------------START
-(void)aliPayViewCreat{
    self.coverView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.coverView.backgroundColor = [UIColor blackColor];
    self.coverView.alpha = 0.5;
    [self.coverView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(coverViewTouchUpInside)]];
    [self.view addSubview:self.coverView];
    
    self.withdrawDepositView = [[WithdrawDepositView alloc]init];
    [self.view addSubview:self.withdrawDepositView];
    [self.withdrawDepositView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.right.offset(0);
        make.height.mas_offset(300);
        make.bottom.offset(-100);
    }];
    
    WeakSelf(self);
    [self.withdrawDepositView setCancelBtn:^(UIButton *cancelBtn) {
        [weakSelf cancelBtn:cancelBtn];
    }];
    
    [self.withdrawDepositView setOKBtn:^(UIButton *OKBtn) {
        [weakSelf okBtn:OKBtn];
    }];
    
    [self.withdrawDepositView setAccountAndNum:^(NSString *accountText, NSString *numText) {
        [weakSelf accountText:accountText withNumText:numText];
    }];
}
-(void)accountText:(NSString *)accountStr withNumText:(NSString *)numText{
    self.CNYWithdrawAccount = accountStr;
    self.CNYWithdrawNum = numText;
}
-(void)cancelBtn:(UIButton *)cancelBtn{
    SLog(@"取消");
    [self hiddenCoverView];
}

-(void)okBtn:(UIButton *)okBtn{
    SLog(@"ok");
    //    [iToast showMessage:@"暂未开通此功能"];
    [self getMoneyRequest:@"2"];
}

-(void)hiddenCoverView{
    [self.withdrawDepositView removeFromSuperview];
    [self.coverView removeFromSuperview];
    self.withdrawDepositView.hidden = YES;
    self.coverView.hidden = YES;
}
- (void)coverViewTouchUpInside {
    [UIView animateWithDuration:0.25 animations:^{
        [self hiddenCoverView];
    }completion:^(BOOL finished) {
        self.withdrawDepositView.hidden = YES;
        self.coverView.hidden = YES;
    }];
}
#pragma mark ----------------------支付宝  支付视图创建   ------------END


#pragma mark ----------------------微信  支付视图创建   ------------START
-(void)WXPayViewCreat{
    self.coverWXPayView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.coverWXPayView.backgroundColor = [UIColor blackColor];
    self.coverWXPayView.alpha = 0.5;
    [self.coverWXPayView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(WXCoverViewTouchUpInside)]];
    [self.view addSubview:self.coverWXPayView];
    
    self.WXPayView = [[WXWithdrawDepositView alloc]init];
    [self.view addSubview:self.WXPayView];
    [self.WXPayView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.right.offset(0);
        make.height.mas_offset(300);
        make.bottom.offset(-100);
    }];
    
    WeakSelf(self);
    [self.WXPayView setCancelBtn:^(UIButton *cancelBtn) {
        [weakSelf WXCancelBtn:cancelBtn];
    }];
    
    [self.WXPayView setOKBtn:^(UIButton *OKBtn) {
        [weakSelf WXOkBtn:OKBtn];
    }];
    
    [self.WXPayView setAccountAndNum:^(NSString *accountText, NSString *numText) {
        [weakSelf WXaccountText:accountText withNumText:numText];
    }];
}
-(void)WXaccountText:(NSString *)accountStr withNumText:(NSString *)numText{
    self.WXWithdrawAccount = accountStr;
    self.WXWithdrawNum = numText;
}
-(void)WXCancelBtn:(UIButton *)cancelBtn{
    SLog(@"取消");
    [self WXHiddenCoverView];
}

-(void)WXOkBtn:(UIButton *)okBtn{
    SLog(@"ok");
    //    [iToast showMessage:@"暂未开通此功能"];
    [self getMoneyRequest:@"1"];
}

-(void)WXHiddenCoverView{
    [self.WXPayView removeFromSuperview];
    [self.coverWXPayView removeFromSuperview];
    self.WXPayView.hidden = YES;
    self.coverWXPayView.hidden = YES;
}
- (void)WXCoverViewTouchUpInside {
    [UIView animateWithDuration:0.25 animations:^{
        [self WXHiddenCoverView];
    }completion:^(BOOL finished) {
        self.WXPayView.hidden = YES;
        self.coverWXPayView.hidden = YES;
    }];
}
#pragma mark ----------------------微信  支付视图创建   ------------END


#pragma mark ----------- 查看生态合伙人信息请求
-(void)checkDetailRequest{
    NSString *urlStr = [NSString stringWithFormat:@"%@uid=%@",ECO_PARTNER_URL,USER_ID];
    urlStr = [urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    [YGYBaseViewModel getRequestWithPath:urlStr parameters:nil responseDataModel:[EcoPartnerModel class] success:^(id responseObject) {
        EcoPartnerModel *model = responseObject;
        if ([model.status isEqualToString:@"200"]) {
            EcoPartnerData *data = model.data;
            self.SDTScoreLabel.text = [NSString stringWithFormat:@"%.2f",[data.cnyNumber floatValue]];
            self.deleteAreaNameLabel.text = data.proxyAddress;
            self.partNumLabel.text = data.nodeNumber;
            [self.tableView reloadData];
        }else{
            MBHUD(model.msg);
        }
        
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark ----------- 生态合伙人提现接口请求
-(void)getMoneyRequest:(NSString *)accountPayType{//accountType=1 微信 =2支付宝
    NSString *urlStr;
    if ([accountPayType isEqualToString:@"1"]) {//微信
        urlStr = [NSString stringWithFormat:@"%@userId=%@&account=%@&accountType=%@&cnyNumber=%@",CNY_ORDER_GENERATE,USER_ID,self.WXWithdrawAccount,accountPayType,self.WXWithdrawNum];
    }else{
        urlStr = [NSString stringWithFormat:@"%@userId=%@&account=%@&accountType=%@&cnyNumber=%@",CNY_ORDER_GENERATE,USER_ID,self.CNYWithdrawAccount,accountPayType,self.CNYWithdrawNum];
    }
   
    urlStr = [urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    [YGYBaseViewModel postRequestWithPath:urlStr parameters:nil responseDataModel:[YGYBaseDataModel class] success:^(id responseObject) {
        YGYBaseDataModel *model = responseObject;
        if ([model.status isEqualToString:@"200"]) {
            MBHUD(@"提现成功");
            [self hiddenCoverView];
            [self WXHiddenCoverView];
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
@end
