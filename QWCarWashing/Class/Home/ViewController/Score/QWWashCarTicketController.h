//
//  QWWashCarTicketController.h
//  QWCarWashing
//
//  Created by Wuxinglin on 2017/8/18.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "QWBaseViewController.h"
#import "QWCardConfigGradeModel.h"
@interface QWWashCarTicketController : QWBaseViewController
@property(nonatomic,strong)QWCardConfigGradeModel *card;

@property(nonatomic,copy)NSString *CurrentScore;
@end
