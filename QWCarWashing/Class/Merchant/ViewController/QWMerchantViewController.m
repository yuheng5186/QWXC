//
//  QWMerchantViewController.m
//  QWCarWashing
//
//  Created by apple on 2017/8/14.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "QWMerchantViewController.h"
#import "AppDelegate.h"
#import "QWMclistTableViewCell.h"
#import "YZPullDownMenu.h"
#import "YZMenuButton.h"
#import "YZSortViewController.h"
#import "YZAllCourseViewController.h"
#import "QWCitySelectViewController.h"
#import "QWMerchantDetailViewController.h"
#import "QWMerchantModel.h"
#define ScreenHeight [[UIScreen mainScreen] bounds].size.height
#define ScreenWidth [[UIScreen mainScreen] bounds].size.width

@interface QWMerchantViewController ()<UITableViewDelegate, UITableViewDataSource,YZPullDownMenuDataSource>
{
    AppDelegate *myDelegate;
}

@property (nonatomic, strong) NSMutableDictionary *pramsDic;
@property (nonatomic, weak) UITableView *MerchantListtableview;
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) NSMutableArray *MerchantData;
@property (nonatomic,strong) NSMutableArray *otherArray;

@property (nonatomic)NSInteger page;
@end

@implementation QWMerchantViewController

- (UITableView *)MerchantListtableview {
    if (nil == _MerchantListtableview) {
        UITableView *MerchantListtableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 64+49+49*myDelegate.autoSizeScaleY, ScreenWidth, ScreenHeight - 49 - 64 - 49*myDelegate.autoSizeScaleY) style:UITableViewStylePlain];
        _MerchantListtableview = MerchantListtableview;
        
        [self.view addSubview:MerchantListtableview];
        
    }
    return _MerchantListtableview;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupview];
   
    myDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    self.pramsDic = [[NSMutableDictionary alloc]init];
    NSArray *array1 = [[NSArray alloc] initWithObjects:@"上海市",@"浦东新区", nil];
    NSDictionary *dic = @{@"0":array1,@"1":@"普洗-5座轿车",@"2":@"默认排序"};
    self.pramsDic  = [NSMutableDictionary dictionaryWithDictionary:dic];
    self.MerchantData = [[NSMutableArray alloc]init];
    self.page = 0;
    self.otherArray = [[NSMutableArray alloc]init];
    NSNotificationCenter *observer = [[NSNotificationCenter defaultCenter] addObserverForName:YZUpdateMenuTitleNote object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        
        // 获取列
        NSInteger col = [self.childViewControllers indexOfObject:note.object];
        
        // 获取所有值
        NSArray *allValues = note.userInfo.allValues;
        
        // 不需要设置标题,字典个数大于1，或者有数组
        if (allValues.count > 1 || [allValues.firstObject isKindOfClass:[NSArray class]]) return ;
        
        NSString *str = allValues.firstObject;
        if ([str containsString:@":"]) {
            NSArray *array = [allValues.firstObject componentsSeparatedByString:@":"];
            // 设置按钮标题
            [self.pramsDic setValue:array forKey:[NSString stringWithFormat:@"%ld",(long)col]];
        } else {
            // 设置按钮标题
            [self.pramsDic setValue:allValues.firstObject forKey:[NSString stringWithFormat:@"%ld",(long)col]];
        }
        
        
        [self.MerchantListtableview.mj_header beginRefreshing];
        //        [self headerRereshing];
        
        
        
    }];

    
    [self setupmenu];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setupview
{
    self.MerchantListtableview.delegate = self;
    self.MerchantListtableview.dataSource = self;
    self.automaticallyAdjustsScrollViewInsets=NO;
    self.MerchantListtableview.separatorStyle = NO;
    self.MerchantListtableview.showsVerticalScrollIndicator = NO;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //    if([newslist count]<=5)
    //    {
    //        return [newslist count];
    //    }
    //    else
    //    {
    return self.MerchantData.count;
//    return 5;
 
    //    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    UILabel *newsname=[UILabel new];
    //    newsname.text=[[newslist objectAtIndex:indexPath.row]objectForKey:@"title"];
    //    CGSize size = [newsname boundingRectWithSize:CGSizeMake(190*myDelegate.autoSizeScaleX,2000)];
    //    newsname.numberOfLines=0;
    //    //[newsname setFont:[UIFont fontWithName:@"MicrosoftYaHei" size:17]];
    //    newsname.lineBreakMode = NSLineBreakByWordWrapping;
    //    [newsname setFont:[UIFont fontWithName:@"Helvetica" size:12*myDelegate.autoSizeScaleX]];
    //
    //    [newsname sizeToFit];
    //    _H=size.height;
    //
    //    if(_H>25&&_H<40)
    //    {
    //        return _H+38.5*(myDelegate.autoSizeScaleY );
    //    }
    //    else if(_H>40)
    //    {
    //        return _H+38.5 * (myDelegate.autoSizeScaleY );
    //    }
    //    else
    
    NSLog(@"%f",105*(myDelegate.autoSizeScaleY));
    return 105*(myDelegate.autoSizeScaleY);
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier=@"Cell";
    [tableView registerClass:[QWMclistTableViewCell class] forCellReuseIdentifier:CellIdentifier];
    QWMclistTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if (cell == nil)
    {
        cell = [[QWMclistTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    [tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    
    if (self.MerchantData.count!=0) {
        QWMerchantModel *tempmodel=[self.MerchantData objectAtIndex:indexPath.row];
        [cell setMerchantmodel:tempmodel];

    }
   
    [cell setBackgroundColor:[UIColor clearColor]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //跳转商家详情
    QWMerchantDetailViewController *detailController = [[QWMerchantDetailViewController alloc] init];
    detailController.hidesBottomBarWhenPushed       = YES;
    [self.navigationController pushViewController:detailController animated:YES];
}
-(void)setupRefresh
{
    self.MerchantListtableview.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        // 模拟延迟加载数据，因此2秒后才调用（真实开发中，可以移除这段gcd代码）
        
        [self headerRereshing];
        
    }];
    
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    self.MerchantListtableview.mj_header.automaticallyChangeAlpha = YES;
    
    [self.MerchantListtableview.mj_header beginRefreshing];
    
    // 上拉刷新
    self.MerchantListtableview.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        // 模拟延迟加载数据，因此2秒后才调用（真实开发中，可以移除这段gcd代码）
        
        [self footerRereshing];
        
    }];
}

- (void)headerRereshing
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [_MerchantData removeAllObjects];
        //
        self.page = 0 ;
        [self setData];
        
    });
}

- (void)footerRereshing
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        if(_MerchantData.count == 0)
        {
            [self setData];
        }
        else
        {
            self.page++;
            _otherArray = [NSMutableArray new];
            [self setDatamore];
            
        }
        //
        //
        //
        //
        //        // 刷新表格
        //
        //        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        
    });
}
-(void)setData
{
    [self.MerchantData removeAllObjects];
    //    NSLog(@"%@",self.pramsDic);
    
    NSString *DefaultSort;
    
    if([[self.pramsDic objectForKey:@"2"] isEqualToString:@"默认排序"])
    {
        DefaultSort = @"1";
    }
    else if([[self.pramsDic objectForKey:@"2"] isEqualToString:@"附近优先"])
    {
        DefaultSort = @"2";
    }
    else if([[self.pramsDic objectForKey:@"2"] isEqualToString:@"评分最高"])
    {
        DefaultSort = @"3";
    }
    else
    {
        DefaultSort = @"4";
    }
    
    
    NSDictionary *mulDic = @{
                             @"City":[[self.pramsDic objectForKey:@"0"] objectAtIndex:0],
                             @"Area":[[self.pramsDic objectForKey:@"0"] objectAtIndex:1],
                             @"ShopType":@1,
                             @"ServiceCode":@101,
                             @"DefaultSort":DefaultSort,
                             @"Ym":@31.192255,
                             @"Xm":@121.52334,
                             @"PageIndex":@0,
                             @"PageSize":@10
                             };
    NSLog(@"%@",mulDic);
    
    [AFNetworkingTool post:mulDic andurl:[NSString stringWithFormat:@"%@MerChant/GetStoreList",Khttp] success:^(NSDictionary *dict, BOOL success) {
        
         NSLog(@"%@",dict);
        if([[dict objectForKey:@"ResultCode"] isEqualToString:[NSString stringWithFormat:@"%@",@"F000000"]])
        {
            NSArray *arr = [NSArray array];
            arr = [dict objectForKey:@"JsonData"];
            if(arr.count == 0)
            {
                //                [self.view showInfo:@"暂无更多数据" autoHidden:YES interval:2];
                [self.MerchantListtableview reloadData];
                [self.MerchantListtableview.mj_header endRefreshing];
            }
            else
            {
               
                for (NSDictionary *tmpDic in arr) {
                    QWMerchantModel *tmpModel = [[QWMerchantModel alloc]initWithDictionary:tmpDic error:nil];
                    //KVC 方式赋值
                    
//                    [tmpModel setValuesForKeysWithDictionary:tmpDic];
                    [self.MerchantData addObject:tmpModel];
                }
//
//                [self.MerchantData addObjectsFromArray:arr];
                [self.MerchantListtableview reloadData];
                [self.MerchantListtableview.mj_header endRefreshing];
            }
            
        }
        else
        {
            [self.view showInfo:@"数据请求失败" autoHidden:YES interval:2];
            [self.MerchantListtableview.mj_header endRefreshing];
        }
        
    } fail:^(NSError *error) {
        [self.view showInfo:@"获取失败" autoHidden:YES interval:2];
        [self.MerchantListtableview.mj_header endRefreshing];
    }];
    
}
-(void)setDatamore
{
    
    NSString *DefaultSort;
    
    if([[self.pramsDic objectForKey:@"2"] isEqualToString:@"默认排序"])
    {
        DefaultSort = @"1";
    }
    else if([[self.pramsDic objectForKey:@"2"] isEqualToString:@"附近优先"])
    {
        DefaultSort = @"2";
    }
    else if([[self.pramsDic objectForKey:@"2"] isEqualToString:@"评分最高"])
    {
        DefaultSort = @"3";
    }
    else
    {
        DefaultSort = @"4";
    }
    
    
    NSDictionary *mulDic = @{
                             @"City":[[self.pramsDic objectForKey:@"0"] objectAtIndex:0],
                             @"Area":[[self.pramsDic objectForKey:@"0"] objectAtIndex:1],
                             @"ShopType":@1,
                             @"ServiceCode":@101,
                             @"DefaultSort":DefaultSort,
                             @"Ym":@31.192255,
                             @"Xm":@121.52334,
                             @"PageIndex":[NSString stringWithFormat:@"%ld",self.page],
                             @"PageSize":@10
                             };
    NSDictionary *params = @{
                             @"JsonData" : [NSString stringWithFormat:@"%@",[AFNetworkingTool convertToJsonData:mulDic]],
                             @"Sign" : [NSString stringWithFormat:@"%@",[LCMD5Tool md5:[AFNetworkingTool convertToJsonData:mulDic]]]
                             };
    
    [AFNetworkingTool post:params andurl:[NSString stringWithFormat:@"%@MerChant/GetStoreList",Khttp] success:^(NSDictionary *dict, BOOL success) {
        
        if([[dict objectForKey:@"ResultCode"] isEqualToString:[NSString stringWithFormat:@"%@",@"F000000"]])
        {
            NSArray *arr = [NSArray array];
            arr = [dict objectForKey:@"JsonData"];
            if(arr.count == 0)
            {
                MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                hud.removeFromSuperViewOnHide =YES;
                hud.mode = MBProgressHUDModeText;
                hud.labelText = @"无更多数据";
                hud.minSize = CGSizeMake(132.f, 108.0f);
                [hud hide:YES afterDelay:3];
                [self.MerchantListtableview.mj_footer endRefreshing];
                self.page--;
            }
            else
            {
                [self.MerchantData addObjectsFromArray:arr];
                [self.MerchantListtableview reloadData];
                [self.MerchantListtableview.mj_footer endRefreshing];
            }
            
        }
        else
        {
            [self.view showInfo:@"数据请求失败" autoHidden:YES interval:2];
            [self.MerchantListtableview.mj_footer endRefreshing];
        }
        
    } fail:^(NSError *error) {
        [self.view showInfo:@"获取失败" autoHidden:YES interval:2];
        [self.MerchantListtableview.mj_header endRefreshing];
    }];
    
}
-(void)setupmenu
{
    // 创建下拉菜单
    YZPullDownMenu *menu = [[YZPullDownMenu alloc] init];
    menu.frame = CGRectMake(0, 64, QWScreenWidth ,39 * myDelegate.autoSizeScaleY);
    [self.view addSubview:menu];
    
    UIView *viewb = [[UIView alloc]initWithFrame:CGRectMake(0, 64+39* myDelegate.autoSizeScaleY, QWScreenWidth, 10* myDelegate.autoSizeScaleY)];
    viewb.backgroundColor = [UIColor colorWithRed:246/255.f green:246/255.f blue:246/255.f alpha:1.0f];
    [self.view addSubview:viewb];
    
    // 设置下拉菜单代理
    menu.dataSource = self;
    
    // 初始化标题
    _titles = @[@"上海市",@"全部门店",@"默认排序"];
    
    // 添加子控制器
    [self setupAllChildViewController];
    [self setupRefresh];
}

#pragma mark - 添加子控制器
- (void)setupAllChildViewController
{
    QWCitySelectViewController *cityVC = [[QWCitySelectViewController alloc] init];
    YZAllCourseViewController *allCourse = [[YZAllCourseViewController alloc] init];
    YZSortViewController *sort = [[YZSortViewController alloc] init];
    
    [self addChildViewController:cityVC];
    [self addChildViewController:allCourse];
    [self addChildViewController:sort];
    
}

#pragma mark - YZPullDownMenuDataSource
// 返回下拉菜单多少列
- (NSInteger)numberOfColsInMenu:(YZPullDownMenu *)pullDownMenu
{
    return 3;
}

// 返回下拉菜单每列按钮
- (UIButton *)pullDownMenu:(YZPullDownMenu *)pullDownMenu buttonForColAtIndex:(NSInteger)index
{
    YZMenuButton *button = [YZMenuButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:_titles[index] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor colorWithHexString:@"#999999"] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor colorWithHexString:@"#999999"] forState:UIControlStateSelected];
    [button setImage:[UIImage imageNamed:@"xiala"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"shangla"] forState:UIControlStateSelected];
    button.titleLabel.font = [UIFont systemFontOfSize:12];
    
    return button;
}

// 返回下拉菜单每列对应的控制器
- (UIViewController *)pullDownMenu:(YZPullDownMenu *)pullDownMenu viewControllerForColAtIndex:(NSInteger)index
{
    return self.childViewControllers[index];
}

// 返回下拉菜单每列对应的高度
- (CGFloat)pullDownMenu:(YZPullDownMenu *)pullDownMenu heightForColAtIndex:(NSInteger)index
{
    // 第1列 高度
    if (index == 0) {
        return 300;
    }
    
    // 第2列 高度
    if (index == 1) {
        return 180;
    }
    
    // 第3列 高度
    return 240;
}

-(void)viewWillAppear:(BOOL)animated
{
    //    如果不想让其他页面的导航栏变为透明 需要重置
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"ijanbiantiao"] forBarMetrics:0];
    [self.navigationController.navigationBar setShadowImage:nil];
}


CG_INLINE CGRect//注意：这里的代码要放在.m文件最下面的位置
CGRectMake1(CGFloat x, CGFloat y, CGFloat width, CGFloat height)
{
    AppDelegate *myDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    CGRect rect;
    rect.origin.x = x * myDelegate.autoSizeScaleX;
    rect.origin.y = y * myDelegate.autoSizeScaleY;
    rect.size.width = width * myDelegate.autoSizeScaleX;
    rect.size.height = height * myDelegate.autoSizeScaleY;
    return rect;
}


@end
