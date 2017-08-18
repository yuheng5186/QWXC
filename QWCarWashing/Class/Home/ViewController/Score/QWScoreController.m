//
//  QWScoreController.m
//  QWCarWashing
//
//  Created by Wuxinglin on 2017/8/16.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "QWScoreController.h"
#import "QWEarnScoreController.h"
#import "GoodsExchangeCell.h"
#import "MemberView.h"
#import "QWMembershipController.h"

#import "QWHowToUpGradeController.h"
#import "QWWashCarTicketController.h"
#import "QWScoreDetailController.h"

@interface QWScoreController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak) UITableView *exchangListView;

@end

static NSString *id_exchangeCell = @"id_exchangeCell";


@implementation QWScoreController

- (UITableView *)exchangListView {
    
    if (!_exchangListView) {
        
        UITableView *exchangeListView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _exchangListView = exchangeListView;
        [self.view addSubview:_exchangListView];
    }
    
    return _exchangListView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title  = @"蔷薇会员";
    self.view.backgroundColor   = [UIColor whiteColor];

    [self setupUI];
    
}
- (void)setupUI {
    
    MemberView *memberShipView = [MemberView memberView];
    memberShipView.frame = CGRectMake(0, 64, Main_Screen_Width, 113);
    [self.view addSubview:memberShipView];
    
    UIView *exchangeView = [[UIView alloc] init];
    
    [self.view addSubview:exchangeView];
    
    UILabel *exchangeLabel = [[UILabel alloc] init];
    exchangeLabel.text = @"精品兑换";
    exchangeLabel.font = [UIFont systemFontOfSize:14];
    exchangeLabel.textColor = [UIColor colorFromHex:@"#4a4a4a"];
    [exchangeView addSubview:exchangeLabel];
    
    //    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    //    UICollectionView *goodsView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    //    goodsView.backgroundColor = [UIColor whiteColor];
    //    [self.view addSubview:goodsView];
    //
    self.exchangListView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.exchangListView.delegate = self;
    self.exchangListView.dataSource = self;
    self.exchangListView.rowHeight = 90;
    self.exchangListView.backgroundColor = [UIColor whiteColor];
    
    [self.exchangListView registerClass:[GoodsExchangeCell class] forCellReuseIdentifier:id_exchangeCell];
    
    //约束
    [exchangeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(memberShipView.mas_bottom).mas_offset(10);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(40);
    }];
    
    [exchangeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(exchangeView);
    }];
    
    //    [goodsView mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.top.equalTo(exchangeView.mas_bottom);
    //        make.left.right.bottom.equalTo(self.view);
    //    }];
    //
    //    goodsView.delegate = self;
    //    goodsView.dataSource = self;
    //
    //    [goodsView registerClass:[GoodsViewCell class] forCellWithReuseIdentifier:id_goodsCell];
    
    [_exchangListView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(exchangeView.mas_bottom);
        make.bottom.equalTo(self.view);
        make.left.equalTo(self.view).mas_equalTo(10);
        make.right.equalTo(self.view).mas_equalTo(-10);
    }];
    
}




#pragma mark - 点击赚积分
- (IBAction)clickEarnScoreBtn:(UIButton *)sender {
    
    QWEarnScoreController *earnScoreVC    = [[QWEarnScoreController alloc] init];
    earnScoreVC.hidesBottomBarWhenPushed  = YES;
    [self.navigationController pushViewController:earnScoreVC animated:YES];
}

#pragma mark - 点击升级
- (IBAction)clickUpgradeBtn:(UIButton *)sender {
    
    QWHowToUpGradeController *upGradeVC = [[QWHowToUpGradeController alloc] init];
    upGradeVC.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:upGradeVC animated:YES];
    
}


#pragma mark - 点击会员按钮
- (IBAction)clickMemberButton:(UIButton *)sender {
    
    QWMembershipController *rightsController = [[QWMembershipController alloc] init];
    rightsController.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:rightsController animated:YES];
    
}

#pragma mark - 点击积分数值按钮
- (IBAction)clickMemberScoreBtn:(UIButton *)sender {
    
    QWScoreDetailController *scoreVC = [[QWScoreDetailController alloc] init];
    scoreVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:scoreVC animated:YES];
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 3;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GoodsExchangeCell *changeCell = [tableView dequeueReusableCellWithIdentifier:id_exchangeCell forIndexPath:indexPath];
    
    
    
    
    return changeCell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    QWWashCarTicketController *ticketVC = [[QWWashCarTicketController alloc] init];
    ticketVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:ticketVC animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 10;
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *v = [[UIView alloc] init];
    v.backgroundColor = [UIColor whiteColor];
    
    return v;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
