//
//  QWcollectionViewController.m
//  QWCarWashing
//
//  Created by apple on 2017/8/15.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "QWcollectionViewController.h"
#import "SalerListViewCell.h"
#import "UIScrollView+EmptyDataSet.h"//第三方空白页
@interface QWcollectionViewController ()<UITableViewDelegate, UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>

@property (nonatomic, weak) UITableView *favoriteListView;
@property (nonatomic, strong) NSMutableArray <QWMerchantModel *>*merchantModelars;
@end
#define QWCellIdentifier_salerListTableViewCell @"salerListCell"

@implementation QWcollectionViewController
-(NSMutableArray<QWMerchantModel *> *)merchantModelars{
    if (_merchantModelars==nil) {
        _merchantModelars=[NSMutableArray arrayWithCapacity:0];
    }
    return _merchantModelars;

}
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
    self.favoriteListView.emptyDataSetDelegate=self;
    self.favoriteListView.emptyDataSetSource=self;
    UINib *nib = [UINib nibWithNibName:@"SalerListViewCell" bundle:nil];
    
    [self.favoriteListView registerNib:nib forCellReuseIdentifier:QWCellIdentifier_salerListTableViewCell];
    self.favoriteListView.tableFooterView   = [[UIView alloc]initWithFrame:CGRectZero];
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
                //  [self.view showInfo:@"暂无更多数据" autoHidden:YES interval:2];
               
                [self.favoriteListView reloadData];
                [self.favoriteListView.mj_header endRefreshing];
            }
            else
            {
                for(int i=0;i<arr.count;i++){
                  QWMerchantModel *tempmodel= [[QWMerchantModel alloc]initWithDictionary:arr[i] error:nil];
                    [self.merchantModelars addObject:tempmodel];
                    
                
                }
               
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
    return self.merchantModelars.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SalerListViewCell *favoriCell = [tableView dequeueReusableCellWithIdentifier:QWCellIdentifier_salerListTableViewCell forIndexPath:indexPath];
    if (self.merchantModelars.count!=0) {
        favoriCell.Merchantmodel=self.merchantModelars[indexPath.row];
    }
    return favoriCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
#pragma mark - 无数据占位
//无数据占位
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView{
    return [UIImage imageNamed:@"shoucang_kongbai"];
}

- (CAAnimation *)imageAnimationForEmptyDataSet:(UIScrollView *)scrollView{
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath: @"shoucang_kongbai"];
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
    NSString *text = @"客官你还没收藏";
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:13.0f],
                                 NSForegroundColorAttributeName: [UIColor colorFromHex:@"#4a4a4a"]};
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}
//设置占位图空白页的背景色( 图片优先级高于文字)

- (UIColor *)backgroundColorForEmptyDataSet:(UIScrollView *)scrollView {
    return [UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
}
//设置按钮的文本和按钮的背景图片

//- (NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state  {
////    NSLog(@"buttonTitleForEmptyDataSet:点击上传照片");
////    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:17.0f]};
////    return [[NSAttributedString alloc] initWithString:@"点击上传照片" attributes:attributes];
//}
// 返回可以点击的按钮 上面带文字
- (NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state {
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:17.0f]};
    return [[NSAttributedString alloc] initWithString:@"" attributes:attribute];
}


- (UIImage *)buttonImageForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state {
    return [UIImage imageNamed:@"button_image"];
}
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
    return -64.f;
}


@end
