//
//  QWMyCarController.m
//  QWCarWashing
//
//  Created by Wuxinglin on 2017/8/16.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "QWMyCarController.h"

#import "QWMyCarPortController.h"
#import "NewPagedFlowView.h"
#import "PGIndexBannerSubiew.h"
#import "MyCarInfosHeaderView.h"
#import "UIView+Uitls.h"
#import "QFDatePickerView.h"
#import "ProvinceShortController.h"
#import "UIScrollView+EmptyDataSet.h"//第三方空白页
#import "QWIcreaseCarController.h"
@interface QWMyCarController ()<UITableViewDelegate, UITableViewDataSource, NewPagedFlowViewDelegate, NewPagedFlowViewDataSource, UITextFieldDelegate,UIGestureRecognizerDelegate,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>

@property (nonatomic, weak) UIImageView *carImageView;

@property (nonatomic, weak) UITableView *carInfoView;

@property (nonatomic, strong) NSMutableArray *imageArray;

@property (nonatomic, weak) UIPageControl *pageControl;

@property (nonatomic, weak) UIButton *provinceBtn;
@property (nonatomic, strong) NSMutableArray *CarArray;
@property (nonatomic, assign) NSInteger Xuhao;

@property (nonatomic, weak) UILabel *lbl;
@property (nonatomic, weak) UILabel *lbl2;
@property (nonatomic, weak) UITextField *carNum;
@property (nonatomic, weak) UITextField *CarBrandlab;
@property (nonatomic, weak) UITextField *PlateNumberlab;
@property (nonatomic, weak) UITextField *ChassisNumlab;
@property (nonatomic, weak) UITextField *Manufacturelab;
@property (nonatomic, weak) UITextField *DepartureTimelab;
@property (nonatomic, weak) UITextField *Mileagelab;
//CarBrand:车辆品牌,PlateNumber:车牌号,ChassisNum:车架号,Manufacture:生产年份,DepartureTime:上路时间,Mileage:行驶里程

@end

static NSString * HeaderId = @"header";


@implementation QWMyCarController
{
    CGFloat _totalYOffset;
}

- (NSMutableArray *)imageArray {
    if (_imageArray == nil) {
        _imageArray = [NSMutableArray array];
    }
    return _imageArray;
}
-(NSMutableArray *)CarArray{
    if (_CarArray==nil) {
        _CarArray=[NSMutableArray arrayWithCapacity:0];
    }
    return _CarArray;
}
#pragma mark-查询爱车列表
-(void)requestMyCarData
{
    NSDictionary *mulDic = @{
                             @"Account_Id":[UdStorage getObjectforKey:Userid]
                             };
    NSLog(@"查询爱车列表:%@",mulDic);
    [AFNetworkingTool post:mulDic andurl:[NSString stringWithFormat:@"%@MyCar/GetCarList",Khttp] success:^(NSDictionary *dict, BOOL success) {
        
         NSLog(@"==%@==",dict);
        if([[dict objectForKey:@"ResultCode"] isEqualToString:[NSString stringWithFormat:@"%@",@"F000000"]])
        {
            NSArray *arr = [NSArray array];
            arr = [dict objectForKey:@"JsonData"];
            for(NSDictionary *dic in arr)
            {
                QWMyCarModel *newcar = [[QWMyCarModel alloc]initWithDictionary:dic error:nil];

                [self.CarArray addObject:newcar];
            }
            
            for (int index = 0; index < [self.CarArray count]; index++) {
                UIImage *image = [UIImage imageNamed:@"aicheditu"];
                [self.imageArray addObject:image];
            }
            
            [self setupUI];
            
            [self.carInfoView reloadData];
            
        }
        else
        {
            [self.view showInfo:@"获取失败" autoHidden:YES interval:2];
        }
        
        
        
        
    } fail:^(NSError *error) {
        [self.view showInfo:@"获取失败" autoHidden:YES interval:2];
    }];
    
}
//- (UIImageView *)carImageView {
//
//    if (_carImageView == nil) {
//        UIImageView *carImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64, Main_Screen_Width, 200)];
//        _carImageView = carImageView;
//        [self.view addSubview:_carImageView];
//    }
//    return _carImageView;
//}

- (UITableView *)carInfoView {
    
    if (_carInfoView == nil) {
        
        UITableView *carInfoView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height) style:UITableViewStyleGrouped];
        _carInfoView = carInfoView;
        
       
        [self.view addSubview:_carInfoView];
    }
    return _carInfoView;
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


- (void)viewDidLoad {
    [super viewDidLoad];
    [self resetBabkButton];
    // Do any additional setup after loading the view.
    self.title  = @"我的爱车";
    NSNotificationCenter * center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(noticeupdateMyCar:) name:@"updatemycarsuccess" object:nil];
    [center addObserver:self selector:@selector(noticeupdateMyCar:) name:@"increasemycarsuccess" object:nil];
    self.navigationItem.rightBarButtonItem  = [[UIBarButtonItem alloc]initWithTitle:@"我的车库" style:UIBarButtonItemStyleDone target:self action:@selector(clickMycarPort)];
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:13],NSFontAttributeName, nil] forState:UIControlStateNormal];
    
    
    
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(endEditing)];
    tap.delegate = self;
    [self.view addGestureRecognizer:tap];
    [self requestMyCarData];
    
    
    
}
#pragma mark-修改或者添加了车辆都会通知更新数据ui
-(void)noticeupdateMyCar:(NSNotification*)notif{
//    _Xuhao = 0;
    _CarArray = [NSMutableArray array];
    self.imageArray  = [NSMutableArray array];
    [self requestMyCarData];
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {//判断如果点击的是tableView的cell，就把手势给关闭了
        return NO;//关闭手势
    }//否则手势存在
    return YES;
}

- (void)setupUI {
    
    //无限轮播图
    NewPagedFlowView *pageFlowView = [[NewPagedFlowView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, (Main_Screen_Width - 60) * 9 / 16 + 24)];
    if (self.CarArray.count!=0) {
        pageFlowView.backgroundColor = [UIColor whiteColor];
    }
//
    pageFlowView.delegate = self;
    pageFlowView.dataSource = self;
//    pageFlowView.emptyDataSetDelegate=self;
//    pageFlowView.emptyDataSetSource=self;
    pageFlowView.minimumPageAlpha = 0.4;
    //pageFlowView.minimumPageScale = 0.85;
    pageFlowView.orientation = NewPagedFlowViewOrientationHorizontal;
    
    [self.view addSubview:pageFlowView];
    [pageFlowView reloadData];
    
    //    UIPageControl *pageControl = [[UIPageControl alloc] init];
    //    pageControl.numberOfPages = self.imageArray.count;
    //    pageControl.userInteractionEnabled = NO;
    //    [pageControl setValue:[UIImage imageNamed:@"xuanzhong"] forKey:@"currentPageImage"];
    //    [pageControl setValue:[UIImage imageNamed:@"wei_xuanzhong"] forKey:@"pageImage"];
    //    self.pageControl = pageControl;
    //    [pageFlowView addSubview:pageControl];
    //
    //    [pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.centerX.equalTo(pageFlowView);
    //        make.bottom.equalTo(pageFlowView).mas_offset(-1);
    //    }];
    
    self.carInfoView.delegate = self;
    self.carInfoView.dataSource = self;
    self.carInfoView.emptyDataSetDelegate=self;
    self.carInfoView.emptyDataSetSource=self;
    
    [self.carInfoView registerClass:[MyCarInfosHeaderView class] forHeaderFooterViewReuseIdentifier:HeaderId];
    
    self.carInfoView.tableHeaderView = pageFlowView;
}

#pragma mark NewPagedFlowView Delegate
- (CGSize)sizeForPageInFlowView:(NewPagedFlowView *)flowView {
    return CGSizeMake(Main_Screen_Width - 84, (Main_Screen_Width - 84) / 2);
}

- (void)didSelectCell:(UIView *)subView withSubViewIndex:(NSInteger)subIndex {
    _Xuhao = subIndex;
}


#pragma mark NewPagedFlowView Datasource
- (NSInteger)numberOfPagesInFlowView:(NewPagedFlowView *)flowView {
    
    return self.CarArray.count;
//    return 0;
    
}

- (UIView *)flowView:(NewPagedFlowView *)flowView cellForPageAtIndex:(NSInteger)index{
    PGIndexBannerSubiew *bannerView = (PGIndexBannerSubiew *)[flowView dequeueReusableCell];
    if (!bannerView) {
        bannerView = [[PGIndexBannerSubiew alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width - 84*Main_Screen_Height/667, (Main_Screen_Width - 84*Main_Screen_Height/667) / 2)];
        bannerView.layer.cornerRadius = 4;
        bannerView.layer.masksToBounds = YES;
    }
    
    UIImageView *containImageView = [[UIImageView alloc] initWithFrame:bannerView.bounds];
    containImageView.image = self.imageArray[index];
    [bannerView addSubview:containImageView];
    
    UIImageView *iconImageView = [[UIImageView alloc] init];
    iconImageView.image = [UIImage imageNamed:@"aichemoren"];
    [containImageView addSubview:iconImageView];
    
    
    QWMyCarModel *car = [[QWMyCarModel alloc]init];
    car = [self.CarArray objectAtIndex:index];
    if(car.IsDefaultFav == 0)
    {
        iconImageView.hidden = YES;
    }
    else
    {
        iconImageView.hidden = NO;
    }
    
    
    
    UIImageView *carImageView = [[UIImageView alloc] init];
    carImageView.image = [UIImage imageNamed:@"aiche1"];
    [containImageView addSubview:carImageView];
    
    UILabel *carpinpai = [[UILabel alloc]initWithFrame:CGRectMake(115*Main_Screen_Height/667, 40*Main_Screen_Height/667, containImageView.frame.size.width - 130*Main_Screen_Height/667, 20)];
    carpinpai.text = car.CarBrand;
    carpinpai.font = [UIFont systemFontOfSize:15*Main_Screen_Height/667];
    [containImageView addSubview:carpinpai];
    
    UILabel *carpro = [[UILabel alloc]initWithFrame:CGRectMake(115*Main_Screen_Height/667, 40*Main_Screen_Height/667 + carpinpai.frame.size.height , containImageView.frame.size.width - 130*Main_Screen_Height/667, 20)];
    carpro.text = [NSString stringWithFormat:@"%ld年产",car.Manufacture];
    carpro.font = [UIFont systemFontOfSize:14*Main_Screen_Height/667];
    [containImageView addSubview:carpro];
    
    [iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(containImageView);
        make.width.height.mas_equalTo(30*Main_Screen_Height/667);
    }];
    
    [carImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(containImageView);
        make.left.equalTo(containImageView).mas_equalTo(24*Main_Screen_Height/667);
        make.width.height.mas_equalTo(67*Main_Screen_Height/667);
    }];
    
    bannerView.mainImageView = containImageView;
    
    
    
    
    return bannerView;
}

- (void)didScrollToPage:(NSInteger)pageNumber inFlowView:(NewPagedFlowView *)flowView {
    
    NSLog(@"%ld",pageNumber);
    _Xuhao = pageNumber;
    QWMyCarModel *car = [[QWMyCarModel alloc]init];
    
    
    
    if(self.CarArray.count != 0)
  {
    car = [self.CarArray objectAtIndex:_Xuhao];
    
    NSString *platenumbertype=[car.PlateNumber substringToIndex:1];
    
    [self.provinceBtn setTitle:platenumbertype forState:BtnNormal];
    //            3.从第n为开始直到最后（包含第n位）
    //CarBrand:车辆品牌,PlateNumber:车牌号,ChassisNum:车架号,Manufacture:生产年份,DepartureTime:上路时间,Mileage:行驶里程
    self.carNum.text=[car.PlateNumber substringFromIndex:1];
    self.CarBrandlab.text = car.CarBrand;
    self.ChassisNumlab.text = car.ChassisNum;
    self.Mileagelab.text = [NSString stringWithFormat:@"%ld",car.Mileage];
    
    
    
    
    
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    [inputFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    [inputFormatter setDateFormat:@"yyyyMM"];
    NSDate* inputDate = [inputFormatter dateFromString:car.DepartureTime];
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setLocale:[NSLocale currentLocale]];
    [outputFormatter setDateFormat:@"yyyy-MM"];
    NSString *targetTime = [outputFormatter stringFromDate:inputDate];
    _lbl2.text  = targetTime;
    
    if(targetTime == 0)
    {
        NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
        [inputFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
        [inputFormatter setDateFormat:@"yyyyM"];
        NSDate* inputDate = [inputFormatter dateFromString:car.DepartureTime];
        NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
        [outputFormatter setLocale:[NSLocale currentLocale]];
        [outputFormatter setDateFormat:@"yyyy-M"];
        NSString *targetTime = [outputFormatter stringFromDate:inputDate];
        _lbl2.text  = targetTime;
    }
    
    
    _lbl.text = [NSString stringWithFormat:@"%ld",car.Manufacture];
      
  }
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return self.CarArray.count;
    }else{
    if (self.CarArray.count!=0) {
        return 4;
    }else{
        return 0;
    
    }
    }
 
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *id_carCell = @"id_carCell";
    UITableViewCell *carCell = [tableView dequeueReusableCellWithIdentifier:id_carCell];
    
    carCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:id_carCell];
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            
            carCell.textLabel.text = @"车牌号";
            carCell.textLabel.textColor = [UIColor colorFromHex:@"#868686"];
            carCell.textLabel.font = [UIFont systemFontOfSize:14];
            
            //            UILabel *provinceLabel = [[UILabel alloc] init];
            //            provinceLabel.text = @"沪";
            //            provinceLabel.textColor = [UIColor colorFromHex:@"#868686"];
            //            provinceLabel.font = [UIFont systemFontOfSize:14];
            UIButton *provinceBtn = [[UIButton alloc] init];
            _provinceBtn = provinceBtn;
            
            [provinceBtn setTitle:@"沪" forState:UIControlStateNormal];
            [provinceBtn setTitleColor:[UIColor colorFromHex:@"#868686"] forState:UIControlStateNormal];
            provinceBtn.titleLabel.font = [UIFont systemFontOfSize:14];
//            [provinceBtn addTarget:self action:@selector(didClickProvinceBtn) forControlEvents:UIControlEventTouchUpInside];
            [carCell.contentView addSubview:provinceBtn];
            
            UIImageView *provinceImgV = [[UIImageView alloc] init];
            provinceImgV.image = [UIImage imageNamed:@"xuanshengfen"];
            [provinceBtn addSubview:provinceImgV];
            
            UITextField *numTF = [[UITextField alloc] init];
            numTF.placeholder = @"请输入车牌号";
            numTF.textColor = [UIColor colorFromHex:@"#b4b4b4"];
            numTF.font = [UIFont systemFontOfSize:12];
            numTF.delegate = self;
            self.carNum=numTF;
            [carCell.contentView addSubview:numTF];
            
            [provinceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(carCell.textLabel);
                make.left.equalTo(carCell.contentView).mas_offset(110);
            }];
            
            [provinceImgV mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(provinceBtn);
                make.bottom.equalTo(provinceBtn);
                make.width.height.mas_equalTo(7);
            }];
            
            [numTF mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(provinceBtn);
                make.leading.equalTo(provinceBtn.mas_trailing).mas_offset(16);
                make.width.mas_equalTo(200);
            }];
            
        
        }
        else{
            carCell.textLabel.text = @"品牌车系";
            carCell.textLabel.textColor = [UIColor colorFromHex:@"#868686"];
            carCell.textLabel.font = [UIFont systemFontOfSize:14];
            
            UITextField *brandTF = [[UITextField alloc] init];
            brandTF.placeholder = @"请填写";
            brandTF.textColor = [UIColor colorFromHex:@"#b4b4b4"];
            brandTF.font = [UIFont systemFontOfSize:12];
            [carCell.contentView addSubview:brandTF];
            self.CarBrandlab=brandTF;
            [brandTF mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(carCell.contentView).mas_offset(110);
                make.centerY.equalTo(carCell);
                make.right.equalTo(carCell.contentView).mas_offset(-12);
            }];
        }
       
    }
    
    if (indexPath.section == 1) {
        
        NSArray *arr = @[@"车架号码",@"生产年份",@"上路时间",@"行驶里程"];
        carCell.textLabel.text = arr[indexPath.row];
        carCell.textLabel.textColor = [UIColor colorFromHex:@"#868686"];
        carCell.textLabel.font = [UIFont systemFontOfSize:14];
        
        if (indexPath.row == 0 || indexPath.row == 3) {
            UITextField *textTF = [[UITextField alloc] init];
            textTF.delegate = self;
            textTF.tag = indexPath.row;
            textTF.placeholder = @"请填写";
            textTF.textColor = [UIColor colorFromHex:@"#b4b4b4"];
            textTF.font = [UIFont systemFontOfSize:12];
            [carCell.contentView addSubview:textTF];
            if (indexPath.row==0) {
                self.ChassisNumlab=textTF;
            }else if (indexPath.row==3){
                self.Mileagelab=textTF;
            }
            
            [textTF mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(carCell.contentView).mas_offset(110);
                make.centerY.equalTo(carCell);
                make.right.equalTo(carCell.contentView).mas_offset(-12);
            }];
        }else {
            
            carCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            if (indexPath.row == 1) {
                UILabel *lbl = [[UILabel alloc] init];
                _lbl = lbl;
                lbl.text = @"请选择";
                lbl.textColor = [UIColor colorFromHex:@"#868686"];
                lbl.font = [UIFont systemFontOfSize:12];
                [carCell.contentView addSubview:lbl];
                
                [lbl mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(carCell.contentView).mas_offset(110);
                    make.centerY.equalTo(carCell);
                }];
            }else {
                UILabel *lbl2 = [[UILabel alloc] init];
                _lbl2 = lbl2;
                lbl2.text = @"请选择";
                lbl2.textColor = [UIColor colorFromHex:@"#868686"];
                lbl2.font = [UIFont systemFontOfSize:12];
                [carCell.contentView addSubview:lbl2];
                
                [lbl2 mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(carCell.contentView).mas_offset(110);
                    make.centerY.equalTo(carCell);
                }];
            }
            
        }
        
        
    }
    QWMyCarModel *car = [[QWMyCarModel alloc]init];
    if (self.CarArray.count!=0) {
        car = [self.CarArray objectAtIndex:_Xuhao];
        //            2.截取到第n为（第n位不算在内）
       
        NSString *platenumbertype=[car.PlateNumber substringToIndex:1];
        
        [self.provinceBtn setTitle:platenumbertype forState:BtnNormal];
        //            3.从第n为开始直到最后（包含第n位）
        //CarBrand:车辆品牌,PlateNumber:车牌号,ChassisNum:车架号,Manufacture:生产年份,DepartureTime:上路时间,Mileage:行驶里程
        self.carNum.text=[car.PlateNumber substringFromIndex:1];
        self.CarBrandlab.text=car.CarBrand;
        self.ChassisNumlab.text=car.ChassisNum;
        self.Mileagelab.text=[NSString stringWithFormat:@"%ld",car.Mileage];
        self.lbl.text= [NSString stringWithFormat:@"%ld",car.Manufacture];
        self.lbl2.text=car.DepartureTime;
        
    }
    return carCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (self.CarArray.count!=0) {
        return 40;
    }else{
        return 0;
        
    }

    
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *hederview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, QWScreenWidth, 40)];
    if (self.CarArray.count!=0) {
        hederview.backgroundColor=kColorTableBG;
        UIView *hederviews=[[UIView alloc]initWithFrame:CGRectMake(0, 10, QWScreenWidth, 29)];
        hederviews.backgroundColor=[UIColor whiteColor];
        
        UIImageView *infoimage = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 15, 15)];
        infoimage.contentMode=UIViewContentModeScaleAspectFill;
        
        
        UILabel *infoLabel = [[UILabel alloc] initWithFrame:CGRectMake(infoimage.frame.origin.x+infoimage.frame.size.width, 0, QWScreenWidth, 29)];
        
        infoLabel.textColor = [UIColor colorFromHex:@"#868686"];
        infoLabel.font = [UIFont systemFontOfSize:15];
        
        if (section == 0) {
            infoimage.image=[UIImage imageNamed:@"xinxi"];
            infoLabel.text = @"  基本信息";
            
        }else{
            infoimage.image=[UIImage imageNamed:@"qitaxinxi"];
            infoLabel.text = @"  其他信息";
        }
        [hederviews addSubview:infoimage];
        [hederviews addSubview:infoLabel];
        [hederview addSubview:hederviews];
        
        return hederview;
    }else{
        return hederview;
    
    }
    
//    MyCarInfosHeaderView *headView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:HeaderId];
//    headView.backgroundColor=[UIColor whiteColor];
//    headView.infosLabel.textColor = [UIColor colorFromHex:@"#868686"];
//    headView.infosLabel.font = [UIFont systemFontOfSize:15];
//    
//    if (section == 0) {
//        headView.infosLabel.text = @"基本信息";
//        headView.imgV.image = [UIImage imageNamed:@"xinxi"];
//    }else {
//        headView.infosLabel.text = @"其他信息";
//        headView.imgV.image = [UIImage imageNamed:@"qitaxinxi"];
//    }
//    
//    
//    return headView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    QWIcreaseCarController *increaseVC = [[QWIcreaseCarController alloc] init];
    QWMyCarModel *car = [[QWMyCarModel alloc]init];
    car = [self.CarArray objectAtIndex:_Xuhao];
     increaseVC.mycarModel = car;
    increaseVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:increaseVC animated:YES];
//    if (indexPath.section == 1)
//    {
//        
//        if (indexPath.row == 1) {
//            QFDatePickerView *datePickerView = [[QFDatePickerView alloc]initDatePackerWithResponse:^(NSString *str) {
//                
//                self.lbl.text = str;
//            }];
//            [datePickerView show];
//        }
//        
//        if (indexPath.row == 2) {
////            QFDatePickerView *datePickerView = [[QFDatePickerView alloc]initDatePackerWithResponse:^(NSString *str) {
////                
////                self.lbl2.text = str;
////            }];
////            [datePickerView show];
//        }
//    }
    
}


#pragma mark - 弹出省份简称
//- (void)didClickProvinceBtn {
//    
//    ProvinceShortController *provinceVC = [[ProvinceShortController alloc] init];
//    
//    typeof(self) weakSelf = self;
//    
//    provinceVC.provinceBlock = ^(NSString *nameText) {
//        
//        [weakSelf.provinceBtn setTitle:nameText forState:UIControlStateNormal];
//    };
//    
//    provinceVC.modalPresentationStyle = UIModalPresentationOverCurrentContext;
//    [self presentViewController:provinceVC animated:NO completion:nil];
//}


#pragma mark - 键盘

//点击输入框触发
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    //键盘高度
    CGFloat keyboardHeight = 216.0f;
    //获取tag
    //NSLog(@"hhhhh === %d",textField.tag);
    //判断键盘高度是否遮住输入框，具体超过多少距离，移动多少距离（自己算好就可以，不一定和这里一样）
    if ((self.carInfoView.bounds.size.height - 264) - keyboardHeight - 60 * (textField.tag + 1) < 0 &&(self.carInfoView.bounds.size.height - 264) - keyboardHeight - 60 * (textField.tag + 1) > -60) {
        
        [self.carInfoView setContentOffset:CGPointMake(0, 216) animated:YES];
    }
    else if (self.carInfoView.bounds.size.height - 264 - keyboardHeight - 60 * (textField.tag + 1) < 180 &&self.carInfoView.bounds.size.height - 264 - keyboardHeight - 60 * (textField.tag + 1) > -120)
    {
        [self.carInfoView setContentOffset:CGPointMake(0, 80) animated:YES];
    }
    else if (self.carInfoView.bounds.size.height - keyboardHeight - 60 * (textField.tag + 1) < -120 &&self.carInfoView.bounds.size.height - keyboardHeight - 60 * (textField.tag + 1) > -180)
    {
        [self.carInfoView setContentOffset:CGPointMake(0, 170) animated:YES];
    }
}

//键盘收回触发
- (void)textFieldDidEndEditing:(UITextField *)textField{
    //回归原处
    [self.carInfoView setContentOffset:CGPointMake(0, 0) animated:YES];
    
}

//- (void)viewDidAppear:(BOOL)animated
//{
//    [super viewDidAppear:animated];
//
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidChangeFrame:) name:UIKeyboardDidChangeFrameNotification object:nil];
//}
//
//- (void)viewWillDisappear:(BOOL)animated
//{
//    [super viewWillDisappear:animated];
//
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidHideNotification object:nil];
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidChangeFrameNotification object:nil];
//}
//
//- (void)keyboardWillShow:(NSNotification *)noti
//{
//    CGFloat keyboardHeight = [noti.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;;
//    [self.view.layer removeAllAnimations];
//    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
//    UIView *firstResponderView = [keyWindow performSelector:@selector(findFirstResponder)];
//
//    CGRect rect = [[UIApplication sharedApplication].keyWindow convertRect:firstResponderView.frame fromView:firstResponderView.superview];
//
//    CGFloat bottom = rect.origin.y + rect.size.height;
//    CGFloat keyboardY = self.view.window.size.height - keyboardHeight;
//    if (bottom > keyboardY) {
//        _totalYOffset += bottom - (self.view.window.size.height - keyboardHeight);
//        [UIView animateWithDuration:[noti.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue]
//                              delay:0
//                            options:[noti.userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue]
//                         animations:^{
//                             self.view.y -= _totalYOffset;
//                         }
//                         completion:nil];
//    }
//
//
//}
//
//- (void)keyboardWillHide:(NSNotification *)noti
//{
//    [UIView animateWithDuration:[noti.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue]
//                          delay:0
//                        options:[noti.userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue]
//                     animations:^{
//                         self.view.y += _totalYOffset;
//                     }
//                     completion:nil];
//    _totalYOffset = 0;
//}
//
//- (void)keyboardWillChangeFrame:(NSNotification *)noti
//{
//
//}
//
//- (void)keyboardDidShow:(NSNotification *)noti
//{
//}
//
//- (void)keyboardDidHide:(NSNotification *)noti
//{
//}
//
//- (void)keyboardDidChangeFrame:(NSNotification *)noti
//{
//}

- (void)endEditing
{
    [self.carInfoView endEditing:YES];
}

#pragma mark -点击我的车库
- (void)clickMycarPort {
    
    QWMyCarPortController *carPortVC = [[QWMyCarPortController alloc] init];
    
    carPortVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:carPortVC animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 无数据占位
#import "UIScrollView+EmptyDataSet.h"//第三方空白页,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>
//无数据占位
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView{
    return [UIImage imageNamed:@"cheku_kongbai"];
}

- (CAAnimation *)imageAnimationForEmptyDataSet:(UIScrollView *)scrollView{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath: @"cheku_kongbai"];
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
    NSString *text = @"小二已在此恭候你多时";
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:13.0f],
                                 NSForegroundColorAttributeName: [UIColor colorFromHex: @"#4a4a4a"]};
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}
//设置按钮的文本和按钮的背景图片

//- (NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state  {
////    NSLog(@"buttonTitleForEmptyDataSet:点击上传照片");
//    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:17.0f]};
//    return [[NSAttributedString alloc] initWithString:@"点击上传照片" attributes:attributes];
//}
// 返回可以点击的按钮 上面带文字
- (NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state {
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:17.0f]};
    return [[NSAttributedString alloc] initWithString:@"xinzeng.png" attributes:attribute];
}


- (UIImage *)buttonImageForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state {
    return [UIImage imageNamed:@"xinzeng.png"];
}
//是否显示空白页，默认YES
- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView {
    return YES;
}
//是否允许点击，默认YES
- (BOOL)emptyDataSetShouldAllowTouch:(UIScrollView *)scrollView {
    return YES;
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
    QWIcreaseCarController *increaseVC = [[QWIcreaseCarController alloc] init];
    increaseVC.hidesBottomBarWhenPushed = YES;
//    increaseVC.titlename = @"新增车辆";
    [self.navigationController pushViewController:increaseVC animated:YES];
}
/**
 *  调整垂直位置
 */
- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView
{
    return -64;
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
