//
//  payCardDetailCell.h
//  QWCarWashing
//
//  Created by Wuxinglin on 2017/8/18.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QWCarModel.h"
@interface payCardDetailCell : UITableViewCell

@property (nonatomic, weak) UILabel *useCardLabel;
@property (nonatomic, weak) UILabel *timesCardLabel;
@property (nonatomic, weak) UILabel *brandCardLabel;
@property(nonatomic,strong)QWCarModel *choosecard;
@end
