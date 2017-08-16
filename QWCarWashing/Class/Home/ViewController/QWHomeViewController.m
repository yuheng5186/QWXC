//
//  QWHomeViewController.m
//  QWCarWashing
//
//  Created by apple on 2017/8/14.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "QWHomeViewController.h"
#import "QWMenuTableViewCell.h"
#import "QWHomeDetailTableViewCell.h"
#import "QWCarFriendsCircleController.h"
#import "QWExchangeViewController.h"
#import "QWMerchantInViewController.h"

#import "QWScanController.h"
#import "QWDownloadController.h"
#import "QWCarClubController.h"
#import "QWShareMoneyController.h"
#import "QWMyCarController.h"
#import "QWUserServiceController.h"
#import "QWMembershipController.h"
#import "QWScoreController.h"
#import "QWCardPackgeController.h"
#import "QWAddShopController.h"

#import "PopupView.h"
#import "LewPopupViewAnimationDrop.h"
@interface QWHomeViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableview;
@end
static NSString *cellstr=@"Cellstr";
@implementation QWHomeViewController
-(UITableView *)tableview{
    if (_tableview==nil) {
        _tableview=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, QWScreenWidth, QWScreenheight)];
        [_tableview registerClass:[UITableViewCell class] forCellReuseIdentifier:cellstr];
        [_tableview registerClass:[QWMenuTableViewCell class] forCellReuseIdentifier:QWCellIdentifier_MenuTableViewCell];
        [_tableview registerNib:[UINib nibWithNibName:QWCellIdentifier_HomeDetailTableViewCell bundle:[NSBundle mainBundle]] forCellReuseIdentifier:QWCellIdentifier_HomeDetailTableViewCell];
        _tableview.delegate=self;
        _tableview.dataSource=self;
        _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
         _tableview.backgroundColor=[UIColor colorWithHexString:@"#eaeaea"];

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
    //左边试图
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    [btn sizeToFit];
    btn.imageView.contentMode=UIViewContentModeScaleAspectFit;
    btn.frame=CGRectMake(0, 0, 50, 50);
    [btn setImage:[UIImage imageNamed:@"gerenxinxitou"] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"gerenxinxitou"] forState:UIControlStateHighlighted];
    
    [btn addTarget:self action:@selector(personInfo) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *leftbarbtn= [[UIBarButtonItem alloc]initWithCustomView:btn];
    self.navigationItem.leftBarButtonItem=leftbarbtn;
    //右边试图
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"xiazai"] scaledToSize:CGSizeMake(25, 25)] style:(UIBarButtonItemStyleDone) target:self action:@selector(downloadOnclick:)];

//    UIButton *rightbtn=[UIButton buttonWithType:UIButtonTypeCustom];
//    [rightbtn sizeToFit];
//    rightbtn.imageView.contentMode=UIViewContentModeScaleAspectFit;
//    rightbtn.frame=CGRectMake(10, 0, 48, 48);
//    [rightbtn setImage:[UIImage imageNamed:@"xiazai"] forState:UIControlStateNormal];
//    [rightbtn setImage:[UIImage imageNamed:@"xiazai"] forState:UIControlStateHighlighted];
//    
//    [rightbtn addTarget:self action:@selector(downloadOnclick) forControlEvents:UIControlEventTouchUpInside];
//    
//    UIBarButtonItem *rightbarbtn= [[UIBarButtonItem alloc]initWithCustomView:rightbtn];
//    self.navigationItem.rightBarButtonItem=rightbarbtn;
}

-(void)personInfo{

}
-(void)downloadOnclick:(id) sender{
    
    QWDownloadController    *downloadController     = [[QWDownloadController alloc]init];
    downloadController.hidesBottomBarWhenPushed     = YES;
    [self.navigationController pushViewController:downloadController animated:YES];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark-UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 6;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            return 1;
            break;
        case 2:
            return 1;
            break;
        default:
            return  1 ;
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section==0)
    {
        QWMenuTableViewCell *cell2 = [tableView dequeueReusableCellWithIdentifier:QWCellIdentifier_MenuTableViewCell forIndexPath:indexPath];
        cell2.selectionStyle = UITableViewCellSelectionStyleNone;
        cell2.backgroundColor=[UIColor clearColor];
        [cell2 setContentAndImgArr:@[@"saoyisao",
                                     @"kabao",
                                     @"huiyuan",
                                     @"jifen"]
                     andContentArr:@[@"扫一扫",
                                     @"卡包",
                                     @"会员",
                                     @"积分"]];
        
        QWScanController    *scanController             = [[QWScanController alloc]init];
        QWCardPackgeController  *cardPackgeController   = [[QWCardPackgeController alloc]init];
        QWMembershipController  *membershipController   = [[QWMembershipController alloc]init];
        QWScoreController       *scoreController        = [[QWScoreController alloc]init];
        
        cell2.selecOptionIndexs=^(NSInteger index){
            #pragma mark-图片点击事件
            switch (index) {
                case 0:
                    [self.navigationController pushViewController:scanController animated:YES];
                    
                    break;
                case 1:
                    [self.navigationController pushViewController:cardPackgeController animated:YES];
                    break;
                case 2:
                    [self.navigationController pushViewController:membershipController animated:YES];
                    break;
                case 3:
                    [self.navigationController pushViewController:scoreController animated:YES];
                    break;
                default:
                    break;
            }
            
        };
        cell2.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"4geiconditu"]];
        return cell2;
        
    }else if (indexPath.section==1){
        QWMenuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:QWCellIdentifier_MenuTableViewCell forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
          cell.backgroundColor=[UIColor clearColor];
        [cell setContentAndImgArr:@[@"duihuanlipin",
                                    @"qiandao",
                                    @"shangjia",
                                    @"kefu",
                                    @"wode-aiche",
                                    @"fenxiang",
                                    @"quanzi"]
                    andContentArr:@[@"兑换礼品",
                                    @"每日签到",
                                    @"商家入驻",
                                    @"客服咨询",
                                    @"我的爱车",
                                    @"分享赚钱",
                                    @"车友圈"]];
        cell.backgroundView                                 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"4geiconditu"]];
        QWCarFriendsCircleController *qwcarfriendscirclectl = [[QWCarFriendsCircleController alloc]init];
        QWExchangeViewController *exchangevctl              = [[QWExchangeViewController alloc]init];
        QWAddShopController *MerchantIn                     = [[QWAddShopController alloc]init];
        
        PopupView *view = [PopupView defaultPopupView];
        view.parentVC   = self;
        
        cell.selecOptionIndexs=^(NSInteger index){
            switch (index) {
                case 0:
                    [self.navigationController pushViewController:exchangevctl animated:YES];
                    
                    break;
                case 1:

                    
                    [self lew_presentPopupView:view animation:[LewPopupViewAnimationDrop new] dismissed:^{
                        
                    }];
                    break;
                case 2:
                    [self.navigationController pushViewController:MerchantIn animated:YES];
                    break;
                case 6:
                    [self.navigationController pushViewController:qwcarfriendscirclectl animated:YES];
                    break;
                    
                default:
                    break;
            }
            #pragma mark-图片点击事件
        };
        return cell;
        
        
    }else {
        QWHomeDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:QWCellIdentifier_HomeDetailTableViewCell forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
        
    }
    
}
#pragma mark-组头组尾
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, QWScreenWidth, 67)];
    header.backgroundColor=[UIColor colorWithHexString:@"#eaeaea"];
    UIImageView *imagevie=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, QWScreenWidth, header.frame.size.height-10)];
    [header addSubview:imagevie];
    if (section == 2 || section == 4) {
        imagevie.image=[UIImage imageNamed:@"guanggao22"];
    } else {
        UIImageView *imagevie=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, QWScreenWidth, header.frame.size.height)];
        [header addSubview:imagevie];
    }
    return header;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
   
    // 覆盖文字
    if (section == 1) {
        UIView *Footer = [[UIView alloc]initWithFrame:CGRectMake(0, 0, QWScreenWidth, 67)];
        Footer.backgroundColor=[UIColor colorWithHexString:@"#eaeaea"];
        UIImageView *imagevie=[[UIImageView alloc]initWithFrame:CGRectMake(20, 10, QWScreenWidth-40, Footer.frame.size.height-20)];
        
        imagevie.layer.cornerRadius=15;
        [Footer addSubview:imagevie];
        imagevie.image=[UIImage imageNamed:@"guanggao11"];
         return Footer;
    } else if (section == 2 || section == 4) {
        UIView *Footer = [[UIView alloc]initWithFrame:CGRectMake(0, 0, QWScreenWidth, 30)];
        Footer.backgroundColor=[UIColor clearColor];
        UILabel *imagevie=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, QWScreenWidth, Footer.frame.size.height)];
        imagevie.textColor=[UIColor colorWithHexString:@"#868686"];
        imagevie.textAlignment=NSTextAlignmentCenter;
        imagevie.text=@"查看详情";
        [Footer addSubview:imagevie];
        
        return Footer;
    }else{
         UIView *Footer = [[UIView alloc]initWithFrame:CGRectMake(0, 0, QWScreenWidth, 0)];
        return Footer;
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(section==2||section==4){
        return 67;
    }else{
       
        return 3;
        
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section==1) {
        return 67;
    }else if(section==2 ||section==4){
        return 30;
    }else{
        return 3;
    
    }
   

}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        return [QWMenuTableViewCell cellHeight:4] ;
    }else if (indexPath.section==1){
        return [QWMenuTableViewCell cellHeight:7];
        ;
    }else if (indexPath.section==2){
        return 100;
        ;
    }else{
        return 100;
    }

}

@end
