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
#import "MBProgressHUD.h"
#import "QWCarModel.h"
#import "QWPayPurchaseCardController.h"

#import "UIView+Frame.h"
#define KCURRENTCITYINFODEFAULTS [NSUserDefaults standardUserDefaults]


@interface QWPurchaseViewController ()<JFLocationDelegate, NewPagedFlowViewDelegate, NewPagedFlowViewDataSource, UIScrollViewDelegate>
{
    
    MBProgressHUD *HUD;
    UILabel *introLabelTwo;
    UILabel *introLabelThree;
    UILabel *functionLabel;
    UILabel *introLabelOne;
}

@property (nonatomic, strong) NSArray *titles;
/** 选择的结果*/
@property (strong, nonatomic) UILabel *resultLabel;
@property (nonatomic, strong) UIButton  *locationButton;
/** 城市定位管理器*/
@property (nonatomic, strong) JFLocation *locationManager;
/** 城市数据管理器*/
@property (nonatomic, strong) JFAreaDataManager *manager;
@property (nonatomic, strong) NSString *area;

/**
 *  图片数组
 */
@property (nonatomic, strong) NSMutableArray *imageArray;

@property (nonatomic, weak) UIScrollView *cycleView;

@property (nonatomic, weak) UIPageControl *pageControl;

@property (nonatomic, strong) NSMutableArray *CardArray;
@property (nonatomic, assign) NSInteger Xuhao;
@property (nonatomic, strong) UIView *middleview;
@end

static NSString *id_puchaseCard = @"purchaseCardCell";


@implementation QWPurchaseViewController

- (NSMutableArray *)imageArray {
    if (_imageArray == nil) {
        _imageArray = [NSMutableArray array];
    }
    return _imageArray;
}
-(NSMutableArray *)CardArray{
    if (_CardArray == nil) {
        _CardArray = [NSMutableArray array];
    }
    return _CardArray;

}
- (JFAreaDataManager *)manager {
    if (!_manager) {
        _manager = [JFAreaDataManager shareManager];
        [_manager areaSqliteDBData];
    }
    return _manager;
}

-(void)viewWillAppear:(BOOL)animated
{
    _Xuhao = 0;
    self.imageArray = [NSMutableArray new];
    [self.middleview removeAllSubviews];
    HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HUD.removeFromSuperViewOnHide =YES;
    HUD.mode = MBProgressHUDModeIndeterminate;
    HUD.labelText = @"加载中";
    HUD.minSize = CGSizeMake(132.f, 108.0f);
    
    [self getMyCardData];
    
}
-(void)getMyCardData
{
    [self.CardArray removeAllObjects];
    NSDictionary *mulDic = @{
                             @"GetCardType":@1,
                             @"Area":self.area
                             };
        [AFNetworkingTool post:mulDic andurl:[NSString stringWithFormat:@"%@Card/GetCardConfigList",Khttp] success:^(NSDictionary *dict, BOOL success) {
        
            NSLog(@"%@",dict);
        if([[dict objectForKey:@"ResultCode"] isEqualToString:[NSString stringWithFormat:@"%@",@"F000000"]])
        {
            NSArray *arr = [NSArray array];
            arr = [dict objectForKey:@"JsonData"];
            for(NSDictionary *dic in arr)
            {
                NSError *error=nil;
                QWCarModel *card = [[QWCarModel alloc]initWithDictionary:dic error:&error];
                NSLog(@"%@==%@",card,error);
                [self.CardArray addObject:card];
            }
            
            for (int index = 0; index < [self.CardArray count]; index++) {
                UIImage *image = [UIImage imageNamed:@"bg_card"];
                [self.imageArray addObject:image];
            }
            
            [self setupUI];
            
            [HUD setHidden:YES];
            
        }
        else
        {
            [HUD setHidden:YES];
            [self.view showInfo:@"获取失败" autoHidden:YES interval:2];
            
        }
        
        
        
        
    } fail:^(NSError *error) {
        [HUD setHidden:YES];
        [self.view showInfo:@"获取失败" autoHidden:YES interval:2];
    }];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //定位按钮
    self.locationManager = [[JFLocation alloc] init];
    _locationManager.delegate = self;
    self.area = @"上海市";
    
    UIView *upView                  = [UIUtil drawLineInView:self.view frame:CGRectMake(0, 0, Main_Screen_Width, 64) color:[UIColor colorFromHex:@"#293754"]];
    upView.top                      = 0;
    
    NSString *titleName              = @"购卡";
    UIFont *titleNameFont            = [UIFont boldSystemFontOfSize:20*Main_Screen_Height/667];
    UILabel *titleNameLabel          = [UIUtil drawLabelInView:upView frame:[UIUtil textRect:titleName font:titleNameFont] font:titleNameFont text:titleName isCenter:NO];
    titleNameLabel.textColor         = [UIColor whiteColor];
    titleNameLabel.centerX           = upView.centerX;
    titleNameLabel.centerY           = upView.centerY +8;
    
    self.locationButton        = [UIButton buttonWithType:UIButtonTypeCustom];
    self.locationButton.frame             = CGRectMake(0, 0, Main_Screen_Width*70/375, Main_Screen_Height*30/667);
    self.locationButton.backgroundColor   = [UIColor clearColor];
    [self.locationButton setTitle:@"上海" forState:UIControlStateNormal];
    [self.locationButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.locationButton.titleLabel.font   = [UIFont systemFontOfSize:Main_Screen_Height*14/667];
    self.locationButton.left              = Main_Screen_Width*14/375;
    self.locationButton.centerY           = titleNameLabel.centerY;
    [self.locationButton addTarget:self action:@selector(clickLocationButton) forControlEvents:UIControlEventTouchUpInside];
    [self.locationButton setImage:[UIImage imageNamed:@"shangjiadingwei"] forState:UIControlStateNormal];
    self.locationButton.imageEdgeInsets = UIEdgeInsetsMake(0, -Main_Screen_Width*10/375, 0, 0);
    [self.locationButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    self.locationButton.layer.cornerRadius = self.locationButton.height/2;
    //self.locationButton.clipsToBounds = YES;
    self.locationButton.layer.borderWidth = 1;
    self.locationButton.layer.borderColor = [UIColor whiteColor].CGColor;
    [upView addSubview:self.locationButton];
    
    
    _middleview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height)];
    _middleview.backgroundColor = [UIColor colorFromHex:@"#fafafa"];

    [self.view addSubview:_middleview];
    
}

- (void)setupUI {
    
    QWCarModel *card = (QWCarModel *)[self.CardArray objectAtIndex:_Xuhao];
    
    
    UIBarButtonItem *leftbarbtn= [[UIBarButtonItem alloc]initWithCustomView:self.locationButton];
    self.navigationItem.leftBarButtonItem=leftbarbtn;
    
    
    //无限轮播图
    NewPagedFlowView *pageFlowView = [[NewPagedFlowView alloc] initWithFrame:CGRectMake(0, 64, Main_Screen_Width, 250*Main_Screen_Height/667)];
    pageFlowView.backgroundColor = [UIColor clearColor];
    pageFlowView.delegate = self;
    pageFlowView.dataSource = self;
    pageFlowView.minimumPageAlpha = 0.4;
    pageFlowView.delegate = self;
    pageFlowView.dataSource = self;
    pageFlowView.minimumPageAlpha = 0;
//        pageFlowView.minimumPageScale = 0.85;
    pageFlowView.orginPageCount = self.imageArray.count;
    pageFlowView.orientation = NewPagedFlowViewOrientationHorizontal;
    [_middleview addSubview:pageFlowView];
    [pageFlowView reloadData];
    [pageFlowView stopTimer];
    
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    pageControl.numberOfPages = self.imageArray.count;
    pageControl.userInteractionEnabled = NO;
    pageControl.currentPage = 0;
    [pageControl setValue:[UIImage imageNamed:@"sel_lunbo"] forKey:@"currentPageImage"];
    [pageControl setValue:[UIImage imageNamed:@"nor_lunbo"] forKey:@"pageImage"];
    pageFlowView.pageControl = pageControl;
    [_middleview addSubview:pageControl];
    
    //关于卡片的label
    functionLabel = [[UILabel alloc] init];
    functionLabel.text = card.CardName;
    functionLabel.font = [UIFont systemFontOfSize:17*Main_Screen_Height/667];
    functionLabel.textAlignment = NSTextAlignmentCenter;
    functionLabel.textColor = [UIColor colorFromHex:@"#868686"];
    [_middleview addSubview:functionLabel];
    
    introLabelOne = [[UILabel alloc] init];
    introLabelOne.text = [NSString stringWithFormat:@"持卡洗车次数%ld次",card.CardCount];
    introLabelOne.font = [UIFont systemFontOfSize:15*Main_Screen_Height/667];
    introLabelOne.textAlignment = NSTextAlignmentCenter;
    introLabelOne.textColor = [UIColor colorFromHex:@"#999999"];
    [_middleview addSubview:introLabelOne];
    
    introLabelTwo = [[UILabel alloc] init];
    introLabelTwo.text =[NSString stringWithFormat:@"购卡获得%ld积分",card.Integralnum];
    introLabelTwo.font = [UIFont systemFontOfSize:15*Main_Screen_Height/667];
    introLabelTwo.textAlignment = NSTextAlignmentCenter;
    introLabelTwo.textColor = [UIColor colorFromHex:@"#999999"];
    [_middleview addSubview:introLabelTwo];
    
    introLabelThree = [[UILabel alloc] init];
    introLabelThree.text = [NSString stringWithFormat:@"有效期%ld天",card.ExpiredDay];
    introLabelThree.font = [UIFont systemFontOfSize:15*Main_Screen_Height/667];
    introLabelThree.textAlignment = NSTextAlignmentCenter;
    introLabelThree.textColor = [UIColor colorFromHex:@"#999999"];
    [_middleview addSubview:introLabelThree];
    
    UIButton *buyButton = [[UIButton alloc] init];
    [buyButton setTitle:@"现在购买" forState:UIControlStateNormal];
    [buyButton setTintColor:[UIColor colorFromHex:@"#ffffff"]];
    buyButton.backgroundColor = [UIColor colorFromHex:@"#293754"];
    buyButton.titleLabel.font = [UIFont systemFontOfSize:18*Main_Screen_Height/667];
    buyButton.layer.cornerRadius = 15*Main_Screen_Height/667;
    [buyButton addTarget:self action:@selector(didSelectCell:withSubViewIndex:) forControlEvents:UIControlEventTouchUpInside];
    [_middleview addSubview:buyButton];
    
    //    _pageControl.hidden = YES;
    
    [pageFlowView.pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_middleview);
        make.top.equalTo(pageFlowView.mas_bottom).mas_offset(-15*Main_Screen_Height/667);
        
    }];
    
    [functionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(pageFlowView.pageControl.mas_bottom).mas_offset(25*Main_Screen_Height/667);
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
        make.top.equalTo(introLabelThree.mas_bottom).mas_offset(40*Main_Screen_Height/667);
        make.centerX.equalTo(self.view);
        make.width.mas_equalTo(120*Main_Screen_Height/667);
        make.height.mas_equalTo(30*Main_Screen_Height/667);
    }];
}

#pragma mark - 点击购买
- (void)didCickBuyButton {

    QWCarModel *card = (QWCarModel *)[self.CardArray objectAtIndex:_Xuhao];
    QWPayPurchaseCardController *payCardVC = [[QWPayPurchaseCardController alloc] init];
    payCardVC.hidesBottomBarWhenPushed = YES;
    payCardVC.choosecard = card;
    [self.navigationController pushViewController:payCardVC animated:YES];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}


#pragma mark NewPagedFlowView Delegate
- (CGSize)sizeForPageInFlowView:(NewPagedFlowView *)flowView {
    return CGSizeMake(300*Main_Screen_Height/667, 192*Main_Screen_Height/667);
}

- (void)didSelectCell:(UIView *)subView withSubViewIndex:(NSInteger)subIndex {
    
    QWCarModel *card = (QWCarModel *)[self.CardArray objectAtIndex:_Xuhao];
    QWPayPurchaseCardController *payCardVC = [[QWPayPurchaseCardController alloc] init];
    payCardVC.hidesBottomBarWhenPushed = YES;
    payCardVC.choosecard = card;
    [self.navigationController pushViewController:payCardVC animated:YES];
}


#pragma mark NewPagedFlowView Datasource
- (NSInteger)numberOfPagesInFlowView:(NewPagedFlowView *)flowView {
    
    return self.imageArray.count;
}


- (UIView *)flowView:(NewPagedFlowView *)flowView cellForPageAtIndex:(NSInteger)index{
    PGIndexBannerSubiew *bannerView = (PGIndexBannerSubiew *)[flowView dequeueReusableCell];
    if (!bannerView) {
        bannerView = [[PGIndexBannerSubiew alloc] initWithFrame:CGRectMake(0, 0, 300*Main_Screen_Height/667, 192*Main_Screen_Height/667)];
        bannerView.layer.cornerRadius = 4*Main_Screen_Height/667;
        bannerView.layer.masksToBounds = YES;
    }
    else
    {
        //删除cell的所有子视图
        while ([bannerView.subviews lastObject] != nil)
        {
            [(UIView*)[bannerView.subviews lastObject] removeFromSuperview];
        }
    }
    
    bannerView.backgroundColor = [UIColor clearColor];
    
    //    bannerView.mainImageView.image = self.imageArray[index];
    
    UIImageView *containImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, 300*Main_Screen_Height/667, 192*Main_Screen_Height/667)];
    //    containImageView.image = [UIImage imageNamed:@"kabeijing"];
    containImageView.image = [UIImage imageNamed:@"bg_card"];
    [containImageView setContentScaleFactor:[[UIScreen mainScreen] scale]];
    containImageView.contentMode =  UIViewContentModeScaleAspectFill;
    containImageView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    containImageView.clipsToBounds  = YES;
    [bannerView addSubview:containImageView];
    
    QWCarModel *card = (QWCarModel *)[self.CardArray objectAtIndex:index];
        
    
    UILabel *cardNameLab = [[UILabel alloc] init];
    cardNameLab.text = card.CardName;
    cardNameLab.font = [UIFont boldSystemFontOfSize:18*Main_Screen_Height/667];
    [bannerView addSubview:cardNameLab];
    
    UILabel *cardtagLab = [[UILabel alloc] init];
    cardtagLab.text = @"蔷薇爱车";
    cardtagLab.font = [UIFont systemFontOfSize:12*Main_Screen_Height/667];
    [bannerView addSubview:cardtagLab];
    
    UILabel *timesLab = [[UILabel alloc] init];
    timesLab.text = [NSString stringWithFormat:@"持卡洗车次数%ld次",card.CardCount];
    timesLab.font = [UIFont systemFontOfSize:18*Main_Screen_Height/667];
    [bannerView addSubview:timesLab];
    
    UILabel *scoreLab = [[UILabel alloc] init];
    scoreLab.text = [NSString stringWithFormat:@"购卡获得%ld积分",card.Integralnum];
    scoreLab.font = [UIFont systemFontOfSize:12*Main_Screen_Height/667];
    [bannerView addSubview:scoreLab];
    
    UILabel *invalidLab = [[UILabel alloc] init];
    invalidLab.text = [NSString stringWithFormat:@"有效期%ld天",card.ExpiredDay];
    invalidLab.font = [UIFont systemFontOfSize:10*Main_Screen_Height/667];
    [bannerView addSubview:invalidLab];
    
    UILabel *introValueLab = [[UILabel alloc] init];
    introValueLab.text = @"尊享超值价";
    introValueLab.textColor = [UIColor colorFromHex:@"#ffffff"];
    introValueLab.font = [UIFont systemFontOfSize:10*Main_Screen_Height/667];
    //    [bannerView addSubview:introValueLab];
    
    UILabel *priceLab = [[UILabel alloc] init];
    priceLab.text = [NSString stringWithFormat:@"￥%@",card.CardPrice];
    priceLab.font = [UIFont systemFontOfSize:15*Main_Screen_Height/667];
    [bannerView addSubview:priceLab];
    
    UILabel *invalidLab2 = [[UILabel alloc] init];
    invalidLab2.text = [NSString stringWithFormat:@"有效期%ld天",card.ExpiredDay];
    invalidLab2.textColor = [UIColor colorFromHex:@"#999999"];
    invalidLab2.font = [UIFont systemFontOfSize:13*Main_Screen_Height/667];
    [bannerView addSubview:invalidLab2];
    
    //约束
    [cardNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(containImageView).mas_offset(20*Main_Screen_Height/667);
        make.left.equalTo(containImageView).mas_offset(18*Main_Screen_Height/667);
    }];
    
    [cardtagLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(cardNameLab.mas_trailing).mas_offset(10*Main_Screen_Height/667);
        make.bottom.equalTo(cardNameLab);
    }];
    
    //    [timesLab mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.top.equalTo(cardNameLab.mas_bottom).mas_offset(16*Main_Screen_Height/667);
    //        make.leading.equalTo(cardNameLab);
    //    }];
    //
    //    [scoreLab mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.top.equalTo(timesLab.mas_bottom).mas_offset(12*Main_Screen_Height/667);
    //        make.leading.equalTo(cardNameLab);
    //    }];
    //
    //    [invalidLab mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.top.equalTo(scoreLab.mas_bottom).mas_offset(8*Main_Screen_Height/667);
    //        make.leading.equalTo(cardNameLab);
    //    }];
    
    //    [introValueLab mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.top.equalTo(invalidLab.mas_bottom).mas_offset(25*Main_Screen_Height/667);
    //        make.leading.equalTo(cardNameLab);
    //    }];
    //
    [priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(cardNameLab.mas_bottom).mas_offset(8*Main_Screen_Height/667);
        make.leading.equalTo(cardNameLab);
    }];
    
    [invalidLab2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(cardNameLab);
        make.bottom.equalTo(containImageView).mas_offset(-18*Main_Screen_Height/667);
    }];
    
    return bannerView;

}

- (void)didScrollToPage:(NSInteger)pageNumber inFlowView:(NewPagedFlowView *)flowView {
    _Xuhao = pageNumber;
    
    QWCarModel *card = (QWCarModel *)[self.CardArray objectAtIndex:pageNumber];
    functionLabel.text = card.CardName;
    introLabelOne.text = [NSString stringWithFormat:@"持卡洗车次数%ld次",card.CardCount];
    introLabelTwo.text =[NSString stringWithFormat:@"购卡获得%ld积分",card.Integralnum];
    introLabelThree.text = [NSString stringWithFormat:@"有效期%ld天",card.ExpiredDay];
}





- (void)clickLocationButton {
    
    JFCityViewController *cityViewController = [[JFCityViewController alloc] init];
    cityViewController.title = @"城市";
    __weak typeof(self) weakSelf = self;
    [cityViewController choseCityBlock:^(NSString *cityName) {
        
        NSString    *cityString  = cityName;
        if (cityName.length > 3) {
            NSString    *city     = [cityName substringToIndex:2];
            cityString = [NSString stringWithFormat:@"%@...",city];
        }
        weakSelf.locationButton.width   = Main_Screen_Width*80/375;
        [weakSelf.locationButton setTitle:cityString forState:UIControlStateNormal];
        
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