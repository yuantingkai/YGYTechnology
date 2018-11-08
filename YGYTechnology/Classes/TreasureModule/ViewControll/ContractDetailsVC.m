//
//  ContractDetailsVC.m
//  YGYTechnology
//
//  Created by 袁庭楷 on 2018/10/3.
//  Copyright © 2018年 YGY. All rights reserved.
//

#import "ContractDetailsVC.h"
#import "contractDetailsCell.h"

@interface ContractDetailsVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray * leftArr;
@property (nonatomic, strong) NSMutableArray * rightMutArr;
@property (nonatomic, strong) NSString * characterLengthStr;
@end

static NSString * const Identifier = @"contractDetailsCell";

@implementation ContractDetailsVC

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = Color(0xf2f2f2);
    
    [self setNav];
    self.leftArr = @[@[@"合约内容",@"功耗",@"价格",@"电费",@"维护费"],@[@"理论收益",@"交割时间",@"风险提示",@"维护费"]];
    if ([self.isMyStr isEqualToString:@"YES"]) {
        MyContractIndentProduct *product = self.myContractIndentPageData.product;
        self.rightMutArr = [NSMutableArray arrayWithObjects:@[product.content,product.power,product.price,product.electricity,product.maintenance],@[product.earnings,product.time,product.cycle,product.hint], nil];
    }else{
        self.rightMutArr = [NSMutableArray arrayWithObjects:@[self.treasureGetAllData.content,self.treasureGetAllData.power,self.treasureGetAllData.price,self.treasureGetAllData.electricity,self.treasureGetAllData.maintenance],@[self.treasureGetAllData.earnings,self.treasureGetAllData.time,self.treasureGetAllData.cycle,self.treasureGetAllData.hint], nil];
    }
    
    [self.view addSubview:self.tableView];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 5;
    }else{
        return 4;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *str =self.characterLengthStr;
    float rowHeight = [ContractDetailsVC heightForReduceStringWith:str  font:13 width:self.view.frame.size.width -24 - 100];
        return 48 > rowHeight ? 48 : rowHeight + 35 ;
}

+(float)heightForReduceStringWith:(NSString *)content font:(float)font width:(CGFloat)width{
    
    CGSize titleSize = [content boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:Font(font)} context:nil].size;
    return titleSize.height;
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
    contractDetailsCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    if (cell == nil) {
        cell = [[contractDetailsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
    }
    self.characterLengthStr = self.rightMutArr[indexPath.section][indexPath.row];
    [cell setIndexPath:indexPath leftName:self.leftArr rightName:self.rightMutArr];
    
    return cell;
}

-(void)setNav{
    UIView * topView = [ViewTools createGradientLayerNav_BarViewWithString:@"合约详情"];
    [self.view addSubview:topView];
    
    UIButton *returnTopBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [returnTopBtn setImage:[UIImage imageNamed:@"leftArrow"] forState:UIControlStateNormal];
    [returnTopBtn sizeToFit];
    returnTopBtn.expandHitEdgeInsets = UIEdgeInsetsMake(15, 15, 15, 15);
    [returnTopBtn addTarget:self action:@selector(returnTopVC) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:returnTopBtn];
    [returnTopBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(12);
        make.bottom.mas_offset(kNavControlImgBottom);
    }];
}
-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kNavHeight, SCREEN_WIDTH, SCREEN_HEIGHT - kNavHeight) style:UITableViewStyleGrouped];
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

-(void)returnTopVC {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
