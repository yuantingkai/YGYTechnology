//
//  TreasureVC.m
//  YGYTechnology
//
//  Created by 袁庭楷 on 2018/9/25.
//  Copyright © 2018年 YGY. All rights reserved.
//

#import "TreasureVC.h"
#import "TreasureTableViewCell.h"
#import "BuyCommodityView.h"
#import "ContractDetailsVC.h"
#import "TreasureGetAllModel.h"
#import "CheckProductVC.h"
#import "PropertyListCell.h"
#import "BTCGetMoneyView.h"
#import "InviteExcavateVC.h"
#import "PayTypeView.h"
#import "GetAssetInfoModel.h"

#define kTopImageViewHeight 44

@interface TreasureVC ()<UITableViewDelegate,UITableViewDataSource>
{
    BOOL isCheck;
}
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UITableView *secondTableView;
@property (nonatomic, strong) UIView * topView;
@property (nonatomic, strong) BuyCommodityView *commodityView;
@property (nonatomic, strong) UIView * coverView;
@property (nonatomic, strong) NSArray * dataSourceArr;//数据源数组
@property (nonatomic, strong) TreasureGetAllData * treasureGetAllData;
@property (nonatomic, strong) NSString * productNum;//商品总数
@property (nonatomic, strong) NSString * productId;//商品ID
@property (nonatomic, strong) UIButton *leftBtn;//合约按钮
@property (nonatomic, strong) UIButton *rightBtn;//资产按钮
@property (nonatomic, strong) UIView * coverViewBtc;
@property (nonatomic, strong) BTCGetMoneyView * btcGetMoneyView;
@property (nonatomic, strong) UIView * coverPayView;
@property (nonatomic, strong) PayTypeView * payTypeView;
@property (nonatomic, strong) GetAssetInfoData * getAssetInfoData;//资产界面数据传递
@property (nonatomic, strong) UIImageView *noNetworkImageView;
@property (nonatomic, strong) UIImageView *topImageView;
@end

static NSString * const Identifier = @"treasureCell";

@implementation TreasureVC

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [self.navigationController setHidesBottomBarWhenPushed:YES];
    [self reFreshBtn];
}

#pragma mark ----------- 进入界面调用的方法
-(void)enterPage{
    [self sendFlotageRequest];
    isCheck = YES;
    [self customNavView];
    [self.leftBtn setBackgroundColor:Color(0x5467ED)];
    [self.rightBtn setBackgroundColor:[UIColor clearColor]];
    [self.secondTableView removeFromSuperview];
    [self allGetRequest];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = YGYColor(245, 245, 245);
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if ([tableView isEqual:self.tableView]) {
        return self.dataSourceArr.count;
    }else if([tableView isEqual:self.secondTableView]){
        return 4;
    }
    return 0;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isEqual:self.tableView]) {
        return 180;
    }else if ([tableView isEqual:self.secondTableView]){
        return 86;
    }
    return 0;
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
    if ([tableView isEqual:self.tableView]) {
        TreasureTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
        if (cell == nil) {
            cell = [[TreasureTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
        }
        
        self.treasureGetAllData = self.dataSourceArr[indexPath.section];
        [cell setIndexPath:indexPath getAlldata:self.treasureGetAllData];
        
        WeakSelf(self);
        [cell setContractInfoBtn:^(UIButton *contractInfoBtn) {
            [weakSelf contractBtn:contractInfoBtn];
        }];
        
        [cell setBuyBtn:^(UIButton *buyBtn) {
            [weakSelf buyBtn:buyBtn];
        }];
        return cell;
    }else if ([tableView isEqual:self.secondTableView]){
        PropertyListCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
        if (cell == nil) {
            cell = [[PropertyListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
        }
        [cell setIndexPath:indexPath withModel:self.getAssetInfoData];
        WeakSelf(self);
        [cell setGetBtnBtn:^(UIButton *getBtnBtn) {
            [weakSelf getMoneyBtn:getBtnBtn];
        }];
        return cell;
    }
    return nil;
}





#pragma mark ----------- 商品合约详情
-(void)contractBtn:(UIButton *)sender{
    SLog(@"合约详情");
    self.treasureGetAllData = self.dataSourceArr[sender.tag];
    ContractDetailsVC *detailsVC = [[ContractDetailsVC alloc]init];
    detailsVC.treasureGetAllData = self.treasureGetAllData;
    detailsVC.isMyStr = @"NO";
    [detailsVC setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:detailsVC animated:YES];
}
//键盘弹出
-(void)keyboardWillShow{
    SLog(@"出来");
    [self.commodityView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.offset(-220);
        make.left.offset(12);
        make.right.offset(-12);
        make.height.mas_offset(350);
    }];
}
//键盘隐藏
-(void)keyboardWillHide{
    SLog(@"消失");
    [self.commodityView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.offset(-35);
        make.left.offset(12);
        make.right.offset(-12);
        make.height.mas_offset(350);
    }];
}
/******************************************** 合约购买 start ********************************************/
#pragma mark --------------- 合约购买按钮
-(void)buyBtn:(UIButton *)sender{
    NSString *str = [USER_DEFAULT objectForKey:@"LOGIN_SUCCESS"];
    if ([str isEqualToString:@"loginSuccess"]){
        //键盘弹起监听
        [[NSNotificationCenter defaultCenter] addObserver:self  selector:@selector(keyboardWillShow)   name:UIKeyboardWillShowNotification object:nil];
        //键盘收起监听
        [[NSNotificationCenter defaultCenter] addObserver:self  selector:@selector(keyboardWillHide)   name:UIKeyboardWillHideNotification object:nil];
        
        self.coverView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        self.coverView.backgroundColor = Color(0x333333);
        self.coverView.alpha = 0.5;
        [self.coverView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(coverViewTouchUpInside)]];
        UIWindow * window = [UIApplication sharedApplication].windows[0];
        [window addSubview:self.coverView];
        
        self.commodityView = [BuyCommodityView new];
        self.commodityView.layer.cornerRadius = 8;
        self.commodityView.backgroundColor = [UIColor whiteColor];
        self.treasureGetAllData = self.dataSourceArr[sender.tag];
        [self.commodityView setTreasureData:self.treasureGetAllData];
        [window addSubview:self.commodityView];
        [self.commodityView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.offset(-35);
            make.left.offset(12);
            make.right.offset(-12);
            make.height.mas_offset(350);
        }];
        
        WeakSelf(self);
        //取消按钮
        [self.commodityView setCancelBtn:^(UIButton *cancelBtn) {
            [weakSelf cancelBtn:cancelBtn];
        }];
        //支付按钮
        [self.commodityView setPayBtn:^(UIButton *payBtn) {
            [weakSelf payBtnBtn:payBtn];
        }];
        
        //勾选按钮
        [self.commodityView setCheckBtn:^(UIButton *checkBtn) {
            [weakSelf checkBtn:checkBtn];
        }];
        
        //阅读合约
        [self.commodityView setContractBtn:^(UIButton *contractBtn) {
            [weakSelf contractReadBtn:contractBtn];
        }];
        
        //回调购买商品总数
        [self.commodityView setSumNumStr:^(NSString *sumNumStr) {
            [weakSelf sumNumStr:sumNumStr];
        }];
        
        //回调id
        [self.commodityView setIdStr:^(NSString *IdStr) {
            [weakSelf IdStr:IdStr];
        }];
    }else{
        [self loginSuccess];
    }
    
}
#pragma mark ----------- 回调商品ID
-(void)IdStr:(NSString *)IdStr{
    self.productId = IdStr;
}
#pragma mark ----------- 回调商品数量
-(void)sumNumStr:(NSString *)sumNumStr{
    self.productNum = sumNumStr;
}
#pragma mark ----------- 购买取消按钮
-(void)cancelBtn:(UIButton *)sender{
    [self hiddenCoverView];
}
#pragma mark ----------- 阅读产品合约的勾选状态切换
-(void)checkBtn:(UIButton *)sender{
    if (isCheck) {
        isCheck = NO;
        [self.commodityView.checkProBtn setImage:[UIImage imageNamed:@"checkIconBack"] forState:UIControlStateNormal];
    }else{
        isCheck = YES;
        [self.commodityView.checkProBtn setImage:[UIImage imageNamed:@"checkIcon"] forState:UIControlStateNormal];
    }
    
    SLog(@"勾选");
}
#pragma mark ----------- 阅读产品合约内容
-(void)contractReadBtn:(UIButton *)sender{
    [self hiddenCoverView];
    CheckProductVC *VC = [[CheckProductVC alloc]init];
    [VC setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:VC animated:YES];
}
#pragma mark ----------- 购买视图蒙层隐藏
-(void)hiddenCoverView{
    isCheck = YES;
    [self.commodityView removeFromSuperview];
    [self.coverView removeFromSuperview];
    self.commodityView.hidden = YES;
    self.coverView.hidden = YES;
}
#pragma mark ----------- 购买视图点击蒙层动画
- (void)coverViewTouchUpInside {
    [UIView animateWithDuration:0.25 animations:^{
        [self hiddenCoverView];
    }completion:^(BOOL finished) {
        self.commodityView.hidden = YES;
        self.coverView.hidden = YES;
    }];
}


#pragma mark ------------- 购买  支付方式 视图
-(void)payBtnBtn:(UIButton *)sender{
    if (isCheck) {//是否阅读合约 阅读了才能支付
        [self hiddenCoverView];
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
            make.bottom.offset(-70);
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
    }else{
        [iToast showMessage:@"请勾选阅读"];
    }
    
}
-(void)payCancelBtn:(UIButton *)sender{
    [self payhiddenCoverView];
}
-(void)zfbPay:(UIButton *)sender{
    [iToast showMessage:@"暂未开通支付宝支付"];
    [self payhiddenCoverView];
    //    [self payRequest:@"2"];
}

-(void)wxPay:(UIButton *)sender{
    [iToast showMessage:@"暂未开通微信支付"];
    //    [self payRequest:@"1"];
    [self payhiddenCoverView];
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


/******************************************** 合约购买 end ********************************************/

#pragma mark ------- 所有商品的request
-(void)allGetRequest{
    STOP_LOADING
    LOADING
    NSString *urlStr = [NSString stringWithFormat:@"%@",TREASURE_GETALL_URL];
    urlStr = [urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    [YGYBaseViewModel postRequestWithPath:urlStr parameters:nil responseDataModel:[TreasureGetAllModel class] success:^(id responseObject) {
        STOP_LOADING
        TreasureGetAllModel *model = responseObject;
        if ([model.status isEqualToString:@"200"]) {
            self.dataSourceArr = model.data;
            if (self.dataSourceArr.count > 0) {
                [self.view addSubview:self.tableView];
            }
            [self.tableView reloadData];
            SLog(@"ok");
        }else{
            [iToast showMessage:model.msg];
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

#pragma mark -------- 支付请求
//1代表微信 2代表支付宝
-(void)payRequest:(NSString *)payType{
    NSString *urlStr = [NSString stringWithFormat:@"%@&num=%@&productId=%@&uid=%@&payType=%@",TREASURE_PAY_URL,self.productNum,self.productId,USER_ID,payType];
    urlStr = [urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    [YGYBaseViewModel postRequestWithPath:urlStr parameters:nil responseDataModel:[YGYBaseDataModel class] success:^(id responseObject) {
        YGYBaseDataModel *model = responseObject;
        if ([model.status isEqualToString:@"200"]) {
            SLog(@"ok");
        }else{
            [iToast showMessage:model.msg];
        }
        
    } failure:^(NSError *error) {
        
    }];
}



#pragma mark --------------懒加载
-(NSArray *)dataSourceArr{
    if (!_dataSourceArr) {
        _dataSourceArr = [NSArray array];
    }
    return _dataSourceArr;
}
#pragma mark ------ 合约tableview
-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kNavHeight + kTopImageViewHeight, SCREEN_WIDTH, SCREEN_HEIGHT - kNavHeight - kTopImageViewHeight) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
        //        _tableView.separatorColor = YGYColor(245, 245, 245);
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.allowsSelection = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        //        _tableView.userInteractionEnabled = NO;
    }
    return _tableView;
}
#pragma mark ------- 资产tableview
-(UITableView *)secondTableView
{
    if (!_secondTableView) {
        _secondTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kNavHeight + kTopImageViewHeight, SCREEN_WIDTH, SCREEN_HEIGHT - kNavHeight - kTopImageViewHeight) style:UITableViewStyleGrouped];
        _secondTableView.delegate = self;
        _secondTableView.dataSource = self;
        _secondTableView.backgroundColor = [UIColor clearColor];
        //        _secondTableView.separatorColor = YGYColor(245, 245, 245);
        _secondTableView.showsVerticalScrollIndicator = NO;
        _secondTableView.showsHorizontalScrollIndicator = NO;
        _secondTableView.allowsSelection = NO;
        _secondTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        //        _secondTableView.userInteractionEnabled = NO;
    }
    return _secondTableView;
}




#pragma mark ----------- 自定义导航栏视图
-(void)customNavView{
    self.topView = [[UIView alloc]init];
    self.topView.frame=CGRectMake(0, 0, SCREEN_WIDTH, kStatusBarHeight+44);
    
    //初始化渐变色
    CAGradientLayer * gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(__bridge id)[ColorFormatter hex2Color:0x6F8AF9].CGColor, (__bridge id)[ColorFormatter hex2Color:0x8033CB].CGColor];
    gradientLayer.locations = @[@0.1, @1.0];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1, 0);
    gradientLayer.frame = CGRectMake(0, 0, SCREEN_WIDTH,kStatusBarHeight+44);
    [self.topView.layer addSublayer:gradientLayer];
    self.topView.userInteractionEnabled=YES;
    [self.view addSubview:self.topView];
    
    UIButton *returnTopBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [returnTopBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [returnTopBtn sizeToFit];
    returnTopBtn.expandHitEdgeInsets = UIEdgeInsetsMake(15, 15, 15, 15);
    [self.topView addSubview:returnTopBtn];
    [returnTopBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(12);
        make.bottom.mas_offset(kNavControlImgBottom);
    }];
    
    CGFloat centerWidth = SCREEN_WIDTH / 2;
    self.leftBtn = [UIButton newWithTitle:@"合约" font:16 textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter Image:nil];
    [self.leftBtn addTarget:self action:@selector(leftBtn:) forControlEvents:UIControlEventTouchUpInside];
    self.leftBtn.layer.cornerRadius = 12;
    [self.leftBtn setBackgroundColor:Color(0x5467ED)];
    [self.topView addSubview:self.leftBtn];
    [self.leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(returnTopBtn);
        make.right.equalTo(self.topView).offset(-centerWidth - 10);
        make.width.mas_offset(60);
        make.height.mas_offset(24);
    }];
    
    self.rightBtn = [UIButton newWithTitle:@"资产" font:16 textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter Image:nil];
    self.rightBtn.layer.cornerRadius = 12;
    [self.rightBtn addTarget:self action:@selector(rightBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.topView addSubview:self.rightBtn];
    [self.rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(returnTopBtn);
        make.left.equalTo(self.topView).offset(centerWidth + 10);
        make.width.mas_offset(60);
        make.height.mas_offset(24);
    }];
    
    self.topImageView = [[UIImageView alloc]init];
    [self.topImageView setImage:[UIImage imageNamed:@"banner"]];
    self.topImageView.userInteractionEnabled = YES;
    [self.view addSubview:self.topImageView];
    [self.topImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.equalTo(self.topView.mas_bottom).offset(0);
        make.height.mas_offset(kTopImageViewHeight);
    }];
    
    UIButton *bannerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [bannerBtn addTarget:self action:@selector(clickBanner) forControlEvents:UIControlEventTouchUpInside];
    [self.topImageView addSubview:bannerBtn];
    [bannerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.offset(0);
    }];
}


#pragma mark ----------- 点击banner 跳转邀请界面
-(void)clickBanner{
    NSString *str = [USER_DEFAULT objectForKey:@"LOGIN_SUCCESS"];
    if ([str isEqualToString:@"loginSuccess"]){
        InviteExcavateVC * inviteExcavateVC = [[InviteExcavateVC alloc]init];
        [inviteExcavateVC setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:inviteExcavateVC animated:YES];
    }else{
        [self loginSuccess];
    }
}
#pragma mark ----------- 点击头部合约按钮
-(void)leftBtn:(UIButton *)sender{
    [self.leftBtn setBackgroundColor:Color(0x5467ED)];
    [self.rightBtn setBackgroundColor:[UIColor clearColor]];
    [self.secondTableView removeFromSuperview];
    [self.view addSubview:self.tableView];
    [self allGetRequest];
}
#pragma mark ----------- 点击头部资产按钮
-(void)rightBtn:(UIButton *)sender{
    NSString *str = [USER_DEFAULT objectForKey:@"LOGIN_SUCCESS"];
    if ([str isEqualToString:@"loginSuccess"]){
        [[NSNotificationCenter defaultCenter] removeObserver:self];
        [sender setBackgroundColor:Color(0x5467ED)];
        [self.leftBtn setBackgroundColor:[UIColor clearColor]];
        [self.tableView removeFromSuperview];
        [self.view addSubview:self.secondTableView];
        [self getAssetInfoRequest];
    }else{
        [self loginSuccess];
    }
}

/******************************************** 提币视图 start ********************************************/
#pragma mark -----------  资产提币按钮
-(void)getMoneyBtn:(UIButton *)sender{
    SLog(@"%ld",sender.tag);
    if (sender.tag == 0) {
        NSString *str = [USER_DEFAULT objectForKey:@"AS_SETS_PWD_EXIST"];
        if ([str isEqualToString:@"0"]) {//0代表未填写资产
            [iToast showMessage:@"请先设置资产密码"];
        }else{
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
            
            UIAlertAction* getMoneyAction = [UIAlertAction actionWithTitle:@"提币" style:UIAlertActionStyleDefault  handler:^(UIAlertAction * action) {
                [self clickGetMoney];
            }];
            
            UIAlertAction* cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel  handler:^(UIAlertAction * action) {}];
            
            [getMoneyAction setValue:MAIN_BODY forKey:@"titleTextColor"];
            [cancleAction setValue:MAIN_BODY forKey:@"titleTextColor"];
            
            [alertController addAction:getMoneyAction];
            [alertController addAction:cancleAction];
            
            [[[[UIApplication sharedApplication] keyWindow] rootViewController] presentViewController:alertController animated:YES completion:nil];
        }
    }
    
    
}
#pragma mark -----------  提币支付账号 数量
-(void)clickGetMoney{
    SLog(@"提现");
    self.coverViewBtc = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.coverViewBtc.backgroundColor = [UIColor blackColor];
    self.coverViewBtc.alpha = 0.5;
    [self.coverViewBtc addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(coverViewBTCTouchUpInside)]];
    [self.view addSubview:self.coverViewBtc];
    
    self.btcGetMoneyView = [[BTCGetMoneyView alloc]init];
    [self.view addSubview:self.btcGetMoneyView];
    [self.btcGetMoneyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.right.offset(0);
        make.height.mas_offset(300);
        make.bottom.offset(-100);
    }];
    
    WeakSelf(self);
    [self.btcGetMoneyView setCancelBtn:^(UIButton *cancelBtn) {
        [weakSelf cancelBTCBtn:cancelBtn];
    }];
    [self.btcGetMoneyView setReturnTextField:^(NSString * _Nonnull accountTextField, NSString * _Nonnull numTextField, NSString * _Nonnull pwdTextField) {
        [weakSelf getWithAccount:accountTextField numStr:numTextField pwdStr:pwdTextField];
    }];
}
#pragma mark -----------  提币支付账号 数量 取消按钮
-(void)cancelBTCBtn:(UIButton *)cancelBtn{
    [self hiddenCoverBtcView];
}
#pragma mark ----------- 提币支付账号 数量的 界面数据返回
-(void)getWithAccount:(NSString *)account numStr:(NSString *)numStr pwdStr:(NSString *)pwdStr{
    SLog(@"地址：%@    数量：%@      密码：%@",account,numStr,pwdStr);
    //    [iToast showMessage:@"暂未开通提币功能"];
    [self assetRequestAccount:account numStr:numStr pwdStr:pwdStr];
}

-(void)hiddenCoverBtcView{
    [self.btcGetMoneyView removeFromSuperview];
    [self.coverViewBtc removeFromSuperview];
    self.btcGetMoneyView.hidden = YES;
    self.coverViewBtc.hidden = YES;
}
- (void)coverViewBTCTouchUpInside {
    [UIView animateWithDuration:0.25 animations:^{
        [self hiddenCoverBtcView];
    }completion:^(BOOL finished) {
        self.btcGetMoneyView.hidden = YES;
        self.coverViewBtc.hidden = YES;
    }];
}
/******************************************** 提币视图 end ********************************************/


#pragma mark -------------资产信息接口
-(void)getAssetInfoRequest{
    NSString *urlStr = [NSString stringWithFormat:@"%@uid=%@",GET_ASSET_INFO_URL,USER_ID];
    urlStr = [urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    [YGYBaseViewModel postRequestWithPath:urlStr parameters:nil responseDataModel:[GetAssetInfoModel class] success:^(id responseObject) {
        GetAssetInfoModel *model = responseObject;
        if ([model.status isEqualToString:@"200"]) {
            self.getAssetInfoData = model.data;
            [self.secondTableView reloadData];
        }else{
            //            MBHUD(model.msg);
        }
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark -------------资产信息BTC提现
-(void)assetRequestAccount:(NSString *)account numStr:(NSString *)numStr pwdStr:(NSString *)pwdStr{
    NSString *pwdStrMD5 = [NSString stringWithFormat:@"%@",[pwdStr MD5]];
    NSString *urlStr = [NSString stringWithFormat:@"%@userId=%@&address=%@&assetsPassword=%@&btcNumber=%@",ASSET_WITHDRAW_URL,USER_ID,account,pwdStrMD5,numStr];
    urlStr = [urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    [YGYBaseViewModel postRequestWithPath:urlStr parameters:nil responseDataModel:[GetAssetInfoModel class] success:^(id responseObject) {
        GetAssetInfoModel *model = responseObject;
        if ([model.status isEqualToString:@"200"]) {
            MBHUD(@"提币成功");
            [self getAssetInfoRequest];
            [self hiddenCoverBtcView];
            
        }else{
            [iToast showMessage:model.msg];
        }
    } failure:^(NSError *error) {
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

//必须销毁
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
    if (self.dataSourceArr.count > 0) {
        self.dataSourceArr = nil;
    }
    if (self.tableView) {
        [self.tableView removeFromSuperview];
    }
    if (self.topView) {
        [self.topView removeFromSuperview];
    }
    if (self.topImageView) {
        [self.topImageView removeFromSuperview];
    }
    if ([[self internetStatus] isEqualToString:@"WIFI"] || [[self internetStatus] isEqualToString:@"蜂窝数据"]) {
        [self enterPage];
    }else{
        [self noNetworkBackImageView];
    }
}
@end
