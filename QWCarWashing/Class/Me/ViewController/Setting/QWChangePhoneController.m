//
//  QWChangePhoneController.m
//  QWCarWashing
//
//  Created by Mac WuXinLing on 2017/8/22.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "QWChangePhoneController.h"

@interface QWChangePhoneController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UITextField *phoneNumberText;
@property (nonatomic, strong) UITextField *verifyNumberFieldText;

@end

@implementation QWChangePhoneController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title      = @"修改手机号";
    
    [self createSubView];
}
- (void) createSubView {
    self.view.top                   = 0;
    self.view.backgroundColor       = [UIColor colorFromHex:@"#e6e6e6"];
    self.tableView                  = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width,Main_Screen_Height*200/667) style:UITableViewStyleGrouped];
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
- (void) nextButtonClick:(id)sender {
    
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
    
    return 5.01f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return Main_Screen_Height*60/667;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellStatic = @"cellStatic";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellStatic];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    }
    cell.backgroundColor    = [UIColor whiteColor];
    if (indexPath.row == 0) {
        self.phoneNumberText                = [[UITextField alloc]initWithFrame:CGRectMake(Main_Screen_Width*10/375, Main_Screen_Height*45/667, Main_Screen_Width-Main_Screen_Width*240/375, Main_Screen_Height*40/667)];
        //        self.phoneNumberText.placeholder    = @"输入验证码";
        self.phoneNumberText.placeholder    = @"15800781856";
        self.phoneNumberText.delegate       = self;
        self.phoneNumberText.returnKeyType  = UIReturnKeyDone;
        self.phoneNumberText.keyboardType   = UIKeyboardTypeNumberPad;
        self.phoneNumberText.textAlignment  = NSTextAlignmentLeft;
        self.phoneNumberText.font           = [UIFont systemFontOfSize:Main_Screen_Height*16/667];
        self.phoneNumberText.backgroundColor= [UIColor whiteColor];
        self.phoneNumberText.centerY        = cell.centerY+Main_Screen_Height*8/667;
        self.phoneNumberText.left           = Main_Screen_Width*10/375 ;
        
        [self.phoneNumberText addTarget:self action:@selector(phoneNumberTextChanged:) forControlEvents:UIControlEventEditingChanged];
        [cell.contentView addSubview:self.phoneNumberText];
        
        NSString *getVeriifyStr      = @"获取验证码";
        UIFont *getVeriifyStrFont          = [UIFont systemFontOfSize:Main_Screen_Height*16/667];
        UIButton *getVeriifyStrButton      = [UIUtil drawButtonInView:cell.contentView frame:CGRectMake(0, 0, Main_Screen_Width*110/375, Main_Screen_Height*40/667) text:getVeriifyStr font:getVeriifyStrFont color:[UIColor whiteColor] target:self action:@selector(getVeriifyBtnClick:)];
        getVeriifyStrButton.backgroundColor= [UIColor colorWithHex:0xFFB500 alpha:1.0];
        getVeriifyStrButton.layer.cornerRadius = Main_Screen_Height*20/667;
        getVeriifyStrButton.right          = Main_Screen_Width -Main_Screen_Width*10/375;
        getVeriifyStrButton.centerY        = self.phoneNumberText.centerY-Main_Screen_Height*5/667;
    }else if (indexPath.row == 1){
        self.verifyNumberFieldText                = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width-Main_Screen_Width*150/375, Main_Screen_Height*40/667)];
        self.verifyNumberFieldText.placeholder    = @"请输入验证码";
        self.verifyNumberFieldText.delegate       = self;
        self.verifyNumberFieldText.returnKeyType  = UIReturnKeyDone;
        self.verifyNumberFieldText.textAlignment  = NSTextAlignmentLeft;
        self.verifyNumberFieldText.keyboardType   = UIKeyboardTypeNumberPad;
        
        self.verifyNumberFieldText.font           = [UIFont systemFontOfSize:Main_Screen_Height*16/667];
        self.verifyNumberFieldText.backgroundColor= [UIColor whiteColor];
        self.verifyNumberFieldText.centerY        = cell.centerY;
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
- (void) getVeriifyBtnClick:(id)sender {
    
}

- (void) verifyNumberFieldTextChanged:(UITextField *)sender {
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
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