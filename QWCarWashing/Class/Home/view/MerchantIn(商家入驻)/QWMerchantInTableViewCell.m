//
//  QWMerchantInTableViewCell.m
//  QWCarWashing
//
//  Created by apple on 2017/8/15.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "QWMerchantInTableViewCell.h"

@implementation QWMerchantInTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.titletype.backgroundColor=[UIColor whiteColor];
    self.contentText.borderStyle = UITextBorderStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
