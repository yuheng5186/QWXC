//
//  RechargeCell.h
//  CarWashing
//
//  Created by 时建鹏 on 2017/8/1.
//  Copyright © 2017年 DS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QWCardBagModel.h"
@interface RechargeCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *CardnameLabels;
@property (weak, nonatomic) IBOutlet UILabel *CarddesLabels;
@property (weak, nonatomic) IBOutlet UILabel *CardTimeLabels;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImgVs;
@property (weak, nonatomic) IBOutlet UILabel *tagLabels;
@property(nonatomic ,strong)QWCardBagModel *cardBagModel;
@end
