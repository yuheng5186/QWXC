//
//  QWScoreheaderTableViewCell.h
//  QWCarWashing
//
//  Created by apple on 2017/8/21.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QWScoreheaderTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headerImage;

@property (weak, nonatomic) IBOutlet UILabel *phoneNum;
@property (weak, nonatomic) IBOutlet UIButton *vipType;
@property (weak, nonatomic) IBOutlet UIButton *goUpGrade;
@property (weak, nonatomic) IBOutlet UIButton *ScoreNum;
@property (weak, nonatomic) IBOutlet UIButton *AddScore;
@property(nonatomic,copy) void (^viptypeonclick)(UIButton *);
@property(nonatomic,copy) void (^goupgradeonclick)(UIButton *);
@property(nonatomic,copy) void (^scorenum)(UIButton *);
@property(nonatomic,copy) void (^addscore)(UIButton *);

@property (weak, nonatomic) IBOutlet UIImageView *bgImage;
- (IBAction)scoreNumOnclick:(id)sender;

@end

