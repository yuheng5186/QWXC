//
//  QWCardPackgeController.m
//  QWCarWashing
//
//  Created by Wuxinglin on 2017/8/16.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "QWCardPackgeController.h"
#import "QWDiscountCategoryView.h"
#import "QWDiscountController.h"
#import "QWRechargeController.h"

@interface QWCardPackgeController ()<UIScrollViewDelegate>

@property (nonatomic, weak) UIView *containerView;

@property (nonatomic, weak) UIScrollView *cardScrollView;

@property (nonatomic, weak) QWDiscountCategoryView *categoryView;

@end

@implementation QWCardPackgeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title  = @"卡包";

     [self setupUI];
}

- (void)setupUI {
    
    [self setupCategoryView];
    [self setupScrollView];
    
    [self addCardChildViewControllers];
    

}


- (void)addCardChildViewControllers{
    
    QWDiscountController *discountVC = [[QWDiscountController alloc] init] ;
    QWRechargeController *rechargeVC = [[QWRechargeController alloc] init];
    
    [self addChildViewController:discountVC];
    [self addChildViewController:rechargeVC];
    
    [_containerView addSubview:discountVC.view];
    [_containerView addSubview:rechargeVC.view];
    
    [discountVC didMoveToParentViewController:self];
    [rechargeVC didMoveToParentViewController:self];
    
    [discountVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.equalTo(_containerView);
        make.size.equalTo(_cardScrollView);
    }];
    
    [rechargeVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_containerView);
        make.leading.equalTo(discountVC.view.mas_trailing);
        make.size.equalTo(_cardScrollView);
    }];
    
}


#pragma mark - 设置分类视图
- (void)setupCategoryView{
    
    QWDiscountCategoryView *categoryView = [[QWDiscountCategoryView alloc] initWithFrame:CGRectMake(0, 64, Main_Screen_Width, 44)];
    
    _categoryView = categoryView;
    
    [self.view addSubview:categoryView];
    
    categoryView.categoryBlock = ^(NSInteger index){
        
        //修改scrollView的contentOffset
        [self.cardScrollView setContentOffset:CGPointMake(index * self.cardScrollView.width, 0) animated:YES];
    };
}



#pragma mark - 布局scrollView
- (void)setupScrollView {
    
    
    
    UIScrollView *cardScrollView =  [[UIScrollView alloc] init];
    _cardScrollView = cardScrollView;
    
    cardScrollView.delegate = self;
    cardScrollView.bounces = NO;
    cardScrollView.pagingEnabled = YES;
    
    [self.view addSubview:cardScrollView];
    
    [cardScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_categoryView.mas_bottom);
        make.leading.trailing.bottom.equalTo(self.view);
    }];
    
    
    //容器视图
    UIView *containerView = [[UIView alloc] init];
    _containerView = containerView;
    containerView.backgroundColor = [UIColor lightGrayColor];
    
    [cardScrollView addSubview:containerView];
    
    [containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(cardScrollView);
        make.width.equalTo(cardScrollView).multipliedBy(2);
        make.height.equalTo(cardScrollView);
    }];
    
}

#pragma mark - scrollView的代理方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if (scrollView.isTracking || scrollView.isDragging || scrollView.isDecelerating) {
        CGFloat offsetX = scrollView.contentOffset.x / 2;
        _categoryView.offsetX = offsetX;
    }
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
