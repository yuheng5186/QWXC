//
//  QWHomeDetailTableViewCell.h
//  QWCarWashing
//
//  Created by apple on 2017/8/15.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#define QWCellIdentifier_HomeDetailTableViewCell @"QWHomeDetailTableViewCell"
@interface QWHomeDetailTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *contentImage;
@property (weak, nonatomic) IBOutlet UILabel *typeName;
@property (weak, nonatomic) IBOutlet UILabel *payType;
@property (weak, nonatomic) IBOutlet UILabel *Nowtime;
@property (weak, nonatomic) IBOutlet UILabel *moneys;
@property (weak, nonatomic) IBOutlet UILabel *chedianName;

@end
