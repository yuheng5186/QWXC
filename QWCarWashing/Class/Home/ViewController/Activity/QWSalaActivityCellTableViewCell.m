//
//  QWSalaActivityCellTableViewCell.m
//  QWCarWashing
//
//  Created by Wuxinglin on 2017/9/6.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "QWSalaActivityCellTableViewCell.h"

@implementation QWSalaActivityCellTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)setFrame:(CGRect)frame {
    
    frame.origin.x = 15*Main_Screen_Height/667;
    frame.size.width -= 30*Main_Screen_Height/667;
    
    [super setFrame:frame];
}


@end
