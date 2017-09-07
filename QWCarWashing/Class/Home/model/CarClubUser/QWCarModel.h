//
//  QWCarModel.h
//  QWCarWashing
//
//  Created by apple on 2017/8/30.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface QWCarModel : JSONModel
@property (nonatomic)NSInteger UseLevel;
@property (nonatomic ,copy)NSString <Optional>*Description;
@property (nonatomic ,copy)NSString <Optional>*Img;
@property (nonatomic ,copy)NSString <Optional>*ExpiredTimes;
@property (nonatomic ,copy)id <Optional>CardPrice;
@property (nonatomic ,copy)NSString <Optional>*Account_Id;
@property (nonatomic)NSInteger Integralnum;
@property (nonatomic)NSInteger CardType;
@property (nonatomic)NSInteger IsReceive;
@property (nonatomic)NSInteger GetCardType;
@property (nonatomic)NSInteger CardCount;
@property (nonatomic)NSInteger CardQuantity;
@property (nonatomic ,copy)NSString <Optional>*Area;
@property (nonatomic ,copy)NSString <Optional>*CardName;
@property (nonatomic ,copy)NSString <Optional>*CreateTime;
@property (nonatomic ,copy)NSString <Optional>*CurrentOrNextLevel;
@property (nonatomic)NSInteger ConfigCode;
@property (nonatomic)NSInteger ExpiredDay;
@property(nonatomic)CGFloat DiscountPrice,PaymentPrice;
@end
