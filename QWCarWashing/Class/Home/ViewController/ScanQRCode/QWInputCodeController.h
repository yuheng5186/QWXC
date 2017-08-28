//
//  QWInputCodeController.h
//  QWCarWashing
//
//  Created by Mac WuXinLing on 2017/8/25.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "QWBaseViewController.h"

typedef NS_ENUM(NSInteger, TFInputViewShowType){
    TFInputViewShowTypeSingleLine,      //单行
    TFInputViewShowTypeMultiLine,       //多行
    TFInputViewShowTypeBorder,          //边框
    TFInputViewShowTypeNoGapAndBorder,   //cell无间隙且带边框
    TFInputViewShowTypeSercetInput,     //密码输入
    TFInputViewShowTypeBecomeFirstResponder     //一进页面就弹出输入
};

@interface QWInputCodeController : QWBaseViewController

@property (nonatomic, assign) TFInputViewShowType showType;

@end
