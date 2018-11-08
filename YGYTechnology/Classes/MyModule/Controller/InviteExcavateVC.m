//
//  InviteExcavateVC.m
//  YGYTechnology
//
//  Created by 袁庭楷 on 2018/10/4.
//  Copyright © 2018年 YGY. All rights reserved.
//

#import "InviteExcavateVC.h"
#import "InviteExcavateCell.h"
#import "ActivityView.h"
#import "CheckDetailVC.h"

@interface InviteExcavateVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UIView * coverView;
@property (nonatomic, strong) UIImageView *activityImgView;
@property (nonatomic, strong) UILabel *SDTScoreLabel;
@end
static NSString * const Identifier = @"inviteExcavateCell";
@implementation InviteExcavateVC

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self getAllScoreRequest];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = Color(0xf2f2f2);
    [self setUI];
    [self.view addSubview:self.tableView];
    
}

-(void)setUI{
    //初始化渐变色
    CAGradientLayer * gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(__bridge id)[ColorFormatter hex2Color:0x6F8AF9].CGColor, (__bridge id)[ColorFormatter hex2Color:0x8033CB].CGColor];
    gradientLayer.locations = @[@0.1, @1.0];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1, 0);
    gradientLayer.frame = CGRectMake(0, 0, SCREEN_WIDTH,190);
    [self.view.layer addSublayer:gradientLayer];
    
    self.topView = [UIImageView new];
    self.topView.backgroundColor = [UIColor clearColor];
    self.topView.userInteractionEnabled = YES;
    [self.view addSubview:self.topView];
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.offset(0);
        make.height.mas_offset(190);
    }];

    
    
    UIButton *returnBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [returnBtn setImage:[UIImage imageNamed:@"leftArrow"] forState:UIControlStateNormal];
    [returnBtn sizeToFit];
    returnBtn.expandHitEdgeInsets = UIEdgeInsetsMake(15, 15, 15, 15);
    [returnBtn addTarget:self action:@selector(returnTopVC) forControlEvents:UIControlEventTouchUpInside];
    [self.topView addSubview:returnBtn];
    [returnBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(12);
        make.top.offset(kNavHeight / 2);
        make.width.mas_offset(30);
    }];



    UILabel *showLabel = [UILabel newWithText:@"你已经挖到" fontSize:14 textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter];
    [self.topView addSubview:showLabel];
    [showLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(44);
        make.centerX.equalTo(self.topView).offset(-8);
    }];
    
    UILabel *SDTLabel = [UILabel newWithText:@"（SDT）" fontSize:12 textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentLeft];
    [self.topView addSubview:SDTLabel];
    [SDTLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(showLabel.mas_right).offset(0);
        make.centerY.equalTo(showLabel);
    }];
    
    self.SDTScoreLabel = [UILabel newWithText:@"0" fontSize:35 textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter];
    [self.topView addSubview:self.SDTScoreLabel];
    [self.SDTScoreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(showLabel.mas_bottom).offset(15);
        make.centerX.equalTo(self.topView);
        make.top.equalTo(showLabel.mas_bottom).offset(18);
    }];
    
    
    
    UIView *centerView = [UIView new];
    centerView.backgroundColor = [UIColor whiteColor];
    centerView.layer.cornerRadius = 8;
    [self.view addSubview:centerView];
    [centerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.width.mas_offset(308);
        make.height.mas_offset(60);
        make.top.equalTo(self.topView.mas_bottom).offset(-30);
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
    [leftImageView setImage:[UIImage imageNamed:@"查看明细"]];
    [centerView addSubview:leftImageView];
    [leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(centerView);
        make.left.offset(30);
        make.top.offset(19);
        make.bottom.offset(-19);
    }];
    
    UILabel *earningDetailLabel = [UILabel newWithText:@"查看明细" fontSize:14 textColor:MAIN_BODY textAlignment:NSTextAlignmentCenter];
    [centerView addSubview:earningDetailLabel];
    [earningDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(centerView);
        make.left.equalTo(leftImageView.mas_right).offset(6);
    }];
    
    
    
    UILabel *getDetailLabel = [UILabel newWithText:@"活动说明" fontSize:14 textColor:MAIN_BODY textAlignment:NSTextAlignmentCenter];
    [centerView addSubview:getDetailLabel];
    [getDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(centerView);
        make.right.offset(-30);
    }];
    
    UIImageView *rightImageView = [UIImageView new];
    [rightImageView setImage:[UIImage imageNamed:@"活动说明"]];
    [centerView addSubview:rightImageView];
    [rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(centerView);
        make.right.equalTo(getDetailLabel.mas_left).offset(-6);
        make.top.offset(19);
        make.bottom.offset(-19);
    }];
    
    UIButton *leftBtn = [UIButton new];
    [leftBtn addTarget:self action:@selector(clickLeftBtn:) forControlEvents:UIControlEventTouchUpInside];
    [centerView addSubview:leftBtn];
    [leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.offset(0);
        make.right.equalTo(lineView.mas_left).offset(0);
    }];

    UIButton *rightBtn = [UIButton new];
    [rightBtn addTarget:self action:@selector(clickRightBtn:) forControlEvents:UIControlEventTouchUpInside];
    [centerView addSubview:rightBtn];
    [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.bottom.offset(0);
        make.left.equalTo(lineView.mas_right).offset(0);
    }];
}

-(void)returnTopVC {
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)clickLeftBtn:(UIButton *)sender{
    SLog(@"点击了明细");
    CheckDetailVC *vc = [CheckDetailVC new];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)clickRightBtn:(UIButton *)sender{
    SLog(@"点击了活动");
    self.coverView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.coverView.backgroundColor = [UIColor blackColor];
    self.coverView.alpha = 0.5;
    [self.coverView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(coverViewTouchUpInside)]];
    [self.view addSubview:self.coverView];
    
    self.activityImgView = [UIImageView new];
    self.activityImgView.userInteractionEnabled = YES;
    [self.activityImgView setImage:[UIImage imageNamed:@"活动弹窗"]];
    [self.view addSubview:self.activityImgView];
    [self.activityImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.view).offset(50);
        make.centerX.equalTo(self.view);
    }];
    
    UIButton *cancelBtn = [UIButton newWithTitle:@"" font:14 textColor:nil textAlignment:NSTextAlignmentCenter Image:[UIImage imageNamed:@"guanbi"]];
    [cancelBtn addTarget:self action:@selector(cancelBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.activityImgView addSubview:cancelBtn];
    [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-15);
        make.top.offset(15);
    }];
}

-(void)cancelBtn:(UIButton *)cancelBtn{
    SLog(@"取消");
    [self hiddenCoverView];
}

-(void)hiddenCoverView{
    [self.activityImgView removeFromSuperview];
    [self.coverView removeFromSuperview];
    self.activityImgView.hidden = YES;
    self.coverView.hidden = YES;
}
- (void)coverViewTouchUpInside {
    [UIView animateWithDuration:0.25 animations:^{
        [self hiddenCoverView];
    }completion:^(BOOL finished) {
        self.activityImgView.hidden = YES;
        self.coverView.hidden = YES;
    }];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
        return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (SCREEN == 1) {
        return SCREEN_HEIGHT - 180 ;
    }else{
        return SCREEN_HEIGHT -190 -30 -20;
    }

}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
        return 10;
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
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    InviteExcavateCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    if (cell == nil) {
        cell = [[InviteExcavateCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
    }

    return cell;
}

-(UITableView *)tableView
{
    if (!_tableView) {
            _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 190 + 30, SCREEN_WIDTH, SCREEN_HEIGHT - 190 -30) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = Color(0xf2f2f2);
        _tableView.allowsSelection = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

//获得挖矿总积分
-(void)getAllScoreRequest{
    NSString *urlStr = [NSString stringWithFormat:@"%@uid=%@",SDT_NUM_URL,USER_ID];
    urlStr = [urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    [YGYBaseViewModel postRequestWithPath:urlStr parameters:nil responseDataModel:[YGYBaseDataModel class] success:^(id responseObject) {
        YGYBaseDataModel *model = responseObject;
        if ([model.status isEqualToString:@"200"]) {
            self.SDTScoreLabel.text = [NSString stringWithFormat:@"%.3f",[model.data doubleValue]];
            [self.view layoutIfNeeded];
            [self.tableView reloadData];
        }else{
            MBHUD(model.msg);
        }
        
    } failure:^(NSError *error) {
        
    }];
}


@end
