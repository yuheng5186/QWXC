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
#import "UIScrollView+EmptyDataSet.h"//第三方空白页
#define ScreenHeight [[UIScreen mainScreen] bounds].size.height
#define ScreenWidth [[UIScreen mainScreen] bounds].size.width

@interface QWMerchantViewController ()<UITableViewDelegate, UITableViewDataSource,YZPullDownMenuDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>
{
    AppDelegate *myDelegate;
}

@property (nonatomic, strong) NSMutableDictionary *pramsDic;
@property (nonatomic, weak) UITableView *MerchantListtableview;
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) NSMutableArray *MerchantData;
@property (nonatomic,strong) NSMutableArray *otherArray;
@property (nonatomic,strong) NSString *areastr;
@property (nonatomic,strong) NSString *citystr;

@property (nonatomic)NSInteger page;

@property (nonatomic)NSInteger weiyi;
@end

@implementation QWMerchantViewController

- (UITableView *)MerchantListtableview {
    if (nil == _MerchantListtableview) {
        UITableView *MerchantListtableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 64+49*Main_Screen_Height/667, ScreenWidth, ScreenHeight - 49 - 64 - 49*Main_Screen_Height/667) style:UITableViewStylePlain];
        _MerchantListtableview = MerchantListtableview;
        
        [self.view addSubview:MerchantListtableview];
        
    }
    return _MerchantListtableview;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
   
    self.areastr=@" ";
    self.citystr=@" ";
    
    myDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    
    [self setupmenu];
    
//    self.pramsDic = [[NSMutableDictionary alloc]init];
    NSArray *array1 = [[NSArray alloc] initWithObjects:[UdStorage getObjectforKey:@"City"],[UdStorage getObjectforKey:@"Quyu"], nil];
    
//    NSDictionary *dic = @{@"0":array1,@"1":@"普洗-5座轿车",@"2":@"默认排序"};
     NSDictionary *dic = @{@"0":array1,@"1":@"车身外部清洗维护",@"2":@"默认排序"};
    self.pramsDic  = [NSMutableDictionary dictionaryWithDictionary:dic];
    NSLog(@"%@==%@",array1, self.pramsDic );
    self.MerchantData = [[NSMutableArray alloc]init];
    self.page = 0;
    self.weiyi = 0;
    self.otherArray = [[NSMutableArray alloc]init];
    NSNotificationCenter *observer = [[NSNotificationCenter defaultCenter] addObserverForName:YZUpdateMenuTitleNote object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        
        // 获取列
        NSInteger col = [self.childViewControllers indexOfObject:note.object];
        if (col==0) {
            self.citystr=[[self.pramsDic objectForKey:@"0"] objectAtIndex:0];
            self.areastr=[[self.pramsDic objectForKey:@"0"] objectAtIndex:1];//区域
        }
        // 获取所有值
        NSArray *allValues = note.userInfo.allValues;
        
        // 不需要设置标题,字典个数大于1，或者有数组
        if (allValues.count > 1 || [allValues.firstObject isKindOfClass:[NSArray class]]) return ;
        
        NSString *str = allValues.firstObject;
        if ([str containsString:@":"]) {
            NSArray *array = [allValues.firstObject componentsSeparatedByString:@":"];
            self.citystr=array[0];
            self.areastr=array[1];

            // 设置按钮标题
            [self.pramsDic setValue:array forKey:[NSString stringWithFormat:@"%ld",(long)col]];
        } else {
            // 设置按钮标题
            [self.pramsDic setValue:allValues.firstObject forKey:[NSString stringWithFormat:@"%ld",(long)col]];
        }
        
        
        [self.MerchantListtableview.mj_header beginRefreshing];
        //        [self headerRereshing];
        
        
        
    }];

    [self setupview];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setupview
{
    self.MerchantListtableview.delegate = self;
    self.MerchantListtableview.dataSource = self;
    self.MerchantListtableview.emptyDataSetSource = self;
    self.MerchantListtableview.emptyDataSetDelegate = self;
    self.automaticallyAdjustsScrollViewInsets=NO;
    self.MerchantListtableview.separatorStyle = NO;
    self.MerchantListtableview.showsVerticalScrollIndicator = NO;

    [self setupRefresh];

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
    if (self.MerchantData.count!=0) {
        QWMerchantModel *tempmodel=(QWMerchantModel *)[self.MerchantData objectAtIndex:indexPath.row];
        detailController.MerCode                       = tempmodel.MerCode;
    }
   
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
    
    NSMutableArray *array = [[NSMutableArray alloc] initWithObjects:@"车身外部清洗维护",@"车内清洁-5座轿车",@"车内清洁SUV或7座", nil];
    
    NSInteger index;
    
    if ([array containsObject:[self.pramsDic objectForKey:@"1"]]) {
        
        index = [array indexOfObject:[self.pramsDic objectForKey:@"1"]];
        
    }
    
    
    
    
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
                             @"City":self.citystr,
                             @"Area":self.areastr,
                             @"ShopType":@1,
                             @"ServiceCode":[NSString stringWithFormat:@"10%ld",index+1],
                             @"DefaultSort":DefaultSort,
                             @"Ym":[UdStorage getObjectforKey:@"Ym"],
                             @"Xm":[UdStorage getObjectforKey:@"Xm"],
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
    
    
    NSMutableArray *array = [[NSMutableArray alloc] initWithObjects:@"车身外部清洗维护",@"车内清洁-5座轿车",@"车内清洁SUV或7座", nil];
    
    NSInteger index;
    
    if ([array containsObject:[self.pramsDic objectForKey:@"1"]]) {
        
        index = [array indexOfObject:[self.pramsDic objectForKey:@"1"]];
        
    }
    
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
                             @"City":self.citystr,
                             @"Area":self.areastr,
                             @"ShopType":@1,
                             @"ServiceCode":[NSString stringWithFormat:@"10%ld",index+1],
                             @"DefaultSort":DefaultSort,
                             @"Ym":[UdStorage getObjectforKey:@"Ym"],
                             @"Xm":[UdStorage getObjectforKey:@"Xm"],
                             @"PageIndex":[NSString stringWithFormat:@"%ld",self.page],
                             @"PageSize":@10
                             };
    
    [AFNetworkingTool post:mulDic andurl:[NSString stringWithFormat:@"%@MerChant/GetStoreList",Khttp] success:^(NSDictionary *dict, BOOL success) {
        
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
            self.page--;
        }
        
    } fail:^(NSError *error) {
        [self.view showInfo:@"获取失败" autoHidden:YES interval:2];
        [self.MerchantListtableview.mj_header endRefreshing];
        self.page--;
    }];
    
}
-(void)setupmenu
{
    // 创建下拉菜单
    YZPullDownMenu *menu = [[YZPullDownMenu alloc] init];
    menu.frame = CGRectMake(0, 64, QWScreenWidth ,39*QWScreenheight/667);
    [self.view addSubview:menu];
    
    UIView *viewb = [[UIView alloc]initWithFrame:CGRectMake(0, 64+39*QWScreenheight/667, QWScreenWidth, 10*QWScreenheight/667)];
    viewb.backgroundColor = [UIColor colorWithRed:246/255.f green:246/255.f blue:246/255.f alpha:1.0f];
    [self.view addSubview:viewb];
    
    // 设置下拉菜单代理
    menu.dataSource = self;
    
    NSLog(@"%@",[UdStorage getObjectforKey:@"Quyu"]);
    
    // 初始化标题
//    _titles = @[[UdStorage getObjectforKey:@"Quyu"],@"普洗-5座轿车",@"默认排序"];
    // 初始化标题
    _titles = @[[UdStorage getObjectforKey:@"City"],@"车身外部清洗维护",@"默认排序"];
    
    // 添加子控制器
    [self setupAllChildViewController];
    
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
    button.titleLabel.font = [UIFont systemFontOfSize:15* myDelegate.autoSizeScaleY];
    
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
        return 300* myDelegate.autoSizeScaleY;
    }
    
    // 第2列 高度
    if (index == 1) {
        return 200* myDelegate.autoSizeScaleY;
    }
    
    // 第3列 高度
    return 200* myDelegate.autoSizeScaleY;
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
#pragma mark - 无数据占位
//无数据占位
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView{
    return [UIImage imageNamed:@"Store"];
}

- (CAAnimation *)imageAnimationForEmptyDataSet:(UIScrollView *)scrollView{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath: @""];
    animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    animation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI_2, 0.0, 0.0,   1.0)];
    animation.duration = 0.25;
    animation.cumulative = YES;
    animation.repeatCount = MAXFLOAT;
    return animation;
}
//设置文字（上图下面的文字，我这个图片默认没有这个文字的）是富文本样式，扩展性很强！

//这个是设置标题文字的
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    NSString *text = @"暂时还没有商家信息";
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:13.0f],
                                 NSForegroundColorAttributeName: [UIColor colorFromHex: @"#4a4a4a"]};
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}
//设置占位图空白页的背景色( 图片优先级高于文字)

- (UIColor *)backgroundColorForEmptyDataSet:(UIScrollView *)scrollView {
    return [UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
}
////设置按钮的文本和按钮的背景图片
//- (NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state  {
//    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:18.0f],NSForegroundColorAttributeName:[UIColor whiteColor]};
//    return [[NSAttributedString alloc] initWithString:@"马上去洗车" attributes:attributes];
//}
//-(UIImage *)buttonBackgroundImageForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state{
////    return [UIImage imageNamed:@"qxiche"];
//}
//- (UIImage *)buttonImageForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state {
//    return [UIImage imageNamed:@"qxiche"];
//}
//是否显示空白页，默认YES
- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView {
    return YES;
}
//是否允许点击，默认YES
- (BOOL)emptyDataSetShouldAllowTouch:(UIScrollView *)scrollView {
    return NO;
}
//是否允许滚动，默认NO
- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView {
    return YES;
}
//图片是否要动画效果，默认NO
- (BOOL) emptyDataSetShouldAllowImageViewAnimate:(UIScrollView *)scrollView {
    return YES;
}
//空白页点击事件
- (void)emptyDataSetDidTapView:(UIScrollView *)scrollView {
    NSLog(@"空白页点击事件");
}
//空白页按钮点击事件
- (void)emptyDataSetDidTapButton:(UIScrollView *)scrollView {
    return NSLog(@"空白页按钮点击事件");
}
/**
 *  调整垂直位置
 */
- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView
{
    self.weiyi ++ ;
    if(self.weiyi == 1)
    {
        return -64.f;
    }
    if(self.weiyi == 2)
    {
        return -64.f;
    }
    else
    {
        return 0.f;
    }
}

@end
