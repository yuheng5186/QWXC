//
//  QWPersonInfoDetailViewController.m
//  QWCarWashing
//
//  Created by apple on 2017/8/15.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "QWPersonInfoDetailViewController.h"
#import<AVFoundation/AVMediaFormat.h>
#import <AVFoundation/AVCaptureDevice.h>
#import "LKAlertView.h"

#import "QWChangePhoneController.h"
#import "QWChangeNameController.h"


@interface QWPersonInfoDetailViewController ()<UITableViewDelegate,UITableViewDataSource,LKActionSheetDelegate,LKAlertViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSString *sexString;
@property (nonatomic, strong) UIImageView *userImageView;

@end

@implementation QWPersonInfoDetailViewController
-(void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden=YES;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title      = @"个人信息";
    [self createSubView];
}
- (void) createSubView {
    self.navigationItem.leftBarButtonItem= [UIBarButtonItem setUibarbutonimgname:@"baisefanhui" andhightimg:@"" Target:self action:@selector(back:) forControlEvents:BtnTouchUpInside];
    self.tableView                  = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, QWScreenWidth,QWScreenheight)];
    self.tableView.backgroundColor = kColorTableBG;
    self.tableView.top              = 0;
    self.tableView.delegate         = self;
    self.tableView.dataSource       = self;
    self.tableView.scrollEnabled    = NO;
    self.tableView.tableFooterView  = [UIView new];
    self.tableView.tableHeaderView  = [UIView new];
    [self.view addSubview:self.tableView];
    
    
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }
}

-(void)back:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];

}

#pragma mark - UITableViewDataSource

-(CGFloat)tableView:(UITableView*)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return 10.0f;
    }
    return 0.01f;
}

-(CGFloat)tableView:(UITableView*)tableView heightForFooterInSection:(NSInteger)section

{
    return 10.0f;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            return 4;
            break;
        
        default:
            break;
    }
    return 0;
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 80;
    }else{
        return 50;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellStatic = @"cellStatic";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellStatic];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
    }
    cell.backgroundColor    = [UIColor whiteColor];
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.textColor    = [UIColor colorFromHex:@"#4a4a4a"];
    cell.textLabel.font         = [UIFont systemFontOfSize:15];
    cell.detailTextLabel.font   = [UIFont systemFontOfSize:14];
    if (indexPath.section == 0) {
        cell.textLabel.text     = @"头像";
        self.userImageView  = [UIUtil drawCustomImgViewInView:cell.contentView frame:CGRectMake(0, cell.contentView.centerY-Main_Screen_Height*11/667, Main_Screen_Width*60/375, Main_Screen_Height*60/667) imageName:@"gerenxinxitou"];
        self.userImageView.left          = QWScreenWidth*275/375;
        
        
    }else{
        if (indexPath.row == 0) {
            cell.textLabel.text         = @"昵称";
            cell.detailTextLabel.text   = @"15800781856";
            
        }else if (indexPath.row == 1){
            cell.textLabel.text         = @"手机号";
            cell.detailTextLabel.text   = @"15800781856";
        }
        else if(indexPath.row==2) {
            cell.textLabel.text         = @"性别";
            cell.detailTextLabel.text   = self.sexString;
        }else{
            cell.textLabel.text         = @"微信绑定";
            cell.detailTextLabel.text   = @"去绑定";
            
        }
        
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0) {
        
        
        AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        if (authStatus == AVAuthorizationStatusRestricted || authStatus ==AVAuthorizationStatusDenied){
            //无权限 做一个友好的提示
            //            UIAlertView * alart = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"请您设置允许APP访问您的相机->设置->隐私->相机" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil]; [alart show]; return ;
            
        } else {
            LKActionSheet *avatarSheet  = [[LKActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从相册中选择", nil];
            avatarSheet.tag             = 1001;
            [avatarSheet showInView:[AppDelegate sharedInstance].window.rootViewController.view];
        }
        
        
        
        
        
    }else if (indexPath.section == 1){
        if (indexPath.row == 0) {
            QWChangeNameController  *changeNameController   = [[QWChangeNameController alloc]init];
            changeNameController.hidesBottomBarWhenPushed   = YES;
            [self.navigationController pushViewController:changeNameController animated:YES];
            
        }else if (indexPath.row == 1){
            
            QWChangePhoneController *changePhone    = [[QWChangePhoneController alloc]init];
            changePhone.hidesBottomBarWhenPushed    = YES;
            [self.navigationController pushViewController:changePhone animated:YES];
            
        }else if (indexPath.row == 2){
            LKActionSheet *actionSheet = [[LKActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"男",@"女",nil];
            
            
            [actionSheet showInView:[AppDelegate sharedInstance].window.rootViewController.view];
        }else {
            
            LKAlertView *alartView      = [[LKAlertView alloc]initWithTitle:nil message:@"”金顶洗车“想要打开“微信”" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认"];
            [alartView show];
        }
    }


}
- (void)actionSheet:(LKActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSLog(@"点击了");
}
- (void)alertView:(LKAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSLog(@"点击");
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
