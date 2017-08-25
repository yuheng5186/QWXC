//
//  QWcollectionViewController.m
//  QWCarWashing
//
//  Created by apple on 2017/8/15.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "QWcollectionViewController.h"
#import "SalerListViewCell.h"
@interface QWcollectionViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) UITableView *favoriteListView;
@end
#define QWCellIdentifier_salerListTableViewCell @"salerListCell"

@implementation QWcollectionViewController
- (UITableView *)favoriteListView{
    if (nil == _favoriteListView) {
        UITableView *favoriteListView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, QWScreenWidth, QWScreenheight)];
        [self.view addSubview:favoriteListView];
        _favoriteListView = favoriteListView;
    }
    
    return _favoriteListView;
}
-(void)viewWillAppear:(BOOL)animated{
     self.tabBarController.tabBar.hidden=YES;
}
- (void)setupUI {
   
    self.title=@"收藏";
    [self resetBabkButton];
    
    self.favoriteListView.delegate = self;
    self.favoriteListView.dataSource = self;
    
    UINib *nib = [UINib nibWithNibName:@"SalerListViewCell" bundle:nil];
    
    [self.favoriteListView registerNib:nib forCellReuseIdentifier:QWCellIdentifier_salerListTableViewCell];
    
    self.favoriteListView.rowHeight = 110;
    
}
#pragma mark-查询手册列表
-(void)requestMyFavouriteData
{
    NSDictionary *mulDic = @{
                             @"Account_Id":[UdStorage getObjectforKey:Userid],
                             @"Ym":@31.192255,
                             @"Xm":@121.52334,
                             @"PageIndex":@0,
                             @"PageSize":@10
                             };
    [AFNetworkingTool post:mulDic andurl:[NSString stringWithFormat:@"%@MerChant/GetFavouriteMerchant",Khttp] success:^(NSDictionary *dict, BOOL success) {
        if([[dict objectForKey:@"ResultCode"] isEqualToString:[NSString stringWithFormat:@"%@",@"F000000"]])
        {
            NSLog(@"==%@==",dict);
            NSArray *arr = [NSArray array];
            arr = [dict objectForKey:@"JsonData"];
            if(arr.count == 0)
            {
                //                [self.view showInfo:@"暂无更多数据" autoHidden:YES interval:2];
                [self.favoriteListView reloadData];
                [self.favoriteListView.mj_header endRefreshing];
            }
            else
            {
//                [self.MyFavouriteMerchantData addObjectsFromArray:arr];
                [self.favoriteListView reloadData];
                [self.favoriteListView.mj_header endRefreshing];
            }
            
            
        }
        else
        {
            [self.view showInfo:@"数据请求失败" autoHidden:YES interval:2];
            [self.favoriteListView.mj_header endRefreshing];
        }
        
        
        
        
        
        
    } fail:^(NSError *error) {
        [self.view showInfo:@"获取失败" autoHidden:YES interval:2];
        [self.favoriteListView.mj_header endRefreshing];
    }];
    
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SalerListViewCell *favoriCell = [tableView dequeueReusableCellWithIdentifier:QWCellIdentifier_salerListTableViewCell forIndexPath:indexPath];
    
    return favoriCell;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self requestMyFavouriteData];
    [self setupUI];
    // Do any additional setup after loading the view.
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
