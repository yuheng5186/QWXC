//
//  QWMerchantInViewController.m
//  QWCarWashing
//
//  Created by apple on 2017/8/15.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "QWMerchantInViewController.h"
#import "QWMerchantInTableViewCell.h"
@interface QWMerchantInViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@property(nonatomic,strong)UITableView *tableview;

@property (nonatomic, strong) UITextField *merchantFieldText;
@property (nonatomic, strong) UITextField *phoneFieldText;
@property (nonatomic, strong) UITextField *addressFieldText;


@end

#define QWCellIdentifier_MerchantInTableViewCell @"QWMerchantInTableViewCell"

@implementation QWMerchantInViewController

-(UITableView *)tableview{
    
    if (_tableview==nil) {
        _tableview=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, QWScreenWidth, QWScreenheight)];
//        [_tableview registerClass:[UITableViewCell class] forCellReuseIdentifier:cellstr];
//        [_tableview registerClass:[QWMenuTableViewCell class] forCellReuseIdentifier:QWCellIdentifier_MenuTableViewCell];
        [_tableview registerNib:[UINib nibWithNibName:QWCellIdentifier_MerchantInTableViewCell bundle:[NSBundle mainBundle]] forCellReuseIdentifier:QWCellIdentifier_MerchantInTableViewCell];
        _tableview.delegate=self;
        _tableview.dataSource=self;
        _tableview.backgroundColor=kColorTableBG;
//        _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
//        _tableview.backgroundColor=[UIColor colorWithHexString:@"#eaeaea"];
        
    }
    
    if ([_tableview respondsToSelector:@selector(setSeparatorInset:)]) {
        [_tableview setSeparatorInset:UIEdgeInsetsZero];
    }
    
    return _tableview;
}
#pragma mark - UITableViewDataSource

-(CGFloat)tableView:(UITableView*)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01f;
}

-(CGFloat)tableView:(UITableView*)tableView heightForFooterInSection:(NSInteger)section

{
    return 10.0f;
}
//去掉组尾的背景色
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footerSection=[UIView new];
    footerSection.backgroundColor=[UIColor clearColor];
    return footerSection;
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            return 1;
            break;
        default:
            return 1;
            break;
    }
    return 1;
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
    cell.textLabel.textColor    = [UIColor colorFromHex:@"#999999"];
    
    if (indexPath.section == 0) {
        
        if (indexPath.row == 0) {
            cell.textLabel.text                   = @"商家名称";
            self.merchantFieldText                = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width-Main_Screen_Width*150/375, Main_Screen_Height*40/667)];
            self.merchantFieldText.placeholder    = @"请填写商家名称";
            self.merchantFieldText.delegate       = self;
            self.merchantFieldText.returnKeyType  = UIReturnKeyDone;
            self.merchantFieldText.textAlignment  = NSTextAlignmentLeft;
            self.merchantFieldText.font           = [UIFont systemFontOfSize:14];
            self.merchantFieldText.backgroundColor= [UIColor whiteColor];
            self.merchantFieldText.centerY        = cell.centerY +Main_Screen_Height*5/667;
            self.merchantFieldText.left           = Main_Screen_Width*120/375 ;
            
            [self.merchantFieldText addTarget:self action:@selector(merchantFieldTextChanged:) forControlEvents:UIControlEventEditingChanged];
            [cell.contentView addSubview:self.merchantFieldText];
        }
    }else if (indexPath.section == 1){
        
        if (indexPath.row == 0) {
            cell.textLabel.text                = @"联系电话";
            self.phoneFieldText                = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width-Main_Screen_Width*150/375, Main_Screen_Height*40/667)];
            self.phoneFieldText.placeholder    = @"请填写联系电话";
            self.phoneFieldText.delegate       = self;
            self.phoneFieldText.returnKeyType  = UIReturnKeyDone;
            self.phoneFieldText.keyboardType   = UIKeyboardTypeNumberPad;
            self.phoneFieldText.textAlignment  = NSTextAlignmentLeft;
            self.phoneFieldText.font           = [UIFont systemFontOfSize:14];
            self.phoneFieldText.backgroundColor= [UIColor whiteColor];
            self.phoneFieldText.centerY        = cell.centerY +Main_Screen_Height*5/667;
            self.phoneFieldText.left           = Main_Screen_Width*120/375 ;
            
            [self.phoneFieldText addTarget:self action:@selector(phoneFieldTextChanged:) forControlEvents:UIControlEventEditingChanged];
            [cell.contentView addSubview:self.phoneFieldText];
        }
        
    }else {
        cell.textLabel.text                  = @"联系地址";
        self.addressFieldText                = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width-Main_Screen_Width*150/375, Main_Screen_Height*40/667)];
        self.addressFieldText.placeholder    = @"请填写联系地址";
        self.addressFieldText.delegate       = self;
        self.addressFieldText.returnKeyType  = UIReturnKeyDone;
        self.addressFieldText.textAlignment  = NSTextAlignmentLeft;
        self.addressFieldText.font           = [UIFont systemFontOfSize:14];
        self.addressFieldText.backgroundColor= [UIColor whiteColor];
        self.addressFieldText.centerY        = cell.centerY +Main_Screen_Height*5/667;
        self.addressFieldText.left           = Main_Screen_Width*120/375 ;
        
        [self.addressFieldText addTarget:self action:@selector(addressFieldTextChanged:) forControlEvents:UIControlEventEditingChanged];
        [cell.contentView addSubview:self.addressFieldText];
    }
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
}

- (void) merchantFieldTextChanged:(UITextField *)sender {
    
    
}
- (void) phoneFieldTextChanged:(UITextField *)sender {
    
    
}
- (void) addressFieldTextChanged:(UITextField *)sender {
    
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableview];
    //右边试图
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"提交" style:UIBarButtonItemStyleDone target:self action:@selector(submitOnclick:)];
   self.title  = @"商家入驻";
    [self resetBabkButton];
}

#pragma mark-提交
-(void)submitOnclick:(UIButton *)sender{
    
}
- (void) resetBabkButton {
    
    UIButton *rightButton = [[UIButton alloc]initWithFrame:CGRectMake(0,0,20,20)];
    [rightButton setImage:[UIImage imageNamed:@"icon_titlebar_arrow"] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(backButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    self.navigationItem.leftBarButtonItem= rightItem;
}
- (void) backButtonClick:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
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
