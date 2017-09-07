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
#import "QWViptequanViewController.h"
#import "QWHowToUpGradeController.h"
#import "QWWashCarTicketController.h"
#import "QWScoreDetailController.h"
#import "QWScoreheaderTableViewCell.h"
#import "QWCardConfigGradeModel.h"
@interface QWScoreController ()<UITableViewDelegate,UITableViewDataSource>
{
  MBProgressHUD *HUD;

}
@property (nonatomic, strong) UITableView *exchangListView;
@property (nonatomic, strong) NSMutableDictionary *MembershipUserScore;
@property (nonatomic, strong) NSMutableArray *MembershipUserScoreArray;
@end

static NSString *id_exchangeCell = @"id_exchangeCell";
#define QWCellIdentifier_ScoreheaderTableViewCell @"QWScoreheaderTableViewCell"

@implementation QWScoreController

- (UITableView *)exchangListView {
    
    if (!_exchangListView) {
        
        _exchangListView = [[UITableView alloc] initWithFrame:CGRectMake(0, -64, QWScreenWidth, QWScreenheight+64)];

        _exchangListView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _exchangListView.delegate = self;
        _exchangListView.dataSource = self;
        
        _exchangListView.backgroundColor = kColorTableBG;

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
    
    NSNotificationCenter * center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(noticeupdate:) name:@"updatenamesuccess" object:nil];
    [center addObserver:self selector:@selector(noticeupdate:) name:@"updateheadimgsuccess" object:nil];
    [center addObserver:self selector:@selector(noticeupdate:) name:@"updatecard" object:nil];
    [center addObserver:self selector:@selector(noticeupdate:) name:@"Earnsuccess" object:nil];
    self.title  = @"金顶会员";
    self.view.backgroundColor   = [UIColor whiteColor];
    
    
    [self.view addSubview:self.exchangListView];
 
    HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HUD.removeFromSuperViewOnHide =YES;
    HUD.mode = MBProgressHUDModeIndeterminate;
    HUD.labelText = @"加载中";
    HUD.minSize = CGSizeMake(132.f, 108.0f);
    _MembershipUserScore = [[NSMutableDictionary alloc]init];
    _MembershipUserScoreArray = [[NSMutableArray alloc]init];
    [self GetMembershipUserScore];



}
-(void)noticeupdate:(NSNotification *)sender{
    
    
    [self GetMembershipUserScore];
}
//#pragma mark-积分规则
//-(void)ScoreRuleOnclick:(id)sender{
//    
//
//}
#pragma mark-获取会员领取,积分兑换列表
-(void)GetMembershipUserScore
{
    NSDictionary *mulDic = @{
                             @"Account_Id":[UdStorage getObjectforKey:@"Account_Id"],
                             @"GetCardType":@5,
                             
                             };
    
    [AFNetworkingTool post:mulDic andurl:[NSString stringWithFormat:@"%@Card/GetCardConfigList",Khttp] success:^(NSDictionary *dict, BOOL success) {
        
        if([[dict objectForKey:@"ResultCode"] isEqualToString:[NSString stringWithFormat:@"%@",@"F000000"]])
        {
            _MembershipUserScore = [dict objectForKey:@"JsonData"];
            
            
            NSArray * arr = [_MembershipUserScore objectForKey:@"cardConfigList"];
            
            for(NSDictionary *dic in arr)
            {
                QWCardConfigGradeModel *card = [[QWCardConfigGradeModel alloc]initWithDictionary:dic error:nil];
               
                [_MembershipUserScoreArray addObject:card];
            }
            

            
           
            
            [_exchangListView reloadData];
            
            [HUD setHidden:YES];
            
            
            
            APPDELEGATE.currentUser.UserScore = [NSString stringWithFormat:@"%@",_MembershipUserScore[@"UserScore"]] ;
            
            [UdStorage storageObject:[_MembershipUserScore objectForKey:@"UserScore"] forKey:UserScores];
            
        }
        else
        {
            [self.view showInfo:@"信息获取失败" autoHidden:YES interval:2];
            [self.navigationController popViewControllerAnimated:YES];
        }
    } fail:^(NSError *error) {
        [self.view showInfo:@"获取失败" autoHidden:YES interval:2];
        [self.navigationController popViewControllerAnimated:YES];
        
    }];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    //设置导航栏背景图片为一个空的image，这样就透明了
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    
    //去掉透明后导航栏下边的黑边
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"ijanbiantiao"] forBarMetrics:0];
        [self.navigationController.navigationBar setShadowImage:nil];
    
}





- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 2;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section==1) {
        return _MembershipUserScoreArray.count;
    }else{
        return 1;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    if (indexPath.section==0) {
        QWScoreheaderTableViewCell *scoreheadercell=[tableView dequeueReusableCellWithIdentifier:QWCellIdentifier_ScoreheaderTableViewCell forIndexPath:indexPath];
        scoreheadercell.contentViews.bounds=CGRectMake(0, 0, QWScreenWidth, 230*Main_Screen_Height/667);
        scoreheadercell.selectionStyle = UITableViewCellSelectionStyleNone;
        [scoreheadercell.vipType addTarget:self action:@selector(clickMemberButton:) forControlEvents:BtnTouchUpInside];
        [scoreheadercell.goUpGrade addTarget:self action:@selector(clickUpgradeBtn:) forControlEvents:BtnTouchUpInside];
        [scoreheadercell.ScoreNum addTarget:self action:@selector(clickMemberScoreBtn:) forControlEvents:BtnTouchUpInside];
        [scoreheadercell.AddScore addTarget:self action:@selector(clickEarnScoreBtn:) forControlEvents:BtnTouchUpInside];
        if (_MembershipUserScore.count!=0) {
            NSArray *arr2 = @[@"",@"普通会员",@"白银会员",@"黄金会员",@"铂金会员",@"钻石会员",@"黑钻会员"];
            
            NSUInteger num = [[NSString stringWithFormat:@"%@",_MembershipUserScore[@"Level_id"]] integerValue];
            
            
            
            [scoreheadercell.vipType setTitle:[arr2 objectAtIndex:num] forState:UIControlStateNormal];
            [scoreheadercell.headerImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kHTTPImg,_MembershipUserScore[@"Headimg"]]] placeholderImage:[UIImage imageNamed:@"huiyuantou"]];
//            scoreheadercell.phoneNum.text = [NSString stringWithFormat:@"%@",_MembershipUserScore[@"Name"]];
            [scoreheadercell.ScoreNum setTitle:[NSString stringWithFormat:@"%@分",_MembershipUserScore[@"UserScore"]] forState:UIControlStateNormal];
        }
        scoreheadercell.headerImage.layer.cornerRadius =  scoreheadercell.headerImage.bounds.size.width/2;
         scoreheadercell.headerImage.clipsToBounds=YES;
        return scoreheadercell;
    }else{
         GoodsExchangeCell *changeCell = [tableView dequeueReusableCellWithIdentifier:id_exchangeCell forIndexPath:indexPath];
       changeCell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (_MembershipUserScoreArray.count!=0) {
            changeCell.cardconfig=_MembershipUserScoreArray[indexPath.row];
        }
        return changeCell;
    
    }
    
}




-(void)back{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"ijanbiantiao"] forBarMetrics:0];
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - 点击赚积分
- (void)clickEarnScoreBtn:(UIButton *)sender {
       QWEarnScoreController *earnScoreVC    = [[QWEarnScoreController alloc] init];
    earnScoreVC.hidesBottomBarWhenPushed  = YES;
     earnScoreVC.CurrentScore = [NSString stringWithFormat:@"%@",_MembershipUserScore[@"UserScore"]];
[self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"ijanbiantiao"] forBarMetrics:0];
    [self.navigationController pushViewController:earnScoreVC animated:YES];
}
//
#pragma mark - 点击升级
- (void)clickUpgradeBtn:(UIButton *)sender {
    
    
    NSArray *arr2 = @[@"",@"普通会员",@"白银会员",@"黄金会员",@"铂金会员",@"钻石会员",@"黑钻会员"];
    
    NSUInteger num = [[NSString stringWithFormat:@"%@",_MembershipUserScore[@"Level_id"]] integerValue];
    
    NSUInteger num2 = [[NSString stringWithFormat:@"%@",_MembershipUserScore[@"NextLevel"]] integerValue];
    
    
    QWHowToUpGradeController *upGradeVC = [[QWHowToUpGradeController alloc] init];
    upGradeVC.hidesBottomBarWhenPushed = YES;
    
    upGradeVC.currentLevel = arr2[num];
    upGradeVC.nextLevel = arr2[num2];
    upGradeVC.NextLevelScore = [NSString stringWithFormat:@"%@",_MembershipUserScore[@"NextLevelScore"]];
    upGradeVC.CurrentScore = [NSString stringWithFormat:@"%@",_MembershipUserScore[@"UserScore"]];
    
    
    [self.navigationController pushViewController:upGradeVC animated:YES];
    

   

}
//
//
#pragma mark - 点击会员按钮
- (void)clickMemberButton:(UIButton *)sender {

    QWViptequanViewController *vipvc=[[QWViptequanViewController alloc]init];
    
    
//    QWMembershipController *rightsController = [[QWMembershipController alloc] init];
//    rightsController.hidesBottomBarWhenPushed = YES;
    vipvc.hidesBottomBarWhenPushed = YES;
[self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"ijanbiantiao"] forBarMetrics:0];
    [self.navigationController pushViewController:vipvc animated:YES];

}
//
#pragma mark - 点击积分数值按钮
- (void)clickMemberScoreBtn:(UIButton *)sender {

    QWScoreDetailController *scoreVC = [[QWScoreDetailController alloc] init];
    scoreVC.CurrentScore=[NSString stringWithFormat:@"%@",_MembershipUserScore[@"UserScore"]];
    scoreVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"ijanbiantiao"] forBarMetrics:0];
    [self.navigationController pushViewController:scoreVC animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        return  230*Main_Screen_Height/667;
    }else{
        return 192*Main_Screen_Height/667;
    }

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section>0) {
        QWCardConfigGradeModel *newcard = (QWCardConfigGradeModel *)[_MembershipUserScoreArray objectAtIndex:indexPath.row];
        QWWashCarTicketController *ticketVC = [[QWWashCarTicketController alloc] init];
        ticketVC.card = newcard;
        ticketVC.CurrentScore = [NSString stringWithFormat:@"%@",_MembershipUserScore[@"UserScore"]];
        ticketVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:ticketVC animated:YES];
    }
    
   
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section==1) {
        return 35*Main_Screen_Height/667;
    }else{
        return 0;
    
    }
    
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section==0) {
        return 10*Main_Screen_Height/667;
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
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, QWScreenWidth, 35*Main_Screen_Height/667)];
    v.backgroundColor =RGBACOLOR(246, 246, 246, 1);
//     /RGBACOLOR(246, 246, 246, 1);
    if (section==1) {
        UILabel *exchangeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, QWScreenWidth, 33*Main_Screen_Height/667)];
        exchangeLabel.backgroundColor=[UIColor whiteColor];
        exchangeLabel.textAlignment=NSTextAlignmentCenter;
        exchangeLabel.text = @"精品兑换";
        exchangeLabel.font = [UIFont systemFontOfSize:16*Main_Screen_Height/667];
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
