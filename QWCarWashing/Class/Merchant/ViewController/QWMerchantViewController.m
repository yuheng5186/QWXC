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

#define ScreenHeight [[UIScreen mainScreen] bounds].size.height
#define ScreenWidth [[UIScreen mainScreen] bounds].size.width

@interface QWMerchantViewController ()<UITableViewDelegate, UITableViewDataSource,YZPullDownMenuDataSource>
{
    AppDelegate *myDelegate;
}


@property (nonatomic, weak) UITableView *MerchantListtableview;
@property (nonatomic, strong) NSArray *titles;

@end

@implementation QWMerchantViewController

- (UITableView *)MerchantListtableview {
    if (nil == _MerchantListtableview) {
        UITableView *MerchantListtableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 64 + 49*myDelegate.autoSizeScaleY, ScreenWidth, ScreenHeight - 49 - 64 - 49*myDelegate.autoSizeScaleY) style:UITableViewStylePlain];
        _MerchantListtableview = MerchantListtableview;
        
        [self.view addSubview:MerchantListtableview];
        
    }
    return _MerchantListtableview;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    myDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    [self setupview];
    
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
    return 5;
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
    else
    {
        //删除cell的所有子视图
        while ([cell.contentView.subviews lastObject] != nil)
        {
            [(UIView*)[cell.contentView.subviews lastObject] removeFromSuperview];
        }
    }
    [cell setlayoutCell];
    [tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    //    NSDictionary *dic=[newslist objectAtIndex:indexPath.row];
    //    [cell setUpCellWithDic:dic];
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


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
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
