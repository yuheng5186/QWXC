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
@interface QWViptequanViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(strong,nonatomic)UITableView*tableview;
@end

#define QWCellIdentifier_VipHeaderTableViewCell @"QWVipHeaderTableViewCell"
#define QWCellIdentifier_VipSecondTableViewCell @"QWVipSecondTableViewCell"

@implementation QWViptequanViewController

-(UITableView *)tableview{
    if (_tableview==nil) {
        _tableview=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, QWScreenWidth, QWScreenheight) style:UITableViewStyleGrouped];
        _tableview.backgroundColor = kColorTableBG;
        //        [_tableview registerClass:[UITableViewCell class] forCellReuseIdentifier:cellstr];
        //        [_tableview registerClass:[QWPersonHeaderTableViewCell class] forCellReuseIdentifier:QWCellIdentifier_PersonHeaderTableViewCell];
        //        [_tableview registerClass:[QWOrderTableViewCell class] forCellReuseIdentifier:kCellIdentifier_QWOrderTableViewCell];
        //        QWCellIdentifier_PersonHeaderTableViewCell
        
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
        return 175;
    }else {
        return 125;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section==2||indexPath.section==1)
    {
        static NSString *cellStatic = @"cellStatic";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellStatic];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
        }
        cell.backgroundColor    = [UIColor whiteColor];
        cell.accessoryType=UITableViewCellAccessoryNone;
        cell.imageView.image=[UIImage imageNamed:@"shengjihoukaquan"];
        cell.textLabel.text=@"10元洗车倦";
        cell.detailTextLabel.text=@"门店洗车时可抵扣相应金额，每月领取一次";
        return cell;
    }else
    {
        
        QWVipHeaderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:QWCellIdentifier_VipHeaderTableViewCell forIndexPath:indexPath];
        
        if (!cell) {
            cell = [[QWVipHeaderTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:QWCellIdentifier_VipHeaderTableViewCell];
        }
        cell.backgroundColor    = [UIColor whiteColor];
        cell.accessoryType=UITableViewCellAccessoryNone;
        
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
    
    
    
    UIView *headerview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, QWScreenWidth, 30)];
    if (section==2||section==1) {
        UILabel *lab=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, QWScreenWidth, 29)];
        lab.backgroundColor=[UIColor whiteColor];
        lab.text=@"   我的特权";
        [headerview addSubview:lab];
        return headerview;
    }else{
        return headerview;
    }
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==2||section==1) {
        return 30;
    }else{
        return 0;
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
