//
//  QWChangeNameController.m
//  QWCarWashing
//
//  Created by Mac WuXinLing on 2017/8/22.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "QWChangeNameController.h"
#import "MBProgressHUD.h"
#import "QWHowToUpGradeController.h"
#import "QWEarnScoreController.h"
#import "QWScoreController.h"

@interface QWChangeNameController ()<UITextFieldDelegate>
{
    MBProgressHUD *HUD;
}
@property (nonatomic, strong) UITextField *userNameText;


@end

@implementation QWChangeNameController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title      = @"修改姓名";
     [self createSubView];
    
    self.navigationItem.rightBarButtonItem  = [[UIBarButtonItem alloc]initWithTitle:@"确定" style:UIBarButtonItemStyleDone target:self action:@selector(sureButtonClick:)];
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:13],NSFontAttributeName, nil] forState:UIControlStateNormal];
    
}
- (void) createSubView {
    self.view.backgroundColor       = [UIColor colorFromHex:@"#e6e6e6"];
    UIView *upView                  = [UIUtil drawLineInView:self.view frame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height*60/667) color:[UIColor whiteColor]];
    upView.top                      = 74;
    
    self.userNameText                = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 40)];
    self.userNameText.placeholder    = self.userName;
    self.userNameText.delegate       = self;
    self.userNameText.returnKeyType  = UIReturnKeyDone;
    self.userNameText.textAlignment  = NSTextAlignmentLeft;
    self.userNameText.font           = [UIFont systemFontOfSize:16*Main_Screen_Height/667];
    self.userNameText.backgroundColor= [UIColor whiteColor];
    self.userNameText.top            = Main_Screen_Height*10/667;
    self.userNameText.left           = Main_Screen_Width*20/375 ;
//    self.userNameText.placeholder    =[UdStorage getObjectforKey:UserNamer];
    [self.userNameText addTarget:self action:@selector(userNameTextChanged:) forControlEvents:UIControlEventEditingChanged];
    [upView addSubview:self.userNameText];
    
}
- (void) userNameTextChanged:(UITextField *)sender {
    

    
    
    
}

- (void) sureButtonClick:(id)sender {
    if (self.userNameText.text.length) {
     
    }
    [self updateUserName:self.userNameText.text];
}
#pragma mark-修改昵称
-(void)updateUserName:(NSString *)username{
    HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HUD.removeFromSuperViewOnHide =YES;
    HUD.mode = MBProgressHUDModeIndeterminate;
    HUD.minSize = CGSizeMake(132.f, 108.0f);
    NSDictionary *mulDic = @{
                             @"Account_Id":[UdStorage getObjectforKey:@"Account_Id"],
                             @"ModifyType":@"2",
                             @"Name":username
                             };
   
    [AFNetworkingTool post:mulDic andurl:[NSString stringWithFormat:@"%@User/UserInfoEdit",Khttp] success:^(NSDictionary *dict, BOOL success) {
        
        if([[dict objectForKey:@"ResultCode"] isEqualToString:[NSString stringWithFormat:@"%@",@"F000000"]])
        {
            HUD.mode = MBProgressHUDModeCustomView;
            
            HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"success"]];
            HUD.mode = MBProgressHUDModeCustomView;
            HUD.animationType = MBProgressHUDAnimationZoom;
            HUD.removeFromSuperViewOnHide = YES;
            
            
            
            HUD.completionBlock = ^(){
                
                
                APPDELEGATE.currentUser.UserName = self.userNameText.text;
                
                [UdStorage storageObject:APPDELEGATE.currentUser.UserName forKey:@"Name"];
                [UdStorage storageObject:username forKey:UserNamer];
                            NSNotification * notice = [NSNotification notificationWithName:@"updatenamesuccess" object:nil userInfo:@{@"username":username}];
                            [[NSNotificationCenter defaultCenter]postNotification:notice];
                

                
                
                
                NSArray *vcsArray = [NSArray array];
                vcsArray= [self.navigationController viewControllers];
                NSInteger vcCount = vcsArray.count;
                
                
                
                if(vcCount <= 3)
                {
                    [self.navigationController popViewControllerAnimated:YES];
                }
                
                else
                {
                    UIViewController *lastVC = vcsArray[vcCount-3];
                    UIViewController *lasttwoVC = vcsArray[vcCount-4];
                    int index=[[self.navigationController viewControllers]indexOfObject:self];
                    //升等级
                    if([lastVC isKindOfClass:[QWHowToUpGradeController class]])
                    {
                        
                        NSNotification * notice = [NSNotification notificationWithName:@"Earnsuccess" object:nil userInfo:nil];
                        [[NSNotificationCenter defaultCenter]postNotification:notice];
                        
                        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:index-3]animated:YES];
                    }
                    //赚积分
                    else if([lastVC isKindOfClass:[QWEarnScoreController class]])
                    {
                        //金顶会员
                        if([lasttwoVC isKindOfClass:[QWScoreController class]])
                        {
                            NSNotification * notice = [NSNotification notificationWithName:@"Earnsuccess" object:nil userInfo:nil];
                            [[NSNotificationCenter defaultCenter]postNotification:notice];
                            [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:index-3]animated:YES];
                        }
                        NSNotification * notice = [NSNotification notificationWithName:@"Earnsuccess" object:nil userInfo:nil];
                        [[NSNotificationCenter defaultCenter]postNotification:notice];
                        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:index-4]animated:YES];
                    }
                    
                    
                }
                
                
                
                
            };
            
            [HUD hide:YES afterDelay:1.f];

        }
        else
        {
            [HUD hide:YES];
            [self.view showInfo:@"修改失败" autoHidden:YES interval:1];
        }
        
    } fail:^(NSError *error) {
        [HUD hide:YES];
        [self.view showInfo:@"修改失败" autoHidden:YES interval:1];
    }];

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
