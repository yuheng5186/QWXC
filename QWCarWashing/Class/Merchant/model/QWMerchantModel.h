//
//  QWMerchantModel.h
//  QWCarWashing
//
//  Created by apple on 2017/8/24.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QWMerchantModel : JSONModel
@property(nonatomic,strong)NSString<Optional> *Area,*City,*Img,*MerAddress,*MerFlag,*MerName,*MerPhone,*ServiceTime,*StoreProfile;
@property(nonatomic,assign)CGFloat Distance,Score,Xm,Ym;//距离
@property(nonatomic,assign)int Iscert,MerCode,ServiceCount,ShopType;

@end
