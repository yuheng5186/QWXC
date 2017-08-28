//
//  QWPurchaseViewController.m
//  QWCarWashing
//
//  Created by Wuxinglin on 2017/8/18.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "QWPurchaseViewController.h"
#import "QWPurchaseCardViewCell.h"
#import "QWPayPurchaseCardController.h"

#import "JFLocation.h"
#import "JFAreaDataManager.h"
#import "JFCityViewController.h"

#import "NewPagedFlowView.h"
#import "PGIndexBannerSubiew.h"

#define KCURRENTCITYINFODEFAULTS [NSUserDefaults standardUserDefaults]


@interface QWPurchaseViewController ()<JFLocationDelegate, NewPagedFlowViewDelegate, NewPagedFlowViewDataSource, UIScrollViewDelegate>

@property (nonatomic, strong) NSArray *titles;
/** 选择的结果*/
@property (strong, nonatomic) UILabel *resultLabel;
@property (nonatomic, strong) UIButton  *locationButton;
/** 城市定位管理器*/
@property (nonatomic, strong) JFLocation *locationManager;
/** 城市数据管理器*/
@property (nonatomic, strong) JFAreaDataManager *manager;

/**
 *  图片数组
 */
@property (nonatomic, strong) NSMutableArray *imageArray;

@property (nonatomic, weak) UIScrollView *cycleView;

@property (nonatomic, weak) UIPageControl *pageControl;

@end

static NSString *id_puchaseCard = @"purchaseCardCell";


@implementation QWPurchaseViewController

- (NSMutableArray *)imageArray {
    if (_imageArray == nil) {
        _imageArray = [NSMutableArray array];
    }
    return _imageArray;
}

- (JFAreaDataManager *)manager {
    if (!_manager) {
        _manager = [JFAreaDataManager shareManager];
        [_manager areaSqliteDBData];
    }
    return _manager;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.navigationController.navigationBar.hidden = YES;
    
    for (int index = 0; index < 3; index++) {
        UIImage *image = [UIImage imageNamed:@"qiangweika-ditu"];
        [self.imageArray addObject:image];
    }
    
    [self setupUI];
    
}

- (void)setupUI {
    
    //定位按钮
    self.locationManager = [[JFLocation alloc] init];
    _locationManager.delegate = self;
    
    
    UIView *upView                  = [UIUtil drawLineInView:self.view frame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height*64/667) color:[UIColor colorFromHex:@"#293754"]];
    upView.top                      = 0;
    
    NSString *titleName              = @"购卡";
    UIFont *titleNameFont            = [UIFont boldSystemFontOfSize:18];
    UILabel *titleNameLabel          = [UIUtil drawLabelInView:upView frame:[UIUtil textRect:titleName font:titleNameFont] font:titleNameFont text:titleName isCenter:NO];
    titleNameLabel.textColor         = [UIColor whiteColor];
    titleNameLabel.centerX           = upView.centerX;
    titleNameLabel.centerY           = upView.centerY +Main_Screen_Height*10/667;
    
    self.locationButton        = [UIButton buttonWithType:UIButtonTypeCustom];
    self.locationButton.frame             = CGRectMake(0, 0, Main_Screen_Width*70/375, Main_Screen_Height*30/667);
    self.locationButton.backgroundColor   = [UIColor clearColor];
    [self.locationButton setTitle:@"上海" forState:UIControlStateNormal];
    [self.locationButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.locationButton.titleLabel.font   = [UIFont systemFontOfSize:14];
//    self.locationButton.left              = Main_Screen_Width*14/375;
//    self.locationButton.centerY           = self.navigationView.centerY;
    [self.locationButton addTarget:self action:@selector(clickLocationButton) forControlEvents:UIControlEventTouchUpInside];
    [self.locationButton setImage:[UIImage imageNamed:@"shangjiadingwei"] forState:UIControlStateNormal];
    self.locationButton.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
    [self.locationButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    self.locationButton.layer.cornerRadius = 15;
    //self.locationButton.clipsToBounds = YES;
    self.locationButton.layer.borderWidth = 1;
    self.locationButton.layer.borderColor = [UIColor whiteColor].CGColor;

    
//
    
    UIBarButtonItem *leftbarbtn= [[UIBarButtonItem alloc]initWithCustomView:self.locationButton];
    self.navigationItem.leftBarButtonItem=leftbarbtn;
//    //右边试图
//    
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"xiazai"] scaledToSize:CGSizeMake(25, 25)] style:(UIBarButtonItemStyleDone) target:self action:@selector(downloadOnclick:)];
    
    
    
    //无限轮播图
    NewPagedFlowView *pageFlowView = [[NewPagedFlowView alloc] initWithFrame:CGRectMake(0, 64, Main_Screen_Width, (Main_Screen_Width - 70*Main_Screen_Height/667) * 9*Main_Screen_Height/667 / 16 + 24)];
    pageFlowView.backgroundColor = [UIColor whiteColor];
    pageFlowView.delegate = self;
    pageFlowView.dataSource = self;
    pageFlowView.minimumPageAlpha = 0.4;
    //pageFlowView.minimumPageScale = 0.85;
    pageFlowView.orientation = NewPagedFlowViewOrientationHorizontal;
    
    [self.view addSubview:pageFlowView];
    [pageFlowView reloadData];
    
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    pageControl.numberOfPages = self.imageArray.count;
    pageControl.userInteractionEnabled = NO;
    [pageControl setValue:[UIImage imageNamed:@"fensexuanzhong"] forKey:@"currentPageImage"];
    [pageControl setValue:[UIImage imageNamed:@"fenseweixuanzhong"] forKey:@"pageImage"];
    self.pageControl = pageControl;
    [self.view addSubview:pageControl];
    
    //关于卡片的label
    UILabel *functionLabel = [[UILabel alloc] init];
    functionLabel.text = @"卡片功能";
    functionLabel.font = [UIFont systemFontOfSize:15*Main_Screen_Height/667];
    functionLabel.textAlignment = NSTextAlignmentCenter;
    functionLabel.textColor = [UIColor colorFromHex:@"#868686"];
    [self.view addSubview:functionLabel];
    
    UILabel *introLabelOne = [[UILabel alloc] init];
    introLabelOne.text = @"您可以享受会员权益";
    introLabelOne.font = [UIFont systemFontOfSize:13*Main_Screen_Height/667];
    introLabelOne.textAlignment = NSTextAlignmentCenter;
    introLabelOne.textColor = [UIColor colorFromHex:@"#999999"];
    [self.view addSubview:introLabelOne];
    
    UILabel *introLabelTwo = [[UILabel alloc] init];
    introLabelTwo.text = @"并且可以持卡";
    introLabelTwo.font = [UIFont systemFontOfSize:15*Main_Screen_Height/667];
    introLabelTwo.textAlignment = NSTextAlignmentCenter;
    introLabelTwo.textColor = [UIColor colorFromHex:@"#999999"];
    [self.view addSubview:introLabelTwo];
    
    UILabel *introLabelThree = [[UILabel alloc] init];
    introLabelThree.text = @"免费洗车5次";
    introLabelThree.font = [UIFont systemFontOfSize:15*Main_Screen_Height/667];
    introLabelThree.textAlignment = NSTextAlignmentCenter;
    introLabelThree.textColor = [UIColor colorFromHex:@"#999999"];
    [self.view addSubview:introLabelThree];
    
    UIButton *buyButton = [[UIButton alloc] init];
    [buyButton setTitle:@"现在购买" forState:UIControlStateNormal];
    [buyButton setTintColor:[UIColor colorFromHex:@"#ffffff"]];
    buyButton.backgroundColor = [UIColor colorFromHex:@"#293754"];
    buyButton.titleLabel.font = [UIFont systemFontOfSize:18*Main_Screen_Height/667];
    buyButton.layer.cornerRadius = 15*Main_Screen_Height/667;
    [buyButton addTarget:self action:@selector(didSelectCell:withSubViewIndex:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buyButton];
    
    
    [_pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(pageFlowView.mas_bottom).mas_offset(23*Main_Screen_Height/667);
    }];
    
    [functionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.pageControl.mas_bottom).mas_offset(25*Main_Screen_Height/667);
        make.centerX.equalTo(self.view);
    }];
    
    [introLabelOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(functionLabel.mas_bottom).mas_offset(25*Main_Screen_Height/667);
        make.centerX.equalTo(self.view);
    }];
    
    [introLabelTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(introLabelOne.mas_bottom).mas_offset(12*Main_Screen_Height/667);
        make.centerX.equalTo(self.view);
    }];
    
    [introLabelThree mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(introLabelTwo.mas_bottom).mas_offset(12*Main_Screen_Height/667);
        make.centerX.equalTo(self.view);
    }];
    
    [buyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(introLabelThree.mas_bottom).mas_offset(50*Main_Screen_Height/667);
        make.centerX.equalTo(self.view);
        make.width.mas_equalTo(120*Main_Screen_Height/667);
        make.height.mas_equalTo(30*Main_Screen_Height/667);
    }];
    
}

#pragma mark - 点击购买
//- (void)didCickBuyButton {
//
//    PayPurchaseCardController *payCardVC = [[PayPurchaseCardController alloc] init];
//    payCardVC.hidesBottomBarWhenPushed = YES;
//
//    [self.navigationController pushViewController:payCardVC animated:YES];
//}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}


#pragma mark NewPagedFlowView Delegate
- (CGSize)sizeForPageInFlowView:(NewPagedFlowView *)flowView {
    return CGSizeMake(Main_Screen_Width - 84*Main_Screen_Height/667, (Main_Screen_Width - 84*Main_Screen_Height/667) * 9*Main_Screen_Height/667 / 16);
}

- (void)didSelectCell:(UIView *)subView withSubViewIndex:(NSInteger)subIndex {
    
    QWPayPurchaseCardController *payCardVC = [[QWPayPurchaseCardController alloc] init];
    payCardVC.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:payCardVC animated:YES];
}


#pragma mark NewPagedFlowView Datasource
- (NSInteger)numberOfPagesInFlowView:(NewPagedFlowView *)flowView {
    
    return self.imageArray.count;
}


- (UIView *)flowView:(NewPagedFlowView *)flowView cellForPageAtIndex:(NSInteger)index{
    PGIndexBannerSubiew *bannerView = (PGIndexBannerSubiew *)[flowView dequeueReusableCell];
    if (!bannerView) {
        bannerView = [[PGIndexBannerSubiew alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width - 84*Main_Screen_Height/667, (Main_Screen_Width - 70*Main_Screen_Height/667) * 9*Main_Screen_Height/667 / 16)];
        bannerView.layer.cornerRadius = 4*Main_Screen_Height/667;
        bannerView.layer.masksToBounds = YES;
    }
    
    bannerView.mainImageView.image = self.imageArray[index];
    
    return bannerView;
}

- (void)didScrollToPage:(NSInteger)pageNumber inFlowView:(NewPagedFlowView *)flowView {
    
    self.pageControl.currentPage = pageNumber;
}





- (void)clickLocationButton {
    
    JFCityViewController *cityViewController = [[JFCityViewController alloc] init];
    cityViewController.title = @"城市";
    __weak typeof(self) weakSelf = self;
    [cityViewController choseCityBlock:^(NSString *cityName) {
        
        [weakSelf.locationButton setTitle:cityName forState:UIControlStateNormal];
        
        weakSelf.resultLabel.text = cityName;
    }];
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:cityViewController];
    [self presentViewController:navigationController animated:YES completion:nil];
}

#pragma mark - JFLocationDelegate
//定位中...
- (void)locating {
    NSLog(@"定位中...");
}

//定位成功
- (void)currentLocation:(NSDictionary *)locationDictionary {
    NSString *city = [locationDictionary valueForKey:@"City"];
    if (![_resultLabel.text isEqualToString:city]) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:[NSString stringWithFormat:@"您定位到%@，确定切换城市吗？",city] preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            _resultLabel.text = city;
            [KCURRENTCITYINFODEFAULTS setObject:city forKey:@"locationCity"];
            [KCURRENTCITYINFODEFAULTS setObject:city forKey:@"currentCity"];
            [self.manager cityNumberWithCity:city cityNumber:^(NSString *cityNumber) {
                [KCURRENTCITYINFODEFAULTS setObject:cityNumber forKey:@"cityNumber"];
            }];
        }];
        [alertController addAction:cancelAction];
        [alertController addAction:okAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }
}

/// 拒绝定位
- (void)refuseToUsePositioningSystem:(NSString *)message {
    NSLog(@"%@",message);
}

/// 定位失败
- (void)locateFailure:(NSString *)message {
    NSLog(@"%@",message);
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
