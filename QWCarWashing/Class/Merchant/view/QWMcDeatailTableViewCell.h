//
//  QWMcDeatailTableViewCell.h
//  QWCarWashing
//
//  Created by apple on 2017/8/15.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QWMcDeatailTableViewCell : UITableViewCell

@property(nonatomic,weak)UIImageView *McImageView;
@property(nonatomic,weak)UIImageView *McImagecheckView;
@property(nonatomic,weak)UILabel *Mcname;
@property(nonatomic,weak)UILabel *Mccat;

@property(nonatomic,weak)UILabel *McDingdanlabel;
@property(nonatomic,weak)UIImageView *McImagedanhaoView;

@property(nonatomic,weak)UILabel *Mcrange;
@property(nonatomic,weak)UILabel *Mcaddress;
@property(nonatomic,weak)UIImageView *Mcxingji;
@property(nonatomic,weak)UILabel *Mcscore;

@property(nonatomic,weak)UILabel *Mctag1;
@property(nonatomic,weak)UILabel *Mctag2;

@property(nonatomic,weak)UIButton *callbtn;
@property(nonatomic,weak)UIButton *collectbtn;

-(void)setlayoutCell;

@end
