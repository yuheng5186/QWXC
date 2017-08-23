//
//  QWSettingController.m
//  QWCarWashing
//
//  Created by Wuxinglin on 2017/8/18.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "QWSettingController.h"
#import "QWPasswordController.h"
#import "QWAboutController.h"
#import "QWFeedbackController.h"
#import "QWGetScoreController.h"


@interface QWSettingController ()<UITableViewDelegate,UITableViewDataSource,LKAlertViewDelegate>
@property(nonatomic,strong) UIView *contentview;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation QWSettingController

- (void)viewDidLoad {
    [super viewDidLoad];
   
//    self.contentview=[[UIView alloc]initWithFrame:CGRectMake(0, 64,QWScreenWidth, QWScreenheight)];
//    
//    self.contentview.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1];
//    self.contentview.userInteractionEnabled = YES;
//    
    [self.view addSubview:self.contentView];
    // Do any additional setup after loading the view.
    self.title      = @"设置";
    [self createSubView];
   
}

- (UIView *)contentView
{
    if (!_contentview) {
        float contentViewTop = 64;
        float contentViewHeight;
        if (self.hidesBottomBarWhenPushed) {
            contentViewHeight = QWScreenheight-self.statusView.frame.size.height-self.navigationView.frame.size.height;
        } else {
            contentViewHeight = QWScreenheight-self.statusView.frame.size.height-self.navigationView.frame.size.height-self.tabBarController.tabBar.frame.size.height;
        }
        _contentview = [[UIView alloc] initWithFrame:CGRectMake(0, contentViewTop, self.view.frame.size.width, contentViewHeight)];
        _contentview.backgroundColor = [UIColor colorFromHex:@"#e5e5e5"];
        _contentview.userInteractionEnabled = YES;
        //        [UIUtil drawLineInView:_contentView frame:CGRectMake(0, 0, 0, 0) color:[UIColor clearColor]];
    }
    return _contentview;
}
- (void) createSubView {
    
    UIView *upView                  = [UIUtil drawLineInView:self.contentView frame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height*180/667) color:[UIColor whiteColor]];
    upView.top                      = 0;
    
    UIImage *appImage              = [UIImage imageNamed:@"denglu-icon-ditu"];
    UIImageView *appImageView      = [UIUtil drawCustomImgViewInView:upView frame:CGRectMake(0, 0, appImage.size.width/2, appImage.size.height/2) imageName:@"denglu-icon-ditu"];
    appImageView.top               = Main_Screen_Height*30/667;
    appImageView.centerX           = upView.centerX;
    
    NSString *showName              = @"分享蔷薇洗车，让您的好友可以下载蔷薇客户端";
    UIFont *showNameFont            = [UIFont systemFontOfSize:Main_Screen_Height*13/667];
    UILabel *showNameLabel          = [UIUtil drawLabelInView:upView frame:[UIUtil textRect:showName font:showNameFont] font:showNameFont text:showName isCenter:NO];
    showNameLabel.textColor         = [UIColor colorFromHex:@"#999999"];
    showNameLabel.top               = appImageView.bottom +Main_Screen_Height*25/667;
    showNameLabel.centerX           = appImageView.centerX;
    
    upView.height                   = showNameLabel.bottom +Main_Screen_Height*10/667;
    
    self.tableView                  = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width,Main_Screen_Height*200/667) ];
    self.tableView.top              = upView.bottom+1;
    self.tableView.delegate         = self;
    self.tableView.dataSource       = self;
    self.tableView.scrollEnabled    = NO;
     self.tableView.backgroundColor  = [UIColor whiteColor];
    [self.contentView addSubview:self.tableView];
    
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    
    UIButton *logoutButton      = [UIUtil drawDefaultButton:self.contentView title:@"退出当前帐号" target:self action:@selector(logoutButtonClick:)];
    logoutButton.top           = self.tableView.bottom;
    logoutButton.centerX       = upView.centerX;
    
    self.contentView.backgroundColor=[UIColor whiteColor];
    
}
- (void) logoutButtonClick:(id)sender {
    
    LKAlertView *alartView      = [[LKAlertView alloc]initWithTitle:@"提示" message:@"是否退出当前账户？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定"];
    alartView.tag               = 110;
    [alartView show];
    
}

#pragma mark - UITableViewDataSource

-(CGFloat)tableView:(UITableView*)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1.0f;
}
//
//-(CGFloat)tableView:(UITableView*)tableView heightForFooterInSection:(NSInteger)section
//
//{
//    return 0.01f;
//}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    

    return 3;
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellStatic = @"cellStatic";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellStatic];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
    }
    cell.backgroundColor    = [UIColor whiteColor];
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.textColor    = [UIColor blackColor];
    cell.textLabel.font         = [UIFont systemFontOfSize:15];
    
    if (indexPath.row == 0) {
        cell.textLabel.text     = @"密码管理";
        
    }else if (indexPath.row == 1){
        
        cell.textLabel.text     = @"关于蔷薇";
        
    }else {
        
        cell.textLabel.text     = @"给我评分";
    }
    
    //    if (indexPath.section == 0) {
    //        if (indexPath.row == 0) {
    //            cell.textLabel.text     = @"密码管理";
    //        }else{
    ////            cell.textLabel.text     = @"清除缓存";
    //        }
    //    }else if (indexPath.section == 1){
    //        if (indexPath.row == 0) {
    //            cell.textLabel.text     = @"关于金顶";
    //        }else {
    //            cell.textLabel.text     = @"意见反馈";
    //        }
    //
    //    }else{
    //        cell.textLabel.text     = @"给我评分";
    //
    //    }
    
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 0) {
        
        QWPasswordController *passwordController        = [[QWPasswordController alloc]init];
        passwordController.hidesBottomBarWhenPushed      = YES;
        [self.navigationController pushViewController:passwordController animated:YES];
        
    }else if (indexPath.row == 1){
        
        QWAboutController *aboutController             = [[QWAboutController alloc]init];
        aboutController.hidesBottomBarWhenPushed        = YES;
        [self.navigationController pushViewController:aboutController animated:YES];
        
    }else {
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/cn/app/qq/id451108668?mt=12"]];
        
    }
    
    
    //    if (indexPath.section == 0) {
    //        if (indexPath.row == 0) {
    //
    //            DSPasswordController *passwordController        = [[DSPasswordController alloc]init];
    //            passwordController.hidesBottomBarWhenPushed      = YES;
    //            [self.navigationController pushViewController:passwordController animated:YES];
    //
    //        }else{
    //            LKAlertView *alartView      = [[LKAlertView alloc]initWithTitle:@"提示框" message:@"目前缓存8M，您确定清空缓存么" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定"];
    //            alartView.tag               = 111;
    //            [alartView show];
    //        }
    //    }else if (indexPath.section == 1){
    //        if (indexPath.row == 0) {
    //
    //            DSAboutController *aboutController             = [[DSAboutController alloc]init];
    //            aboutController.hidesBottomBarWhenPushed        = YES;
    //            [self.navigationController pushViewController:aboutController animated:YES];
    //
    //        }else {
    //
    //            DSFeedbackController *feedbackController        = [[DSFeedbackController alloc]init];
    //            feedbackController.hidesBottomBarWhenPushed     = YES;
    //            [self.navigationController pushViewController:feedbackController animated:YES];
    //        }
    //
    //    }else{
    ////
    ////        DSGetScoreController *getScore                      = [[DSGetScoreController alloc]init];
    ////        getScore.hidesBottomBarWhenPushed                   = YES;
    ////        [self.navigationController pushViewController:getScore animated:YES];
    //        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/cn/app/qq/id451108668?mt=12"]];
    
    //    }
}

#pragma mark ---LKAlertViewDelegate---
- (void)alertView:(LKAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView.tag == 110) {
        if (buttonIndex == 0) {
            
        }else{
//            LoginViewController *loginViewControler     = [[LoginViewController alloc] init];
//            UINavigationController *navController       = [[UINavigationController alloc] initWithRootViewController:loginViewControler];
//            navController.navigationBar.hidden          = YES;
//            
//            [self presentViewController: navController animated: YES completion:nil];
            
        }
    }else{
        
        if (buttonIndex == 0) {
            
        }else{
            
            
        }
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
