//
//  QWwashCardTableViewCell.m
//  QWCarWashing
//
//  Created by apple on 2017/8/22.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "QWwashCardTableViewCell.h"

@implementation QWwashCardTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    self.titlelabel.font = [UIFont systemFontOfSize:14];
    self.titlelabel.textColor = [UIColor colorFromHex:@"#3a3a3a"];
    
    
//    self.detaillabel.text = @"门店吸尘是可抵扣相应金额,每月领取一次";
    self.detaillabel.font = [UIFont systemFontOfSize:12];
    self.detaillabel.textColor = [UIColor colorFromHex:@"#999999"];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
