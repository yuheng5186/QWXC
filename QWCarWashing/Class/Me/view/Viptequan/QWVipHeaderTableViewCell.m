//
//  QWVipHeaderTableViewCell.m
//  QWCarWashing
//
//  Created by apple on 2017/8/15.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "QWVipHeaderTableViewCell.h"
#import "UIView+AutoSizeToDevice.h"

@implementation QWVipHeaderTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.dg_viewAutoSizeToDevice = YES;
    
    self.username.textColor=[UIColor colorFromHex:@"#999999"];
    self.username.font=[UIFont systemFontOfSize:14*Main_Screen_Height/667 weight:2];
    
    self.headerimage.image=[UIImage imageNamed:@"gerenxinxitou"];
    NSString *ImageURL=[NSString stringWithFormat:@"%@%@",kHTTPImg,[UdStorage getObjectforKey:UserHead]];
    NSURL *url=[NSURL URLWithString:ImageURL];
    [self.headerimage sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"gerenxinxitou"]];
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
