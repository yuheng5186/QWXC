//
//  QWVipSecondTableViewCell.h
//  QWCarWashing
//
//  Created by apple on 2017/8/16.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HYSlider.h"
@interface QWVipSecondTableViewCell : UITableViewCell<HYSliderDelegate>
@property (strong, nonatomic) HYSlider *sliderview;
@property (strong, nonatomic) UIButton *integralbtn, *rulebtn;

@end
