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
#import "ShareWeChatController.h"

#import "QWSettingController.h"
#import "PopupView.h"
#import "LewPopupViewAnimationDrop.h"

#import "QWCardPackgeController.h"
#import "QWScoreController.h"

@interface QWMeViewController ()<UITableViewDelegate,UITableViewDataSource, SetTabBarDelegate>

{
    
    NSString *title;
    UIImage *image;
    NSURL *url;
    enum WXScene scene;
    
    NSArray *activity;
}
@property (nonatomic, strong) HYActivityView *activityView;


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
    [self.tableview reloadData];
}
- (void)viewDidLoad {
    
    
   
    [super viewDidLoad];
    [self setNagationLeftAndRightButton];
    [self.view addSubview:self.tableview];
//    [self.tableview reloadData];
    NSNotificationCenter * center = [NSNotificationCenter defaultCenter];
//    [center addObserver:self selector:@selector(noticeupdateUserName:)  name:@"updatenamesuccess" object:nil];
    [center addObserver:self selector:@selector(noticeupdateUserheadimg:) name:@"updateheadimgsuccess" object:nil];
}

-(void)noticeupdateUserheadimg:(NSNotification *)sender{
//        UIImageView *imageV = [[UIImageView alloc]init];
//        NSString *ImageURL=[NSString stringWithFormat:@"%@%@",kHTTPImg,[UdStorage getObjectforKey:@"Headimg"]];
//        NSURL *url=[NSURL URLWithString:ImageURL];
//        [imageV sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"touxiang"]];
    
//        [self.userImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",Khttp,imagestr]] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
//    self.userImageView.image=image;
//  }];
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
            QWPersonInfoDetailViewController *personInfo=[[QWPersonInfoDetailViewController alloc]init];
            [self.navigationController pushViewController:personInfo animated:YES];
        
        };
        

        
        cell.qiandaoClicked=^(void){
            [self Addsign];
//            PopupView *view = [PopupView defaultPopupView];
//            view.parentVC   = self;
//            [self lew_presentPopupView:view animation:[LewPopupViewAnimationDrop new] dismissed:^{
//                
//            }];
        
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
//        ShareWeChatController *shareVC = [[ShareWeChatController alloc] init];
//        shareVC.modalPresentationStyle = UIModalPresentationOverCurrentContext;
//        shareVC.delegate = self;
//        
//        self.tabBarController.tabBar.hidden = YES;
//        [self presentViewController:shareVC animated:NO completion:nil];
        
        if (!self.activityView)
        {
            self.activityView = [[HYActivityView alloc]initWithTitle:@"" referView:self.view];
            self.activityView.delegate = self;
            //横屏会变成一行6个, 竖屏无法一行同时显示6个, 会自动使用默认一行4个的设置.
            self.activityView.numberOfButtonPerLine = 6;
            
            ButtonView *bv ;
            
            bv = [[ButtonView alloc]initWithText:@"微信" image:[UIImage imageNamed:@"btn_share_weixin"] handler:^(ButtonView *buttonView){
                NSLog(@"点击微信");
                SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
                req.text                = @"简单文本分享测试";
                req.bText               = YES;
                // 目标场景
                // 发送到聊天界面  WXSceneSession
                // 发送到朋友圈    WXSceneTimeline
                // 发送到微信收藏  WXSceneFavorite
                req.scene               = WXSceneSession;
                [WXApi sendReq:req];
                
                self.tabBarController.tabBar.hidden = NO;
                
            }];
            [self.activityView addButtonView:bv];
            
            bv = [[ButtonView alloc]initWithText:@"微信朋友圈" image:[UIImage imageNamed:@"btn_share_pengyouquan"] handler:^(ButtonView *buttonView){
                NSLog(@"点击微信朋友圈");
                SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
                req.text                = @"简单文本分享测试";
                req.bText               = YES;
                // 目标场景
                // 发送到聊天界面  WXSceneSession
                // 发送到朋友圈    WXSceneTimeline
                // 发送到微信收藏  WXSceneFavorite
                req.scene               = WXSceneTimeline;
                [WXApi sendReq:req];
                self.tabBarController.tabBar.hidden = NO;
                
            }];
            [self.activityView addButtonView:bv];
            
            
        }
        self.tabBarController.tabBar.hidden = YES;
        
        [self.activityView show];
        
    
        
    }
    
}


#pragma mark-添加表头
//通过委托方法设置表头高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
        return 10;
    
}
//去掉组头的背景色
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *footerSection=[UIView new];
    footerSection.backgroundColor=[UIColor clearColor];
    return footerSection;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
   
        return 0;
  

}


#pragma mark - modal代理
- (void)setTabBarIsHide:(UIViewController *)VC {
    
    self.tabBarController.tabBar.hidden = NO;
}


@end
