//
//  QWMerchantModel.h
//  QWCarWashing
//
//  Created by apple on 2017/8/24.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QWMerchantModel : NSObject
@property(nonatomic,strong)NSString *Area,*City,*Img,*MerAddress,*MerFlag,*MerName,*MerPhone,*ServiceTime,*StoreProfile;
@property(nonatomic,assign)CGFloat Distance,Score,Xm,Ym;//距离
@property(nonatomic,assign)int Iscert,MerCode,ServiceCount,ShopType;

@end
