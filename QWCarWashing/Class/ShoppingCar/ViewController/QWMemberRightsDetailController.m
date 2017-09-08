//
//  QWMemberRightsDetailController.m
//  QWCarWashing
//
//  Created by Mac WuXinLing on 2017/8/23.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "QWMemberRightsDetailController.h"

#import "QWCardPackgeController.h"
@interface QWMemberRightsDetailController ()<UITableViewDelegate, UITableViewDataSource>
{
    UILabel *cardNameLab;
    UILabel *invalidLab;
    MBProgressHUD *HUD;
}
@property(nonatomic,strong)UITableView *noticeView;
@property(nonatomic,strong)UIButton *getBtn;
//@property (nonatomic, strong) NSMutableDictionary *GradeDetailDic;
@property (nonatomic, strong) NSString *area;
@end

@implementation QWMemberRightsDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title      = @"特权详情";
     [self setupUI];
    self.area = @"上海市";
    if(self.card == nil)
    {
//        self.GradeDetailDic = [[NSMutableDictionary alloc]init];
        
        
        HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        HUD.removeFromSuperViewOnHide =YES;
        HUD.mode = MBProgressHUDModeIndeterminate;
        HUD.labelText = @"加载中";
        HUD.minSize = CGSizeMake(132.f, 108.0f);
        
        
        [self requestCardConfigGradeDetail];
    }
    else
    {
//        self.GradeDetailDic=[[NSMutableDictionary alloc]init];
        
//        self.GradeDetailDic = [[NSMutableDictionary alloc]initWithDictionary:self.nextdic];
        [self UpdateUI];
    }
}
-(void)UpdateUI
{
    cardNameLab.text =self.card.CardName;
//    [_GradeDetailDic objectForKey:@"CardName"];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *datenow = [NSDate date];
    NSDate *newDate = [datenow dateByAddingTimeInterval:60 * 60 * 24 * self.card.ExpiredDay];
    invalidLab.text = [NSString stringWithFormat:@"截止日期:%@",[formatter stringFromDate:newDate]];
    
    NSArray *arr = @[@"",@"普通会员",@"白银会员",@"黄金会员",@"铂金会员",@"钻石会员",@"黑钻会员"];
    if([self.currentUseLevel intValue] < [self.nextUseLevel intValue])
    {
        [self.getBtn setTitle:[NSString stringWithFormat:@"升级到%@可以获取",[arr objectAtIndex:[self.nextUseLevel intValue]]] forState:UIControlStateNormal];
        self.getBtn.enabled = NO;
    }
    else
    {
        if(self.card.CardQuantity != 0)
        {
            
        }
        else
        {
            [self.getBtn setTitle:@"该卡已领取完毕" forState:UIControlStateNormal];
            self.getBtn.enabled = NO;
        }
    }
    
    
    
    
    [_noticeView reloadData];
    
}
-(void)requestCardConfigGradeDetail
{
    NSDictionary *mulDic = @{
                             @"Account_Id":[UdStorage getObjectforKey:@"Account_Id"],
                             @"ConfigCode":self.ConfigCode,
                             @"UseLevel":self.currentUseLevel
                             };
   
    [AFNetworkingTool post:mulDic andurl:[NSString stringWithFormat:@"%@Card/CardConfigGradeDetail",Khttp] success:^(NSDictionary *dict, BOOL success) {
        
        if([[dict objectForKey:@"ResultCode"] isEqualToString:[NSString stringWithFormat:@"%@",@"F000000"]])
        {
//            self.GradeDetailDic = [dict objectForKey:@"JsonData"];
            self.card=[[QWCardConfigGradeModel alloc]initWithDictionary:[dict objectForKey:@"JsonData"] error:nil];
                [self UpdateUI];
            
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
- (void)setupUI {
    
    UIView *containView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 310*Main_Screen_Height/667)];
    [self.view addSubview:containView];
    
    UIImageView *cardImgV = [[UIImageView alloc] init];
    cardImgV.image = [UIImage imageNamed:@"bg_card"];
    [containView addSubview:cardImgV];
    
    cardNameLab = [[UILabel alloc] init];
    cardNameLab.text = @"体验卡";
    cardNameLab.font = [UIFont systemFontOfSize:18*Main_Screen_Height/667];
    [cardImgV addSubview:cardNameLab];
    
    UILabel *introLab = [[UILabel alloc] init];
    introLab.text = @"扫码洗车服务中使用";
    introLab.font = [UIFont systemFontOfSize:13*Main_Screen_Height/667];
    [cardImgV addSubview:introLab];
    
   invalidLab = [[UILabel alloc] init];
    invalidLab.text = @"截止日期：2017-8-10";
    invalidLab.textColor = [UIColor colorFromHex:@"#999999"];
    invalidLab.font = [UIFont systemFontOfSize:13*Main_Screen_Height/667];
    [cardImgV addSubview:invalidLab];
    
    UILabel *brandLab = [[UILabel alloc] init];
    brandLab.text = @"金顶洗车";
    brandLab.font = [UIFont systemFontOfSize:11*Main_Screen_Height/667];
    [cardImgV addSubview:brandLab];
    
   self.getBtn = [UIUtil drawDefaultButton:containView title:@"立即领取" target:self action:@selector(didClickGetBtn)];
    
    UIButton *checkCardBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [checkCardBtn setTitle:@"查看卡包" forState:UIControlStateNormal];
    [checkCardBtn setTitleColor:[UIColor colorFromHex:@"#999999"] forState:UIControlStateNormal];
    checkCardBtn.titleLabel.font = [UIFont systemFontOfSize:13*Main_Screen_Height/667];
    [checkCardBtn setImage:[UIImage imageNamed:@"chakandaijinquan-jiantou"] forState:UIControlStateNormal];
    checkCardBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -150*Main_Screen_Height/667);
    [checkCardBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -50*Main_Screen_Height/667, 0, 0)];
    
    [checkCardBtn addTarget:self action:@selector(didClickCheckCardBtn) forControlEvents:UIControlEventTouchUpInside];
    [containView addSubview:checkCardBtn];
    
    
    //约束
//    [containView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.view);
//        make.left.right.equalTo(self.view);
//        make.height.mas_equalTo(305*Main_Screen_Height/667);
//    }];
    
    [cardImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(containView).mas_offset(10*Main_Screen_Height/667);
        make.left.equalTo(containView).mas_offset(37.5*Main_Screen_Height/667);
        make.right.equalTo(containView).mas_offset(-37.5*Main_Screen_Height/667);
        make.height.mas_equalTo(192*Main_Screen_Height/667);
    }];
    
    [cardNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(cardImgV).mas_offset(20*Main_Screen_Height/667);
        make.left.equalTo(cardImgV).mas_offset(20*Main_Screen_Height/667);
    }];
    
    [brandLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(cardNameLab);
        make.leading.equalTo(cardNameLab.mas_trailing).mas_offset(5*Main_Screen_Height/667);
    }];
    
    [introLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(cardNameLab.mas_bottom).mas_offset(10*Main_Screen_Height/667);
        make.leading.equalTo(cardNameLab);
    }];
    
    [invalidLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(cardNameLab);
        make.bottom.equalTo(cardImgV).mas_offset(-18*Main_Screen_Height/667);
    }];
    
    [self.getBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(cardImgV.mas_bottom).mas_offset(15*Main_Screen_Height/667);
        make.centerX.equalTo(containView);
        make.width.mas_equalTo(351*Main_Screen_Height/667);
        make.height.mas_equalTo(48*Main_Screen_Height/667);
    }];
    
    [checkCardBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.getBtn.mas_bottom);
        make.centerX.equalTo(containView);
        make.height.mas_equalTo(45*Main_Screen_Height/667);
        make.width.mas_equalTo(100*Main_Screen_Height/667);
    }];
    
    UITableView *noticeView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height) style:UITableViewStyleGrouped];
    [self.view addSubview:noticeView];
    
//    [noticeView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(checkCardBtn.mas_bottom);
//        make.bottom.equalTo(self.view);
//        make.width.mas_equalTo(Main_Screen_Width);
//    }];
    noticeView.delegate = self;
    noticeView.dataSource = self;
    noticeView.estimatedRowHeight = 80;
    noticeView.rowHeight = UITableViewAutomaticDimension;
    
    noticeView.tableHeaderView = containView;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *id_noticeCell = @"id_noticeCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:id_noticeCell];
    
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:id_noticeCell];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    if (indexPath.section == 0) {
        
        UILabel *titleLab = [[UILabel alloc] init];
        titleLab.textColor = [UIColor colorFromHex:@"#4a4a4a"];
        titleLab.font = [UIFont systemFontOfSize:16*Main_Screen_Height/667];
        [cell.contentView addSubview:titleLab];
        
        UILabel *infosLab = [[UILabel alloc] init];
        infosLab.textColor = [UIColor colorFromHex:@"#999999"];
        infosLab.font = [UIFont systemFontOfSize:15*Main_Screen_Height/667];
        infosLab.numberOfLines = 0;
        titleLab.text = @"特权介绍";
        infosLab.text = @"白银会员每月可领取10元代金券，不可以和其他优惠活动叠加使用";
        [cell.contentView addSubview:infosLab];
        
        [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(cell.contentView).mas_offset(8*Main_Screen_Height/667);
            make.left.equalTo(cell.contentView).mas_offset(12*Main_Screen_Height/667);
        }];
        
        [infosLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(titleLab.mas_bottom).mas_offset(8*Main_Screen_Height/667);
            make.leading.equalTo(titleLab);
            make.right.equalTo(cell.contentView).mas_offset(-12*Main_Screen_Height/667);
            make.bottom.equalTo(cell.contentView).mas_offset(-8*Main_Screen_Height/667);
        }];
        
        
    }else if (indexPath.section == 1) {
        UILabel *titleLab = [[UILabel alloc] init];
        titleLab.textColor = [UIColor colorFromHex:@"#4a4a4a"];
        titleLab.font = [UIFont systemFontOfSize:16*Main_Screen_Height/667];
        [cell.contentView addSubview:titleLab];
        
        UILabel *infosLab = [[UILabel alloc] init];
        infosLab.textColor = [UIColor colorFromHex:@"#999999"];
        infosLab.font = [UIFont systemFontOfSize:15*Main_Screen_Height/667];
        infosLab.numberOfLines = 0;
        titleLab.text = @"领取对象";
        infosLab.text = @"白银会员";
        [cell.contentView addSubview:infosLab];
        
        [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(cell.contentView).mas_offset(8*Main_Screen_Height/667);
            make.left.equalTo(cell.contentView).mas_offset(12*Main_Screen_Height/667);
        }];
        
        [infosLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(titleLab.mas_bottom).mas_offset(8*Main_Screen_Height/667);
            make.leading.equalTo(titleLab);
            make.right.equalTo(cell.contentView).mas_offset(-12*Main_Screen_Height/667);
            make.bottom.equalTo(cell.contentView).mas_offset(-8*Main_Screen_Height/667);
        }];
        
        
    }else {
        UILabel *titleLab = [[UILabel alloc] init];
        titleLab.textColor = [UIColor colorFromHex:@"#4a4a4a"];
        titleLab.font = [UIFont systemFontOfSize:16*Main_Screen_Height/667];
        [cell.contentView addSubview:titleLab];
        
        UILabel *infosLab = [[UILabel alloc] init];
        infosLab.textColor = [UIColor colorFromHex:@"#999999"];
        infosLab.font = [UIFont systemFontOfSize:15*Main_Screen_Height/667];
        infosLab.numberOfLines = 0;
        [cell.contentView addSubview:infosLab];
        
        [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(cell.contentView).mas_offset(8*Main_Screen_Height/667);
            make.left.equalTo(cell.contentView).mas_offset(12*Main_Screen_Height/667);
        }];
        
        [infosLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(titleLab.mas_bottom).mas_offset(8*Main_Screen_Height/667);
            make.leading.equalTo(titleLab);
            make.right.equalTo(cell.contentView).mas_offset(-12*Main_Screen_Height/667);
        }];
        
        UILabel *infosLab2 = [[UILabel alloc] init];
        infosLab2.textColor = [UIColor colorFromHex:@"#999999"];
        infosLab2.font = [UIFont systemFontOfSize:15*Main_Screen_Height/667];
        infosLab2.numberOfLines = 0;
        [cell.contentView addSubview:infosLab2];
        
        UILabel *infosLab3 = [[UILabel alloc] init];
        infosLab3.textColor = [UIColor colorFromHex:@"#999999"];
        infosLab3.font = [UIFont systemFontOfSize:15*Main_Screen_Height/667];
        infosLab3.numberOfLines = 0;
        [cell.contentView addSubview:infosLab3];
        
        titleLab.text = @"使用须知";
        infosLab.text = @"1、本代金券由金顶洗车APP开发，仅限金顶洗车店和与金顶合作商家使用";
        infosLab2.text = @"2、如果代金券购买服务时发生了退服务行为，代金券不予退还";
        infosLab3.text = @"3、有任何问题，可咨询金顶客服";
        
        [infosLab2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(infosLab.mas_bottom).mas_offset(8*Main_Screen_Height/667);
            make.leading.equalTo(infosLab);
            make.right.equalTo(cell.contentView).mas_offset(-12*Main_Screen_Height/667);
        }];
        
        [infosLab3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(infosLab2.mas_bottom).mas_offset(8*Main_Screen_Height/667);
            make.leading.equalTo(infosLab2);
            make.right.equalTo(cell.contentView).mas_offset(-12*Main_Screen_Height/667);
            make.bottom.equalTo(cell.contentView).mas_offset(-8*Main_Screen_Height/667);
        }];
        
        
        
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}



#pragma mark -
- (void)didClickGetBtn {
    
    [self RequestCard];
}
#pragma mark-领取卡片
-(void)RequestCard{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *datenow = [NSDate date];
    NSDate *newDate = [datenow dateByAddingTimeInterval:60 * 60 * 24 * self.card.ExpiredDay];
    
//    NSLog(@"%@",card);
    
    NSDictionary *mulDic = @{
                             @"Account_Id":[UdStorage getObjectforKey:@"Account_Id"],
                             @"ConfigCode":self.ConfigCode,
                             @"UseLevel":self.currentUseLevel,
                             @"GetCardType":[NSString stringWithFormat:@"%ld",self.card.GetCardType],
                             @"Area":self.card.Area,
                             @"CardCount":[NSString stringWithFormat:@"%ld",self.card.CardCount],
                             @"CardName":self.card.CardName,
                             @"CardPrice":[NSString stringWithFormat:@"%@",self.card.CardPrice],
                             @"CardType":[NSString stringWithFormat:@"%ld",self.card.CardType],
                             @"Description":self.card.Description,
                             @"ExpStartDates":[NSString stringWithFormat:@"%@",[formatter stringFromDate:datenow]],
                             @"ExpEndDates":[NSString stringWithFormat:@"%@",[formatter stringFromDate:newDate]],
                             @"Integralnum": @1,
                             };
    
    
    NSLog(@"%@",mulDic);
    
   
    [AFNetworkingTool post:mulDic andurl:[NSString stringWithFormat:@"%@Card/ReceiveCardInfo",Khttp] success:^(NSDictionary *dict, BOOL success) {
        
        if([[dict objectForKey:@"ResultCode"] isEqualToString:[NSString stringWithFormat:@"%@",@"F000000"]])
        {
            
            [self.view showInfo:@"领取成功" autoHidden:YES interval:2];
            
            
            
            
            NSLog(@"旧：%ld",self.card.CardQuantity);
            self.card.CardQuantity= self.card.CardQuantity-1;
            NSLog(@"新：%ld",self.card.CardQuantity);
//            [_GradeDetailDic setObject:[NSString stringWithFormat:@"%d",num-1] forKey:@"CardQuantity"];
            
            NSNotification * notice = [NSNotification notificationWithName:@"receivesuccess" object:nil userInfo:nil];
            [[NSNotificationCenter defaultCenter]postNotification:notice];
            
            //            self.GradeDetailDic = [dict objectForKey:@"JsonData"];
            if(self.card.CardQuantity != 0)
            {
                
            }
            else
            {
                [_getBtn setTitle:@"该卡已领取完毕" forState:UIControlStateNormal];
                _getBtn.enabled = NO;
            }
            
            
        }
        else
        {
            [self.view showInfo:@"领取失败" autoHidden:YES interval:2];
        }
    } fail:^(NSError *error) {
        [self.view showInfo:@"领取失败" autoHidden:YES interval:2];
        
    }];
    


}
- (void)didClickCheckCardBtn {
    
    QWCardPackgeController *VC = [[QWCardPackgeController alloc] init];
    
    [self.navigationController pushViewController:VC animated:YES];
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