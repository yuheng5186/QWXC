//
//  QWAboutStoreViewController.m
//  QWCarWashing
//
//  Created by apple on 2017/8/15.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "QWAboutStoreViewController.h"
#import "AppDelegate.h"
#import "QWStoreCategory.h"
#import "QWMerChantIntroViewController.h"
#import "QWMerChantCommentViewController.h"

@interface QWAboutStoreViewController ()<UIScrollViewDelegate>
{
    AppDelegate *myDelegate;
}

@property (nonatomic, weak) UIView *containerView;

@property (nonatomic, weak) UIScrollView *shopScrollView;

@property (nonatomic, weak) QWStoreCategory *categoryView;

@end

@implementation QWAboutStoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    myDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self setupview];
    
    [self setupCategoryView];
    [self setupScrollView];
    [self addChildViewControllers];
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
}

-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)addChildViewControllers{
    //门店简介
    QWMerChantIntroViewController *introController = [[QWMerChantIntroViewController alloc] init];
    [self addChildViewController:introController];
    introController.view.frame = CGRectMake(0, 0, QWScreenWidth, QWScreenheight - 44*myDelegate.autoSizeScaleY - 64);
    
    //门店评价
    QWMerChantCommentViewController *commentController = [[QWMerChantCommentViewController alloc] init];
    [self addChildViewController:commentController];
    commentController.view.frame = CGRectMake(QWScreenWidth, 0, QWScreenWidth, QWScreenheight - 44*myDelegate.autoSizeScaleY - 64);
    
    [_containerView addSubview:introController.view];
    [_containerView addSubview:commentController.view];
    
    [introController didMoveToParentViewController:self];
    [commentController didMoveToParentViewController:self];
    
   

}

//设置分类视图
- (void)setupCategoryView {
    
    QWStoreCategory *categoryView = [[QWStoreCategory alloc] initWithFrame:CGRectMake(0, 64, QWScreenWidth, 44*myDelegate.autoSizeScaleY)];
    
    _categoryView = categoryView;
    
    [self.view addSubview:categoryView];
    
    //给block赋值
    categoryView.categoryBlock = ^(NSInteger index){
        
        //修改scrollView的contentOffset
        [self.shopScrollView setContentOffset:CGPointMake(index * self.shopScrollView.width, 0) animated:YES];
    };
    
    
}

#pragma mark - 布局scrollView
- (void)setupScrollView {
    
    UIScrollView *shopScrollView =  [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64 + 44*myDelegate.autoSizeScaleY, QWScreenWidth, QWScreenheight - 44*myDelegate.autoSizeScaleY - 64)];

    _shopScrollView = shopScrollView;
    
    shopScrollView.delegate = self;
    shopScrollView.bounces = NO;
    shopScrollView.pagingEnabled = YES;
    shopScrollView.contentSize = CGSizeMake(QWScreenWidth*2, QWScreenheight - 44*myDelegate.autoSizeScaleY - 64);
    
    [self.view addSubview:shopScrollView];
    
    
    //容器视图
    UIView *containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, QWScreenWidth*2, QWScreenheight - 44*myDelegate.autoSizeScaleY - 64)];
    _containerView = containerView;
    containerView.backgroundColor = [UIColor lightGrayColor];
    
    [shopScrollView addSubview:containerView];
    
    
    
}

#pragma mark - scrollView的代理方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if (scrollView.isTracking || scrollView.isDragging || scrollView.isDecelerating) {
        CGFloat offsetX = scrollView.contentOffset.x / 2;
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
