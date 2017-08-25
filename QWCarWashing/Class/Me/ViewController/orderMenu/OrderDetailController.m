//
//  OrderDetailController.m
//  CarWashing
//
//  Created by 时建鹏 on 2017/8/7.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "OrderDetailController.h"
#import "OrderDetailView.h"

@interface OrderDetailController ()

@end

@implementation OrderDetailController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"订单详情";
    
    UIButton *leftButton = [[UIButton alloc]initWithFrame:CGRectMake(0,0,20,20)];
    [leftButton setImage:[UIImage imageNamed:@"baisefanhui"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem= leftItem;
    
    
    OrderDetailView *detailView = [OrderDetailView orderDetailView];
    detailView.frame = CGRectMake(0, 64, QWScreenWidth, QWScreenheight - 64);
    [self.view addSubview:detailView];
}

-(void)back
{
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
