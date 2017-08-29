//
//  DelayPayCell.m
//  CarWashing
//
//  Created by 时建鹏 on 2017/8/4.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "DelayPayCell.h"
#import "UIView+AutoSizeToDevice.h"
#import "QWPayViewController.h"

@implementation DelayPayCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.dg_viewAutoSizeToDevice = YES;
    
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    self.orderLabel.textColor = [UIColor colorWithHexString:@"#4a4a4a"];
    
    self.washTypeLabel.textColor = [UIColor colorWithHexString:@"#3a3a3a"];
    
    self.timesLabel.textColor = [UIColor colorWithHexString:@"#999999"];
    
    self.stateLabel.textColor = [UIColor colorWithHexString:@"#ff525a"];
    
    self.priceLabel.textColor = [UIColor colorWithHexString:@"#ff525a"];
    
    [self.stateButton setTintColor:[UIColor colorWithHexString:@"#ff525a"]];
    self.stateButton.layer.cornerRadius = 12.5;
    self.stateButton.layer.borderWidth = 1;
    self.stateButton.layer.borderColor = [UIColor colorWithHexString:@"#ff525a"].CGColor;
}


- (IBAction)skipToPay:(id)sender {
    
    if ([self.delegate respondsToSelector:@selector(pushVC:animated:)]) {
        

        QWPayViewController *payVC = [[QWPayViewController alloc] init];
        payVC.hidesBottomBarWhenPushed = YES;
        
        [self.delegate pushVC:payVC animated:YES];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
