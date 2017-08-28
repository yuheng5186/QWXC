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



@interface QWViptequanViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(strong,nonatomic)UITableView*tableview;
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
    [containView addSubview:gradeBtn];
    [gradeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(containView);
        make.height.mas_equalTo(40*Main_Screen_Height/667);
        make.width.mas_equalTo(250*Main_Screen_Height/667);
    }];
    
    gradeBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    [gradeBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
    
    
    [gradeBtn addTarget:self action:@selector(clickHowToIncreaseGradeBtn) forControlEvents:UIControlEventTouchUpInside];
}
- (void)clickHowToIncreaseGradeBtn {
    
    QWHowToUpGradeController *upGradeVC = [[QWHowToUpGradeController alloc] init];
    
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
        case 0:
            return 1;
            break;
        case 1:
            return 1;
            break;
            
        default:
            return 1;
            break;
    }
    return 0;
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 90*Main_Screen_Height/667;
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
    
    
    
    UIView *headerview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, QWScreenWidth, 30*Main_Screen_Height/667)];
    if (section==2||section==1) {
        UILabel *lab=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, QWScreenWidth, 29*Main_Screen_Height/667)];
        lab.backgroundColor=[UIColor whiteColor];
        lab.font=[UIFont systemFontOfSize:14*Main_Screen_Height/667];
        lab.textColor = [UIColor colorFromHex:@"#3a3a3a"];
        lab.text=@"   我的特权";
        [headerview addSubview:lab];
        return headerview;
    }else{
        return headerview;
    }
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==2||section==1) {
        return 30*Main_Screen_Height/667;
    }else{
        return 0;
    }
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    QWMemberRightsDetailController      *rightDetailVC  = [[QWMemberRightsDetailController alloc]init];
    [self.navigationController pushViewController:rightDetailVC animated:YES];
    
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
