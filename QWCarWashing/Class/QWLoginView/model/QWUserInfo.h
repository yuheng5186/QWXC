//
//  QWUserInfo.h
//  QWCarWashing
//
//  Created by apple on 2017/8/23.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JSONModel/JSONModel.h>
@interface QWUserInfo:JSONModel
@property (assign,nonatomic)NSInteger Account_Id;
@property (assign,nonatomic)NSInteger Level_id;
@property (assign,nonatomic)NSInteger Sex;
@property (copy, nonatomic)NSString <Optional> *Age,*Headimg,*Hobby,*Memo,*Mobile,*ModifyType,*Name,*usermemo,*Occupation,*UserName,*VerCode,*UserScore;

@end
