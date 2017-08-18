//
//  QWorderMenuViewController.m
//  QWCarWashing
//
//  Created by apple on 2017/8/15.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "QWorderMenuViewController.h"
#import "OrderCategoryView.h"
#import "AllOrderController.h"
#import "PayOrderController.h"
#import "CommentOrderController.h"
@interface QWorderMenuViewController ()<UIScrollViewDelegate>

@property (nonatomic, weak) UIView *containerView;

@property (nonatomic, weak) UIScrollView *orderScrollView;

@property (nonatomic, weak) OrderCategoryView *categoryView;



@end

@implementation QWorderMenuViewController


- (void)viewDidLoad {
    [super viewDidLoad];
     self.title=@"全部订单";
    [self setupUI];
}


- (void)setupUI {
    
    [self resetBabkButton];
    
    [self setupCategoryView];
    [self setupScrollView];
    
    [self addOrderChildViewControllers];
    
    
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

- (void)addOrderChildViewControllers {
    
    AllOrderController *allVC = [[AllOrderController alloc] init];
    PayOrderController *payVC = [[PayOrderController alloc] init];
    CommentOrderController *commentVC = [[CommentOrderController alloc] init];
    
    [self addChildViewController:allVC];
    [self addChildViewController:payVC];
    [self addChildViewController:commentVC];
    
    [_containerView addSubview:allVC.view];
    [_containerView addSubview:payVC.view];
    [_containerView addSubview:commentVC.view];
    
    [allVC didMoveToParentViewController:self];
    [payVC didMoveToParentViewController:self];
    [commentVC didMoveToParentViewController:self];
    
    
    [allVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.leading.equalTo(_containerView);
        make.size.equalTo(_orderScrollView);
    }];
    
    [payVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_containerView);
        make.leading.equalTo(allVC.view.mas_trailing);
        make.size.equalTo(_orderScrollView);
    }];
    
    [commentVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_containerView);
        make.leading.equalTo(payVC.view.mas_trailing);
        make.size.equalTo(_orderScrollView);
    }];
}



#pragma mark - 设置分类视图
- (void)setupCategoryView{
    
    OrderCategoryView *categoryView = [[OrderCategoryView alloc] initWithFrame:CGRectMake(0, 64, QWScreenWidth, 44)];
    
    _categoryView = categoryView;
    
    [self.view addSubview:categoryView];
    
    categoryView.categoryBlock = ^(NSInteger index){
        
        //修改scrollView的contentOffset
        [self.orderScrollView setContentOffset:CGPointMake(index * self.orderScrollView.width, 0) animated:YES];
    };
}



#pragma mark - 布局scrollView
- (void)setupScrollView {
    
    
    
    UIScrollView *orderScrollView =  [[UIScrollView alloc] init];
    _orderScrollView = orderScrollView;
    
    orderScrollView.delegate = self;
    orderScrollView.bounces = NO;
    orderScrollView.pagingEnabled = YES;
    
    [self.view addSubview:orderScrollView];
    
    [orderScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_categoryView.mas_bottom);
        make.leading.trailing.bottom.equalTo(self.view);
    }];
    
    
    //容器视图
    UIView *containerView = [[UIView alloc] init];
    _containerView = containerView;
    containerView.backgroundColor = [UIColor lightGrayColor];
    
    [orderScrollView addSubview:containerView];
    
    [containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(orderScrollView);
        make.width.equalTo(orderScrollView).multipliedBy(3);
        make.height.equalTo(orderScrollView);
    }];
    
}

#pragma mark - scrollView的代理方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if (scrollView.isTracking || scrollView.isDragging || scrollView.isDecelerating) {
        CGFloat offsetX = scrollView.contentOffset.x / 3;
        _categoryView.offsetX = offsetX;
    }
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
