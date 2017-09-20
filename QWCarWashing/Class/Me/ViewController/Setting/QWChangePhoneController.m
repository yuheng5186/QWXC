//
//  QWChangePhoneController.m
//  QWCarWashing
//
//  Created by Mac WuXinLing on 2017/8/22.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "QWChangePhoneController.h"
#import "QWUpdatePhoneNextVC.h"
@interface QWChangePhoneController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UITextField *phoneNumberText;
@property (nonatomic, strong) UITextField *verifyNumberFieldText;
@property (nonatomic, strong) NSString    *phoneString;
@property (nonatomic, strong) NSString    *verifyNumberString;
@property (nonatomic,strong) NSTimer *timer;
@property (nonatomic, strong)UIButton *getVeriifyStrButton;
@property (nonatomic,assign) int second;
@property (nonatomic, strong) UIButton *resendFakeBtn;

@end

@implementation QWChangePhoneController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title      = @"修改手机号";
    self.phoneString=[UdStorage getObjectforKey:UserPhone];
    [self createSubView];
}
- (void) createSubView {
    self.view.top                   = 0;
    self.view.backgroundColor       = [UIColor colorFromHex:@"#e6e6e6"];
    self.tableView                  = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width,Main_Screen_Height*200/667)];
    self.tableView.top              = 0;
    self.tableView.delegate         = self;
    self.tableView.dataSource       = self;
    self.tableView.scrollEnabled    = NO;
    //    self.tableView.tableFooterView  = [UIView new];
    //    self.tableView.tableHeaderView  = [UIView new];
    [self.view addSubview:self.tableView];
    
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    
    UIButton *nextButton      = [UIUtil drawDefaultButton:self.view title:@"下一步" target:self action:@selector(nextButtonClick:)];
    nextButton.top           = self.tableView.bottom +Main_Screen_Height*40/667;
    nextButton.centerX       = Main_Screen_Width/2;
    
}
#pragma mark- 3#修改手机
- (void) nextButtonClick:(id)sender {
   
    if (self.verifyNumberFieldText.text.length == 4 &&[self.verifyNumberFieldText.text isEqualToString:self.verifyNumberString]) {
         QWUpdatePhoneNextVC *updatePhoneNextvc=[[QWUpdatePhoneNextVC alloc]init];
         [self.navigationController pushViewController:updatePhoneNextvc animated:YES];
        
        }
        else{
            [self.view showInfo:@"请输入4位验证码！" autoHidden:YES interval:2];
        }
    
}
#pragma mark-修改手机
-(void)updatephonestr:(NSString *)phonestr{
    

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
    
    return 10.01f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60*Main_Screen_Height/667;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellStatic = @"cellStatic";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellStatic];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    }
    cell.backgroundColor    = [UIColor whiteColor];
    if (indexPath.row == 0) {
        self.phoneNumberText                = [[UITextField alloc]initWithFrame:CGRectMake(Main_Screen_Width*10/375, 0, Main_Screen_Width-Main_Screen_Width*240/375, Main_Screen_Height*40/667)];
        
        self.phoneNumberText.text    = self.phoneString;
        self.phoneNumberText.delegate       = self;
        self.phoneNumberText.returnKeyType  = UIReturnKeyDone;
        self.phoneNumberText.keyboardType   = UIKeyboardTypeNumberPad;
        self.phoneNumberText.textAlignment  = NSTextAlignmentLeft;
        self.phoneNumberText.font           = [UIFont systemFontOfSize:Main_Screen_Height*16/667];
        self.phoneNumberText.backgroundColor= [UIColor whiteColor];
        self.phoneNumberText.top            = Main_Screen_Height*10/667;
        self.phoneNumberText.left           = Main_Screen_Width*10/375 ;
        
        [self.phoneNumberText addTarget:self action:@selector(phoneNumberTextChanged:) forControlEvents:UIControlEventEditingChanged];
        [cell.contentView addSubview:self.phoneNumberText];
        
        NSString *getVeriifyStr      = @"获取验证码";
        UIFont *getVeriifyStrFont          = [UIFont systemFontOfSize:Main_Screen_Height*16/667];
        self.getVeriifyStrButton      = [UIUtil drawButtonInView:cell.contentView frame:CGRectMake(0, 0, Main_Screen_Width*110/375, Main_Screen_Height*40/667) text:getVeriifyStr font:getVeriifyStrFont color:[UIColor whiteColor] target:self action:@selector(getVeriifyBtnClick:)];
        self.getVeriifyStrButton.backgroundColor= [UIColor colorWithHex:0xFFB500 alpha:1.0];
        self.getVeriifyStrButton.layer.cornerRadius = self.getVeriifyStrButton.height/2;
        self.getVeriifyStrButton.right          = Main_Screen_Width -Main_Screen_Width*10/375;
        self.getVeriifyStrButton.top            = Main_Screen_Height*10/667;
    }else if (indexPath.row == 1){
        self.verifyNumberFieldText                = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width-Main_Screen_Width*150/375, Main_Screen_Height*40/667)];
        self.verifyNumberFieldText.placeholder    = @"请输入验证码";
        self.verifyNumberFieldText.delegate       = self;
        self.verifyNumberFieldText.returnKeyType  = UIReturnKeyDone;
        self.verifyNumberFieldText.textAlignment  = NSTextAlignmentLeft;
        self.verifyNumberFieldText.keyboardType   = UIKeyboardTypeNumberPad;
        
        self.verifyNumberFieldText.font           = [UIFont systemFontOfSize:Main_Screen_Height*16/667];
        self.verifyNumberFieldText.backgroundColor= [UIColor whiteColor];
        self.verifyNumberFieldText.top            = Main_Screen_Height*10/667;
        self.verifyNumberFieldText.left           = Main_Screen_Width*10/375;
        
        [self.verifyNumberFieldText addTarget:self action:@selector(verifyNumberFieldTextChanged:) forControlEvents:UIControlEventEditingChanged];
        [cell.contentView addSubview:self.verifyNumberFieldText];
        
        
    }else {
        
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}
- (void) phoneNumberTextChanged:(UITextField *)sender {
    
}
#pragma mark-获取验证码按钮
- (void) getVeriifyBtnClick:(id)sender {
    if (self.phoneNumberText.text.length == 11) {
        
        
        [self startTimer];
        [self requestVerifyNumAndPhoneNum:self.phoneNumberText.text];
        
        
        
    }else
    {
        [self.view showInfo:@"请输入正确的11位手机号码" autoHidden:YES];
        
    }
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
        self.getVeriifyStrButton.hidden = NO;
        self.resendFakeBtn.hidden = NO;
        self.getVeriifyStrButton.enabled = YES;
        self.resendFakeBtn.enabled = YES;
        [self.getVeriifyStrButton setTitle:@"重新发送" forState:UIControlStateNormal];
        
        [self.timer invalidate];
        
    } else {
        
        self.getVeriifyStrButton.enabled = NO;
        self.resendFakeBtn.enabled = NO;
        //        [self.resendBtn setTitle:NSLocalizedString(@"Waiting", nil) forState:UIControlStateNormal];
        //        self.secondLbl.hidden = NO;
        NSString *text = [NSString stringWithFormat:@"%d%@",self.second--,@"s"];
        [self.getVeriifyStrButton setTitle:text forState:UIControlStateNormal];
    }
}

#pragma mark-获取短信验证码
-(void)requestVerifyNumAndPhoneNum:(NSString *)phoneNum{
    NSDictionary *mulDic = @{@"Mobile":phoneNum};
    
    
    [AFNetworkingTool post:mulDic andurl:[NSString stringWithFormat:@"%@User/GetVerCode",Khttp] success:^(NSDictionary *dict, BOOL success) {
        NSLog(@"%@",dict);
        if([[dict objectForKey:@"ResultCode"] isEqualToString:[NSString stringWithFormat:@"%@",@"F000000"]])
        {
            self.verifyNumberString=[[dict objectForKey:@"JsonData"] objectForKey:@"VerCode"];
            [self.view showInfo:@"验证码发送成功，请在手机上查收！" autoHidden:YES interval:2];
        }else{
            [self.view showInfo:@"验证码发送失败" autoHidden:YES interval:2];
            
        }
        
    } fail:^(NSError *error) {
        NSLog(@"%@",@"fail");
    }];
    
}
- (void) verifyNumberFieldTextChanged:(UITextField *)sender {
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self.view endEditing:YES];
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
