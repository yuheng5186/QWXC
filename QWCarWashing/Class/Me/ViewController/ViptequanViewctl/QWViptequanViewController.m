//
//  QWViptequanViewController.m
//  QWCarWashing
//
//  Created by apple on 2017/8/15.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "QWViptequanViewController.h"
#import "QWVipHeaderTableViewCell.h"
#import "QWVipSecondTableViewCell.h"
#import "QWwashCardTableViewCell.h"
#import "QWHowToUpGradeController.h"

#import "QWMemberRightsDetailController.h"

#import "QWCardConfigGradeModel.h"

@interface QWViptequanViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    MBProgressHUD *HUD;
}
@property(strong,nonatomic)UITableView*tableview;
@property (nonatomic, strong) NSMutableArray *MembershipprivilegesArray;
@property (nonatomic, strong) NSMutableDictionary *MembershipprivilegesDic;
@property (nonatomic, strong) NSMutableArray *NextMembershipprivilegesArr;
@property (nonatomic, strong) NSMutableArray *CurrentMembershipprivilegesArr;
@property (nonatomic, strong) NSString *area;
@property (nonatomic, strong)UIButton *gradeBtns;

@end

#define QWCellIdentifier_VipHeaderTableViewCell @"QWVipHeaderTableViewCell"
#define QWCellIdentifier_VipSecondTableViewCell @"QWVipSecondTableViewCell"
#define QWCellIdentifier_washCardTableViewCell @"QWwashCardTableViewCell"

@implementation QWViptequanViewController

-(UITableView *)tableview{
    if (_tableview==nil) {
        _tableview=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, QWScreenWidth, QWScreenheight)];
        _tableview.backgroundColor = kColorTableBG;
        //        [_tableview registerClass:[UITableViewCell class] forCellReuseIdentifier:cellstr];
        //        [_tableview registerClass:[QWPersonHeaderTableViewCell class] forCellReuseIdentifier:QWCellIdentifier_PersonHeaderTableViewCell];
        //        [_tableview registerClass:[QWOrderTableViewCell class] forCellReuseIdentifier:kCellIdentifier_QWOrderTableViewCell];
        //        QWCellIdentifier_PersonHeaderTableViewCell
         [_tableview registerNib:[UINib nibWithNibName:@"QWwashCardTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:QWCellIdentifier_washCardTableViewCell];
        [_tableview registerNib:[UINib nibWithNibName:@"QWVipHeaderTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:QWCellIdentifier_VipHeaderTableViewCell];
        [_tableview registerClass:[QWVipSecondTableViewCell class] forCellReuseIdentifier:QWCellIdentifier_VipSecondTableViewCell];
        _tableview.delegate=self;
        _tableview.dataSource=self;
        _tableview.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
        
    }
    return _tableview;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"会员特权";
    [self resetBabkButton];

    [self.view addSubview:self.tableview];
    //底部
    CGFloat _tabbarheight=self.tabBarController.tabBar.frame.size.height;
    
    UIView *containView = [[UIView alloc] initWithFrame:CGRectMake(0, QWScreenheight-_tabbarheight, QWScreenWidth, _tabbarheight)];
    containView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:containView];
    
    UIButton *gradeBtn = [[UIButton alloc] init];
    [gradeBtn setTitle:@"如何升级到黄金会员" forState:UIControlStateNormal];
    [gradeBtn setTitleColor:[UIColor colorFromHex:@"#4a4a4a"] forState:UIControlStateNormal];
    //    [containView mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.top.equalTo(self.exchangListView.mas_bottom);
    //        make.bottom.left.right.equalTo(self.view);
    //        make.height.mas_equalTo(49*Main_Screen_Height/667);
    //    }];
    gradeBtn.titleLabel.font = [UIFont systemFontOfSize:15*Main_Screen_Height/667];
    [gradeBtn setImage:[UIImage imageNamed:@"qw_shengji"] forState:UIControlStateNormal];
    self.gradeBtns=gradeBtn;
    [containView addSubview:gradeBtn];
    [gradeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(containView);
        make.height.mas_equalTo(40*Main_Screen_Height/667);
        make.width.mas_equalTo(250*Main_Screen_Height/667);
    }];
    
    gradeBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    [gradeBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
    
    
    [gradeBtn addTarget:self action:@selector(clickHowToIncreaseGradeBtn) forControlEvents:UIControlEventTouchUpInside];
    NSNotificationCenter * center = [NSNotificationCenter defaultCenter];
    //    [center addObserver:self selector:@selector(noticeupdateCardNum:) name:@"receivesuccess" object:nil];
    [center addObserver:self selector:@selector(noticeupdate:) name:@"Earnsuccess" object:nil];
    self.area = @"上海市";
    _MembershipprivilegesArray = [[NSMutableArray alloc]init];
    _NextMembershipprivilegesArr = [[NSMutableArray alloc]init];
    _CurrentMembershipprivilegesArr = [[NSMutableArray alloc]init];

    HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HUD.removeFromSuperViewOnHide =YES;
    HUD.mode = MBProgressHUDModeIndeterminate;
    HUD.labelText = @"加载中";
    HUD.minSize = CGSizeMake(132.f, 108.0f);
    [self GetMembershipprivileges];
    
}
-(void)noticeupdate:(NSNotification *)sender{
    [self GetMembershipprivileges];
}
#pragma mark-等级特权查询
-(void)GetMembershipprivileges
{
    NSDictionary *mulDic = @{
                             @"Account_Id":[UdStorage getObjectforKey:Userid],
                             @"GetCardType":@3,
                             
                             };
       [AFNetworkingTool post:mulDic andurl:[NSString stringWithFormat:@"%@Card/GetCardConfigList",Khttp] success:^(NSDictionary *dict, BOOL success) {
           NSLog(@"等级特权查：%@",dict);
        if([[dict objectForKey:@"ResultCode"] isEqualToString:[NSString stringWithFormat:@"%@",@"F000000"]])
        {
            _MembershipprivilegesDic = [dict objectForKey:@"JsonData"];
            
            
            NSArray * arr = [_MembershipprivilegesDic objectForKey:@"cardConfigList"];
            
            for(NSDictionary *dic in arr)
            {
                QWCardConfigGradeModel *tempmodel=[[QWCardConfigGradeModel alloc]initWithDictionary:dic error:nil];
                
                if(tempmodel.CurrentOrNextLevel == 1)
                {
                    [_CurrentMembershipprivilegesArr addObject:tempmodel];
                }
                else
                {
                    [_NextMembershipprivilegesArr addObject:tempmodel];
                }
            }
           
            
            APPDELEGATE.currentUser.UserScore = [_MembershipprivilegesDic objectForKey:@"UserScore"];
//            if (!IsNullIsNull([_MembershipprivilegesDic objectForKey:@"UserScore"])) {
                 [UdStorage storageObject: [_MembershipprivilegesDic objectForKey:@"UserScore"] forKey:UserScores];
//            }
//            if (!IsNullIsNull([_MembershipprivilegesDic objectForKey:@"Headimg"])) {
//                [UdStorage storageObject: [_MembershipprivilegesDic objectForKey:@"Headimg"] forKey:UserScores];
//            }
//            [UdStorage storageObject: [_MembershipprivilegesDic objectForKey:@"Headimg"] forKey:UserHead];
            [self.tableview reloadData];
            
            
            [HUD setHidden:YES];
            
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
- (void)clickHowToIncreaseGradeBtn {
    
    NSArray *arr2 = @[@"",@"普通会员",@"白银会员",@"黄金会员",@"铂金会员",@"钻石会员",@"黑钻会员"];
    
    NSUInteger num = [[NSString stringWithFormat:@"%@",_MembershipprivilegesDic[@"Level_id"]] integerValue];
    
    NSUInteger num2 = [[NSString stringWithFormat:@"%@",_MembershipprivilegesDic[@"NextLevel"]] integerValue];
    
    
    QWHowToUpGradeController *upGradeVC = [[QWHowToUpGradeController alloc] init];
    upGradeVC.hidesBottomBarWhenPushed = YES;
    
    upGradeVC.currentLevel = arr2[num];
    upGradeVC.nextLevel = arr2[num2];
    upGradeVC.NextLevelScore = [NSString stringWithFormat:@"%@",_MembershipprivilegesDic[@"NextLevelScore"]];
    upGradeVC.CurrentScore = [NSString stringWithFormat:@"%@",_MembershipprivilegesDic[@"UserScore"]];
    
    
    [self.navigationController pushViewController:upGradeVC animated:YES];

    
}
- (void) resetBabkButton {
    
    UIButton *rightButton = [[UIButton alloc]initWithFrame:CGRectMake(0,0,20,20)];
    [rightButton setImage:[UIImage imageNamed:@"icon_titlebar_arrow"] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(backButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    self.navigationItem.leftBarButtonItem= rightItem;
}
- (void) backButtonClick:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UITableViewDataSource
//
//-(CGFloat)tableView:(UITableView*)tableView heightForHeaderInSection:(NSInteger)section
//{
//    return 0.01f;
//}

//去掉组尾的背景色
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footerSection=[UIView new];
    footerSection.backgroundColor=[UIColor clearColor];
    return footerSection;

}
-(CGFloat)tableView:(UITableView*)tableView heightForFooterInSection:(NSInteger)section

{
    return 10.0f;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
 
    switch (section) {
        case 1:
            return [_CurrentMembershipprivilegesArr count];
            break;
            
        case 2:
            return [_NextMembershipprivilegesArr count];
            break;
            
        default:
            return 1;
            break;
    }
  
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 120*Main_Screen_Height/667;
    }else {
        return 70*Main_Screen_Height/667;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section==2||indexPath.section==1)
    {
    
        QWwashCardTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:QWCellIdentifier_washCardTableViewCell];
        if (!cell) {
            cell = [[QWwashCardTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:QWCellIdentifier_washCardTableViewCell];
        }
        cell.backgroundColor    = [UIColor whiteColor];
        cell.accessoryType=UITableViewCellAccessoryNone;
        cell.selectionStyle =  UITableViewCellSelectionStyleNone;

        cell.imageViews.image=[UIImage imageNamed:@"shengjihoukaquan"];
        cell.titlelabel.text=@"10元洗车倦";
        cell.detaillabel.text=@"门店洗车时可抵扣相应金额，每月领取一次";
        if (indexPath.section==2) {
            if (_NextMembershipprivilegesArr.count!=0) {
                cell.cardConfogmodel=_NextMembershipprivilegesArr[indexPath.row];
            }
        }else{
            
            if (_CurrentMembershipprivilegesArr.count!=0) {
                cell.cardConfogmodel=_CurrentMembershipprivilegesArr[indexPath.row];
            }
        
        }
        
        return cell;
    }else
    {
        
        QWVipHeaderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:QWCellIdentifier_VipHeaderTableViewCell forIndexPath:indexPath];
        
        if (!cell) {
            cell = [[QWVipHeaderTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:QWCellIdentifier_VipHeaderTableViewCell];
        }
        cell.backgroundColor    = [UIColor whiteColor];
        cell.accessoryType=UITableViewCellAccessoryNone;
        cell.selectionStyle =  UITableViewCellSelectionStyleNone;
        if([_MembershipprivilegesDic[@"Level_id"] integerValue] == 1)
        {
            cell.username.text = @"普通会员";
            [self.gradeBtns setTitle:@"如何升级到白银会员" forState:UIControlStateNormal];
        }
        else if([_MembershipprivilegesDic[@"Level_id"] integerValue] == 2)
        {
            cell.username.text = @"白银会员";
            [self.gradeBtns setTitle:@"如何升级到黄金会员" forState:UIControlStateNormal];
        }
        else if([_MembershipprivilegesDic[@"Level_id"] integerValue] == 3)
        {
            cell.username.text = @"黄金会员";
            [self.gradeBtns setTitle:@"如何升级到铂金会员" forState:UIControlStateNormal];
        }
        else if([_MembershipprivilegesDic[@"Level_id"] integerValue] == 4)
        {
            cell.username.text = @"铂金会员";
            [self.gradeBtns setTitle:@"如何升级到钻石会员" forState:UIControlStateNormal];
        }
        else if([_MembershipprivilegesDic[@"Level_id"] integerValue] == 5)
        {
            cell.username.text = @"钻石会员";
            [self.gradeBtns setTitle:@"如何升级到黑钻会员" forState:UIControlStateNormal];
        }
        else if([_MembershipprivilegesDic[@"Level_id"] integerValue] == 6)
        {
            cell.username.text = @"黑钻会员";
            [self.gradeBtns setTitle:@"您已经是黑钻会员" forState:UIControlStateNormal];
        }
        cell.headerimage.contentMode=UIViewContentModeScaleAspectFill;
        
        cell.headerimage.layer.cornerRadius = cell.headerimage.bounds.size.width/2;
        cell.headerimage.clipsToBounds=YES;
        return cell;
    }
    //        else {
    //
    //        QWVipSecondTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:QWCellIdentifier_VipSecondTableViewCell forIndexPath:indexPath];
    //
    //        if (!cell) {
    //            cell = [[QWVipSecondTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:QWCellIdentifier_VipSecondTableViewCell];
    //        }
    //        cell.accessoryType=UITableViewCellAccessoryNone;
    //        cell.backgroundColor    = [UIColor whiteColor];
    //               return cell;
    //    }
    
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    
    
    UIView *headerview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, QWScreenWidth, 40*Main_Screen_Height/667)];
    if (section==2||section==1) {
        UILabel *lab=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, QWScreenWidth, 39*Main_Screen_Height/667)];
        lab.backgroundColor=[UIColor whiteColor];
        lab.font=[UIFont systemFontOfSize:16*Main_Screen_Height/667];
        lab.textColor = [UIColor colorFromHex:@"#3a3a3a"];
        if (section==1) {
            lab.text=@"   我的特权";
        }else{
            lab.text=@"   升级后可获得特权";
        
        }
        
        [headerview addSubview:lab];
        return headerview;
    }else{
        return headerview;
    }
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==2||section==1) {
        return 40*Main_Screen_Height/667;
    }else{
        return 0;
    }
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
   
    
    if (indexPath.section != 0) {
        
        QWMemberRightsDetailController      *VC  = [[QWMemberRightsDetailController alloc]init];
         VC.hidesBottomBarWhenPushed = YES;
        
        if(indexPath.section == 1)
        {
            QWCardConfigGradeModel *model=_CurrentMembershipprivilegesArr[indexPath.row];
            VC.ConfigCode = [NSString stringWithFormat:@"%ld",model.ConfigCode];
            VC.nextUseLevel = [NSString stringWithFormat:@"%ld",model.CurrentOrNextLevel];
            
        }
        else
        {
             QWCardConfigGradeModel *model=_NextMembershipprivilegesArr[indexPath.row];
            VC.ConfigCode =[NSString stringWithFormat:@"%ld",model.ConfigCode];
            VC.nextUseLevel =[NSString stringWithFormat:@"%ld",model.UseLevel] ;
            VC.card = [_NextMembershipprivilegesArr objectAtIndex:indexPath.row];
        }
        VC.currentUseLevel =_MembershipprivilegesDic[@"Level_id"];
        [self.navigationController pushViewController:VC animated:YES];
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
