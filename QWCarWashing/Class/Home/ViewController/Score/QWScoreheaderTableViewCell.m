//
//  QWScoreheaderTableViewCell.m
//  QWCarWashing
//
//  Created by apple on 2017/8/21.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "QWScoreheaderTableViewCell.h"
#import "QWMembershipController.h"

#import "QWHowToUpGradeController.h"
#import "QWWashCarTicketController.h"
#import "QWScoreDetailController.h"
@implementation QWScoreheaderTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.bgImage.userInteractionEnabled=YES;
//    self.contentView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"qiangweihuiyuanditu"]];
//    self.imageView.contentMode=UIViewContentModeScaleAspectFill;
//    self.backgroundView.userInteractionEnabled=YES;
    self.headerImage.image=[UIImage imageNamed:@"huiyuantou"];
    
#pragma mark-电话号码显示
    NSMutableString *phonestr = [[NSMutableString  alloc] initWithString:self.phoneNum.text];
    [phonestr replaceCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
    self.phoneNum.text=phonestr;
    [self.vipType setTitle:@"黄金会员" forState:BtnNormal];
    self.vipType.imageView.contentMode=UIViewContentModeScaleAspectFill;
    
    [self.vipType setImage:[UIImage imageNamed:@"huiyuandianjitiaozhuan"] forState:BtnStateSelected];
    [self.vipType setTitleEdgeInsets:UIEdgeInsetsMake(5, -self.vipType.imageView.image.size.width, 0, self.vipType.imageView.image.size.width)];
    [self.vipType setImageEdgeInsets:UIEdgeInsetsMake(5, self.vipType.titleLabel.bounds.size.width, 0, -self.vipType.titleLabel.bounds.size.width)];
    
     [self.ScoreNum setTitle:@"1680积分" forState:BtnNormal];
    self.ScoreNum.imageView.contentMode=UIViewContentModeScaleAspectFill;
    [self.ScoreNum setImage:[UIImage imageNamed:@"huiyuandianjitiaozhuan"] forState:UIControlStateNormal];
   
    [self.ScoreNum setTitleEdgeInsets:UIEdgeInsetsMake(10, -self.ScoreNum.imageView.image.size.width, 0, self.ScoreNum.imageView.image.size.width)];
    [self.ScoreNum setImageEdgeInsets:UIEdgeInsetsMake(10, self.ScoreNum.titleLabel.bounds.size.width, 0, -self.ScoreNum.titleLabel.bounds.size.width)];
 [self.ScoreNum addTarget:self action:@selector(scorenum:) forControlEvents:BtnTouchUpInside];
    CGFloat corner=10;
    self.goUpGrade.layer.borderWidth=1;
    self.goUpGrade.layer.borderColor=[UIColor whiteColor].CGColor;
    self.goUpGrade.layer.cornerRadius=corner;
    self.goUpGrade.titleLabel.font=[UIFont systemFontOfSize:9];
    [self.goUpGrade setTitle:@"去升等级" forState:BtnNormal];
    [self.goUpGrade addTarget:self action:@selector(goupgradeonclick:) forControlEvents:BtnTouchUpInside];
    CGFloat corners=10;
     self.AddScore.layer.borderWidth=1;
    self.AddScore.layer.borderColor=[UIColor whiteColor].CGColor;
    self.AddScore.layer.cornerRadius=corners;
    self.AddScore.titleLabel.font=[UIFont systemFontOfSize:9];
    [self.AddScore setTitle:@"去赚积分" forState:BtnNormal];
    [self.AddScore addTarget:self action:@selector(addscore:) forControlEvents:BtnTouchUpInside];
    
    
}
- (void)viptypeonclick:(UIButton *)sender{
    if (self.viptypeonclick) {
        self.viptypeonclick(sender);
    }
}
- (void)goupgradeonclick:(UIButton *)sender{
    if (self.goupgradeonclick) {
        self.goupgradeonclick(sender);
    }
}
- (void)scorenum:(UIButton *)sender{
    if (self.scorenum) {
        self.scorenum(sender);
    }
}
- (void)addscore:(UIButton *)sender{
    if (self.addscore) {
        self.addscore(sender);
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



- (IBAction)scoreNumOnclick:(id)sender {
    NSLog(@"%d",2);
}
@end
