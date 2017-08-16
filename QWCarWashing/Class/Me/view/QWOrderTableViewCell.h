//
//  QWOrderTableViewCell.h
//  QWCarWashing
//
//  Created by biti on 2017/8/14.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kCellIdentifier_QWOrderTableViewCell @"QWOrderTableViewCell"

@interface QWOrderTableViewCell : UITableViewCell

@property (nonatomic, copy) void (^oneClicked)(void);
@property (nonatomic, copy) void (^twoClicked)(void);
@property (nonatomic, copy) void (^threeClicked)(void);
+ (CGFloat)cellHeight;
@end
