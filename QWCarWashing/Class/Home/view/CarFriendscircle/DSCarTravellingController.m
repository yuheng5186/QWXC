//
//  DSCarTravellingController.m
//  CarWashing
//
//  Created by Wuxinglin on 2017/7/21.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "DSCarTravellingController.h"
#import "ActivityListCell.h"
#import "DSCarClubDetailController.h"
@interface DSCarTravellingController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property (nonatomic,strong) NSString *area;


@property (nonatomic,strong) NSMutableArray *otherArray;

@property (nonatomic)NSInteger page;
@end

@implementation DSCarTravellingController
-(NSMutableArray *)dataArray{
    if (_dataArray==nil) {
        _dataArray=[NSMutableArray arrayWithCapacity:0];
    }
    return _dataArray;
}
-(NSMutableArray *)otherArray{
    if (_otherArray==nil) {
        _otherArray=[NSMutableArray arrayWithCapacity:0];
    }
    return _otherArray;
    
}
- (void) drawContent
{
    self.statusView.hidden      = YES;
    self.navigationView.hidden  = YES;
    self.contentView.top        = 0;
    self.contentView.height     = self.view.height;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _area = @"上海市";
    // Do any additional setup after loading the view.
    self.tableView                  = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width,Main_Screen_Height-Main_Screen_Height*100/667)];
    self.tableView.delegate         = self;
    self.tableView.dataSource       = self;
    self.tableView.top              = 0;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ActivityListCell" bundle:nil] forCellReuseIdentifier:@"ActivityListCell"];
    
    self.tableView.rowHeight        = Main_Screen_Height*205/667;
//    self.tableView.contentInset     = UIEdgeInsetsMake(0, 0, 180, 0);
    self.tableView.backgroundColor=kColorTableBG;
    [self.contentView addSubview:self.tableView];
    
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    [self setupRefresh];
    
}
-(void)setupRefresh
{
    self.tableView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        // 模拟延迟加载数据，因此2秒后才调用（真实开发中，可以移除这段gcd代码）
        
        [self headerRereshing];
        
    }];
    
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    
    [self.tableView.mj_header beginRefreshing];
    
    // 上拉刷新
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        // 模拟延迟加载数据，因此2秒后才调用（真实开发中，可以移除这段gcd代码）
        
        [self footerRereshing];
        
    }];
}
- (void)headerRereshing
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        
        self.page = 0 ;
        [self requestSelcectList];
        
    });
}


- (void)footerRereshing
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        if(self.dataArray.count == 0)
        {
            [self requestSelcectList];
        }
        else
        {
            self.page++;
            [self requestSelectListMore];
            
        }
        
        
        
        
        // 刷新表格
        
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        
    });
}
#pragma mark-车友圈列表查询更多
-(void)requestSelectListMore{
    NSDictionary *mulDic = @{
                             @"Account_Id":[UdStorage getObjectforKey:Userid],
                             @"Area":@"",
                             @"PageIndex":[NSString stringWithFormat:@"%ld",self.page],
                             @"PageSize":@10
                             };
    [AFNetworkingTool post:mulDic andurl:[NSString stringWithFormat:@"%@Activity/GetActivityList",Khttp] success:^(NSDictionary *dict, BOOL success) {
        NSLog(@"%@",dict);
        if([[dict objectForKey:@"ResultCode"] isEqualToString:[NSString stringWithFormat:@"%@",@"F000000"]])
        {
            //            [self.view showInfo:@"获取数据成功" autoHidden:YES interval:2];
            NSArray *arr = [NSArray array];
            arr = [dict objectForKey:@"JsonData"];
            for(NSDictionary *dic in arr)
            {
                QWCarClubNewsModel *news = [[QWCarClubNewsModel alloc]initWithDictionary:dict error:nil];
                [news setValuesForKeysWithDictionary:dic];
                [self.otherArray addObject:news];
            }
            if(self.otherArray.count == 0)
            {
                MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                hud.removeFromSuperViewOnHide =YES;
                hud.mode = MBProgressHUDModeText;
                hud.labelText = @"无更多数据";
                hud.minSize = CGSizeMake(132.f, 108.0f);
                [hud hide:YES afterDelay:3];
                [self.tableView.mj_footer endRefreshing];
                self.page--;
            }
            else
            {
                [self.dataArray addObjectsFromArray:self.otherArray];
                [self.tableView.mj_footer endRefreshing];
                [self.tableView reloadData];
            }
            
            
        }
        else
        {
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud.removeFromSuperViewOnHide =YES;
            hud.mode = MBProgressHUDModeText;
            hud.labelText = @"无更多数据";
            hud.minSize = CGSizeMake(132.f, 108.0f);
            [hud hide:YES afterDelay:3];
            [self.tableView.mj_footer endRefreshing];
            self.page--;
        }
        
    } fail:^(NSError *error) {
        [self.view showInfo:@"获取数据失败" autoHidden:YES interval:2];
        [self.tableView.mj_header endRefreshing];
    }];
    
}
#pragma mark-车友圈列表查询
-(void)requestSelcectList{
    [self.dataArray removeAllObjects];
    
    NSDictionary *mulDic = @{
                             @"Account_Id":[UdStorage getObjectforKey:Userid],
                             @"Area":self.area,
                             @"PageIndex":[NSString stringWithFormat:@"%ld",self.page],
                             @"PageSize":@10
                             };
    [AFNetworkingTool post:mulDic andurl:[NSString stringWithFormat:@"%@Activity/GetActivityList",Khttp] success:^(NSDictionary *dict, BOOL success) {
        
        NSLog(@"%@",dict);
        if([[dict objectForKey:@"ResultCode"] isEqualToString:[NSString stringWithFormat:@"%@",@"F000000"]])
        {
            //            [self.view showInfo:@"获取数据成功" autoHidden:YES interval:2];
            NSArray *arr = [NSArray array];
            arr = [dict objectForKey:@"JsonData"];
            for(NSDictionary *dic in arr)
            {
                QWCarClubNewsModel *news = [[QWCarClubNewsModel alloc]initWithDictionary:dic error:nil];
                [self.dataArray addObject:news];
            }
            [self.tableView.mj_header endRefreshing];
            [self.tableView reloadData];
            
        }
        else
        {
            [self.view showInfo:@"获取数据失败" autoHidden:YES interval:2];
            [self.tableView.mj_header endRefreshing];
        }
        
    } fail:^(NSError *error) {
        [self.view showInfo:@"获取数据失败" autoHidden:YES interval:2];
        [self.tableView.mj_header endRefreshing];
    }];
    
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

-(CGFloat)tableView:(UITableView*)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01f;
}

-(CGFloat)tableView:(UITableView*)tableView heightForFooterInSection:(NSInteger)section

{
    return 10.00f;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footervie=[UIView new];
    footervie.backgroundColor=[UIColor clearColor];
    return footervie;

}
#pragma mark --

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ActivityListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ActivityListCell" forIndexPath:indexPath];
    
    if (self.dataArray.count!=0) {
        cell.CarNewsModel=self.dataArray[indexPath.row];
    }
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    DSCarClubDetailController  *detailController    = [[DSCarClubDetailController alloc]init];
    if (self.dataArray.count!=0) {
        detailController.ActivityCode=((QWCarClubNewsModel *)self.dataArray[indexPath.section]).ActivityCode;
        NSLog(@"%ld",(long)((QWCarClubNewsModel *)self.dataArray[indexPath.section]).ActivityCode);
    }
    
    detailController.hidesBottomBarWhenPushed       = YES;
    [self.navigationController pushViewController:detailController animated:YES];
    
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
