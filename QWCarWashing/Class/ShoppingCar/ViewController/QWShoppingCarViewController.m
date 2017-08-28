//
//  QWShoppingCarViewController.m
//  QWCarWashing
//
//  Created by apple on 2017/8/14.
//  Copyright © 2017年 apple. All rights reserved.
//


#import "QWShoppingCarViewController.h"
#import "NewPagedFlowView.h"
#import "PGIndexBannerSubiew.h"
#import "AppDelegate.h"

@interface QWShoppingCarViewController ()<NewPagedFlowViewDelegate, NewPagedFlowViewDataSource, UIScrollViewDelegate>
{
    AppDelegate *myDelegate;
    UILabel *introTwo;
    UILabel *introThree;
}


/**
 *  图片数组
 */
@property (nonatomic, strong) NSMutableArray *imageArray;

@property (nonatomic, weak) UIScrollView *CarouselView;

@property (nonatomic, weak) UIPageControl *pageC;

@end

@implementation QWShoppingCarViewController

#pragma mark --懒加载
- (NSMutableArray *)imageArray {
    if (_imageArray == nil) {
        _imageArray = [NSMutableArray array];
    }
    return _imageArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //    self.navigationController.navigationBar.translucent = YES;
    
    myDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    for (int index = 0; index < 3; index++) {
        UIImage *image = [UIImage imageNamed:@"qiangweika-ditu"];
        [self.imageArray addObject:image];
    }
    
    [self setupview];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setupview
{
    //    //定位按钮
    //    self.locationManager = [[JFLocation alloc] init];
    //    _locationManager.delegate = self;
    //
    //
    //    UIView *upView                  = [UIUtil drawLineInView:self.contentView frame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height*64/667) color:[UIColor colorFromHex:@"#293754"]];
    //    upView.top                      = 0;
    //
    //    NSString *titleName              = @"购卡";
    //    UIFont *titleNameFont            = [UIFont boldSystemFontOfSize:18];
    //    UILabel *titleNameLabel          = [UIUtil drawLabelInView:upView frame:[UIUtil textRect:titleName font:titleNameFont] font:titleNameFont text:titleName isCenter:NO];
    //    titleNameLabel.textColor         = [UIColor whiteColor];
    //    titleNameLabel.centerX           = upView.centerX;
    //    titleNameLabel.centerY           = upView.centerY +Main_Screen_Height*10/667;
    //
    //    self.locationButton        = [UIButton buttonWithType:UIButtonTypeCustom];
    //    self.locationButton.frame             = CGRectMake(0, 0, Main_Screen_Width*70/375, Main_Screen_Height*30/667);
    //    self.locationButton.backgroundColor   = [UIColor clearColor];
    //    [self.locationButton setTitle:@"上海" forState:UIControlStateNormal];
    //    [self.locationButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //    self.locationButton.titleLabel.font   = [UIFont systemFontOfSize:14];
    //    self.locationButton.left              = Main_Screen_Width*14/375;
    //    self.locationButton.centerY           = self.navigationView.centerY;
    //    [self.locationButton addTarget:self action:@selector(clickLocationButton) forControlEvents:UIControlEventTouchUpInside];
    //    [self.locationButton setImage:[UIImage imageNamed:@"dingwei"] forState:UIControlStateNormal];
    //    self.locationButton.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
    //    [self.locationButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    //    self.locationButton.layer.cornerRadius = 15;
    //    //self.locationButton.clipsToBounds = YES;
    //    self.locationButton.layer.borderWidth = 1;
    //    self.locationButton.layer.borderColor = [UIColor whiteColor].CGColor;
    //    [upView addSubview:self.locationButton];
    
    
    
    //无限轮播图
    NewPagedFlowView *pageFlowView = [[NewPagedFlowView alloc] initWithFrame:CGRectMake(0, 64 + 40 * myDelegate.autoSizeScaleX, QWScreenWidth, (QWScreenWidth - 80 * myDelegate.autoSizeScaleX) * 19 / 30)];
    
    pageFlowView.backgroundColor = [UIColor orangeColor];
    pageFlowView.delegate = self;
    pageFlowView.dataSource = self;
    pageFlowView.minimumPageAlpha = 0.4;
    //pageFlowView.minimumPageScale = 0.85;
    pageFlowView.orientation = NewPagedFlowViewOrientationHorizontal;
    //不允许在垂直方向上进行滚动
    pageFlowView.scrollView.contentSize = CGSizeMake(pageFlowView.frame.size.width, (QWScreenWidth - 80 * myDelegate.autoSizeScaleX) * 19 / 30);
    
    [self.view addSubview:pageFlowView];
    [pageFlowView reloadData];
    
    UIPageControl *pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, pageFlowView.frame.origin.y + pageFlowView.frame.size.height + 25 * myDelegate.autoSizeScaleY, QWScreenWidth, 10 * myDelegate.autoSizeScaleY)];
    pageControl.numberOfPages = self.imageArray.count;
    pageControl.userInteractionEnabled = NO;
    [pageControl setValue:[UIImage imageNamed:@"fensexuanzhong"] forKey:@"currentPageImage"];
    [pageControl setValue:[UIImage imageNamed:@"fenseweixuanzhong"] forKey:@"pageImage"];
    self.pageC = pageControl;
    [self.view addSubview:pageControl];
    
    //关于卡片的label
    UILabel *EnjoyLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, pageControl.frame.origin.y + pageControl.frame.size.height + 25 * myDelegate.autoSizeScaleY, QWScreenWidth, 10 * myDelegate.autoSizeScaleY)];
    EnjoyLabel.text = @"超值享受";
    EnjoyLabel.font = [UIFont systemFontOfSize:17 * myDelegate.autoSizeScaleX];
    EnjoyLabel.textAlignment = NSTextAlignmentCenter;
    EnjoyLabel.textColor = [UIColor colorWithHexString:@"#868686"];
    [self.view addSubview:EnjoyLabel];
    
    UILabel *introOne = [[UILabel alloc] initWithFrame:CGRectMake(0, EnjoyLabel.frame.origin.y + EnjoyLabel.frame.size.height + 28 * myDelegate.autoSizeScaleY, QWScreenWidth, 10 * myDelegate.autoSizeScaleY)];
    introOne.text = @"您可以享受会员权益";
    introOne.font = [UIFont systemFontOfSize:16 * myDelegate.autoSizeScaleX];
    introOne.textAlignment = NSTextAlignmentCenter;
    introOne.textColor = [UIColor colorWithHexString:@"#999999"];
    [self.view addSubview:introOne];
    
    introTwo = [[UILabel alloc] initWithFrame:CGRectMake(0, introOne.frame.origin.y + introOne.frame.size.height + 20 * myDelegate.autoSizeScaleY, QWScreenWidth, 10 * myDelegate.autoSizeScaleY)];
    introTwo.text = @"拥有一年的使用期限";
    introTwo.font = [UIFont systemFontOfSize:16 * myDelegate.autoSizeScaleX];
    introTwo.textAlignment = NSTextAlignmentCenter;
    introTwo.textColor = [UIColor colorWithHexString:@"#999999"];
    [self.view addSubview:introTwo];
    
    introThree = [[UILabel alloc] initWithFrame:CGRectMake(0, introTwo.frame.origin.y + introTwo.frame.size.height + 20 * myDelegate.autoSizeScaleY, QWScreenWidth, 10 * myDelegate.autoSizeScaleY)];
    introThree.text = @"优质洗车100次";
    introThree.font = [UIFont systemFontOfSize:16 * myDelegate.autoSizeScaleX];
    introThree.textAlignment = NSTextAlignmentCenter;
    introThree.textColor = [UIColor colorWithHexString:@"#999999"];
    [self.view addSubview:introThree];
    
    
    UIButton *GobuyButton = [[UIButton alloc] initWithFrame:CGRectMake((QWScreenWidth - 120 * myDelegate.autoSizeScaleX)/2, introThree.frame.origin.y + introThree.frame.size.height + 60 * myDelegate.autoSizeScaleY, 120 * myDelegate.autoSizeScaleX, 40 * myDelegate.autoSizeScaleY)];
    [GobuyButton setTitle:@"现在购买" forState:UIControlStateNormal];
    [GobuyButton setTintColor:[UIColor colorWithHexString:@"#ffffff"]];
    GobuyButton.backgroundColor = [UIColor colorWithHexString:@"#ffcf36"];
    GobuyButton.titleLabel.font = [UIFont systemFontOfSize:18 * myDelegate.autoSizeScaleX];
    GobuyButton.layer.cornerRadius = 20 * myDelegate.autoSizeScaleY;
    [GobuyButton addTarget:self action:@selector(didSelectCell:withSubViewIndex:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:GobuyButton];
    
    
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}


#pragma mark NewPagedFlowView Delegate
- (CGSize)sizeForPageInFlowView:(NewPagedFlowView *)flowView {
    return CGSizeMake(QWScreenWidth - 80 * myDelegate.autoSizeScaleX, (QWScreenWidth - 80 * myDelegate.autoSizeScaleX) * 19 / 30);
}

- (void)didSelectCell:(UIView *)subView withSubViewIndex:(NSInteger)subIndex {
    
    //    PayPurchaseCardController *payCardVC = [[PayPurchaseCardController alloc] init];
    //    payCardVC.hidesBottomBarWhenPushed = YES;
    //
    //    [self.navigationController pushViewController:payCardVC animated:YES];
    
    NSString *message = [NSString stringWithFormat:@"%ld",subIndex];
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    
    
    NSString *cancelButtonTitle = NSLocalizedString(@"取消", nil);
    NSString *otherButtonTitle = NSLocalizedString(@"确定", nil);
    
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelButtonTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
        
    }];
    
    UIAlertAction *otherAction = [UIAlertAction actionWithTitle:otherButtonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        
        
        
    }];
    
    
    [alertController addAction:cancelAction];
    [alertController addAction:otherAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
    
    
}


#pragma mark NewPagedFlowView Datasource
- (NSInteger)numberOfPagesInFlowView:(NewPagedFlowView *)flowView {
    
    return self.imageArray.count;
}


- (UIView *)flowView:(NewPagedFlowView *)flowView cellForPageAtIndex:(NSInteger)index{
    PGIndexBannerSubiew *bannerView = (PGIndexBannerSubiew *)[flowView dequeueReusableCell];
    if (!bannerView) {
        bannerView = [[PGIndexBannerSubiew alloc] initWithFrame:CGRectMake(0, 0, QWScreenWidth - 84, (QWScreenWidth - 70) * 9 / 16)];
        bannerView.layer.cornerRadius = 4;
        bannerView.layer.masksToBounds = YES;
    }
    
    bannerView.mainImageView.image = self.imageArray[index];
    
    return bannerView;
}

- (void)didScrollToPage:(NSInteger)pageNumber inFlowView:(NewPagedFlowView *)flowView {
    
    self.pageC.currentPage = pageNumber;
    
    
    NSLog(@"%ld",pageNumber);
    introTwo.text = [NSString stringWithFormat:@"拥有%ld年的使用期限",pageNumber];
    introThree.text = [NSString stringWithFormat:@"优质洗车%ld100次",pageNumber];;
    
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
