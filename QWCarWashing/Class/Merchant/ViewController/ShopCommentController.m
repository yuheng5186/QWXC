//
//  ShopCommentController.m
//  CarWashing
//
//  Created by 时建鹏 on 2017/7/26.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "ShopCommentController.h"
//#import "BusinessEstimateCell.h"
#import "QWMccommentTableViewCell.h"
#import "UIScrollView+EmptyDataSet.h"//第三方空白页
@interface ShopCommentController ()<UITableViewDataSource, UITableViewDelegate,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>

@property (nonatomic, weak) UITableView *commentListView;
@property (nonatomic)NSInteger page;
@property (nonatomic, strong) NSMutableArray *MerchantCommentListData;
@property (nonatomic,copy) NSMutableArray <QWMerComListModel *> *MerComList;
@end

static NSString *id_commentShopCell = @"id_commentShopCell";

@implementation ShopCommentController

- (UITableView *)commentListView{
    if (_commentListView == nil) {
        UITableView *commenListView = [[UITableView alloc] initWithFrame:CGRectMake(0, 5, QWScreenWidth, QWScreenheight-5) style:UITableViewStyleGrouped];
        _commentListView = commenListView;
        [self.view addSubview:commenListView];
    }
    return _commentListView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.commentListView.delegate = self;
    self.commentListView.dataSource = self;
#pragma maek-空白页
    self.commentListView.emptyDataSetSource = self;
    self.commentListView.emptyDataSetDelegate = self;
    //可以去除tableView的多余的线，否则会影响美观
    self.commentListView.tableFooterView = [UIView new];
    [self.commentListView registerClass:[QWMccommentTableViewCell class] forCellReuseIdentifier:id_commentShopCell];
    self.commentListView.rowHeight = 110*Main_Screen_Height/667;
    self.commentListView.backgroundColor=kColorTableBG;
    [self setupRefresh];
}

-(void)setupRefresh
{
    self.commentListView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        // 模拟延迟加载数据，因此2秒后才调用（真实开发中，可以移除这段gcd代码）
        
        [self headerRereshing];
        
    }];
    
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    self.commentListView.mj_header.automaticallyChangeAlpha = YES;
    
    [self.commentListView.mj_header beginRefreshing];
    
    // 上拉刷新
    self.commentListView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        // 模拟延迟加载数据，因此2秒后才调用（真实开发中，可以移除这段gcd代码）
        
        [self footerRereshing];
        
    }];
}

- (void)headerRereshing
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        _MerchantCommentListData = [NSMutableArray new];
        
        self.page = 0 ;
        
        [self GetCommentDetail];
        
    });
}

-(NSMutableArray<QWMerComListModel *> *)MerComList{
    if (_MerComList==nil) {
        _MerComList=[NSMutableArray arrayWithCapacity:0];
    }
    return _MerComList;

}
- (void)footerRereshing
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        if(_MerchantCommentListData.count == 0)
        {
            [self GetCommentDetail];
        }
        else
        {
            self.page++;
            [self GetCommentDetail];
            
        }
        
        
        
        
        // 刷新表格
        
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        
    });
}

#pragma mark-请求商家评论数据
-(void)GetCommentDetail
{
    NSDictionary *mulDic = @{
                             @"MerCode":self.mercode,
                             @"PageIndex":[NSString stringWithFormat:@"%ld",self.page],
                             @"PageSize":@10
                             };
    
    [AFNetworkingTool post:mulDic andurl:[NSString stringWithFormat:@"%@MerChant/GetCommentDetail",Khttp] success:^(NSDictionary *dict, BOOL success) {
        
        if([[dict objectForKey:@"ResultCode"] isEqualToString:[NSString stringWithFormat:@"%@",@"F000000"]])
        {
            NSLog(@"%@",dict);
            NSArray *arr = [NSArray array];
            arr = [dict objectForKey:@"JsonData"];
            for (QWMerComListModel *comlistmodel in arr) {
                [self.MerComList addObject:comlistmodel];
            }
//            [self.MerchantCommentListData addObjectsFromArray:arr];
            [_commentListView.mj_header endRefreshing];
            [_commentListView reloadData];
        }
        else
        {
            [self.view showInfo:@"商家评论信息获取失败" autoHidden:YES interval:2];
            [_commentListView.mj_header endRefreshing];
        }
        
        
        
        
    } fail:^(NSError *error) {
        [self.view showInfo:@"获取失败" autoHidden:YES interval:2];
        [_commentListView.mj_header endRefreshing];
    }];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    if (self.MerComList.count==0) {
//        return 5;
//    }else
    return self.MerComList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QWMccommentTableViewCell *commentCell = [tableView dequeueReusableCellWithIdentifier:id_commentShopCell forIndexPath:indexPath];
    if (commentCell == nil)
    {
        commentCell = [[QWMccommentTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:id_commentShopCell];
    }
    if (self.MerComList.count!=0) {
        commentCell.ComList =self.MerComList[indexPath.row];
    }
    
    return commentCell;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UILabel *commentTitleLabel = [[UILabel alloc] init];
    commentTitleLabel.text = @"  评价(58)";
    commentTitleLabel.backgroundColor = [UIColor whiteColor];
    commentTitleLabel.textColor = [UIColor colorFromHex:@"#4a4a4a"];
    commentTitleLabel.font = [UIFont systemFontOfSize:14*Main_Screen_Height/667];
    
    return commentTitleLabel;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 40*Main_Screen_Height/667;
    
}

#pragma mark - 无数据占位
//无数据占位
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView{
    return [UIImage imageNamed:@"pinglun_kongbai"];
}

- (CAAnimation *)imageAnimationForEmptyDataSet:(UIScrollView *)scrollView{
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath: @"pinglun_kongbai"];
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
    NSString *text = @"暂无评价";
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:13.0f],
                                 NSForegroundColorAttributeName: [UIColor colorFromHex:@"#4a4a4a"]};
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}
//设置占位图空白页的背景色( 图片优先级高于文字)

- (UIColor *)backgroundColorForEmptyDataSet:(UIScrollView *)scrollView {
    return [UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
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
    return -64.f-74;
}
@end
