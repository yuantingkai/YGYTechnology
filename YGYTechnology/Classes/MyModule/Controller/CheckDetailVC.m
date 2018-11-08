//
//  CheckDetailVC.m
//  YGYTechnology
//
//  Created by 袁庭楷 on 2018/10/4.
//  Copyright © 2018年 YGY. All rights reserved.
//

#import "CheckDetailVC.h"
#import "CheckDetailCell.h"
#import "CheckDetailModel.h"

@interface CheckDetailVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray * dataArr;
@property (nonatomic, strong)  UIImageView *noDataImageView;
@end
static NSString * const Identifier = @"checkDetailCell";
@implementation CheckDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self setNav];
    [self checkDetailRequest];
}

-(void)setNav{
    UIView * topView = [ViewTools createGradientLayerNav_BarViewWithString:@"挖矿明细"];
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

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.dataArr.count>0) {
        return self.dataArr.count;
    }else{
        return 0;
    }
    
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CheckDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    if (cell == nil) {
        cell = [[CheckDetailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
    }
    
    CheckDetailPageData *checkPageData = self.dataArr[indexPath.section];
    if (self.dataArr.count > 0) {
        NSString *dateStr = checkPageData.date.length >= 10 ? [checkPageData.date substringToIndex:10] : checkPageData.date;
        [cell setIndexPath:indexPath phoneNum:checkPageData.name timeStr:dateStr showStr:checkPageData.desc numStr:checkPageData.number];
    }
    return cell;
}


-(UITableView *)tableView
{
    if (!_tableView) {
            _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kNavHeight, SCREEN_WIDTH, SCREEN_HEIGHT -kNavHeight) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = Color(0xf2f2f2);
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

//查看明细请求
-(void)checkDetailRequest{
    LOADING
    [self removeNoDataImage];
    NSString *urlStr = [NSString stringWithFormat:@"%@index=1&size=100&uid=%@",CHECK_DETAIL_URL,USER_ID];
    urlStr = [urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    [YGYBaseViewModel postRequestWithPath:urlStr parameters:nil responseDataModel:[CheckDetailModel class] success:^(id responseObject) {
        STOP_LOADING
        CheckDetailModel *model = responseObject;
        CheckDetailData *detailData = model.data;
        if ([model.status isEqualToString:@"200"]) {
            self.dataArr = detailData.pageData;
            if (self.dataArr.count > 0) {
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

-(NSArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSArray array];
    }
    return _dataArr;
}

-(void)removeNoDataImage{
    [self.noDataImageView removeFromSuperview];
}
@end
