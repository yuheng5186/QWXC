//
//  QWLoginVC.m
//  QWCarWashing
//
//  Created by Mac WuXinLing on 2017/8/22.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "QWLoginVC.h"
#import "AppDelegate.h"
#import "QWTabBarController.h"
#import "QWAgreementVC.h"
#import "TPKeyboardAvoidingScrollView.h"

@interface QWLoginVC ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UITextField *userMobileFieldText;
@property (nonatomic, strong) UITextField *verifyFieldText;
@property (nonatomic, strong) TPKeyboardAvoidingScrollView *scrollView;

@property (nonatomic,strong) NSTimer *timer;
@property (nonatomic,assign) int second;
@property (nonatomic, strong) UIButton *getVeriifyStringButton;
@property (nonatomic, strong) UIButton *resendFakeBtn;

@end

@implementation QWLoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor               = [UIColor whiteColor];
    [self createSubView];
    
}
- (void) dealloc
{
    [self.timer invalidate];
}

- (void) createSubView {
    
    NSString   *headerString     = @"登录";
    UIFont     *headerFont       = [UIFont systemFontOfSize:Main_Screen_Height*20/667];
    UILabel *deaderLabel         = [UIUtil drawLabelInView:self.scrollView frame:CGRectMake(0, 0, Main_Screen_Width*150/375, Main_Screen_Height*30/667) font:headerFont text:headerString isCenter:NO];
    deaderLabel.textColor        = [UIColor colorFromHex:@"#febb02"];
    deaderLabel.textAlignment    = NSTextAlignmentCenter;
    
    deaderLabel.centerX          = Main_Screen_Width/2;
    deaderLabel.top              = Main_Screen_Height*30/667;
    
    //    UIImage *logoImage          = [UIImage imageNamed:@"WechatIMG3"];
    UIImageView *logoImageView  = [UIUtil drawCustomImgViewInView:self.scrollView frame:CGRectMake(0, 0, Main_Screen_Width*100/375, Main_Screen_Height*100/667) imageName:@"huiyuantou"];
    logoImageView.top           = deaderLabel.bottom +Main_Screen_Height*30/667;
    logoImageView.centerX       = Main_Screen_Width/2;
    
    NSString   *titleString     = @"蔷薇爱车";
    NSMutableAttributedString *attributed = [[NSMutableAttributedString alloc]initWithString:titleString];
//    CGAffineTransform matrix = CGAffineTransformMake(1, 0, tanf(-20 * (CGFloat)M_PI / 180), 1, 0, 0);
    UIFont     *titleFont       = [UIFont boldSystemFontOfSize:Main_Screen_Height*20/667];
    UILabel *titleLabel         = [UIUtil drawLabelInView:self.scrollView frame:CGRectMake(0, 0, Main_Screen_Width*150/375, Main_Screen_Height*30/667) font:titleFont text:titleString isCenter:NO];
    titleLabel.attributedText   = attributed;
//    titleLabel.transform        = matrix;
    titleLabel.textColor        = [UIColor colorFromHex:@"#febb02"];

    titleLabel.textAlignment    = NSTextAlignmentCenter;
    
    
    titleLabel.centerX          = Main_Screen_Width/2;
    titleLabel.top              = logoImageView.bottom +Main_Screen_Height*18/667;
    
//    NSString   *welcomeString     = @"欢迎登录金顶洗车APP";
//    UIFont     *welcomeFont       = [UIFont systemFontOfSize:Main_Screen_Height*14/667];
//    UILabel *welcomeLabel         = [UIUtil drawLabelInView:self.scrollView frame:CGRectMake(0, 0, Main_Screen_Width*200/375, Main_Screen_Height*30/667) font:welcomeFont text:welcomeString isCenter:NO];
//    welcomeLabel.textColor        = [UIColor colorFromHex:@"#febb02"];
//    welcomeLabel.textAlignment    = NSTextAlignmentCenter;
//    welcomeLabel.centerX          = Main_Screen_Width/2;
//    welcomeLabel.top              = titleLabel.bottom +Main_Screen_Height*10/667;
    
    
//        UIImage *backgroundImage            = [UIImage imageNamed:@"denglu-icon-ditu"];
    UIImageView  *backgroundImageView   = [UIUtil drawCustomImgViewInView:self.scrollView frame:CGRectMake(0, 0, Main_Screen_Width-Main_Screen_Width*10/375, Main_Screen_Height*168/667) imageName:@"qiangweidenglu-ditu"];
    backgroundImageView.contentMode=UIViewContentModeScaleAspectFill;
    backgroundImageView.top             = titleLabel.bottom +Main_Screen_Height*22/667;
    backgroundImageView.centerX         = Main_Screen_Width/2;
    
    
    self.tableView                  = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width*235/375,Main_Screen_Height*95/667) style:UITableViewStyleGrouped];
    self.tableView.top              = backgroundImageView.top +Main_Screen_Height*42/667;
    self.tableView.centerX          = backgroundImageView.centerX;
    self.tableView.delegate         = self;
    self.tableView.dataSource       = self;
    self.tableView.scrollEnabled    = NO;
    self.tableView.backgroundColor  = [UIColor whiteColor];
    self.tableView.tableFooterView  = [UIView new];
    [self.scrollView addSubview:self.tableView];
    
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    

    
    NSString *buttonString          = @"登录";
    UIFont   *buttonFont            = [UIFont systemFontOfSize:Main_Screen_Height*16/667];
    UIButton    *loginButton        = [UIButton buttonWithType:UIButtonTypeCustom];
    loginButton.frame               = CGRectMake(0, 0, Main_Screen_Width*300/375, Main_Screen_Height*45/667);
    [loginButton setBackgroundImage:[UIImage imageNamed:@"denglujianbiantiao"] forState:UIControlStateNormal];
    [loginButton setTitle:buttonString forState:UIControlStateNormal];
    loginButton.titleLabel.font     = buttonFont;
    [loginButton addTarget:self action:@selector(loginButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    loginButton.titleLabel.textColor= [UIColor whiteColor];
    loginButton.layer.cornerRadius  = Main_Screen_Height*5/667;
    loginButton.bottom              = backgroundImageView.bottom +Main_Screen_Height*60/667;
    loginButton.centerX             = Main_Screen_Width/2;
    [self.scrollView addSubview:loginButton];
    
    
    NSString   *remindString     = @"新用户验证码登录即可完成注册";
    UIFont     *remindFont       = [UIFont systemFontOfSize:Main_Screen_Height*12/667];
    UILabel *remindLabel         = [UIUtil drawLabelInView:self.scrollView frame:CGRectMake(0, 0, Main_Screen_Width*250/375, Main_Screen_Height*30/667) font:remindFont text:remindString isCenter:NO];
    remindLabel.textColor        = [UIColor colorFromHex:@"#999999"];
    remindLabel.textAlignment    = NSTextAlignmentCenter;
    remindLabel.centerX          = Main_Screen_Width/2;
    remindLabel.top              = loginButton.bottom +Main_Screen_Height*100/667;
    
    UIButton *updateRuleButton=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width*320/375, Main_Screen_Height*30/667)];
    [updateRuleButton setTitleColor:[UIColor colorFromHex:@"#293754"] forState:UIControlStateNormal];
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc] initWithString:@"注册即为同意《金顶洗车用户服务协议》"];
    NSRange titleRange = {0,[title length]};
    [title addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleNone] range:titleRange];
    [title addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:NSMakeRange(0, 6)];
    [title addAttribute:NSForegroundColorAttributeName value:[UIColor colorFromHex:@"#febb02"] range:NSMakeRange(6, 12)];
    
    [updateRuleButton setAttributedTitle:title forState:UIControlStateNormal];
    [updateRuleButton setBackgroundColor:[UIColor clearColor]];
    [updateRuleButton.titleLabel setFont:[UIFont systemFontOfSize:Main_Screen_Height*12/667]];
    [updateRuleButton addTarget:self action:@selector(agreeButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    updateRuleButton.top              = remindLabel.bottom +Main_Screen_Height*0/667;
    updateRuleButton.centerX          = loginButton.centerX;
    [self.view addSubview:updateRuleButton];
    
//    [self.scrollView addSubview:self.view];
    [self.view addSubview:self.scrollView];
    
    
}
- (TPKeyboardAvoidingScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[TPKeyboardAvoidingScrollView alloc] initWithFrame:self.view.bounds];
    }
    return _scrollView;
}
#pragma mark-登录按钮点击事件
- (void) loginButtonClick:(id)sender {
    
        if (self.userMobileFieldText.text.length == 11) {
            if (self.verifyFieldText.text.length == 4) {
                //请求数据
                [self requestLoginDataPhoneNum:self.userMobileFieldText.text andverify:self.verifyFieldText.text];
            }
            else{
                [self.view showInfo:@"请输入4位验证码！" autoHidden:YES interval:2];
            }
    
        }else {
            [self.view showInfo:@"请输入正确的11位手机号码" autoHidden:YES];
        }
    
}
#pragma mark-请求用户登录数据
-(void)requestLoginDataPhoneNum:(NSString *)phonenum andverify:(NSString *)Verify{
    
//    NSDictionary *mulDic = @{
//                             @"Mobile":phonenum,
//                             @"VerCode":Verify
//                             };
//        NSLog(@"==dic:%@===",mulDic);
//    [AFNetworkingTool post:mulDic andurl:[NSString stringWithFormat:@"%@User/Login",Khttp] success:^(NSDictionary *dict, BOOL success) {
//        
//        if([[dict objectForKey:@"ResultCode"] isEqualToString:[NSString stringWithFormat:@"%@",@"F000000"]])
//        {
//            NSLog(@"%@",[dict objectForKey:@"JsonData"]);
//            QWUserInfo *usertmpModel = [QWUserInfo new];
//            //KVC 方式赋值
//            [usertmpModel setValuesForKeysWithDictionary:[dict objectForKey:@"JsonData"]];
////            //数据本地化
//            [UdStorage storageObject:usertmpModel.Age forKey:@"userAge"];
//           [UdStorage storageObject:usertmpModel.UserName forKey:@"userName"];
//            [UdStorage storageObject:usertmpModel.Mobile forKey:@"userPhone"];
//            [UdStorage storageObject:usertmpModel.Sex forKey:@"userSex"];
//;
//            [UdStorage storageObject:[[dict objectForKey:@"JsonData"] objectForKey:@"Level_id"] forKey:@"Level_id"];
//            [UdStorage storageObject:[[dict objectForKey:@"JsonData"] objectForKey:@"Account_Id"] forKey:@"Account_Id"];
//              APPDELEGATE.currentUser = usertmpModel;
//
            QWTabBarController *menuTabBarController              = [[QWTabBarController alloc] init];
//                QWTabBarController *menuTabBarController=[[QWTabBarController alloc]init];
            menuTabBarController.tabBar.backgroundColor=[UIColor whiteColor];
            [AppDelegate sharedInstance].window.rootViewController  = menuTabBarController;
            
//        }
//        else
//        {
//            [self.view showInfo:@"验证码不正确" autoHidden:YES interval:2];
//        }
//        
//    } fail:^(NSError *error) {
//        [self.view showInfo:@"登录失败" autoHidden:YES interval:2];
//    }];
}

- (void) agreeButtonClick:(id)sender {
    
    QWLoginVC *agreeController      = [[QWLoginVC alloc]init];
    agreeController.hidesBottomBarWhenPushed    = YES;
    [self.navigationController pushViewController:agreeController animated:YES];
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 2;
    
}
- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 0.01f;
}
- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.01f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return Main_Screen_Height*46/667;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellStatic = @"cellStatic";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellStatic];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    }
    cell.backgroundColor    = [UIColor whiteColor];
    //    cell.imageView.image    = [UIImage imageNamed:@"btnImage"];
    if (indexPath.row == 0) {
        cell.imageView.image                = [UIImage imageNamed:@"yonghushouji"];
        
        self.userMobileFieldText                = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width-150, Main_Screen_Height*40/667)];
        self.userMobileFieldText.placeholder    = @"请输入手机号码";
        self.userMobileFieldText.delegate       = self;
        self.userMobileFieldText.returnKeyType  = UIReturnKeyDone;
        self.userMobileFieldText.keyboardType   = UIKeyboardTypeNumberPad;
        self.userMobileFieldText.textAlignment  = NSTextAlignmentLeft;
        self.userMobileFieldText.font           = [UIFont systemFontOfSize:Main_Screen_Height*16/667];
        self.userMobileFieldText.backgroundColor= [UIColor whiteColor];
        self.userMobileFieldText.top            = Main_Screen_Height*3/667;
        self.userMobileFieldText.left           = Main_Screen_Width*50/375 ;
        
        [self.userMobileFieldText addTarget:self action:@selector(userPhoneFieldTextChanged:) forControlEvents:UIControlEventEditingChanged];
        [cell.contentView addSubview:self.userMobileFieldText];
        
    }else
    {
        cell.imageView.image                = [UIImage imageNamed:@"mimayanzheng"];
        
        self.verifyFieldText                = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width-Main_Screen_Width*260/375, Main_Screen_Height*40/667)];
        self.verifyFieldText.placeholder    = @"输入验证码";
        self.verifyFieldText.delegate       = self;
        self.verifyFieldText.returnKeyType  = UIReturnKeyDone;
        self.verifyFieldText.keyboardType   = UIKeyboardTypeNumberPad;
        self.verifyFieldText.textAlignment  = NSTextAlignmentLeft;
        self.verifyFieldText.font           = [UIFont systemFontOfSize:Main_Screen_Height*16/667];
        //        self.verifyFieldText.backgroundColor= [UIColor grayColor];
        self.verifyFieldText.top            = Main_Screen_Height*3/667;
        self.verifyFieldText.left           = Main_Screen_Width*50/375 ;
        
        [self.verifyFieldText addTarget:self action:@selector(verifyFieldChanged:) forControlEvents:UIControlEventEditingChanged];
        [cell.contentView addSubview:self.verifyFieldText];
        
        NSString *getVeriifyString      = @"获取验证码";
        UIFont *getVeriifyStringFont          = [UIFont systemFontOfSize:Main_Screen_Height*12/667];
        self.getVeriifyStringButton      = [UIUtil drawButtonInView:cell.contentView frame:CGRectMake(0, 0, Main_Screen_Width*80/375, Main_Screen_Height*28/667) text:getVeriifyString font:getVeriifyStringFont color:[UIColor whiteColor] target:self action:@selector(getVeriifyByButtonClick:)];
        self.getVeriifyStringButton.backgroundColor=  [UIColor colorWithHex:0xFFB500 alpha:1.0];
        self.getVeriifyStringButton.layer.masksToBounds  = YES;
        self.getVeriifyStringButton.layer.cornerRadius = Main_Screen_Height*14/667;
        self.getVeriifyStringButton.right          = self.tableView.width;
        self.getVeriifyStringButton.centerY        = self.verifyFieldText.centerY;
        
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    return YES;
}


- (void) userPhoneFieldTextChanged:(UITextField *)sender {
    
    
    
    
}
- (void) verifyFieldChanged: (UITextField *) sender
{
    
}
- (void) getVeriifyByButtonClick:(id)sender {
    
    if (self.userMobileFieldText.text.length == 11) {
        
        
        [self startTimer];
//        [self requestVerifyNumAndPhoneNum:self.userMobileFieldText.text];
//        [self.view showInfo:@"验证码发送成功，请在手机上查收！" autoHidden:YES interval:2];
        
        
    }else
    {
        [self.view showInfo:@"请输入正确的11位手机号码" autoHidden:YES];
        
    }
}
#pragma mark-获取短信验证码
-(void)requestVerifyNumAndPhoneNum:(NSString *)phoneNum{
    NSDictionary *mulDic = @{@"Mobile":phoneNum};
    
    
    [AFNetworkingTool post:mulDic andurl:[NSString stringWithFormat:@"%@User/GetVerCode",Khttp] success:^(NSDictionary *dict, BOOL success) {
         NSLog(@"%@",dict);
        if([[dict objectForKey:@"ResultCode"] isEqualToString:[NSString stringWithFormat:@"%@",@"F000000"]])
        {
            [self.view showInfo:@"验证码发送成功，请在手机上查收！" autoHidden:YES interval:2];
        }else{
            [self.view showInfo:@"验证码发送失败" autoHidden:YES interval:2];

        }
       
    } fail:^(NSError *error) {
        NSLog(@"%@",@"fail");
    }];

}

- (void)startTimer
{
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
    self.second = 10;
    self.timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(onTimer) userInfo:nil repeats:YES];
    [self.timer fire];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSDefaultRunLoopMode];
}

- (void)onTimer
{
    if (self.second == 0) {
        
        [self.view showInfo:@"未收到验证码，请点击重新发送！" autoHidden:YES interval:2];
        self.getVeriifyStringButton.hidden = NO;
        self.resendFakeBtn.hidden = NO;
        self.getVeriifyStringButton.enabled = YES;
        self.resendFakeBtn.enabled = YES;
        [self.getVeriifyStringButton setTitle:@"重新发送" forState:UIControlStateNormal];
        //                [self.resendBtn setTitle:NSLocalizedString(@"Resend Code", nil) forState:UIControlStateNormal];
        //        self.secondLbl.text = @"";
        //        self.secondLbl.hidden = YES;
        [self.timer invalidate];
        
    } else {
        //        self.resendBtn.hidden = YES;
        self.getVeriifyStringButton.enabled = NO;
        self.resendFakeBtn.enabled = NO;
        //        [self.resendBtn setTitle:NSLocalizedString(@"Waiting", nil) forState:UIControlStateNormal];
        //        self.secondLbl.hidden = NO;
        NSString *text = [NSString stringWithFormat:@"%d%@",self.second--,@"s"];
        [self.getVeriifyStringButton setTitle:text forState:UIControlStateNormal];
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
