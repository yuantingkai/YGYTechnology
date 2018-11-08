//
//  securityCenterVC.m
//  YGYTechnology
//
//  Created by 袁庭楷 on 2018/9/29.
//  Copyright © 2018年 YGY. All rights reserved.
//

#import "securityCenterVC.h"
#import "securityCenterCell.h"
#import "CertificationVC.h"
#import "LoginPwdVC.h"
#import "PropertyPwdVC.h"
#import "LoginVC.h"

@interface securityCenterVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;

@end

static NSString * const Identifier = @"securityCenterCell";

@implementation securityCenterVC

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = Color(0xf2f2f2);
    [self topNavigation];
    [self.view addSubview:self.tableView];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 1) {
        return 2;
    }else{
        return 1;
    }
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
    if (indexPath.section == 0) {
        CertificationVC *certifiVC = [[CertificationVC alloc]init];
        [self.navigationController pushViewController:certifiVC animated:YES];
    }else if (indexPath.section == 1){
        if (indexPath.row == 0) {
            LoginPwdVC *loginPwdVC = [[LoginPwdVC alloc]init];
            [self.navigationController pushViewController:loginPwdVC animated:YES];
        }else{
            PropertyPwdVC *propertyVC = [[PropertyPwdVC alloc]init];
            [self.navigationController pushViewController:propertyVC animated:YES];
        }
    }else{//退出登录
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"确认退出登录？" message:nil preferredStyle:UIAlertControllerStyleAlert];

        
        UIAlertAction* okAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault  handler:^(UIAlertAction * action) {
            [self removeAllUserDeafultKey];
            LoginVC *loginV = [[LoginVC alloc]init];
            loginV.isExitLogin = @"YES";
            [loginV setHidesBottomBarWhenPushed:YES];
            [self.navigationController pushViewController:loginV animated:YES];
        }];
        UIAlertAction* canclePhotoAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel  handler:^(UIAlertAction * action) {}];
        
        [canclePhotoAction setValue:SECOND_BODY forKey:@"titleTextColor"];
        [okAction setValue:MAIN_BODY forKey:@"titleTextColor"];
        
        
        [alertController addAction:canclePhotoAction];
        [alertController addAction:okAction];
        [[[[UIApplication sharedApplication] keyWindow] rootViewController] presentViewController:alertController animated:YES completion:nil];
        
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    securityCenterCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    if (cell == nil) {
        cell = [[securityCenterCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
    }
    [cell setIndexpath:indexPath];
    
    return cell;
}


-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kNavHeight, SCREEN_WIDTH, SCREEN_HEIGHT - kNavHeight) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

//pragma mark 创建导航栏
-(void)topNavigation{
    UIView * topView = [ViewTools createGradientLayerNav_BarViewWithString:@"安全中心"];
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

#pragma mark-------------------清空数据
-(void)removeAllUserDeafultKey{//退出 清空数据
    [[LoginSaveTool sharedTool] deleteCurrentLoginData];
    [USER_DEFAULT removeObjectForKey:@"CLAC_ARR"];
    [USER_DEFAULT removeObjectForKey:@"IMAGE_STR"];
    [USER_DEFAULT removeObjectForKey:@"NAME_STR"];
    [USER_DEFAULT removeObjectForKey:@"OLDPWD"];
    [USER_DEFAULT removeObjectForKey:@"GENDER_STR"];
    [USER_DEFAULT removeObjectForKey:@"AS_SETS_PWD_EXIST"];
    [USER_DEFAULT removeObjectForKey:@"LOGIN_SUCCESS"];
}
@end
