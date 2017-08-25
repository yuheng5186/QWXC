//
//  ShopInfoHeadView.h
//  CarWashing
//
//  Created by 时建鹏 on 2017/8/4.
//  Copyright © 2017年 DS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QWMerchantModel.h"
@interface ShopInfoHeadView : UIView

@property (weak, nonatomic) IBOutlet UIView *separateLine;

@property (weak, nonatomic) IBOutlet UIView *separateView;
@property (weak, nonatomic) IBOutlet UIView *twoLine;
@property (weak, nonatomic) IBOutlet UIView *thereLine;

@property (weak, nonatomic) IBOutlet UILabel *freeCheckLabel;

@property (weak, nonatomic) IBOutlet UILabel *qualityProtectedLabel;
@property (weak, nonatomic) IBOutlet UILabel *namelabel;
@property (weak, nonatomic) IBOutlet UILabel *addresslabel;
@property (weak, nonatomic) IBOutlet UILabel *typelabel;
@property(nonatomic,strong)QWMerchantModel *Merchant;




+ (instancetype)shopInfoHeadView;


@end
