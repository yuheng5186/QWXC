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
//#import "MemberView.h"
#import "QWMembershipController.h"

#import "QWHowToUpGradeController.h"
#import "QWWashCarTicketController.h"
#import "QWScoreDetailController.h"
#import "QWScoreheaderTableViewCell.h"
@interface QWScoreController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *exchangListView;

@end

static NSString *id_exchangeCell = @"id_exchangeCell";
#define QWCellIdentifier_ScoreheaderTableViewCell @"QWScoreheaderTableViewCell"

@implementation QWScoreController

- (UITableView *)exchangListView {
    
    if (!_exchangListView) {
        
        _exchangListView = [[UITableView alloc] initWithFrame:CGRectMake(0, -64, QWScreenWidth, QWScreenheight)];
        _exchangListView.backgroundColor=[UIColor redColor];
        _exchangListView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _exchangListView.delegate = self;
        _exchangListView.dataSource = self;
        
        _exchangListView.backgroundColor = [UIColor whiteColor];

        [_exchangListView registerNib:[UINib nibWithNibName:@"QWScoreheaderTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:QWCellIdentifier_ScoreheaderTableViewCell];
        [_exchangListView registerClass:[GoodsExchangeCell class] forCellReuseIdentifier:id_exchangeCell];
        
    }
    
    return _exchangListView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *leftButton = [[UIButton alloc]initWithFrame:CGRectMake(0,0,20,20)];
    [leftButton setImage:[UIImage imageNamed:@"baisefanhui"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem= leftItem;
    // Do any additional setup after loading the view.
    self.title  = @"蔷薇会员";
    self.view.backgroundColor   = [UIColor whiteColor];
   

    [self.view addSubview:self.exchangListView];

    
}

-(void)viewWillAppear:(BOOL)animated
{
    //设置导航栏背景图片为一个空的image，这样就透明了
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    
    //去掉透明后导航栏下边的黑边
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    
}





- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 2;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section==1) {
        return 2;
    }else{
        return 1;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    if (indexPath.section==0) {
        QWScoreheaderTableViewCell *scoreheadercell=[tableView dequeueReusableCellWithIdentifier:QWCellIdentifier_ScoreheaderTableViewCell forIndexPath:indexPath];
        [scoreheadercell.vipType addTarget:self action:@selector(clickMemberButton:) forControlEvents:BtnTouchUpInside];
        
//        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 40, QWScreenWidth/2, 60)];
//        btn.backgroundColor=[UIColor redColor];
//        [btn addTarget:self action:@selector(aa:) forControlEvents:BtnTouchUpInside];
//        scoreheadercell.bgImage.userInteractionEnabled = YES;
//        [scoreheadercell.bgImage addSubview:btn];
//
//        scoreheadercell.viptypeonclick=^(UIButton *btn){
//            [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"ijanbiantiao"] forBarMetrics:0];
//            QWMembershipController *rightsController = [[QWMembershipController alloc] init];
//                rightsController.hidesBottomBarWhenPushed = YES;
//            
//                [self.navigationController pushViewController:rightsController animated:YES];
//        };
        return scoreheadercell;
    }else{
         GoodsExchangeCell *changeCell = [tableView dequeueReusableCellWithIdentifier:id_exchangeCell forIndexPath:indexPath];
       
        return changeCell;
    
    }
    
    
    
    
    
}
-(void)back{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"ijanbiantiao"] forBarMetrics:0];
    [self.navigationController popViewControllerAnimated:YES];
}
//#pragma mark - 点击赚积分
//- (IBAction)clickEarnScoreBtn:(UIButton *)sender {
//
//    QWEarnScoreController *earnScoreVC    = [[QWEarnScoreController alloc] init];
//    earnScoreVC.hidesBottomBarWhenPushed  = YES;
//    [self.navigationController pushViewController:earnScoreVC animated:YES];
//}
//
//#pragma mark - 点击升级
//- (IBAction)clickUpgradeBtn:(UIButton *)sender {
//
//    QWHowToUpGradeController *upGradeVC = [[QWHowToUpGradeController alloc] init];
//    upGradeVC.hidesBottomBarWhenPushed = YES;
//
//    [self.navigationController pushViewController:upGradeVC animated:YES];
//
//}
//
//
//#pragma mark - 点击会员按钮
- (void)clickMemberButton:(UIButton *)sender {

    QWMembershipController *rightsController = [[QWMembershipController alloc] init];
    rightsController.hidesBottomBarWhenPushed = YES;

    [self.navigationController pushViewController:rightsController animated:YES];

}
//
//#pragma mark - 点击积分数值按钮
//- (IBAction)clickMemberScoreBtn:(UIButton *)sender {
//
//    QWScoreDetailController *scoreVC = [[QWScoreDetailController alloc] init];
//    scoreVC.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:scoreVC animated:YES];
//}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        return  190;
    }else{
        return 130;
    }

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    QWWashCarTicketController *ticketVC = [[QWWashCarTicketController alloc] init];
//    ticketVC.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:ticketVC animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section==1) {
        return 35;
    }else{
        return 0;
    
    }
    
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section==0) {
        return 10;
    }else{
        return 0;
        
    }
   
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section==0) {
        UIView *v = [[UIView alloc] init];
        v.backgroundColor = RGBACOLOR(246, 246, 246, 1);
        
        return v;
    }
    else{
        UIView *v = [[UIView alloc] init];
        v.backgroundColor = [UIColor grayColor];
        
        return v;
        
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, QWScreenWidth, 35)];
    v.backgroundColor =RGBACOLOR(246, 246, 246, 1);
//     /RGBACOLOR(246, 246, 246, 1);
    if (section==1) {
        UILabel *exchangeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, QWScreenWidth, 33)];
        exchangeLabel.backgroundColor=[UIColor whiteColor];
        exchangeLabel.textAlignment=NSTextAlignmentCenter;
        exchangeLabel.text = @"精品兑换";
        exchangeLabel.font = [UIFont systemFontOfSize:12];
        exchangeLabel.textColor = [UIColor colorFromHex:@"#4a4a4a"];
        [v addSubview:exchangeLabel];
        return v;

    }else {
    UIView *v = [[UIView alloc] init];
    v.backgroundColor = [UIColor blueColor];
    
    return v;
    }
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
