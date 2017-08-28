//
//  QWMyCarModel.h
//  QWCarWashing
//
//  Created by apple on 2017/8/28.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface QWMyCarModel : JSONModel
@property (copy, nonatomic)NSString <Optional>*Account_Id;
@property (copy, nonatomic)NSString <Optional>*CarBrand;//车辆品牌
@property NSInteger CarCode;
@property (copy, nonatomic)NSString <Optional>*ChassisNum;//车架号
@property NSInteger IsDefaultFav;//是否默认
@property NSInteger Manufacture;//生产年份
@property (copy, nonatomic)NSString <Optional>*PlateNumber;//车牌号
@property (copy, nonatomic)NSString <Optional>*DepartureTime;//上路时间
@property (copy, nonatomic)NSString <Optional>*EngineNum;//发动机编号
@property (copy, nonatomic)NSString <Optional>*Img;//车辆图片
@property (copy, nonatomic)NSString <Optional>*Province;//车辆图片
@property (nonatomic)NSInteger Mileage;//行驶里程
@property (nonatomic)NSInteger ModifyType;
@end
