//
//  QWVipHeaderTableViewCell.m
//  QWCarWashing
//
//  Created by apple on 2017/8/15.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "QWVipHeaderTableViewCell.h"

@implementation QWVipHeaderTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.username.textColor=[UIColor colorFromHex:@"#999999"];
    self.username.font=[UIFont systemFontOfSize:14 weight:2];
    self.headerimage.contentMode=UIViewContentModeScaleAspectFill;
    self.headerimage.image=[UIImage imageNamed:@"gerenxinxitou"];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
