//
//  QWWashCarTicketController.m
//  QWCarWashing
//
//  Created by Wuxinglin on 2017/8/18.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "QWWashCarTicketController.h"
#import "CarTicketView.h"

@interface QWWashCarTicketController ()

@end

@implementation QWWashCarTicketController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title      = @"体验卡";
    
    CarTicketView *ticketView = [CarTicketView carTicketView];
    ticketView.frame = CGRectMake(10, 64 + 50, Main_Screen_Width - 20, 90);
    [self.view addSubview:ticketView];
    
    UIButton *exchangeButton = [UIUtil drawDefaultButton:self.view title:@"1000积分兑换" target:self action:@selector(didClickExhangeButton:)];
    
    [exchangeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ticketView.mas_bottom).mas_offset(50);
        make.centerX.equalTo(self.view);
        make.height.mas_equalTo(48);
        make.width.mas_equalTo(351);
    }];
}
- (void)didClickExhangeButton:(UIButton *)button {
    
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
