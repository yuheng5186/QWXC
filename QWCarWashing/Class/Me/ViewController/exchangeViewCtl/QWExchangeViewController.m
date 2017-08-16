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
    self.title=@"兑换";
    
    [self setupUI];
}
-(void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden=YES;
}

- (void)setupUI {
    self.view.backgroundColor=[UIColor colorWithHexString:@"#eaeaea"];
    UITextField *exchangeTF = [[UITextField alloc] init];
    exchangeTF.placeholder = @"请输入兑换码";
    exchangeTF.textAlignment = NSTextAlignmentCenter;
    exchangeTF.layer.cornerRadius = 24;
    exchangeTF.keyboardType = UIKeyboardTypeNumberPad;
    exchangeTF.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:exchangeTF];
    
    UIButton *exchangeBtn = [UIUtil drawDefaultButton:self.view title:@"兑换" target:self action:@selector(didClickExchangeScoreBtn:)];
    [exchangeBtn setBackgroundColor:RGBACOLOR(252, 186, 44, 1) ];
    
    [exchangeTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).mas_offset(64 + 23);
        make.centerX.equalTo(self.view);
        make.width.mas_equalTo(351);
        make.height.mas_equalTo(48);
    }];
    
    [exchangeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(exchangeTF.mas_bottom).mas_offset(60);
        make.centerX.equalTo(self.view);
        make.width.mas_equalTo(351);
        make.height.mas_equalTo(48);
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
