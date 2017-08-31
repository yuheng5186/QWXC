//
//  QWMemberRightsDetailController.h
//  QWCarWashing
//
//  Created by Mac WuXinLing on 2017/8/23.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "QWBaseViewController.h"
#import "QWCardConfigGradeModel.h"
@interface QWMemberRightsDetailController : QWBaseViewController
@property(nonatomic,copy)NSString *ConfigCode;
@property(nonatomic,copy)NSString *nextUseLevel;
@property(nonatomic,copy)NSString *currentUseLevel;


@property(nonatomic,copy)QWCardConfigGradeModel *card;
@end
