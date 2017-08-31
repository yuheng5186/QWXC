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
#import "QWSaleActivityController.h"

#import "QWConsumerController.h"

#import "QWUserRightDetailViewController.h"
#import "QWCarWashingActivityViewController.h"

#import "PopupView.h"
#import "LewPopupViewAnimationDrop.h"
#import "QWViptequanViewController.h"

#import "QWRecordModel.h"
@interface QWHomeViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableview;
@property (nonatomic, strong) NSMutableArray *GetUserRecordData;
//@property (nonatomic, strong) UIButton  *locationButton;
@property (strong, nonatomic)NSString *LocCity;
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
        _tableview.backgroundColor=[UIColor colorWithHexString:@"#fafafa"];
        
    }
    return _tableview;
}
-(NSMutableArray *)GetUserRecordData{
    if (_GetUserRecordData==nil) {
        _GetUserRecordData=[NSMutableArray arrayWithCapacity:0];
    }
    return _GetUserRecordData;
}
-(void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden=NO;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNagationLeftAndRightButton];
    [self.view addSubview:self.tableview];
    
    [self setupRefresh];
    
}

-(void)setupRefresh
{
    self.tableview.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        // 模拟延迟加载数据，因此2秒后才调用（真实开发中，可以移除这段gcd代码）
        
        [self headerRereshing];
        
    }];
    
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    self.tableview.mj_header.automaticallyChangeAlpha = YES;
    
    [self.tableview.mj_header beginRefreshing];
    
    
}

- (void)headerRereshing
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.GetUserRecordData = [[NSMutableArray alloc]init];
        
        
        [self setData];
        
    });
}
#pragma mark-获取首页展示用户记录和活动列表
-(void)setData
{
    
    if(self.LocCity == nil)
    {
        self.LocCity = @"";
    }
    
    NSDictionary *mulDic = @{
                             @"Account_Id":[UdStorage getObjectforKey:Userid],
                             @"Area":@"上海市"
                             //                             @"Area":self.LocCity
                             };
       [AFNetworkingTool post:mulDic andurl:[NSString stringWithFormat:@"%@User/GetUserRecord",Khttp] success:^(NSDictionary *dict, BOOL success) {
           NSLog(@"%@",dict);
        if([[dict objectForKey:@"ResultCode"] isEqualToString:[NSString stringWithFormat:@"%@",@"F000000"]])
        {
            NSArray *arr = [NSArray array];
            arr = [dict objectForKey:@"JsonData"];
            if(arr.count == 0)
            {
                //                [self.view showInfo:@"暂无更多数据" autoHidden:YES interval:2];
                [self.tableview.mj_header endRefreshing];
            }
            else
            {
                
                
                NSArray *arr = [NSArray array];
                arr = [dict objectForKey:@"JsonData"];
                for(NSDictionary *dic in arr)
                {
                    QWRecordModel *newrc = [[QWRecordModel alloc]initWithDictionary:dic error:nil];
                    
                    [self.GetUserRecordData addObject:newrc];
                }
                
                [self.tableview reloadData];
                [self.tableview.mj_header endRefreshing];
            }
            
        }
        else
        {
            [self.view showInfo:@"数据请求失败,请检查定位" autoHidden:YES interval:2];
            [self.tableview.mj_header endRefreshing];
        }
        
    } fail:^(NSError *error) {
        [self.view showInfo:@"获取失败" autoHidden:YES interval:2];
        [self.tableview.mj_header endRefreshing];
    }];
    
}


#pragma mark-设置导航栏左右按钮
-(void)setNagationLeftAndRightButton{
    //左边试图
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
//    [btn sizeToFit];
//    btn.imageView.contentMode=UIViewContentModeScaleAspectFit;
//    btn.backgroundColor = [UIColor redColor];
    btn.frame = CGRectMake(0, 0, Main_Screen_Width*34/375, Main_Screen_Height*34/667);
    [btn setImage:[UIImage imageNamed:@"gerenxinxitou"] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"gerenxinxitou"] forState:UIControlStateHighlighted];
    btn.top     = Main_Screen_Height*5/667;
    [btn addTarget:self action:@selector(personInfo) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *leftbarbtn= [[UIBarButtonItem alloc]initWithCustomView:btn];
    self.navigationItem.leftBarButtonItem=leftbarbtn;
    //右边试图
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"xiazai"] scaledToSize:CGSizeMake(25, 25)] style:(UIBarButtonItemStyleDone) target:self action:@selector(downloadOnclick:)];
    
    
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
    return self.GetUserRecordData.count+2;
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
        QWViptequanViewController  *vipController   = [[QWViptequanViewController alloc]init];
        QWScoreController       *scoreController        = [[QWScoreController alloc]init];
        
        cell2.selecOptionIndexs=^(NSInteger index){
            #pragma mark-图片点击事件
            switch (index) {
                case 0:
                    scanController.hidesBottomBarWhenPushed     = YES;
                    [self.navigationController pushViewController:scanController animated:YES];
                    
                    break;
                case 1:
                    cardPackgeController.hidesBottomBarWhenPushed     = YES;
                    [self.navigationController pushViewController:cardPackgeController animated:YES];
                    break;
                case 2:
                    
                    vipController.hidesBottomBarWhenPushed   = YES;
                    [self.navigationController pushViewController:vipController animated:YES];
                    break;
                case 3:
                    scoreController.hidesBottomBarWhenPushed        = YES;
                    [self.navigationController pushViewController:scoreController animated:YES];
                    break;
                default:
                    break;
            }
            
#pragma mark-图片点击事件
        };
        cell2.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"4geiconditu"]];
        return cell2;
        
    }
    else if (indexPath.section==1)
    {
        QWMenuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:QWCellIdentifier_MenuTableViewCell forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
          cell.backgroundColor=[UIColor clearColor];
        [cell setContentAndImgArr:@[@"jihuo",
                                    @"qiandao",
                                    @"shangjia",
                                    @"kefu",
                                    @"aiche",
                                    @"fenxiang",
                                    @"duihuanlipin",
                                    @"quanzi"]
                    andContentArr:@[@"激活卡券",
                                    @"每日签到",
                                    @"商家入驻",
                                    @"客服咨询",
                                    @"我的爱车",
                                    @"分享赚钱",
                                    @"优惠活动",
                                    @"车友圈"]];
        cell.backgroundView                                 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"4geiconditu"]];
        QWCarFriendsCircleController *qwcarfriendscirclectl = [[QWCarFriendsCircleController alloc]init];
        QWExchangeViewController *exchangevctl              = [[QWExchangeViewController alloc]init];
        QWAddShopController *MerchantIn                     = [[QWAddShopController alloc]init];
        QWUserServiceController     *userService            = [[QWUserServiceController alloc]init];
        QWMyCarController           *myCar                  = [[QWMyCarController alloc]init];
        QWShareMoneyController      *shareMoney             = [[QWShareMoneyController alloc]init];
        QWSaleActivityController    *activity               = [[QWSaleActivityController alloc]init];
        
        PopupView *view = [PopupView defaultPopupView];
        view.parentVC   = self;
    
        cell.selecOptionIndexs=^(NSInteger index){
            switch (index) {
                case 0:
                    
                    [self.navigationController pushViewController:exchangevctl animated:YES];
                    
                    break;
                case 1:

                    [self Addsign];
//                    [self lew_presentPopupView:view animation:[LewPopupViewAnimationDrop new] dismissed:^{
//                        
//                        
//                    }];
                    break;
                case 2:
                    MerchantIn.hidesBottomBarWhenPushed         = YES;
                    [self.navigationController pushViewController:MerchantIn animated:YES];
                    break;
                case 3:
                    userService.hidesBottomBarWhenPushed        = YES;
                    [self.navigationController pushViewController:userService animated:YES];
                    break;
                case 4:
                    myCar.hidesBottomBarWhenPushed              = YES;
                    [self.navigationController pushViewController:myCar animated:YES];
                    break;
                case 5:
                    
                    shareMoney.hidesBottomBarWhenPushed         = YES;
                    [self.navigationController pushViewController:shareMoney animated:YES];
                    break;
                case 6:
                    
                    activity.hidesBottomBarWhenPushed           = YES;
                    [self.navigationController pushViewController:activity animated:YES];
                    break;
                case 7:
                    qwcarfriendscirclectl.hidesBottomBarWhenPushed      = YES;
                    [self.navigationController pushViewController:qwcarfriendscirclectl animated:YES];
                    break;
                    
                default:
                    break;
            }
#pragma mark-图片点击事件
        };
        return cell;
        
        
    }else if(indexPath.section==4)
    {
 
        UITableViewCell *cell2 = [tableView dequeueReusableCellWithIdentifier:cellstr forIndexPath:indexPath];
        cell2.selectionStyle = UITableViewCellSelectionStyleNone;
        cell2.backgroundColor=[UIColor clearColor];
        cell2.backgroundView.contentMode=UIViewContentModeScaleAspectFill;
        cell2.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"guanggao22"]];
        return cell2;
    
    }
    else if(indexPath.section==7){
        
        UITableViewCell *cell2 = [tableView dequeueReusableCellWithIdentifier:cellstr forIndexPath:indexPath];
        cell2.selectionStyle = UITableViewCellSelectionStyleNone;
        cell2.backgroundColor=[UIColor clearColor];
        cell2.backgroundView.contentMode=UIViewContentModeScaleAspectFill;
        cell2.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]];
        return cell2;
    }
    else{
        QWHomeDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:QWCellIdentifier_HomeDetailTableViewCell forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (self.GetUserRecordData.count!=0) {
            QWRecordModel *record = (QWRecordModel *)[self.GetUserRecordData objectAtIndex:indexPath.section-2];
            cell.RecordModel=record;
        }
        
       
        return cell;
        
        
    }
    
}
#pragma mark-签到数据请求
-(void)Addsign{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYYMMdd"];
    NSDate *datenow = [NSDate date];
    NSString *currentTimeString = [formatter stringFromDate:datenow];
    
    if([UdStorage getObjectforKey:UserSignTime])
    {
        if([[UdStorage getObjectforKey:UserSignTime] intValue]<[currentTimeString intValue])
        {
            NSDictionary *mulDic = @{
                                     @"Account_Id":[UdStorage getObjectforKey:Userid]
                                     };
            
            
            [AFNetworkingTool post:mulDic andurl:[NSString stringWithFormat:@"%@User/AddUserSign",Khttp] success:^(NSDictionary *dict, BOOL success) {
                NSLog(@"%@",dict);
                if([[dict objectForKey:@"ResultCode"] isEqualToString:[NSString stringWithFormat:@"%@",@"F000000"]])
                {
                    
                    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
                    [inputFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
                    [inputFormatter setDateFormat:@"yyyy/MM/dd"];
                    NSDate* inputDate = [inputFormatter dateFromString:[[dict objectForKey:@"JsonData"] objectForKey:@"SignTime"]];
                    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
                    [outputFormatter setLocale:[NSLocale currentLocale]];
                    [outputFormatter setDateFormat:@"yyyyMMdd"];
                    NSString *targetTime = [outputFormatter stringFromDate:inputDate];
                    
                    [UdStorage storageObject:targetTime forKey:UserSignTime];
                    
                    PopupView *view = [PopupView defaultPopupView];
                    view.parentVC = self;
                    
                    [self lew_presentPopupView:view animation:[LewPopupViewAnimationDrop new] dismissed:^{
                        
                    }];
                }
                
                else
                {
                    [self.view showInfo:@"签到失败" autoHidden:YES interval:2];
                }
                
                
                
            } fail:^(NSError *error) {
                [self.view showInfo:@"签到失败" autoHidden:YES interval:2];
            }];
            
        }
        else
        {
            [self.view showInfo:@"今天已经签过到了" autoHidden:YES interval:2];
        }
    }
    else
    {
#pragma mark-没签到
        NSDictionary *mulDic = @{
                                 @"Account_Id":[UdStorage getObjectforKey:Userid]
                                 };
       
        
        [AFNetworkingTool post:mulDic andurl:[NSString stringWithFormat:@"%@User/AddUserSign",Khttp] success:^(NSDictionary *dict, BOOL success) {
            NSLog(@"%@",dict);
            if([[dict objectForKey:@"ResultCode"] isEqualToString:[NSString stringWithFormat:@"%@",@"F000000"]])
            {
                
                NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
                [inputFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
                [inputFormatter setDateFormat:@"yyyy/MM/dd"];
                NSDate* inputDate = [inputFormatter dateFromString:[[dict objectForKey:@"JsonData"] objectForKey:@"SignTime"]];
                NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
                [outputFormatter setLocale:[NSLocale currentLocale]];
                [outputFormatter setDateFormat:@"yyyyMMdd"];
                NSString *targetTime = [outputFormatter stringFromDate:inputDate];
                
                [UdStorage storageObject:targetTime forKey:UserSignTime];
                
                PopupView *view = [PopupView defaultPopupView];
                view.parentVC = self;
                
                [self lew_presentPopupView:view animation:[LewPopupViewAnimationDrop new] dismissed:^{
                    
                }];
            }
            
            else
            {
                [self.view showInfo:@"签到失败" autoHidden:YES interval:2];
            }
            
            
            
        } fail:^(NSError *error) {
            [self.view showInfo:@"签到失败" autoHidden:YES interval:2];
        }];
        
    }

}
#pragma mark-组头组尾
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, QWScreenWidth, 100)];
    if(section==0){
        header.backgroundColor=[UIColor clearColor];
    }else{
        header.backgroundColor= [UIColor colorFromHex:@"#fafafa"];
    
    }
    
//    UIImageView *imagevie=[[UIImageView alloc]initWithFrame:CGRectMake(0, 10, QWScreenWidth,87)];
//    [header addSubview:imagevie];
//    if (section == 4) {
//        imagevie.contentMode=UIViewContentModeScaleAspectFill;
////        UIEdgeInsetsMake
//
//        imagevie.image=[UIImage imageNamed:@"guanggao22"];
//    } else {
//        UIImageView *imagevie=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, QWScreenWidth, 47)];
//        [header addSubview:imagevie];
//    }
    return header;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 2) {
        QWConsumerController      *consumerController     = [[QWConsumerController alloc]init];
        consumerController.hidesBottomBarWhenPushed             = YES;
        [self.navigationController pushViewController:consumerController animated:YES];
    }else if(indexPath.section==3){
        QWUserRightDetailViewController *UserRightDetailController     = [[QWUserRightDetailViewController alloc]init];
        UserRightDetailController.hidesBottomBarWhenPushed             = YES;
        [self.navigationController pushViewController:UserRightDetailController animated:YES];
    
    }else if(indexPath.section==5){
        QWCarWashingActivityViewController *CarWashingActivityController     = [[QWCarWashingActivityViewController alloc]init];
        CarWashingActivityController.hidesBottomBarWhenPushed             = YES;
        [self.navigationController pushViewController:CarWashingActivityController animated:YES];
    
    }
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(section==1||section==7){
        
        return 0;
        
    }else{
        return 10;
    }
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        return [QWMenuTableViewCell cellHeight:4] ;
    }else if (indexPath.section==1){
        return [QWMenuTableViewCell cellHeight:7];
        ;
    }else if (indexPath.section==2){
        return 171;
        ;
    }else{
        return 171;
    }
    
}

@end
