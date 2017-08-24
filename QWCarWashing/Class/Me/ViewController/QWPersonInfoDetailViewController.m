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


@interface QWPersonInfoDetailViewController ()<UITableViewDelegate,UITableViewDataSource,LKActionSheetDelegate,LKAlertViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSString *sexString,*usernameString,*phoneString;
@property (nonatomic, strong) UIImageView *userImageView;

@end

@implementation QWPersonInfoDetailViewController
-(void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden=YES;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    NSMutableString *phonestr;
    if ([UdStorage getObjectforKey:UserPhone]!=nil) {
        phonestr = [[NSMutableString  alloc] initWithString:[UdStorage getObjectforKey:UserPhone]];
        [phonestr replaceCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
    }
    switch ([[UdStorage getObjectforKey:UserSex] intValue]) {
        case 0:
            
            self.sexString=@"男";
            break;
        case 1:
            
            self.sexString=@"女";
            break;
        default:
            break;
    }
    self.phoneString=phonestr;
    
    NSString *usernames=[UdStorage getObjectforKey:UserNamer]==nil?self.phoneString:[UdStorage getObjectforKey:UserNamer];
    self.usernameString=usernames;
    self.title      = @"个人信息";
    [self createSubView];
    NSNotificationCenter * center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(noticeupdateUserName:)  name:@"updatenamesuccess" object:nil];
    [center addObserver:self selector:@selector(noticeupdateUserPhone:)  name:@"updatephonesuccess" object:nil];
    
}
//修改手机通知
-(void)noticeupdateUserPhone:(NSNotification *)sender{
  
    NSString *phonestrs= [sender.userInfo objectForKey:@"userphone"];
    NSMutableString *phonestr = [[NSMutableString  alloc] initWithString:phonestrs];
    [phonestr replaceCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
    self.phoneString=phonestr;
    
    [self.tableView reloadData];
    
}
//修改昵称通知
-(void)noticeupdateUserName:(NSNotification *)sender{
    NSString *username= [sender.userInfo objectForKey:@"username"];

  
   
    self.usernameString=username;
    [self.tableView reloadData];
    
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
//去掉组尾的背景色
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footerSection=[UIView new];
    footerSection.backgroundColor=[UIColor clearColor];
    return footerSection;
    
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
        self.userImageView  = [UIUtil drawCustomImgViewInView:cell.contentView frame:CGRectMake(0, cell.contentView.centerY-Main_Screen_Height*11/667, Main_Screen_Width*60/375, Main_Screen_Height*60/667) imageName:@""];
#pragma mark-圆角
        self.userImageView.layer.cornerRadius=(Main_Screen_Height*60/667)/2;
        self.userImageView.layer.masksToBounds = YES;
        self.userImageView.contentMode=UIViewContentModeScaleAspectFill;
       
        [self.userImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kHTTPImg,[UdStorage getObjectforKey:@"Headimg"]]] placeholderImage:[UIImage imageNamed:@"gerenxinxitou"]];
        
        self.userImageView.left          = QWScreenWidth*275/375;
        
        
    }else{
        if (indexPath.row == 0) {
            cell.textLabel.text         = @"昵称";
            cell.detailTextLabel.text   = self.usernameString;
            
        }else if (indexPath.row == 1){
            cell.textLabel.text         = @"手机号";
            cell.detailTextLabel.text   = self.phoneString;
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
    
    if (actionSheet.tag == 1001)
    {
        
        switch (buttonIndex) {
            case 0:
            {
                UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
                if ([UIImagePickerController isSourceTypeAvailable:sourceType]) {
                    UIImagePickerController *picker     = [[UIImagePickerController alloc] init];
                    picker.sourceType                   = sourceType;
                    picker.delegate                     = self;
                    picker.allowsEditing                = YES;
                    [self presentViewController:picker animated:YES completion:nil];
                }
            }
                break;
            case 1:
            {
                UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                if ([UIImagePickerController isSourceTypeAvailable:sourceType]) {
                    UIImagePickerController *picker     = [[UIImagePickerController alloc] init];
                    picker.sourceType                   = sourceType;
                    picker.delegate                     = self;
                    picker.allowsEditing                = YES;
                    [self presentViewController:picker animated:YES completion:nil];
                }
            }
                break;
            default:
                break;
        }
        
    }
    else {
        UITableViewCell *cell   = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:1]];
        NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
        
        switch (buttonIndex) {
            case 0:
            {
                self.sexString = @"男";
                [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
                
                
                [self updateSexInfoAndsexstr:@"0" andupdatetypenum:@"4"];
                
                
                
                
            }
                break;
            case 1:
            {
                self.sexString = @"女";
                [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
                 [self updateSexInfoAndsexstr:@"1" andupdatetypenum:@"4"];
                
                
                
            }
                break;
            default:
                break;
        }
    }
}
#pragma mark-delegate 点击头像图片选择
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    UIImage *imagePick = [info objectForKey:UIImagePickerControllerEditedImage];
    [self dismissViewControllerAnimated:YES completion:nil];
    [self updateHeaderInfoAndimage:imagePick andupdatetypenum:@"1"];
}
//修改性别

-(void)updateSexInfoAndsexstr:(NSString*)sexstr andupdatetypenum:(NSString *)typenum{
    
    NSDictionary *mulDic = @{
                             @"Account_Id":[UdStorage getObjectforKey:@"Account_Id"],
                             @"ModifyType":typenum,
                             @"Sex":sexstr
                             };
    NSLog(@"%@",mulDic);
    [AFNetworkingTool post:mulDic andurl:[NSString stringWithFormat:@"%@User/UserInfoEdit",Khttp] success:^(NSDictionary *dict, BOOL success) {
        
        [UdStorage storageObject:sexstr forKey:@"userSex"];
        
        NSLog(@"%@",dict);
        //                    APPDELEGATE.currentUser.userSex = @"0";
        [self.tableView reloadData];
        
        
        
    } fail:^(NSError *error) {
        [self.view showInfo:@"设置失败" autoHidden:YES interval:2];
    }];
    
}
//修改头像数据
-(void)updateHeaderInfoAndimage:(UIImage*)headerimage andupdatetypenum:(NSString *)typenum{
    
    //头像1
    NSDictionary *mulDic = @{
                             @"Account_Id":[UdStorage getObjectforKey:@"Account_Id"],
                             @"ModifyType":typenum,
                             @"Headimg":[self imageToString:headerimage]
                             };
    
    NSLog(@"%@",mulDic);
   
    [AFNetworkingTool postimage:mulDic andurl:[NSString stringWithFormat:@"%@User/UserInfoEdit",Khttp] success:^(NSDictionary *dict, BOOL success) {
        
        NSLog(@"%@",dict);
        
        
        if([[dict objectForKey:@"ResultCode"] isEqualToString:[NSString stringWithFormat:@"%@",@"F000000"]])
        {
            
            //            APPDELEGATE.currentUser.Headimg = [[dict objectForKey:@"JsonData"] objectForKey:@"Headimg"];
//            UdStorage storageObject: forKey:@"Headimg"
//            [UdStorage storageObject:[[dict objectForKey:@"JsonData"] objectForKey:@"Headimg"] forKey:@"Headimg"];
//         [self.userImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",Khttp,[UdStorage getObjectforKey:@"Headimg"]]] placeholderImage:[UIImage imageNamed:@"gerenxinxitou"]];
////            刷新上一页面头像
//            NSNotification * notice = [NSNotification notificationWithName:@"updateheadimgsuccess" object:nil userInfo:nil];
//            [[NSNotificationCenter defaultCenter]postNotification:notice];
            APPDELEGATE.currentUser.Headimg = [[dict objectForKey:@"JsonData"] objectForKey:@"Headimg"];
            [UdStorage storageObject:[[dict objectForKey:@"JsonData"] objectForKey:@"Headimg"] forKey:UserHead];
            self.userImageView.image =headerimage ;
            
            NSNotification * notice = [NSNotification notificationWithName:@"updateheadimgsuccess" object:nil userInfo:nil];
            [[NSNotificationCenter defaultCenter]postNotification:notice];
            
        }
        else
        {
            [self.view showInfo:@"修改头像失败" autoHidden:YES interval:2];
        }
        
        
        
        
    } fail:^(NSError *error) {
        [self.view showInfo:@"设置失败" autoHidden:YES interval:2];
    }];
    
}
//将图片改成string类型
- (NSString *)imageToString:(UIImage *)image {
    NSData *imageData = UIImageJPEGRepresentation(image, 1.0);
    NSString *dataStr = [imageData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    
    NSLog(@"%@",dataStr);
    
    return dataStr;
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
