//
//  QWCardConfigGradeModel.h
//  QWCarWashing
//
//  Created by apple on 2017/8/31.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface QWCardConfigGradeModel : JSONModel
@property(nonatomic,copy)NSString *Account_Id;
@property(nonatomic,copy)NSString *Area;
@property(nonatomic)NSInteger CardCount;
@property(nonatomic,copy)NSString *CardName;
@property(nonatomic)NSInteger CardQuantity;
@property(nonatomic,copy)id <Optional>CardPrice;
@property(nonatomic)NSInteger CardType;
@property(nonatomic)NSInteger ConfigCode;
@property(nonatomic,copy)NSString *CreateTime;
@property(nonatomic)NSInteger CurrentOrNextLevel;
@property(nonatomic,copy)NSString *Description;
@property(nonatomic)NSInteger ExpiredDay;
@property(nonatomic,copy)NSString *ExpiredTimes;
@property(nonatomic)NSInteger GetCardType;
@property(nonatomic,copy)NSString *Img;
@property(nonatomic)NSInteger Integralnum;
@property(nonatomic)NSInteger IsReceive;
@property(nonatomic)NSInteger UseLevel;
@end
