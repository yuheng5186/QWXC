//
//  RechargeCell.m
//  CarWashing
//
//  Created by 时建鹏 on 2017/8/1.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "RechargeCell.h"
#import "UIView+AutoSizeToDevice.h"

@implementation RechargeCell


-(void)setCardBagModel:(QWCardBagModel *)cardBagModel{
    _cardBagModel=cardBagModel;
//    NSLog(@"%@===%ld",cardBagModel.Description,cardBagModel.CardCount);
    self.CardnameLabels.text = cardBagModel.CardName;
    self.CarddesLabels.text = [NSString stringWithFormat:@"%@ 免费洗车%ld次",cardBagModel.Description,cardBagModel.CardCount];
    
    
    
    
    
    self.CardTimeLabels.text = [NSString stringWithFormat:@"有效期: %@-%@",[LCMD5Tool DateZhuan:cardBagModel.ExpStartDates],[LCMD5Tool DateZhuan:cardBagModel.ExpEndDates]];
    
    if(cardBagModel.CardUseState == 2)
    {
        self.CardnameLabels.textColor = [UIColor colorFromHex:@"#ffffff"];
        self.tagLabels.textColor = [UIColor colorFromHex:@"#ffffff"];
        self.CarddesLabels.textColor = [UIColor colorFromHex:@"#ffffff"];
        self.backgroundImgVs.image = [UIImage imageNamed:@"bg_yishiyong"];
        
    }
    else if(cardBagModel.CardUseState == 3)
    {
        self.CardnameLabels.textColor = [UIColor colorFromHex:@"#ffffff"];
        self.tagLabels.textColor = [UIColor colorFromHex:@"#ffffff"];
        self.CarddesLabels.textColor = [UIColor colorFromHex:@"#ffffff"];
        self.backgroundImgVs.image = [UIImage imageNamed:@"bg_yiguoqi"];
    }
    

}


- (void)awakeFromNib {
    [super awakeFromNib];
    self.dg_viewAutoSizeToDevice = YES;
    //    self.CardnameLabel.textColor = [UIColor blackColor];
    self.tagLabels.font = [UIFont systemFontOfSize:11*Main_Screen_Height/667];
    self.CardnameLabels.font = [UIFont boldSystemFontOfSize:20*Main_Screen_Height/667];
    self.CarddesLabels.font = [UIFont systemFontOfSize:14*Main_Screen_Height/667];
    self.CardTimeLabels.font = [UIFont systemFontOfSize:12*Main_Screen_Height/667];
    self.CardTimeLabels.textColor = [UIColor colorFromHex:@"#999999"];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
