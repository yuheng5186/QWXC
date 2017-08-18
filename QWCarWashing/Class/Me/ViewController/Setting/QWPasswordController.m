//
//  QWPasswordController.m
//  QWCarWashing
//
//  Created by Wuxinglin on 2017/8/18.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "QWPasswordController.h"

@interface QWPasswordController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UITextField *userMobileFieldText;
@property (nonatomic, strong) UITextField *verifyFieldText;
@property (nonatomic, strong) UITextField *passwordNewFieldText;
@property (nonatomic, strong) UITextField *passwordAgainFieldText;

@end

@implementation QWPasswordController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createSubView];
}

- (void) createSubView {
    
    self.tableView                  = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width,Main_Screen_Height*280/667) style:UITableViewStyleGrouped];
    self.tableView.top              = Main_Screen_Height*0/667;
    self.tableView.delegate         = self;
    self.tableView.dataSource       = self;
    self.tableView.scrollEnabled    = NO;
    self.tableView.tableFooterView  = [UIView new];
    //    self.tableView.tableHeaderView  = [UIView new];
    [self.view addSubview:self.tableView];
    
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    
    UIButton *submitButton      = [UIUtil drawDefaultButton:self.view title:@"提交" target:self action:@selector(submitButtonClick:)];
    submitButton.top           = self.tableView.bottom +Main_Screen_Height*40/667;
    submitButton.centerX       = Main_Screen_Width/2;
    
}
- (void) submitButtonClick:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 1;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
}

- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 10.0f;
}
-(CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 0.01f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellStatic = @"cellStatic";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellStatic];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    }
    cell.backgroundColor    = [UIColor whiteColor];
    //    cell.imageView.image    = [UIImage imageNamed:@"btnImage"];
    
    if (indexPath.section == 0) {
        cell.imageView.image                = [UIImage imageNamed:@"yonghushouji"];
        
        self.userMobileFieldText                = [[UITextField alloc]initWithFrame:CGRectMake(10, 45, Main_Screen_Width-Main_Screen_Width*70/375, Main_Screen_Height*40/667)];
        self.userMobileFieldText.placeholder    = @"15800781856";
        self.userMobileFieldText.delegate       = self;
        self.userMobileFieldText.clearButtonMode= UITextFieldViewModeAlways;
        self.userMobileFieldText.returnKeyType  = UIReturnKeyDone;
        self.userMobileFieldText.textAlignment  = NSTextAlignmentLeft;
        self.userMobileFieldText.font           = [UIFont systemFontOfSize:13];
        self.userMobileFieldText.backgroundColor= [UIColor whiteColor];
        self.userMobileFieldText.centerY        = cell.centerY;
        self.userMobileFieldText.left           = Main_Screen_Width*70/375 ;
        
        [self.userMobileFieldText addTarget:self action:@selector(userMobileFieldTextChanged:) forControlEvents:UIControlEventEditingChanged];
        [cell.contentView addSubview:self.userMobileFieldText];
    }else if (indexPath.section == 1){
        cell.imageView.image                = [UIImage imageNamed:@"mimayanzheng"];
        
        self.verifyFieldText                = [[UITextField alloc]initWithFrame:CGRectMake(10, 45, Main_Screen_Width-Main_Screen_Width*240/375, Main_Screen_Height*40/667)];
        self.verifyFieldText.placeholder    = @"输入验证码";
        self.verifyFieldText.delegate       = self;
        self.verifyFieldText.returnKeyType  = UIReturnKeyDone;
        self.verifyFieldText.textAlignment  = NSTextAlignmentLeft;
        self.verifyFieldText.font           = [UIFont systemFontOfSize:13];
        self.verifyFieldText.clearButtonMode= UITextFieldViewModeAlways;
        
        //        self.verifyFieldText.backgroundColor= [UIColor grayColor];
        self.verifyFieldText.centerY        = cell.centerY;
        self.verifyFieldText.left           = Main_Screen_Width*70/375 ;
        
        [self.verifyFieldText addTarget:self action:@selector(verifyFieldTextChanged:) forControlEvents:UIControlEventEditingChanged];
        [cell.contentView addSubview:self.verifyFieldText];
        
        NSString *getVeriifyString      = @"获取验证码";
        UIFont *getVeriifyStringFont          = [UIFont systemFontOfSize:14];
        UIButton *getVeriifyStringButton      = [UIUtil drawButtonInView:cell.contentView frame:CGRectMake(0, 0, Main_Screen_Width*90/375, Main_Screen_Height*30/667) text:getVeriifyString font:getVeriifyStringFont color:[UIColor whiteColor] target:self action:@selector(getVeriifyButtonClick:)];
        getVeriifyStringButton.backgroundColor=  [UIColor colorWithHex:0xFFB500 alpha:1.0];
        getVeriifyStringButton.layer.cornerRadius = 15;
        getVeriifyStringButton.right          = Main_Screen_Width -Main_Screen_Width*10/375;
        getVeriifyStringButton.centerY        = self.verifyFieldText.centerY;
    }else if (indexPath.section == 2){
        cell.imageView.image                = [UIImage imageNamed:@"mimasuo"];
        
        self.passwordNewFieldText                = [[UITextField alloc]initWithFrame:CGRectMake(10, 45, Main_Screen_Width-Main_Screen_Width*70/375, Main_Screen_Height*40/667)];
        self.passwordNewFieldText.placeholder    = @"请输入新密码";
        self.passwordNewFieldText.delegate       = self;
        self.passwordNewFieldText.returnKeyType  = UIReturnKeyDone;
        self.passwordNewFieldText.clearButtonMode= UITextFieldViewModeAlways;
        self.passwordNewFieldText.textAlignment  = NSTextAlignmentLeft;
        self.passwordNewFieldText.font           = [UIFont systemFontOfSize:13];
        self.passwordNewFieldText.backgroundColor= [UIColor whiteColor];
        self.passwordNewFieldText.centerY        = cell.centerY;
        self.passwordNewFieldText.left           = Main_Screen_Width*70/375 ;
        
        [self.verifyFieldText addTarget:self action:@selector(passwordNewFieldTextChanged:) forControlEvents:UIControlEventEditingChanged];
        [cell.contentView addSubview:self.passwordNewFieldText];
    }else{
        cell.imageView.image                = [UIImage imageNamed:@"mimasuo"];
        
        self.passwordAgainFieldText                = [[UITextField alloc]initWithFrame:CGRectMake(10, 45, Main_Screen_Width-Main_Screen_Width*70/375, Main_Screen_Height*40/667)];
        self.passwordAgainFieldText.placeholder    = @"再次输入密码";
        self.passwordAgainFieldText.delegate       = self;
        self.passwordAgainFieldText.returnKeyType  = UIReturnKeyDone;
        self.passwordAgainFieldText.textAlignment  = NSTextAlignmentLeft;
        self.passwordAgainFieldText.clearButtonMode= UITextFieldViewModeAlways;
        self.passwordAgainFieldText.font           = [UIFont systemFontOfSize:13];
        self.passwordAgainFieldText.backgroundColor= [UIColor whiteColor];
        self.passwordAgainFieldText.centerY        = cell.centerY;
        self.passwordAgainFieldText.left           = Main_Screen_Width*70/375 ;
        
        [self.passwordAgainFieldText addTarget:self action:@selector(passwordAgainFieldTextChanged:) forControlEvents:UIControlEventEditingChanged];
        [cell.contentView addSubview:self.passwordAgainFieldText];
        
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


- (void) userMobileFieldTextChanged:(UITextField *)sender {
    
    
}
- (void) verifyFieldTextChanged: (UITextField *) sender
{
    
}
- (void) getVeriifyButtonClick:(id)sender {
    
}

- (void) passwordNewFieldTextChanged: (UITextField *) sender
{
    
}
- (void) passwordAgainFieldTextChanged: (UITextField *) sender
{
    
}
- (void)textFieldDidEndEditing:(UITextField *)textField {
    
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
