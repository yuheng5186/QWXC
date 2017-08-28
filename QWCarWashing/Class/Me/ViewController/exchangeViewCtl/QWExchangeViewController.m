//
//  QWExchangeViewController.m
//  QWCarWashing
//
//  Created by apple on 2017/8/15.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "QWExchangeViewController.h"

@interface QWExchangeViewController ()

@end

@implementation QWExchangeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"激活";

    [self resetBabkButton];
    
    [self setupUI];
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

-(void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden=YES;
}

- (void)setupUI {
    self.view.backgroundColor=[UIColor colorWithHexString:@"#eaeaea"];
    UITextField *exchangeTF = [[UITextField alloc] init];
    exchangeTF.placeholder = @"请输入激活码";
    exchangeTF.textAlignment = NSTextAlignmentCenter;
    exchangeTF.layer.cornerRadius = 24*Main_Screen_Height/667;
    exchangeTF.keyboardType = UIKeyboardTypeNumberPad;
    exchangeTF.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:exchangeTF];
    
    UIButton *exchangeBtn = [UIUtil drawDefaultButton:self.view title:@"激活" target:self action:@selector(didClickExchangeScoreBtn:)];
    [exchangeBtn setBackgroundColor:RGBACOLOR(252, 186, 44, 1) ];
    
    [exchangeTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).mas_offset(64 + 25*Main_Screen_Height/667);
        make.centerX.equalTo(self.view);
        make.width.mas_equalTo(Main_Screen_Width*351/375);
        make.height.mas_equalTo(48*Main_Screen_Height/667);
    }];
    
    [exchangeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(exchangeTF.mas_bottom).mas_offset(60*Main_Screen_Height/667);
        make.centerX.equalTo(self.view);
        make.width.mas_equalTo(Main_Screen_Width*351/375);
        make.height.mas_equalTo(48*Main_Screen_Height/667);
    }];
    
}

- (void)didClickExchangeScoreBtn:(UIButton *)button {
    
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
