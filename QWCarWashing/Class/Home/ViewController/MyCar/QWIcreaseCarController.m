//
//  QWIcreaseCarController.m
//  QWCarWashing
//
//  Created by Wuxinglin on 2017/8/17.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "QWIcreaseCarController.h"
#import "QFDatePickerView.h"
#import "ProvinceShortController.h"

@interface QWIcreaseCarController ()<UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate>

@property (nonatomic, weak) UITableView *carInfoView;

@property (nonatomic, weak) UILabel *lbl;
@property (nonatomic, weak) UILabel *lbl2;
@property (nonatomic, weak) UIButton *provinceBtn;
@property (nonatomic, weak) UITextField *CarBrandlab;
@property (nonatomic, weak) UITextField *PlateNumberlab;
@property (nonatomic, weak) UITextField *ChassisNumlab;
@property (nonatomic, weak) UITextField *Manufacturelab;
@property (nonatomic, weak) UITextField *DepartureTimelab;
@property (nonatomic, weak) UITextField *Mileagelab;
//CarBrand:车辆品牌,PlateNumber:车牌号,ChassisNum:车架号,Manufacture:生产年份,DepartureTime:上路时间,Mileage:行驶里程
@end
static NSString *id_carInfoCell = @"id_carInfoCell";

@implementation QWIcreaseCarController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"我的车库";
    // Do any additional setup after loading the view.
    self.view.backgroundColor = kColorTableBG;
    
    UITableView *carInfoView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 420)];
    
    _carInfoView = carInfoView;
    carInfoView.backgroundColor=kColorTableBG;
    [self.view addSubview:carInfoView];
    
    carInfoView.delegate = self;
    carInfoView.dataSource = self;
    
    UIButton *saveButton = [UIUtil drawDefaultButton:self.view title:@"保存" target:self action:@selector(didClickSaveButton)];
    
    [saveButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).mas_offset(-25);
        make.centerX.equalTo(self.view);
        make.left.equalTo(self.view).mas_offset(10);
        make.height.mas_equalTo(48);
    }];
    
    
    //手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(endEditing)];
    tap.delegate = self;
    [self.view addGestureRecognizer:tap];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {//判断如果点击的是tableView的cell，就把手势给关闭了
        return NO;//关闭手势
    }//否则手势存在
    return YES;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 2;
    }
    
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *carCell = [tableView dequeueReusableCellWithIdentifier:id_carInfoCell];
    
    carCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:id_carInfoCell];
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            //CarBrand:车辆品牌,PlateNumber:车牌号,ChassisNum:车架号,Manufacture:生产年份,DepartureTime:上路时间,Mileage:行驶里程
            carCell.textLabel.text = @"车牌号";
            carCell.textLabel.textColor = [UIColor colorFromHex:@"#868686"];
            carCell.textLabel.font = [UIFont systemFontOfSize:14];
             UIButton *provinceLabel = [[UIButton alloc] init];
            [provinceLabel setTitle:@"沪" forState:UIControlStateNormal];
                        [provinceLabel setTitleColor:[UIColor colorFromHex:@"#868686"] forState:UIControlStateNormal];
            provinceLabel.font = [UIFont systemFontOfSize:14];
            [carCell.contentView addSubview:provinceLabel];
//            UIButton *provinceBtn = [[UIButton alloc] init];
            _provinceBtn = provinceLabel;
//            [provinceBtn setTitle:@"沪" forState:UIControlStateNormal];
//            [provinceBtn setTitleColor:[UIColor colorFromHex:@"#868686"] forState:UIControlStateNormal];
//            provinceBtn.titleLabel.font = [UIFont systemFontOfSize:14];
            [provinceLabel addTarget:self action:@selector(didClickProvinceBtn) forControlEvents:UIControlEventTouchUpInside];
            [carCell.contentView addSubview:provinceLabel];
            UIImageView *provinceImgV = [[UIImageView alloc] init];
            provinceImgV.image = [UIImage imageNamed:@"xuanshengfen"];
            [provinceLabel addSubview:provinceImgV];
            
            
            UITextField *numTF = [[UITextField alloc] init];
            numTF.placeholder = @"请输入车牌号";
            numTF.textColor = [UIColor colorFromHex:@"#b4b4b4"];
            numTF.font = [UIFont systemFontOfSize:12];
            [carCell.contentView addSubview:numTF];
            self.PlateNumberlab=numTF;
            [provinceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(carCell.textLabel);
                make.left.equalTo(carCell.contentView).mas_offset(110);
            }];
            [provinceImgV mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(provinceLabel);
                make.bottom.equalTo(provinceLabel);
                make.width.height.mas_equalTo(7);
            }];
            [numTF mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(provinceLabel);
                make.leading.equalTo(provinceLabel.mas_trailing).mas_offset(16);
                make.width.mas_equalTo(200);
            }];
        }else{
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
            textTF.placeholder = @"请填写";
            textTF.textColor = [UIColor colorFromHex:@"#b4b4b4"];
            textTF.font = [UIFont systemFontOfSize:12];
            [carCell.contentView addSubview:textTF];
            
            [textTF mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(carCell.contentView).mas_offset(110);
                make.centerY.equalTo(carCell);
                make.right.equalTo(carCell.contentView).mas_offset(-12);
            }];
            if (indexPath.row == 0) {
                self.ChassisNumlab=textTF;
            }else{
                self.Mileagelab=textTF;
                
            }
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
            }        }
        
        
    }
    if (self.mycarModel!=nil) {
        NSString *platenumbertype=[self.mycarModel.PlateNumber substringToIndex:1];
        
        [self.provinceBtn setTitle:platenumbertype forState:BtnNormal];
        //            3.从第n为开始直到最后（包含第n位）
        //CarBrand:车辆品牌,PlateNumber:车牌号,ChassisNum:车架号,Manufacture:生产年份,DepartureTime:上路时间,Mileage:行驶里程
        self.PlateNumberlab.text=[self.mycarModel.PlateNumber substringFromIndex:1];
        self.CarBrandlab.text=self.mycarModel.CarBrand;
        self.ChassisNumlab.text=self.mycarModel.ChassisNum;
        self.Mileagelab.text=[NSString stringWithFormat:@"%ld",self.mycarModel.Mileage];
        self.lbl.text= [NSString stringWithFormat:@"%ld",self.mycarModel.Manufacture];
        self.lbl2.text=self.mycarModel.DepartureTime;
    }
    
    return carCell;
}
#pragma mark - 弹出省份简称
- (void)didClickProvinceBtn {
    
    ProvinceShortController *provinceVC = [[ProvinceShortController alloc] init];
    
    typeof(self) weakSelf = self;
    
    provinceVC.provinceBlock = ^(NSString *nameText) {
        
        [weakSelf.provinceBtn setTitle:nameText forState:UIControlStateNormal];
    };
    
    provinceVC.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    [self presentViewController:provinceVC animated:NO completion:nil];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 40;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *hederview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, QWScreenWidth, 40)];
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
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 1)
    {
        
        if (indexPath.row == 1) {
            QFDatePickerView *datePickerView = [[QFDatePickerView alloc]initDatePackerWithResponse:^(NSString *str) {
                
                self.lbl.text = str;
            }];
            [datePickerView show];
        }
        
        if (indexPath.row == 2) {
            QFDatePickerView *datePickerView = [[QFDatePickerView alloc]initDatePackerWithResponse:^(NSString *str) {
                
                self.lbl2.text = str;
            }];
            [datePickerView show];
        }
    }
    
}



- (void)endEditing
{
    [self.view endEditing:YES];
}



- (void)didClickSaveButton {
    if (self.mycarModel==nil) {
        //新增
        if (IsNullIsNull(self.CarBrandlab.text)||IsNullIsNull(self.PlateNumberlab.text)||IsNullIsNull(self.ChassisNumlab.text)||IsNullIsNull(self.lbl.text)||IsNullIsNull(self.lbl2.text)||IsNullIsNull(self.Mileagelab.text)) {
            [self.view showInfo:@"请将信息填写完整" autoHidden:YES interval:1];
            
        }else{
            //车牌号：沪+编号
            NSString *PlateNumberstr=[NSString stringWithFormat:@"%@%@",self.provinceBtn.titleLabel.text,self.PlateNumberlab.text];
            
            [self requestAddCarAndcCarBrand:self.CarBrandlab.text andPlateNumber:PlateNumberstr andChassisNum:self.ChassisNumlab.text andManufacture:[self.lbl.text substringWithRange:NSMakeRange(0,4)] andDepartureTime:self.lbl2.text andMileage:self.Mileagelab.text];
            
        }
    }else{
        [self updateCarDefaultAndCarCode:[NSString stringWithFormat:@"%ld",self.mycarModel.CarCode] andModifyType:@"1"];
    }
    
    
    
}
#pragma mark-修改信息
#pragma mark-修改车辆默认值接口
-(void)updateCarDefaultAndCarCode:(NSString *)carCode andModifyType:(NSString *)ModifyType {
    //车牌号：沪+编号
    NSString *PlateNumberstr=[NSString stringWithFormat:@"%@%@",self.provinceBtn.titleLabel.text,self.PlateNumberlab.text];
    //    [[_mycararray objectAtIndex:button.tag] objectForKey:@"CarCode"]
    NSDictionary *mulDic = @{
                             @"Account_Id":[UdStorage getObjectforKey:Userid],
                             @"CarCode":carCode,
                             @"ModifyType":@1,
                             @"CarBrand":self.CarBrandlab.text,
                             @"PlateNumber":PlateNumberstr,
                             @"ChassisNum":self.ChassisNumlab.text,
                             @"EngineNum":@"",
                             @"Manufacture":[self.lbl.text substringWithRange:NSMakeRange(0,4)],
                             @"DepartureTime":self.lbl2.text,
                             @"Mileage":self.Mileagelab.text
                             };
    NSLog(@"%@",mulDic);
    [AFNetworkingTool post:mulDic andurl:[NSString stringWithFormat:@"%@MyCar/ModifyCarInfo",Khttp] success:^(NSDictionary *dict, BOOL success) {
        NSLog(@"%@",dict);
        if([[dict objectForKey:@"ResultCode"] isEqualToString:[NSString stringWithFormat:@"%@",@"F000000"]])
        {
            [self.view showInfo:@"修改成功" autoHidden:YES interval:2];
            NSNotification * notice = [NSNotification notificationWithName:@"updatemycarsuccess" object:nil userInfo:nil];
            [[NSNotificationCenter defaultCenter]postNotification:notice];
            [self.navigationController popViewControllerAnimated:YES];
        }
        else
        {
            [self.view showInfo:@"修改失败" autoHidden:YES interval:2];
        }
        
    } fail:^(NSError *error) {
        [self.view showInfo:@"修改失败" autoHidden:YES interval:2];
    }];
    
}
#pragma mark-新增爱车
//CarBrand:车辆品牌,PlateNumber:车牌号,ChassisNum:车架号,Manufacture:生产年份,DepartureTime:上路时间,Mileage:行驶里程
-(void)requestAddCarAndcCarBrand:(NSString *)CarBrand andPlateNumber:(NSString *)PlateNumber andChassisNum:(NSString *)ChassisNum andManufacture:(NSString *)Manufacture andDepartureTime:(NSString *)DepartureTime andMileage:(NSString *)Mileage {
        NSDictionary *mulDic = @{
                                 @"CarBrand":CarBrand,
                                 @"PlateNumber":PlateNumber,
                                 @"ChassisNum":ChassisNum,
                                 @"EngineNum":@"",
                                 @"Manufacture":Manufacture,
                                 @"DepartureTime":DepartureTime,
                                 @"Mileage":Mileage,
                                 @"Account_Id":[UdStorage getObjectforKey:Userid]
                                 };
    
        
    
            NSLog(@"%@",mulDic);
            [AFNetworkingTool post:mulDic andurl:[NSString stringWithFormat:@"%@MyCar/AddCarInfo",Khttp] success:^(NSDictionary *dict, BOOL success) {
                
                
                if([[dict objectForKey:@"ResultCode"] isEqualToString:[NSString stringWithFormat:@"%@",@"F000000"]])
                {
                    NSLog(@"%@",dict);
                    [self.view showInfo:@"新增成功" autoHidden:YES interval:2];
                    NSNotification * notice = [NSNotification notificationWithName:@"increasemycarsuccess" object:nil userInfo:nil];
                    [[NSNotificationCenter defaultCenter]postNotification:notice];
                    [self.navigationController popViewControllerAnimated:YES];
                }
                
                else
                {
                    [self.view showInfo:@"新增失败" autoHidden:YES interval:2];
                }
                
                
                
                
                
                
            } fail:^(NSError *error) {
                [self.view showInfo:@"新增失败" autoHidden:YES interval:2];
            }];
            
    
    


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
