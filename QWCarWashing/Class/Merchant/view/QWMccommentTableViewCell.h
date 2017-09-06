//
//  QWMccommentTableViewCell.h
//  QWCarWashing
//
//  Created by apple on 2017/8/15.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QWMerchantModel.h"
@interface QWMccommentTableViewCell : UITableViewCell

@property(nonatomic,weak)UIImageView *UserImageView;
@property(nonatomic,weak)UILabel *Username;

@property(nonatomic,weak)UIImageView *Mcxingji;
@property(nonatomic,weak)UILabel *comment;

@property(nonatomic,weak)UILabel *commenttime;
@property(nonatomic,strong)QWMerComListModel *ComList;

//-(void)setlayoutCell;

@end
