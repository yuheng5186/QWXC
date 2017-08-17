//
//  QWDiscountController.m
//  QWCarWashing
//
//  Created by Wuxinglin on 2017/8/16.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "QWDiscountController.h"

#import "DiscountCell.h"
#import "QWDiscountDetailController.h"

@interface QWDiscountController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) UITableView *discountView;

@end

static NSString *id_discountCell = @"id_discountCell";

@implementation QWDiscountController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor   = [UIColor whiteColor];
    
    self.discountView.delegate = self;
    self.discountView.dataSource = self;
    
    [self.discountView registerNib:[UINib nibWithNibName:@"DiscountCell" bundle:nil] forCellReuseIdentifier:id_discountCell];
    
    self.discountView.backgroundColor = [UIColor whiteColor];
    self.discountView.rowHeight = 80;
    
}

- (UITableView *)discountView {
    
    if (_discountView == nil) {
        
        UITableView *discountView = [[UITableView alloc] initWithFrame:CGRectInset(self.view.bounds, 10, 10) style:UITableViewStyleGrouped];
        _discountView = discountView;
        [self.view addSubview:_discountView];
    }
    return _discountView;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DiscountCell *cell = [tableView dequeueReusableCellWithIdentifier:id_discountCell forIndexPath:indexPath];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.1;
}


#pragma mark - 点击cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    QWDiscountDetailController *detailVC = [[QWDiscountDetailController alloc] init];
    detailVC.hidesBottomBarWhenPushed = YES;
    [super.navigationController pushViewController:detailVC animated:YES];
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
