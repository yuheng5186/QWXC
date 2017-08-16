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
@interface QWMeViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(strong,nonatomic)UITableView*tableview;
@end
#define QWCellIdentifier_PersonHeaderTableViewCell @"QWPersonHeaderTableViewCell"
static NSString *cellstr=@"cell";
@implementation QWMeViewController
-(UITableView *)tableview{
    if (_tableview==nil) {
        _tableview=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, QWScreenWidth, QWScreenheight) style:UITableViewStyleGrouped];
        _tableview.backgroundColor = kColorTableBG;
        [_tableview registerClass:[UITableViewCell class] forCellReuseIdentifier:cellstr];
        [_tableview registerClass:[QWPersonHeaderTableViewCell class] forCellReuseIdentifier:QWCellIdentifier_PersonHeaderTableViewCell];
        [_tableview registerClass:[QWOrderTableViewCell class] forCellReuseIdentifier:kCellIdentifier_QWOrderTableViewCell];
        [_tableview registerClass:[MenuIconCell class] forCellReuseIdentifier:kCellIdentifier_MenuIconCell];
        
        _tableview.delegate=self;
        _tableview.dataSource=self;
        _tableview.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
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
        QWPersonHeaderTableViewCell *cell =[[QWPersonHeaderTableViewCell alloc]initWithFrame:CGRectMake(10, 10, QWScreenWidth-20, 90)];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (!cell) {
            cell = [[QWPersonHeaderTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:QWCellIdentifier_PersonHeaderTableViewCell];
        }
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
        
        };
        return cell;

    }else if (indexPath.section==1){
        QWOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier_QWOrderTableViewCell forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        QWorderMenuViewController *menuorder=[[QWorderMenuViewController alloc]init];
        cell.oneClicked = ^(void){
            [self.navigationController pushViewController:menuorder animated:YES];
        };
        QWcollectionViewController *collectionViectl=[[QWcollectionViewController alloc]init];
        cell.twoClicked = ^(void){
           
            [self.navigationController pushViewController:collectionViectl animated:YES];
        };
        QWExchangeViewController *ExchangeViectl=[[QWExchangeViewController alloc]init];
        cell.threeClicked = ^(void){
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
#pragma mark-添加表头
//通过委托方法设置表头高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(section==0){
        return 0;
    }else{
        return 5;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if(section==0){
        return 0;
    }else{
        return 0;
    }

}
@end
