//
//  QWIntegModel.h
//  QWCarWashing
//
//  Created by apple on 2017/9/1.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface QWIntegModel : JSONModel
@property(nonatomic,copy)NSString *Account_Id;
@property(nonatomic,copy)NSString <Optional>*IntegDesc,*IntegName,*GetIntegralTime;
@property(nonatomic)NSInteger IntegType,IntegralNum,IsComplete;
@end
