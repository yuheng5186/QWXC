//
//  QWMeViewController.m
//  QWCarWashing
//
//  Created by apple on 2017/8/14.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "QWMeViewController.h"
#import "QWPersonHeaderTableViewCell.h"
#import "QWOrderTableViewCell.h"
#import "MenuIconCell.h"
#import "QWcollectionViewController.h"
#import "QWorderMenuViewController.h"
#import "QWExchangeViewController.h"
#import "QWPersonInfoDetailViewController.h"
#import "QWViptequanViewController.h"
#import "QWMyCarController.h"
#import "TYAlertController.h"
#import "ShareView.h"
#import "UIView+TYAlertView.h"
#import "TYAlertController+BlurEffects.h"

#import "QWSettingController.h"
#import "PopupView.h"
#import "LewPopupViewAnimationDrop.h"

#import "QWCardPackgeController.h"
#import "QWScoreController.h"

@interface QWMeViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(strong,nonatomic)UITableView*tableview;

@end

#define QWCellIdentifier_PersonHeaderTableViewCell @"QWPersonHeaderTableViewCell"

static NSString *cellstr=@"cell";

@implementation QWMeViewController

-(UITableView *)tableview{
    if (_tableview==nil) {
        _tableview=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, QWScreenWidth, QWScreenheight)];
        _tableview.backgroundColor = kColorTableBG;
        [_tableview registerClass:[UITableViewCell class] forCellReuseIdentifier:cellstr];
        [_tableview registerClass:[QWPersonHeaderTableViewCell class] forCellReuseIdentifier:QWCellIdentifier_PersonHeaderTableViewCell];
        [_tableview registerClass:[QWOrderTableViewCell class] forCellReuseIdentifier:kCellIdentifier_QWOrderTableViewCell];
        [_tableview registerClass:[MenuIconCell class] forCellReuseIdentifier:kCellIdentifier_MenuIconCell];
        
        _tableview.delegate=self;
        _tableview.dataSource=self;
//        _tableview.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
        _tableview.tableFooterView  = [UIView new];
        _tableview.tableHeaderView  = [UIView new];
    }
    return _tableview;
}
-(void)viewWillAppear:(BOOL)animated{
    
     self.tabBarController.tabBar.hidden=NO;
    
}
- (void)viewDidLoad {
   
    [super viewDidLoad];
    [self setNagationLeftAndRightButton];
    [self.view addSubview:self.tableview];
}
#pragma mark-设置导航栏左右按钮
-(void)setNagationLeftAndRightButton{
    //右边试图
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"shezhi"] scaledToSize:CGSizeMake(48, 48)] style:(UIBarButtonItemStyleDone) target:self action:@selector(shezOnclick:)];

}
-(void)shezOnclick:(id)sender{

    QWSettingController   *settingController    = [[QWSettingController alloc]init];
    settingController.hidesBottomBarWhenPushed  = YES;
    [self.navigationController pushViewController:settingController animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
#pragma mark-UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==3) {
        return 2;
    }else{
         return 1;
    }
   

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        QWPersonHeaderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:QWCellIdentifier_PersonHeaderTableViewCell forIndexPath:indexPath];
        
//            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (!cell) {
            cell = [[QWPersonHeaderTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:QWCellIdentifier_PersonHeaderTableViewCell];
        }
        cell.backgroundColor=[UIColor clearColor];;
        cell.contentView.backgroundColor=[UIColor clearColor];
         QWPersonInfoDetailViewController *personInfo=[[QWPersonInfoDetailViewController alloc]init];
        cell.ImageClicked=^(void){
            [self.navigationController pushViewController:personInfo animated:YES];
       
        };
#pragma madrk-会员特权
        cell.vipClicked=^(void){
            QWViptequanViewController *Viptequan=[[QWViptequanViewController alloc]init];
            [self.navigationController pushViewController:Viptequan animated:YES];
        
        };
        

        
        cell.qiandaoClicked=^(void){
            
            PopupView *view = [PopupView defaultPopupView];
            view.parentVC   = self;
            [self lew_presentPopupView:view animation:[LewPopupViewAnimationDrop new] dismissed:^{
                
            }];
        
        };
        return cell;

    }else if (indexPath.section==1){
        QWOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier_QWOrderTableViewCell forIndexPath:indexPath];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        QWorderMenuViewController *menuorder=[[QWorderMenuViewController alloc]init];
        cell.oneClicked = ^(void){
             menuorder.hidesBottomBarWhenPushed     = YES;
            [self.navigationController pushViewController:menuorder animated:YES];
        };
        QWcollectionViewController *collectionViectl=[[QWcollectionViewController alloc]init];
        cell.twoClicked = ^(void){
           collectionViectl.hidesBottomBarWhenPushed     = YES;
            [self.navigationController pushViewController:collectionViectl animated:YES];
        };
        QWExchangeViewController *ExchangeViectl=[[QWExchangeViewController alloc]init];
        cell.threeClicked = ^(void){
            ExchangeViectl.hidesBottomBarWhenPushed     = YES;
            [self.navigationController pushViewController:ExchangeViectl animated:YES];
        };
        return cell;
    } else if (indexPath.section==2){
        MenuIconCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier_MenuIconCell forIndexPath:indexPath];
        
        [cell setTitle:@"蔷薇会员" icon:@"huiyuanchequan" detailtitle:@"200积分" ];
        return cell;

    }else if(indexPath.section == 3){
        MenuIconCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier_MenuIconCell forIndexPath:indexPath];
        
        if (indexPath.row == 0) {
            [cell setTitle:@"我的爱车" icon:@"wode-aiche" detailtitle:@""];
            
        }else if (indexPath.row ==1){
            [cell setTitle:@"我的卡卷" icon:@"wwode-kaquan" detailtitle:@""];
        }
        return cell;
    }else{
        MenuIconCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier_MenuIconCell forIndexPath:indexPath];
        
        [cell setTitle:@"推荐蔷薇APP" icon:@"tuijianAPP" detailtitle:@""];
        return cell;
    }

}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        return 110;
    }else if (indexPath.section==1) {
        return [QWOrderTableViewCell cellHeight];
    }else{
        return [MenuIconCell cellHeight];

    }

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 3) {
        
        if (indexPath.row == 0) {
            QWMyCarController   *myCar      = [[QWMyCarController alloc]init];
            myCar.hidesBottomBarWhenPushed  = YES;
            [self.navigationController pushViewController:myCar animated:YES];
        }else
        {
            QWCardPackgeController  *cardPackgeController   = [[QWCardPackgeController alloc]init];
            cardPackgeController.hidesBottomBarWhenPushed   = YES;
            [self.navigationController pushViewController:cardPackgeController animated:YES];
            
        }
        
    }else if(indexPath.section==2){
        QWScoreController *scoreCtl=[[QWScoreController alloc]init];
        scoreCtl.hidesBottomBarWhenPushed  = YES;
        [self.navigationController pushViewController:scoreCtl animated:YES];
        
        
        
    }
    
    if (indexPath.section == 4) {
        ShareView *shareView = [ShareView createViewFromNib];
        TYAlertController *alertController = [TYAlertController alertControllerWithAlertView:shareView preferredStyle:TYAlertControllerStyleAlert];
        
        [alertController setBlurEffectWithView:self.view];
        //[alertController setBlurEffectWithView:(UIView *)view style:(BlurEffectStyle)blurStyle];
        [self presentViewController:alertController animated:YES completion:nil];
    }
    
}


#pragma mark-添加表头
//通过委托方法设置表头高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
        return 10;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
   
        return 0;
  

}
@end
