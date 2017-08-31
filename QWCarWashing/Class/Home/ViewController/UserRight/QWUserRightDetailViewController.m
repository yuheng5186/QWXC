//
//  QWUserRightDetailViewController.m
//  QWCarWashing
//
//  Created by apple on 2017/8/18.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "QWUserRightDetailViewController.h"
#import "UIWindow+YzdHUD.h"
#import "MBProgressHUD.h"
#import "QWCardConfigGradeModel.h"
@interface QWUserRightDetailViewController ()
{
    
    MBProgressHUD *HUD;
}
@property (nonatomic,strong) QWCardConfigGradeModel *card;
@property (nonatomic,strong) NSDictionary *dic;
@property(nonatomic,strong) UIView *contentView;
@property (nonatomic,strong) UIButton    *getButton;
@end

@implementation QWUserRightDetailViewController

#pragma mark-用户权限详情查询
-(void)GetCouponDetail
{
    NSDictionary *mulDic = @{
                             @"ConfigCode":self.ConfigCode,
                             @"Account_Id":[UdStorage getObjectforKey:@"Account_Id"]
                             };
   
    [AFNetworkingTool post:mulDic andurl:[NSString stringWithFormat:@"%@Card/CardConfigDetail",Khttp] success:^(NSDictionary *dict, BOOL success) {
        
        if([[dict objectForKey:@"ResultCode"] isEqualToString:[NSString stringWithFormat:@"%@",@"F000000"]])
        {
            self.dic = [[NSDictionary alloc]initWithDictionary:[dict objectForKey:@"JsonData"]];
            self.card=[[QWCardConfigGradeModel alloc]initWithDictionary:[dict objectForKey:@"JsonData"] error:nil];
            
            //            [_CouponListData addObjectsFromArray:arr];
            //            [self.tableView reloadData];
            //            NSLog(@"%@",card);
            
            [self createSubView];
            
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
//- (void) drawContent {
//   
//}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.contentView=[[UIView alloc]initWithFrame:CGRectMake(0, 64,QWScreenWidth, QWScreenheight)];
    
    self.contentView.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1];
    self.contentView.userInteractionEnabled = YES;
  
    [self.view addSubview:self.contentView];
    self.title=@"用户权益";
    HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HUD.removeFromSuperViewOnHide =YES;
    HUD.mode = MBProgressHUDModeIndeterminate;
    HUD.labelText = @"加载中";
    HUD.minSize = CGSizeMake(132.f, 108.0f);
    
    [self GetCouponDetail];

//    [self createSubView];
    [self resetBabkButton];
//    self.view.backgroundColor=[UIColor redColor];
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

- (void) createSubView {
    
    UIView *upView                  = [UIUtil drawLineInView:self.contentView frame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height*328/667) color:[UIColor colorFromHex:@"#fafafa"]];
    upView.top                      = 0;
    
    //    UIImage *backgroundImage              = [UIImage imageNamed:@"saomaxichetiyanquan"];
    UIImageView *backgroundImageView      = [UIUtil drawCustomImgViewInView:upView frame:CGRectMake(37.5*Main_Screen_Height/667, 0, Main_Screen_Width-75*Main_Screen_Height/667, 192*Main_Screen_Height/667) imageName:@"bg_card"];
    backgroundImageView.top               = Main_Screen_Height*25/667;
    backgroundImageView.centerX           = upView.centerX;
    
    NSString *showString             = _dic[@"CardName"];
    UIFont    *showFont              = [UIFont boldSystemFontOfSize:18*Main_Screen_Height/667];
    UILabel     *showlabel           = [UIUtil drawLabelInView:backgroundImageView frame:[UIUtil textRect:showString font:showFont] font:showFont text:showString isCenter:NO];
    showlabel.left                   = Main_Screen_Width*20/375;
    showlabel.top                    = Main_Screen_Height*20/667;
    
    
    NSString *showString33             = @"扫码洗车服务中使用";
    UIFont    *showFont33             = [UIFont systemFontOfSize:15*Main_Screen_Height/667];
    UILabel     *showlabel33           = [UIUtil drawLabelInView:backgroundImageView frame:[UIUtil textRect:showString33 font:showFont33] font:showFont33 text:showString33 isCenter:NO];
    showlabel33.left                   = Main_Screen_Width*20/375;
    showlabel33.top                    = showlabel.bottom + Main_Screen_Height*5/667;
    
    
    
    NSString *showString2             = @"金顶洗车";
    UIFont    *showFont2              = [UIFont systemFontOfSize:12*Main_Screen_Height/667];
    UILabel     *showlabel2           = [[UILabel alloc]initWithFrame:CGRectMake(0, Main_Screen_Height*20/667, Main_Screen_Width*200/375, Main_Screen_Height*50/667)];
    showlabel2.font = showFont2;
    showlabel2.text = showString2;
//    [showlabel2 setVerticalAlignment:VerticalAlignmentBottom];
    showlabel2.bottom   = showlabel.bottom+10;
    showlabel2.left     = showlabel.right +Main_Screen_Width*10/375;
    [backgroundImageView addSubview:showlabel2];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *datenow = [NSDate date];
    
    NSString *showString3             =  [NSString stringWithFormat:@"有效期: %@-%@",[LCMD5Tool DateZhuan:[formatter stringFromDate:datenow]],[LCMD5Tool DateZhuan:_dic[@"ExpiredTimes"]]];
    UIFont    *showFont3              = [UIFont systemFontOfSize:13*Main_Screen_Height/667];
    UILabel     *showlabel3           = [UIUtil drawLabelInView:backgroundImageView frame:[UIUtil textRect:showString3 font:showFont3] font:showFont3 text:showString3 isCenter:NO];
    showlabel3.textColor =               [UIColor colorFromHex:@"#999999"];
    showlabel3.left                   = Main_Screen_Width*20/375;
    showlabel3.bottom                    = backgroundImageView.height -showlabel3.height -Main_Screen_Height*5/667;
    
    
    
    NSString *string;
    if([_dic[@"IsReceive"] intValue] == 1)
    {
        string        = @"立即领取";
        _getButton  = [UIUtil drawDefaultButton:upView title:string target:self action:@selector(getButtonClick:)];
        
    }
    else
    {
        string        = @"已领取";
        _getButton  = [UIUtil drawDefaultButton:upView title:string target:self action:nil];
        _getButton.enabled = NO;
    }
    
    
    
    _getButton.top           = backgroundImageView.bottom +Main_Screen_Height*50/667;
    _getButton.centerX       = Main_Screen_Width/2;
    upView.height           = _getButton.bottom +Main_Screen_Height*50/667;
    
    
    UIView *downView                = [UIUtil drawLineInView:self.contentView frame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height*170/667) color:[UIColor whiteColor]];
    downView.top                    = upView.bottom;
    
    NSString *useString             = @"使用须知";
    UIFont    *useFont              = [UIFont systemFontOfSize:16*Main_Screen_Height/667];
    UILabel     *uselabel           = [UIUtil drawLabelInView:downView frame:CGRectMake(0, 0, Main_Screen_Width*100/375, Main_Screen_Height*20/667) font:useFont text:useString isCenter:NO];
    uselabel.textColor              = [UIColor colorFromHex:@"#4a4a4a"];
    uselabel.left                   = Main_Screen_Width*10/375;
    uselabel.top                    = Main_Screen_Height*10/667;
    
    NSString *useString1             = @"1. 本代金券由蔷薇爱车APP开发，仅限蔷薇爱车店和与蔷薇合作商家使用";
    UIFont    *useFont1              = [UIFont systemFontOfSize:14*Main_Screen_Height/667];
    UILabel     *uselabel1           = [UIUtil drawLabelInView:downView frame:CGRectMake(0, 0, Main_Screen_Width-Main_Screen_Width*20/375, Main_Screen_Height*40/667) font:useFont1 text:useString1 isCenter:NO];
    uselabel1.textColor              = [UIColor colorFromHex:@"#999999"];
    uselabel1.numberOfLines          = 0;
    uselabel1.centerX                = downView.width/2;
    uselabel1.top                    = uselabel.bottom +Main_Screen_Height*10/667;
    
    NSString *useString2             = @"2. 如果使用代金券购买服务时发生退服务行为，代金券不予退还";
    UIFont    *useFont2              = [UIFont systemFontOfSize:14*Main_Screen_Height/667];
    UILabel     *uselabel2           = [UIUtil drawLabelInView:downView frame:CGRectMake(0, 0, Main_Screen_Width-Main_Screen_Width*20/375, Main_Screen_Height*40/667) font:useFont2 text:useString2 isCenter:NO];
    uselabel2.textColor              = [UIColor colorFromHex:@"#999999"];
    uselabel2.numberOfLines          = 0;
    uselabel2.centerX                = Main_Screen_Width/2;
    uselabel2.top                    = uselabel1.bottom +Main_Screen_Height*5/667;
    
    NSString *useString3             = @"3. 有任何问题，可咨询蔷薇客服";
    UIFont    *useFont3              = [UIFont systemFontOfSize:14*Main_Screen_Height/667];
    UILabel     *uselabel3           = [UIUtil drawLabelInView:downView frame:CGRectMake(0, 0, Main_Screen_Width-Main_Screen_Width*20/375, Main_Screen_Height*40/667) font:useFont3 text:useString3 isCenter:NO];
    uselabel3.textColor              = [UIColor colorFromHex:@"#999999"];
    uselabel3.numberOfLines          = 0;
    uselabel3.centerX                = Main_Screen_Width/2;
    uselabel3.top                    = uselabel2.bottom +Main_Screen_Height*0/667;
    
}
- (void) getButtonClick:(id)sender {
    
    [self.view.window showHUDWithText:@"恭喜您领取成功，已经放入您的卡券中" Type:ShowPhotoYes Enabled:YES];
    
}
#pragma mark-领取卡片
-(void)requestAddCard{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *datenow = [NSDate date];
    
    NSDictionary *mulDic = @{
                             @"Account_Id":[UdStorage getObjectforKey:@"Account_Id"],
                             @"ConfigCode":self.ConfigCode,
                             @"UseLevel":@1,
                             @"GetCardType":@2,
                             @"Area":_dic[@"Area"],
                             @"CardCount":[NSString stringWithFormat:@"%ld",self.card.CardCount],
                             @"CardName":self.card.CardName,
                             @"CardPrice":[NSString stringWithFormat:@"%@",self.card.CardPrice],
                             @"CardType":[NSString stringWithFormat:@"%ld",self.card.CardType],
                             @"Description":self.card.Description,
                             @"ExpStartDates":[NSString stringWithFormat:@"%@",[formatter stringFromDate:datenow]],
                             @"ExpEndDates":[NSString stringWithFormat:@"%@",_dic[@"ExpiredTimes"]],
                             @"Integralnum": @1
                             };
    
   
    [AFNetworkingTool post:mulDic andurl:[NSString stringWithFormat:@"%@Card/ReceiveCardInfo",Khttp] success:^(NSDictionary *dict, BOOL success) {
        
        if([[dict objectForKey:@"ResultCode"] isEqualToString:[NSString stringWithFormat:@"%@",@"F000000"]])
        {
            
            [self.view.window showHUDWithText:@"恭喜您领取成功，已经放入您的卡券中" Type:ShowPhotoYes Enabled:YES];
            
            
            
            //            NSInteger num = [[_dic objectForKey:@"IsReceive"] intValue] + 1;
            
            //            [_dic setObject:[NSString stringWithFormat:@"%ld",num] forKey:@"IsReceive"];
            
            [_getButton setTitle:@"已领取" forState:UIControlStateNormal];
            _getButton.enabled = NO;
            
            
        }
        else
        {
            [self.view showInfo:@"领取失败" autoHidden:YES interval:2];
        }
    } fail:^(NSError *error) {
        [self.view showInfo:@"领取失败" autoHidden:YES interval:2];
        
    }];


}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
