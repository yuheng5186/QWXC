//
//  SuccessPayCell.m
//  CarWashing
//
//  Created by 时建鹏 on 2017/8/4.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "SuccessPayCell.h"
//#import "OrderCommentController.h"

@implementation SuccessPayCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.orderLabel.textColor = [UIColor colorWithHexString:@"#4a4a4a"];
    
    self.washTypeLabel.textColor = [UIColor colorWithHexString:@"#3a3a3a"];
    
    self.timesLabel.textColor = [UIColor colorWithHexString:@"#999999"];
    
    self.stateLabel.textColor = [UIColor colorWithHexString:@"#ff525a"];
    
    self.priceLabel.textColor = [UIColor colorWithHexString:@"#ff525a"];
    
    [self.stateButton setTitleColor:[UIColor colorWithHexString:@"#afafaf"] forState:UIControlStateNormal];
    self.stateButton.layer.cornerRadius = 12.5;
    self.stateButton.layer.borderWidth = 1;
    self.stateButton.layer.borderColor = [UIColor colorWithHexString:@"#afafaf"].CGColor;
    [self.stateButton addTarget:self action:@selector(clickCommentButton:) forControlEvents:UIControlEventTouchUpInside];
    
}


- (void)clickCommentButton:(UIButton *)button {
    
    if ([self.delegate respondsToSelector:@selector(pushController:animated:)]) {
        
//        OrderCommentController *starCommentVC = [[OrderCommentController alloc] init];
//        starCommentVC.hidesBottomBarWhenPushed = YES;
//        
//        [self.delegate pushController:starCommentVC animated:YES];
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
