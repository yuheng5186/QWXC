//
//  QWMerChantIntroViewController.m
//  QWCarWashing
//
//  Created by apple on 2017/8/15.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "QWMerChantIntroViewController.h"
#import "AppDelegate.h"

@interface QWMerChantIntroViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    AppDelegate *myDelegate;
}

@property (nonatomic, weak) UITableView *MerchantIntrotableview;

@end

@implementation QWMerChantIntroViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    myDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self setupview];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setupview
{
    UIButton *leftButton = [[UIButton alloc]initWithFrame:CGRectMake(0,0,20,20)];
    [leftButton setImage:[UIImage imageNamed:@"baisefanhui"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem= leftItem;
    
//    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, QWScreenWidth, QWScreenheight - 20*myDelegate.autoSizeScaleY)];
//    tableView.backgroundColor = [UIColor colorWithRed:246/255.f green:246/255.f blue:246/255.f alpha:1.0f];
//    _MerchantIntrotableview = tableView;
//    _MerchantIntrotableview.delegate = self;
//    _MerchantIntrotableview.dataSource = self;
//    self.automaticallyAdjustsScrollViewInsets=NO;
//    _MerchantIntrotableview.separatorStyle = NO;
//    _MerchantIntrotableview.showsVerticalScrollIndicator = NO;
//    [self.view addSubview:_MerchantIntrotableview];

}

-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
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
