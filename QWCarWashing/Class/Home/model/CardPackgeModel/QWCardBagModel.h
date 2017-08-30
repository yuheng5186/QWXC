//
//  QWCardBagModel.h
//  QWCarWashing
//
//  Created by apple on 2017/8/30.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface QWCardBagModel : JSONModel
@property(nonatomic,copy)NSString *Account_Id;
@property(nonatomic,copy)NSString *CardCode;
@property(nonatomic)NSInteger CardUseState;
@property(nonatomic,copy)NSString *Area;
@property(nonatomic)NSInteger CardCount;
@property(nonatomic)NSInteger UsedCount;
@property(nonatomic,copy)NSString *CardName;
@property(nonatomic,copy)id <Optional>CardPrice;
@property(nonatomic)NSInteger ConfigCode;
@property(nonatomic,copy)NSString *Description;
@property(nonatomic,copy)NSString *ExpStartDates;
@property(nonatomic,copy)NSString *ExpEndDates;
@property(nonatomic)NSInteger GetCardType;
@property(nonatomic)NSInteger Integralnum;
@property(nonatomic)NSInteger CardType;
@property(nonatomic)NSInteger UseLevel;
@end
