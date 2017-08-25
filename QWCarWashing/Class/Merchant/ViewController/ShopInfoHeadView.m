//
//  ShopInfoHeadView.m
//  CarWashing
//
//  Created by 时建鹏 on 2017/8/4.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "ShopInfoHeadView.h"
#import "UIView+AutoSizeToDevice.h"

@implementation ShopInfoHeadView

+ (instancetype)shopInfoHeadView {
    
    return [[NSBundle mainBundle] loadNibNamed:@"ShopInfoHeadView" owner:nil options:nil].lastObject;
}

#pragma mark-model赋值
-(void)setMerchant:(QWMerchantModel *)Merchant{
    _Merchant=Merchant;
    self.namelabel.text=Merchant.MerName;
    if(Merchant.ShopType == 1)
            {
                self.typelabel.text = @"洗车服务";
            }
    self.addresslabel.text=Merchant.MerAddress;
    
    NSArray *lab = [Merchant.MerFlag componentsSeparatedByString:@","];
    if (lab.count>1) {
        self.qualityProtectedLabel.hidden=NO;
        self.freeCheckLabel.text=lab[0];
        self.qualityProtectedLabel.text=lab[1];
        
    }else{
        self.freeCheckLabel.text=lab[0];
        self.qualityProtectedLabel.hidden=YES;
    }


}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.separateView.backgroundColor=kColorTableBG;
    self.twoLine.backgroundColor=kColorTableBG;
    self.thereLine.backgroundColor=kColorTableBG;
    self.dg_viewAutoSizeToDevice = YES;
  
    [self.freeCheckLabel setFont:[UIFont fontWithName:@"Helvetica" size:11]];
   self.freeCheckLabel.textColor = [UIColor colorWithHexString:@"#fefefe"];
//    taglabel1.text = @"免费检测";
    self.freeCheckLabel.backgroundColor = [UIColor colorWithHexString:@"#ffa24f"];
    self.freeCheckLabel.textAlignment = NSTextAlignmentCenter;
    self.freeCheckLabel.layer.masksToBounds = YES;
    self.freeCheckLabel.layer.cornerRadius = 7.5;
    
    
  
    [self.freeCheckLabel setFont:[UIFont fontWithName:@"Helvetica" size:11*Main_Screen_Height/667]];
    self.freeCheckLabel.textColor = [UIColor colorWithHexString:@"#fefefe"];

    self.freeCheckLabel.backgroundColor = [UIColor colorWithHexString:@"#ff7556"];
    self.freeCheckLabel.textAlignment = NSTextAlignmentCenter;
    self.freeCheckLabel.layer.masksToBounds = YES;
    
    self.freeCheckLabel.layer.cornerRadius = 7.5*Main_Screen_Height/667;
   ;
    
    self.qualityProtectedLabel.layer.cornerRadius = 7.5*Main_Screen_Height/667;
  
    
}

@end
