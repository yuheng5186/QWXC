//
//  QWDetailAddressTableViewCell.h
//  QWCarWashing
//
//  Created by apple on 2017/8/15.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QWMerchantModel.h"

@protocol SkipToNaviDelegate <NSObject>

- (void)showMapNavigationView;

@end


@interface QWDetailAddressTableViewCell : UITableViewCell

@property(nonatomic,weak)UIImageView *MczuobiaoImageView;
@property(nonatomic,weak)UIImageView *MctimeImageView;
@property(nonatomic,weak)UILabel *Mctimelabel;
@property(nonatomic,weak)UILabel *Mcaddress;

@property(nonatomic,weak)UIImageView *McImagelubiaoView;
@property(nonatomic,weak)UILabel *Mcrange;

@property(nonatomic,weak)UIButton *navigationbtn;
@property(nonatomic,strong)QWMerchantModel *merchantModel;
//-(void)setlayoutCell;

@property (nonatomic, weak) id<SkipToNaviDelegate>delegate;

@end
