//
//  QWHomeDetailTableViewCell.m
//  QWCarWashing
//
//  Created by apple on 2017/8/15.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "QWHomeDetailTableViewCell.h"

@implementation QWHomeDetailTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.typeName.textColor=[UIColor colorWithHexString:@"#4a4a4a"];
    self.typeName.font=[UIFont systemFontOfSize:14];
    self.Nowtime.textColor=[UIColor colorWithHexString:@"#999999"];
    self.Nowtime.font=[UIFont systemFontOfSize:12];
    self.payType.font=[UIFont systemFontOfSize:12];
    self.payType.textColor=[UIColor colorWithHexString:@"#868686"];
    self.moneys.font=[UIFont systemFontOfSize:20];
    self.moneys.textColor=[UIColor colorWithHexString:@"#3a3a3a"];
    self.chedianName.font=[UIFont systemFontOfSize:12];
    self.chedianName.textColor=[UIColor colorWithHexString:@"#868686"];
    self.seeDetailbtn.titleLabel.font=[UIFont systemFontOfSize:12];
    [self.seeDetailbtn setTitleColor:[UIColor colorFromHex:@"#868686"] forState:BtnNormal];
    self.seeDetailbtn.backgroundColor=[UIColor colorFromHex:@"#eaeaea"];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
