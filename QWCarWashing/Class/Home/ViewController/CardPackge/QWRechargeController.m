//
//  QWRechargeController.m
//  QWCarWashing
//
//  Created by Wuxinglin on 2017/8/16.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "QWRechargeController.h"
#import "RechargeCell.h"
#import "QWRechargeDetailController.h"

@interface QWRechargeController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) UITableView *rechargeView;

@end

static NSString *id_rechargeCell = @"id_rechargeCell";

@implementation QWRechargeController


- (UITableView *)rechargeView {
    
    if (_rechargeView == nil) {
        UITableView *rechargeView = [[UITableView alloc] initWithFrame:CGRectInset(self.view.bounds, 10, 10) style:UITableViewStyleGrouped];
        _rechargeView = rechargeView;
        [self.view addSubview:_rechargeView];
    }
    return _rechargeView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor   = [UIColor whiteColor];
    
    self.rechargeView.delegate = self;
    self.rechargeView.dataSource = self;
    
    [self.rechargeView registerNib:[UINib nibWithNibName:@"RechargeCell" bundle:nil] forCellReuseIdentifier:id_rechargeCell];
    self.rechargeView.rowHeight = 100;
    self.rechargeView.backgroundColor = [UIColor whiteColor];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    RechargeCell *cell = [tableView dequeueReusableCellWithIdentifier:id_rechargeCell forIndexPath:indexPath];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.1;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPat{
    
    QWRechargeDetailController *rechargeDetailVC = [[QWRechargeDetailController alloc] init];
    rechargeDetailVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:rechargeDetailVC animated:YES];
    
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
