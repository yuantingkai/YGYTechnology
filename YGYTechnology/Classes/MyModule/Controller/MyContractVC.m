//
//  MyContractVC.m
//  YGYTechnology
//
//  Created by 袁庭楷 on 2018/10/9.
//  Copyright © 2018年 YGY. All rights reserved.
//

#import "MyContractVC.h"
#import "MyContractCell.h"
#import "MyContractCollectionCell.h"
#import "MyContractIndentModel.h"
#import "ContractDetailsVC.h"

static NSString *const kMyContractCollectionIdentifier = @"myContractCollectionIdentifier";
static NSString *const kMyContractCellIdentifier = @"myContractCellIdentifier";

@interface MyContractVC ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout,UITableViewDelegate,UITableViewDataSource>
{
    BOOL isFirstEnter;
}
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UICollectionView *myCollectionCollectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *collectionViewFlowLayout; /**< 流式布局 */
@property (nonatomic, strong) NSArray * titleArr;
@property (nonatomic, strong) NSIndexPath * indexpath;
@property (nonatomic, strong) NSArray * dataSourceArr;//数据源数组
@property (nonatomic, strong) MyContractIndentPageData *myContractIndentPageData;
@property (nonatomic, strong) NSString * statusStr;//0全部 1未支付 2尚未处理 3正在采购 4正在部署 5正在运行 6停机维护
@property (nonatomic, strong) NSString * IDSTR;
@property (nonatomic, strong)  UIImageView *noDataImageView;
@end

@implementation MyContractVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = Color(0xf2f2f2);
    isFirstEnter = YES;
    self.statusStr = @"0";
    [self setNav];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.myCollectionCollectionView];
    [self myContractRequest];
}



#pragma mark TableView的协议方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataSourceArr.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 165;
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
    MyContractCell * cell=[tableView dequeueReusableCellWithIdentifier:kMyContractCellIdentifier];
    if (!cell){
        cell=[[MyContractCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kMyContractCellIdentifier];
    }
    WeakSelf(self)
    [cell setBlock_payBtn:^(UIButton *payBtn) {
        [weakSelf clickPay:payBtn];
    }];
    [cell setBlock_cancelBtn:^(UIButton *cancelBtn) {
        [weakSelf clickCancelOrder:cancelBtn];
    }];
    [cell setBlock_moreBtn:^(UIButton *moreBtn) {
        [weakSelf clickCheckMore:moreBtn];
    }];
    [cell setBlock_IDStr:^(NSString *idStr) {
        [weakSelf getID:idStr];
    }];
    if (self.dataSourceArr.count > 0) {
        self.myContractIndentPageData = self.dataSourceArr[indexPath.section];
        [cell setIndexPath:indexPath withPageData:self.myContractIndentPageData];
    }
    return cell;
}

-(void)getID:(NSString *)idStr{
    self.IDSTR = idStr;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSLog(@"%ld",(long)indexPath.row);
}

//点击立即支付
-(void)clickPay:(UIButton *)sender{
    MBHUD(@"暂不支持");
    SLog(@"pay===%ld",sender.tag);
}

//点击取消订单
-(void)clickCancelOrder:(UIButton *)sender{
//    MBHUD(@"暂不支持");
    SLog(@"cancel====%ld",sender.tag);
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提醒" message:@"您确认要取消订单？" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"我点错了" style:UIAlertActionStyleCancel  handler:^(UIAlertAction * action) {}];
    UIAlertAction* okAction = [UIAlertAction actionWithTitle:@"确认取消" style:UIAlertActionStyleDefault  handler:^(UIAlertAction * action) {
        [self deleteCommodityRequest];
    }];
    [okAction setValue:MAIN_BODY forKey:@"titleTextColor"];
    [cancelAction setValue:CLICK_BODY forKey:@"titleTextColor"];
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    [[[[UIApplication sharedApplication] keyWindow] rootViewController] presentViewController:alertController animated:YES completion:nil];
}

//点击更多
-(void)clickCheckMore:(UIButton *)sender{
    SLog(@"more====%ld",sender.tag);
    self.myContractIndentPageData = self.dataSourceArr[sender.tag];
    ContractDetailsVC *vc = [ContractDetailsVC new];
    vc.isMyStr = @"YES";
    vc.myContractIndentPageData = self.myContractIndentPageData;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark *** UICollectionViewDataSource ***
// 设置组数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
// 设置个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 7;
    
}

//设置单元格
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    // item重用机制
    MyContractCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kMyContractCollectionIdentifier forIndexPath:indexPath];
    cell.indexPath = indexPath;
    
    if (self.indexpath == indexPath) {
        cell.titleLabel.textColor = Color(0x8286fa);
    }else{
        cell.titleLabel.textColor = Color(0x666666);
    }
    if (isFirstEnter) {
        if (indexPath.row == 0) {
            cell.titleLabel.textColor = Color(0x8286fa);
        }
    }
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    //调用点击的cell类
    //    MyContractCollectionCell *cell = (MyContractCollectionCell *)[collectionView cellForItemAtIndexPath:indexPath ];
    isFirstEnter = NO;
    self.indexpath = indexPath;
    
    if (indexPath.row == 0) {//全部合约订单请求
        NSLog(@"全部请求");
        self.statusStr = @"0";
    }else if (indexPath.row == 1){//未支付订单请求
        NSLog(@"未支付请求");
        self.statusStr = @"1";
    }else if (indexPath.row == 2){//尚未处理
        NSLog(@"尚未处理");
        self.statusStr = @"2";
    }else if (indexPath.row == 3){//正在采购
        NSLog(@"正在采购");
        self.statusStr = @"3";
    }else if (indexPath.row == 4){//正在部署
        NSLog(@"正在部署");
        self.statusStr = @"4";
    }else if (indexPath.row == 5){//正在运行
        NSLog(@"正在运行");
        self.statusStr = @"5";
    }else if (indexPath.row == 6){//停机维护
        NSLog(@"停机维护");
        self.statusStr = @"6";
    }
    [self myContractRequest];
    [collectionView reloadData];
    SLog(@"%ld",indexPath.row);
}
//返回这个UICollectionViewCell是否可以被选择
-( BOOL )collectionView:( UICollectionView *)collectionView shouldSelectItemAtIndexPath:( NSIndexPath *)indexPath{
    return YES ;
}

-(void)setNav{
    UIView * topView = [ViewTools createGradientLayerNav_BarViewWithString:@"我的合约"];
    [self.view addSubview:topView];
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setImage:[UIImage imageNamed:@"leftArrow"] forState:UIControlStateNormal];
    [leftBtn sizeToFit];
    leftBtn.expandHitEdgeInsets = UIEdgeInsetsMake(15, 15, 15, 15);
    [leftBtn addTarget:self action:@selector(returnTopVC) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:leftBtn];
    [leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(12);
        make.bottom.mas_offset(kNavControlImgBottom);
    }];
}

-(void)returnTopVC {
    [self.navigationController popViewControllerAnimated:YES];
}

-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kNavHeight + 10 + 50, SCREEN_WIDTH, SCREEN_HEIGHT -kNavHeight - 10 - 50) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = Color(0xf2f2f2);
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
    }
    return _tableView;
}

#pragma mark *** Getters ***
- (UICollectionViewFlowLayout *)collectionViewFlowLayout {
    if (!_collectionViewFlowLayout) {
        _collectionViewFlowLayout = [[UICollectionViewFlowLayout alloc] init];
        // 设置item估计值
        //        _collectionViewFlowLayout.estimatedItemSize = CGSizeMake(SCREEN_WIDTH/2-15, 40);
        // 全局配置item尺寸,单独定义调用协议方法[sizeForItemAtIndexPath]
        //        _collectionViewFlowLayout.itemSize = CGSizeMake(SCREEN_WIDTH / 6, 50);
        // 全局配置每行之间的间距,单独定义可调用协议方法[minimumLineSpacingForSectionAtIndex]
        //        _collectionViewFlowLayout.minimumLineSpacing = 12;
        // 全局配置每行内部item的间距,单独定义可调用协议方法[minimumInteritemSpacingForSectionAtIndex]
        _collectionViewFlowLayout.minimumInteritemSpacing = 30;
        // 设置头部size
        //_collectionViewFlowLayout.headerReferenceSize = CGSizeMake(CGRectGetWidth(self.view.bounds), 30);
        // 设置尾部size
        //_collectionViewFlowLayout.footerReferenceSize = CGSizeZero;
        // 设置滚动方向
        // UICollectionViewScrollDirectionVertical
        // UICollectionViewScrollDirectionHorizontal
        _collectionViewFlowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        //允许多选
        //        _collectionView.allowsMultipleSelection =NO;
        // 设置是否当元素超出屏幕之后固定头部视图位置，默认NO；
        //_collectionViewFlowLayout.sectionHeadersPinToVisibleBounds = YES;
        // 设置是否当元素超出屏幕之后固定尾部视图位置，默认NO；
        //_collectionViewFlowLayout.sectionFootersPinToVisibleBounds = YES;
    }
    return _collectionViewFlowLayout;
}

- (UICollectionView *)myCollectionCollectionView {
    if (!_myCollectionCollectionView) {
        _myCollectionCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(12,kNavHeight +10, SCREEN_WIDTH -24, 50) collectionViewLayout:self.collectionViewFlowLayout];
        _myCollectionCollectionView.layer.cornerRadius = 8;
        _myCollectionCollectionView.backgroundColor = [UIColor whiteColor];
        // 设置是否允许滚动
        _myCollectionCollectionView.scrollEnabled = YES;
        _myCollectionCollectionView.showsHorizontalScrollIndicator = NO;
        // 设置是否允许选中，默认YES
        _myCollectionCollectionView.allowsSelection = YES;
        // 设置是否允许多选，默认NO
        //        _myCollectionCollectionView.allowsMultipleSelection = YES;
        // 设置代理
        _myCollectionCollectionView.delegate = self;
        // 设置数据源
        _myCollectionCollectionView.dataSource = self;
        // 注册Item
        [_myCollectionCollectionView registerClass:[MyContractCollectionCell class] forCellWithReuseIdentifier:kMyContractCollectionIdentifier];
        // 注册头部视图
        //        [_successCollectionView registerClass:[WDSuccessCollectionViewCell class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kSuccessCollectionViewCellIdentifier];
    }
    return _myCollectionCollectionView;
}

//设置单独的item大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGSize titleWidth = [self.titleArr[indexPath.row] sizeWithAttributes:@{NSFontAttributeName : Font(14)}];
    CGSize singleSize = CGSizeMake(titleWidth.width + 15, 50);
    return singleSize;
}

-(NSArray *)titleArr{
    if (!_titleArr) {
        _titleArr = @[@"全部",@"未支付",@"尚未处理",@"正在采购",@"正在部署",@"正在运行",@"停机维护"];
    }
    return _titleArr;
}

-(NSArray *)dataSourceArr{
    if (!_dataSourceArr) {
        _dataSourceArr = [NSArray array];
    }
    return _dataSourceArr;
}

#pragma mark 合约列表请求
-(void)myContractRequest{
    STOP_LOADING
    LOADING
    [self removeNoDataImage];
    NSString *urlStr = [NSString stringWithFormat:@"%@userId=%@&index=1&size=100&status=%@",GET_ORDER_LIST_URL,USER_ID,self.statusStr];
    urlStr = [urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    [YGYBaseViewModel getRequestWithPath:urlStr parameters:nil responseDataModel:[MyContractIndentModel class] success:^(id responseObject) {
        MyContractIndentModel *model = responseObject;
        if ([model.status isEqualToString:@"200"]) {
            STOP_LOADING
            MyContractIndentData *data = model.data;
            self.dataSourceArr = data.pageData;
            [self.tableView reloadData];
            if (self.dataSourceArr.count > 0) {
                NSIndexPath * topOneIndex = [NSIndexPath indexPathForRow:0 inSection:0];
                [self.tableView scrollToRowAtIndexPath:topOneIndex atScrollPosition:UITableViewScrollPositionTop animated:YES];
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

#pragma mark -------------删除订单
-(void)deleteCommodityRequest{
    LOADING
    NSString *urlStr = [NSString stringWithFormat:@"%@id=%@",DELETE_PAY_PRODUCT,self.IDSTR];
    urlStr = [urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    [YGYBaseViewModel postRequestWithPath:urlStr parameters:nil responseDataModel:[YGYBaseDataModel class] success:^(id responseObject) {
        STOP_LOADING
        YGYBaseDataModel *model = responseObject;
        if ([model.status isEqualToString:@"200"]) {
            [iToast showMessage:@"删除成功"];
            [self myContractRequest];
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

-(void)removeNoDataImage{
    [self.noDataImageView removeFromSuperview];
}
@end
