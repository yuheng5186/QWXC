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
#import "UIView+AutoSizeToDevice.h"
@implementation QWScoreheaderTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
//    self.supview.backgroundColor=[UIColor clearColor];
    self.dg_viewAutoSizeToDevice = YES;
#pragma mark-电话号码显示
    NSMutableString *phonestr = [[NSMutableString  alloc] initWithString:self.phoneNum.text];
    [phonestr replaceCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
    self.phoneNum.text=phonestr;
    self.vipType.titleLabel.font=[UIFont systemFontOfSize:13*QWScreenheight/667 weight:5*QWScreenWidth/667];
    [self.vipType setTitle:@"黄金会员" forState:BtnNormal];
    self.vipType.imageView.contentMode=UIViewContentModeScaleAspectFill;
    
    [self.vipType setImage:[UIImage imageNamed:@"huiyuandianjitiaozhuan"] forState:BtnNormal];
    [self.vipType setTitleEdgeInsets:UIEdgeInsetsMake(1, -self.vipType.imageView.image.size.width, 0, self.vipType.imageView.image.size.width)];
    [self.vipType setImageEdgeInsets:UIEdgeInsetsMake(1, self.vipType.titleLabel.bounds.size.width, 0, -self.vipType.titleLabel.bounds.size.width)];
    self.ScoreNum.titleLabel.font=[UIFont systemFontOfSize:13*QWScreenheight/667 weight:5*QWScreenWidth/667];
    
    NSString *userscorestr= [NSString stringWithFormat:@"%@积分",[UdStorage getObjectforKey:UserScores]==nil?0:[UdStorage getObjectforKey:UserScores]];
    [self.ScoreNum setTitle:userscorestr forState:BtnNormal];

    self.ScoreNum.imageView.contentMode=UIViewContentModeScaleAspectFill;
    [self.ScoreNum setImage:[UIImage imageNamed:@"huiyuandianjitiaozhuan"] forState:UIControlStateNormal];
    
    [self.ScoreNum setTitleEdgeInsets:UIEdgeInsetsMake(1, -self.ScoreNum.imageView.image.size.width, 0, self.ScoreNum.imageView.image.size.width)];
    [self.ScoreNum setImageEdgeInsets:UIEdgeInsetsMake(1, self.ScoreNum.titleLabel.bounds.size.width, 0, -self.ScoreNum.titleLabel.bounds.size.width)];
//    [self.ScoreNum addTarget:self action:@selector(scorenum:) forControlEvents:BtnTouchUpInside];
    CGFloat corner=self.goUpGrade.bounds.size.height/2;
    self.goUpGrade.layer.borderWidth=1;
    self.goUpGrade.layer.borderColor=[UIColor whiteColor].CGColor;
    self.goUpGrade.layer.cornerRadius=corner;
    self.goUpGrade.titleLabel.font=[UIFont systemFontOfSize:8*QWScreenheight/667 weight:3*QWScreenWidth/667];
    [self.goUpGrade setTitle:@"升等级" forState:BtnNormal];
//    [self.goUpGrade addTarget:self action:@selector(goupgradeonclick:) forControlEvents:BtnTouchUpInside];
    CGFloat corners=self.AddScore.bounds.size.height/2;
    self.AddScore.layer.borderWidth=1;
    self.AddScore.layer.borderColor=[UIColor whiteColor].CGColor;
    self.AddScore.layer.cornerRadius=corners;
    self.AddScore.titleLabel.font=[UIFont systemFontOfSize:8*QWScreenheight/667 weight:3*QWScreenWidth/667];
    [self.AddScore setTitle:@"赚积分" forState:BtnNormal];
    //初始化CAGradientlayer对象，使它的大小为UIView的大小
    self.gradientLayer = [CAGradientLayer layer];
    self.gradientLayer.frame =CGRectMake(0, 0, QWScreenWidth, 230*QWScreenheight/667);
    
    //将CAGradientlayer对象添加在我们要设置背景色的视图的layer层
    [self.contentView.layer addSublayer:self.gradientLayer];
    
    //设置渐变区域的起始和终止位置（范围为0-1）
    self.gradientLayer.startPoint = CGPointMake(0, 0);
    self.gradientLayer.endPoint = CGPointMake(0, 1);
    
    self.gradientLayer.colors = @[(__bridge id)RGBACOLOR(253, 133, 40, 1).CGColor, (__bridge id)RGBACOLOR(253, 161, 51, 1).CGColor, (__bridge id)RGBACOLOR(253, 203, 71, 1).CGColor];
    self.gradientLayer.locations = @[@0.1, @0.4, @1.0];
    
   
//    //设置颜色数组
//    self.gradientLayer.colors = @[(__bridge id)RGBACOLOR(252, 127, 42, 1).CGColor,
//                                  (__bridge id)RGBACOLOR(253, 203, 71, 1).CGColor];
//    
//    //设置颜色分割点（范围：0-1）
//    self.gradientLayer.locations = @[@(0.5f), @(1.0f)];
//    
//    self.headerImage=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, QWScreenWidth/2, 40)];
//    self.contentViews.backgroundColor=[UIColor clearColor];
    self.headerImage.image=[UIImage imageNamed:@"huiyuantou"];
    [self.contentViews addSubview:    self.headerImage];
    [self.contentViews addSubview:    self.phoneNum];
    
    [self.contentViews addSubview:    self.supview];
    [self.supview addSubview:self.vipType];
    [self.supview addSubview:    self.goUpGrade];
    [self.supview addSubview:    self.ScoreNum];
    [self.supview addSubview:self.AddScore];
    
    [self.supview addSubview:self.linev];
    [self.contentViews addSubview:    self.Maxline];
   
//    self.Maxline.
//    .backgroundColor=[UIColor colorWithRed:248/255.0 green:238/255.0 blue:71/255.0 alpha:1];
//    self.linev.backgroundColor=[UIColor colorWithRed:248/255.0 green:238/255.0 blue:71/255.0 alpha:1];
//    self.aa.image=[UIImage imageNamed:@"huiyuantou"];

    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}




@end
