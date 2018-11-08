//
//  MarketplaceVC.m
//  YGYTechnology
//
//  Created by 袁庭楷 on 2018/9/25.
//  Copyright © 2018年 YGY. All rights reserved.
//

#import "MarketplaceVC.h"
#import "HW3DBannerView.h"
#import "MarketTableViewCell.h"
#import "MarketCollectionViewCell.h"
#import "TendencyMagnifyView.h"
#import "ShoppingMallCell.h"

@interface MarketplaceVC ()<UIWebViewDelegate,UITableViewDelegate,UITableViewDataSource,UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
{
    BOOL isFirstEnter;
}
@property (nonatomic, strong) UITableView *scoreExchangeTableView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UICollectionView *tendencyCollectionCollectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *tendencyCollectionViewFlowLayout; /**< 流式布局 */
@property (nonatomic, strong) NSIndexPath * indexpath;
@property (nonatomic, strong) NSArray * tendencyArr;
@property (nonatomic, strong) NSArray * kLineArr;

@property (nonatomic, strong) UIView * topView;
@property (nonatomic, strong) UIButton *leftBtn;//合约按钮
@property (nonatomic, strong) UIButton *rightBtn;//资产按钮
@property (nonatomic,strong) HW3DBannerView *scrollView;


@property (nonatomic, strong) NSArray * lineChartArr;
@property (nonatomic, strong) UIWebView *tendencyWebView;//用于存储趋势图 点击 的 上一个webview
@property (nonatomic, strong) UIWebView *tendencyMagnifyWebView;//用于存储放大的趋势图 点击 的 上一个webview
@property (nonatomic, assign) NSInteger tendencyClickNum;//趋势图点击后的num 用于放大的趋势图加载对应界面
@property (nonatomic, strong) UIView *jumpView;

@property (nonatomic, strong) UIImageView *noNetworkImageView;
@end
static NSString * const kIdentifier = @"MarketTableViewCell";
static NSString * const kShoppingMallIdentifier = @"ShoppingMallCell";
static NSString *const kContractCollectionIdentifier = @"MarketCollectionIdentifier";
@implementation MarketplaceVC

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    
    [self.leftBtn setBackgroundColor:Color(0x5467ED)];
    [self.rightBtn setBackgroundColor:[UIColor clearColor]];
    [self.scrollView setHidden:NO];
    [self.tableView setHidden:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = Color(0xf2f2f2);
    isFirstEnter = YES;
    [self customNavView];
    [self creatTopScrollView];
    //    [self creatTendencyWebView];
    [self.view addSubview:self.scoreExchangeTableView];
    [self.view addSubview:self.tableView];
    
    
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
    self.leftBtn = [UIButton newWithTitle:@"有商城" font:16 textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter Image:nil];
    [self.leftBtn addTarget:self action:@selector(leftBtn:) forControlEvents:UIControlEventTouchUpInside];
    self.leftBtn.layer.cornerRadius = 12;
    [self.leftBtn setBackgroundColor:Color(0x5467ED)];
    [self.topView addSubview:self.leftBtn];
    [self.leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(returnTopBtn);
        make.right.equalTo(self.topView).offset(-centerWidth - 10);
        if (SCREEN == 3) {
            make.width.mas_offset(70);
        }else{
            make.width.mas_offset(60);
        }
        make.height.mas_offset(24);
    }];
    
    self.rightBtn = [UIButton newWithTitle:@"行情" font:16 textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter Image:nil];
    self.rightBtn.layer.cornerRadius = 12;
    [self.rightBtn addTarget:self action:@selector(rightBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.topView addSubview:self.rightBtn];
    [self.rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(returnTopBtn);
        make.left.equalTo(self.topView).offset(centerWidth + 10);
        make.width.mas_offset(60);
        make.height.mas_offset(24);
    }];
}

#pragma mark ----------- 点击头部有商城按钮
-(void)leftBtn:(UIButton *)sender{
    [self.leftBtn setBackgroundColor:Color(0x5467ED)];
    [self.rightBtn setBackgroundColor:[UIColor clearColor]];
    [self.scrollView setHidden:NO];
    [self.tableView setHidden:YES];
}

#pragma mark ----------- 点击头部行情按钮
-(void)rightBtn:(UIButton *)sender{
    NSString *str = [USER_DEFAULT objectForKey:@"LOGIN_SUCCESS"];
    if ([str isEqualToString:@"loginSuccess"]){
        [[NSNotificationCenter defaultCenter] removeObserver:self];
        [sender setBackgroundColor:Color(0x5467ED)];
        [self.leftBtn setBackgroundColor:[UIColor clearColor]];
        [self.tableView setHidden:NO];
        [self.scrollView setHidden:YES];
        [self creatTendencyWebView];
        isFirstEnter = YES;
    }else{
        [self loginSuccess];
    }
}

-(void)creatTopScrollView{
    _scrollView = [HW3DBannerView initWithFrame:CGRectMake(0, kNavHeight + 10, SCREEN_WIDTH, 150) imageSpacing:10 imageWidth:SCREEN_WIDTH - 50];
    _scrollView.initAlpha = 0.5; // 设置两边卡片的透明度
    _scrollView.imageRadius = 10; // 设置卡片圆角
    _scrollView.imageHeightPoor = 10; // 设置中间卡片与两边卡片的高度差
    // 设置要加载的图片
    self.scrollView.data = @[@"http://d.hiphotos.baidu.com/image/pic/item/b7fd5266d016092408d4a5d1dd0735fae7cd3402.jpg",@"http://h.hiphotos.baidu.com/image/h%3D300/sign=2b3e022b262eb938f36d7cf2e56085fe/d0c8a786c9177f3e18d0fdc779cf3bc79e3d5617.jpg",@"http://a.hiphotos.baidu.com/image/pic/item/b7fd5266d01609240bcda2d1dd0735fae7cd340b.jpg",@"http://h.hiphotos.baidu.com/image/pic/item/728da9773912b31b57a6e01f8c18367adab4e13a.jpg",@"http://h.hiphotos.baidu.com/image/pic/item/0d338744ebf81a4c5e4fed03de2a6059242da6fe.jpg"];
    _scrollView.placeHolderImage = [UIImage imageNamed:@"banner-1"]; // 设置占位图片
    [self.view addSubview:self.scrollView];
    _scrollView.clickImageBlock = ^(NSInteger currentIndex) { // 点击中间图片的回调
    };
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if ([tableView isEqual:self.scoreExchangeTableView]) {
        return 2;
    }else if([tableView isEqual:self.tableView]){
        return 1;
    }
    return 0;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([tableView isEqual:self.scoreExchangeTableView]) {
        if (section == 0) {
            return 1;
        }else{
            return 10;
        }
        
    }else  if([tableView isEqual:self.tableView]){
        return 1;
    }
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isEqual:self.scoreExchangeTableView]) {
        if (indexPath.section == 0) {
            return 52;
        }else{
            return 105;
        }
        
    }else  if([tableView isEqual:self.tableView]){
        return SCREEN_HEIGHT - kNavHeight - TabbarHeight;
    }
    return 0.0001;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if ([tableView isEqual:self.scoreExchangeTableView]) {
        if (section == 1) {
            return 10;
        }else{
            return 0.001;
        }
        
    }else  if([tableView isEqual:self.tableView]){
        return 0.001;
    }
    return 0.001;
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

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([tableView isEqual:self.scoreExchangeTableView]) {
        ShoppingMallCell *cell = [tableView dequeueReusableCellWithIdentifier:kShoppingMallIdentifier];
        if (cell == nil) {
            cell = [[ShoppingMallCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kShoppingMallIdentifier];
        }
        [cell setIndexPath:indexPath];
        return cell;
    }else if ([tableView isEqual:self.tableView]){
        MarketTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kIdentifier];
        if (cell == nil) {
            cell = [[MarketTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kIdentifier];
        }
        [cell.collectionView addSubview:self.tendencyCollectionCollectionView];
        for (int i = 0; i < 5; i++) {//获得遍历的webview添加到视图
            UIWebView *showLineChartWeb = [self.view viewWithTag:i +1000];
            if (i == 0) {
                showLineChartWeb.hidden = NO;
            }else{
                showLineChartWeb.hidden = YES;
            }
            [cell.showLineChartView addSubview:showLineChartWeb];
        }
        return cell;
    }
    
    return nil;
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
        _tableView.allowsSelection = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        //        _tableView.userInteractionEnabled = NO;
    }
    return _tableView;
}

-(UITableView *)scoreExchangeTableView {
    if (!_scoreExchangeTableView) {
        _scoreExchangeTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kNavHeight + 170, SCREEN_WIDTH, SCREEN_HEIGHT - kNavHeight - 170 - TabbarHeight) style:UITableViewStyleGrouped];
        _scoreExchangeTableView.delegate = self;
        _scoreExchangeTableView.dataSource = self;
        _scoreExchangeTableView.backgroundColor = [UIColor clearColor];
        //        _scoreExchangeTableView.separatorColor = YGYColor(245, 245, 245);
        _scoreExchangeTableView.showsVerticalScrollIndicator = NO;
        _scoreExchangeTableView.showsHorizontalScrollIndicator = NO;
        _scoreExchangeTableView.allowsSelection = NO;
        _scoreExchangeTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        //        _scoreExchangeTableView.userInteractionEnabled = NO;
    }
    return _scoreExchangeTableView;
}

#pragma mark *** UICollectionViewDataSource ***
// 设置组数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
// 设置个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 6;
    
}

//设置单元格
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    // item重用机制
    MarketCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kContractCollectionIdentifier forIndexPath:indexPath];
    cell.indexPath = indexPath;
    
    if (self.indexpath == indexPath) {
        cell.titleLabel.backgroundColor = Color(0x8286fa);
        cell.titleLabel.textColor = [UIColor whiteColor];
    }else{
        cell.titleLabel.textColor = MAIN_BODY;
        cell.titleLabel.backgroundColor = [UIColor whiteColor];
    }
    if (isFirstEnter) {
        if (indexPath.row == 0) {
            cell.titleLabel.backgroundColor = Color(0x8286fa);
            cell.titleLabel.textColor = [UIColor whiteColor];
        }else{
            cell.titleLabel.textColor = MAIN_BODY;
            cell.titleLabel.backgroundColor = [UIColor whiteColor];
        }
    }
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    //调用点击的cell类
    if (!(indexPath.row == 5)) {
        isFirstEnter = NO;
        self.indexpath = indexPath;
        
        UIWebView *showLineChartWeb = [self.view viewWithTag:indexPath.row +1000];
        if (self.tendencyWebView == showLineChartWeb) {}else{
            showLineChartWeb.hidden = NO;
            self.tendencyWebView.hidden = YES;
        }
        self.tendencyWebView = showLineChartWeb;
        self.tendencyClickNum = indexPath.row;
    }
    if (indexPath.row == 5){
        //创建放大后的webview
        [self creatMagnifyTendencyWebView];
        TendencyMagnifyView *tendencyMagnifyView = [[TendencyMagnifyView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_HEIGHT, SCREEN_WIDTH)];
        [tendencyMagnifyView setNum:self.tendencyClickNum];
        //获得遍历的webview添加到视图
        for (int i = 0; i < 5; i++) {
            UIWebView *MagnifyTendencyWeb = [self.view viewWithTag:i +2000];
            if (i == self.tendencyClickNum) {
                MagnifyTendencyWeb.hidden = NO;
            }else{
                MagnifyTendencyWeb.hidden = YES;
            }
            [tendencyMagnifyView.showTendencyChartView addSubview:MagnifyTendencyWeb];
        }
        //调取所点击的按钮和视图
        WeakSelf(self);
        [tendencyMagnifyView setClickBtn:^(UIButton * _Nonnull tendencyBtn, UIView * _Nonnull selfView) {
            [weakSelf tendencyBtn:tendencyBtn selfView:selfView];
        } ];
        [self.tabBarController.tabBar setHidden:YES];
        [[UIApplication sharedApplication] setStatusBarHidden:TRUE];
        
        [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionTransitionNone animations:^{
            tendencyMagnifyView.transform = CGAffineTransformMakeRotation(M_PI_2);
            tendencyMagnifyView.frame = self.view.bounds;
            //最后将webView添加到界面
            [self.view addSubview:tendencyMagnifyView];
        } completion:^(BOOL finished) {
        }];
    }
    [collectionView reloadData];
    SLog(@"%ld",indexPath.row);
}


-(void)tendencyBtn:(UIButton *)sender selfView:(UIView *)selfView{
    if (sender.tag - 10000 != 5) {
        UIWebView *showLineChartWeb = [self.view viewWithTag:sender.tag - 10000 +2000];
        if (self.tendencyMagnifyWebView == showLineChartWeb) {}else{
            showLineChartWeb.hidden = NO;
            self.tendencyMagnifyWebView.hidden = YES;
        }
        self.tendencyMagnifyWebView = showLineChartWeb;
    }
    if (sender.tag - 10000 == 5){
        [selfView removeFromSuperview];
        [self.tabBarController.tabBar setHidden:NO];
        [[UIApplication sharedApplication] setStatusBarHidden:FALSE];
    }
}
//返回这个UICollectionViewCell是否可以被选择
-( BOOL )collectionView:( UICollectionView *)collectionView shouldSelectItemAtIndexPath:( NSIndexPath *)indexPath{
    return YES ;
}

#pragma mark *** 趋势图流式布局  ***
- (UICollectionViewFlowLayout *)tendencyCollectionViewFlowLayout {
    if (!_tendencyCollectionViewFlowLayout) {
        _tendencyCollectionViewFlowLayout = [[UICollectionViewFlowLayout alloc] init];
        // 全局配置每行内部item的间距,单独定义可调用协议方法[minimumInteritemSpacingForSectionAtIndex]
        if (SCREEN == 1) {
            _tendencyCollectionViewFlowLayout.minimumInteritemSpacing = 3;
        }else if (SCREEN == 2){
            _tendencyCollectionViewFlowLayout.minimumInteritemSpacing = 11;
        }else if (SCREEN == 3){
            _tendencyCollectionViewFlowLayout.minimumInteritemSpacing = 15;
        }else{
            _tendencyCollectionViewFlowLayout.minimumInteritemSpacing = 11;
        }
        // 设置滚动方向
        // UICollectionViewScrollDirectionVertical
        // UICollectionViewScrollDirectionHorizontal
        _tendencyCollectionViewFlowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    }
    return _tendencyCollectionViewFlowLayout;
}

- (UICollectionView *)tendencyCollectionCollectionView {
    if (!_tendencyCollectionCollectionView) {
        _tendencyCollectionCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0,0, SCREEN_WIDTH -24, 42) collectionViewLayout:self.tendencyCollectionViewFlowLayout];
        _tendencyCollectionCollectionView.layer.cornerRadius = 8;
        _tendencyCollectionCollectionView.backgroundColor = [UIColor whiteColor];
        // 设置是否允许滚动
        _tendencyCollectionCollectionView.scrollEnabled = YES;
        _tendencyCollectionCollectionView.showsHorizontalScrollIndicator = NO;
        // 设置是否允许选中，默认YES
        _tendencyCollectionCollectionView.allowsSelection = YES;
        // 设置是否允许多选，默认NO
        //        _myCollectionCollectionView.allowsMultipleSelection = YES;
        // 设置代理
        _tendencyCollectionCollectionView.delegate = self;
        // 设置数据源
        _tendencyCollectionCollectionView.dataSource = self;
        // 注册Item
        [_tendencyCollectionCollectionView registerClass:[MarketCollectionViewCell class] forCellWithReuseIdentifier:kContractCollectionIdentifier];
    }
    return _tendencyCollectionCollectionView;
}

//设置单独的item大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGSize titleWidth;
    if (indexPath.row == 5) {
        UIImage *image = self.tendencyArr[indexPath.row];
        titleWidth.width = image.size.width + 50;
    }else{
        titleWidth = [self.tendencyArr[indexPath.row] sizeWithAttributes:@{NSFontAttributeName : Font(14)}];
    }
    CGSize singleSize = CGSizeMake(titleWidth.width + 20, 42);
    return singleSize;
}

-(NSArray *)tendencyArr{
    if (!_tendencyArr) {
        _tendencyArr = @[@"2周",@"1月",@"3月",@"6月",@"1年",[UIImage imageNamed:@"quanping"]];
    }
    return _tendencyArr;
}


-(NSArray *)kLineArr{
    if (!_kLineArr) {
        _kLineArr = @[@"日K",@"周K",@"月K",@"更多"];
    }
    return _kLineArr;
}
























#pragma mark ----------- 加载web视图 start  ----------- ----------- -----------
-(void)creatTendencyWebView{//创建趋势图webView
    for (int i = 0; i < 5; i++) {
        UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - 24, SCREEN_HEIGHT - kNavHeight - TabbarHeight - 121 - 10 - 50 - 42 - 20 -20)];
        webView.backgroundColor = [UIColor whiteColor];
        NSMutableURLRequest *request =[NSMutableURLRequest requestWithURL:[NSURL URLWithString:self.lineChartArr[i]]];
        // 3.加载网页
        [webView loadRequest:request];
        webView.layer.cornerRadius = 10;
        webView.layer.masksToBounds = YES;
        webView.hidden = YES;
        webView.userInteractionEnabled = YES;
        webView.scrollView.scrollEnabled = NO;
        webView.delegate = self;
        webView.tag = 1000+i;
        [self.view addSubview:webView];
    }
    [self.tableView reloadData];
}

-(void)creatMagnifyTendencyWebView{//创建放大后的趋势图webView
    for (int i = 0; i < 5; i++) {
        UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_HEIGHT - 24, SCREEN_WIDTH - 86)];
        webView.backgroundColor = [UIColor whiteColor];
        NSMutableURLRequest *request =[NSMutableURLRequest requestWithURL:[NSURL URLWithString:self.lineChartArr[i]]];
        // 3.加载网页
        [webView loadRequest:request];
        webView.layer.cornerRadius = 10;
        webView.layer.masksToBounds = YES;
        webView.hidden = YES;
        webView.userInteractionEnabled = YES;
        webView.scrollView.scrollEnabled = NO;
        webView.delegate = self;
        webView.tag = 2000+i;
        [self.view addSubview:webView];
    }
}

- (void)webViewDidStartLoad:(UIWebView *)webView{
    SLog(@"加载中");
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    SLog(@"加载结束");
    if (webView.isLoading) {
        return;
    }
}
-(NSArray *)lineChartArr{
    if (!_lineChartArr) {
        _lineChartArr = @[[NSString stringWithFormat:@"%@resources/h5/aline.html?days=14",BASEURL],[NSString stringWithFormat:@"%@resources/h5/aline.html?days=30",BASEURL],[NSString stringWithFormat:@"%@resources/h5/aline.html?days=91",BASEURL],[NSString stringWithFormat:@"%@resources/h5/aline.html?days=183",BASEURL],[NSString stringWithFormat:@"%@resources/h5/aline.html?days=365",BASEURL]];
    }
    return _lineChartArr;
}
#pragma mark ----------- 加载web视图 end  ----------- ----------- -----------













#pragma mark ----------- 进入界面调用的方法
-(void)enterPage{
    NSString *str = [USER_DEFAULT objectForKey:@"LOGIN_SUCCESS"];
    if ([str isEqualToString:@"loginSuccess"]) {
        [self sendFlotageRequest];
    }
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
        } failure:^(NSError *error) {}];
    }else{
        SLog(@"数组为空~~~~不用传值");
    }
}

//未登录点击弹窗
-(void)loginSuccess{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"当前账号未登录，请登录" message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault  handler:^(UIAlertAction * action) {}];
    
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
    if ([[self internetStatus] isEqualToString:@"WIFI"] || [[self internetStatus] isEqualToString:@"蜂窝数据"]) {
        [self enterPage];
    }else{
        [self noNetworkBackImageView];
    }
}
@end
