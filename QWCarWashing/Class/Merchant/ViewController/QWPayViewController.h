//
//  QWPayViewController.h
//  QWCarWashing
//
//  Created by apple on 2017/8/15.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QWPayViewController : UIViewController

@property(nonatomic ,copy)NSString *SerMerChant;
@property(nonatomic ,copy)NSString *SerProject;

@property(nonatomic ,copy)NSString *Jprice;
@property(nonatomic ,copy)NSString *Xprice;

@property(nonatomic ,copy)NSString *DeviceCode;

@property(nonatomic ,copy)NSString *SCode;
@property(nonatomic ,copy)NSString *MCode;
@property(nonatomic ,copy)NSString *OrderCode;

@property(nonatomic,copy)NSString *RemainCount;
@property(nonatomic,copy)NSString *CardType;
@property(nonatomic,copy)NSString *CardName;
@property(nonatomic,copy)NSString *IntegralNum;


@end
