//
//  QWPersonHeaderTableViewCell.h
//  QWCarWashing
//
//  Created by apple on 2017/8/14.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QWPersonHeaderTableViewCell : UITableViewCell
@property(nonatomic,copy) void (^ImageClicked)(void);
@property(nonatomic,copy) void (^vipClicked)(void);
@property(nonatomic,copy) void (^qiandaoClicked)(void);
@end
