//
//  QWScoreheaderTableViewCell.h
//  QWCarWashing
//
//  Created by apple on 2017/8/21.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QWScoreheaderTableViewCell : UITableViewCell
@property (weak, nonatomic)IBOutlet  UIImageView *headerImage;
@property (assign, nonatomic) IBOutlet UIView *contentViews;
@property (weak, nonatomic) IBOutlet UILabel *Maxline;
@property (weak, nonatomic) IBOutlet UILabel *linev;
//
@property (weak, nonatomic) IBOutlet UILabel *phoneNum;
@property (weak, nonatomic) IBOutlet UIButton *vipType;
@property (weak, nonatomic) IBOutlet UIButton *goUpGrade;
@property (weak, nonatomic) IBOutlet UIButton *ScoreNum;
@property (weak, nonatomic) IBOutlet UIButton *AddScore;


@property (nonatomic, strong) CAGradientLayer *gradientLayer;
//- (IBAction)scoreNumOnclick:(id)sender;

@end

