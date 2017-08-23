//
//  QWUserInfo.h
//  QWCarWashing
//
//  Created by apple on 2017/8/23.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QWUserInfo : NSObject
@property (assign,nonatomic)NSInteger Account_Id;
@property (assign,nonatomic)NSInteger Level_id;
@property (copy, nonatomic)NSString *Age,*Headimg,*Hobby,*Memo,*Mobile,*ModifyType,*Name,*usermemo,*Occupation,*Sex,*UserName,*VerCode,*UserScore;

//@property (copy, nonatomic)NSString *userName,*Accountname,*userImagePath,*userPhone,*userSex,*userAge,*userhobby,*usermemo,*useroccupation,*userVerCode,*userOccupation,*userModifyType;

//+(QWUserInfo *)getInstanceByDic:(NSDictionary *)dic;
@end
