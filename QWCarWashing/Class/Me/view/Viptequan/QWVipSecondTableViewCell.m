//
//  QWVipSecondTableViewCell.m
//  QWCarWashing
//
//  Created by apple on 2017/8/16.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "QWVipSecondTableViewCell.h"

@implementation QWVipSecondTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        if (!_sliderview) {
            _sliderview = [[HYSlider alloc]initWithFrame:CGRectMake(15*Main_Screen_Height/667, 32*Main_Screen_Height/667, QWScreenWidth-30,10*Main_Screen_Height/667)];
            _sliderview.currentValueColor = [UIColor orangeColor];
            _sliderview.maxValue = 1000;
            _sliderview.currentSliderValue = 600;
            _sliderview.showTextColor = [UIColor orangeColor];
            _sliderview.showTouchView = YES;
            _sliderview.showScrollTextView = YES;
            _sliderview.touchViewColor = [UIColor orangeColor];
            _sliderview.delegate = self;
            
            
            [self.contentView addSubview:_sliderview];
        }
        if (!_integralbtn) {
            _integralbtn = [[UIButton alloc] initWithFrame:CGRectMake(_sliderview.frame.origin.x, _sliderview.frame.origin.y+_sliderview.frame.size.height+10*Main_Screen_Height/667, _sliderview.frame.size.width, 30*Main_Screen_Height/667)];
            _integralbtn.imageView.contentMode=UIViewContentModeScaleAspectFill;
            [_integralbtn setImage:[UIImage imageNamed:@"shengji"] forState:BtnNormal];
            _integralbtn.titleLabel.font = [UIFont systemFontOfSize:10*Main_Screen_Height/667];
            [_integralbtn setTitleColor:[UIColor grayColor] forState:BtnNormal];
            [_integralbtn setTitleColor:[UIColor orangeColor] forState:BtnHighlighted];
            [_integralbtn setTitle:@"在获取400积分升级为黄金会员" forState:BtnNormal];
            _integralbtn.backgroundColor=[UIColor redColor];
            
            [self.contentView addSubview:_integralbtn];
        }
        if (!_rulebtn) {
            _rulebtn = [[UIButton alloc] initWithFrame:CGRectMake(_sliderview.frame.origin.x,  _integralbtn.frame.origin.y+_integralbtn.frame.size.height+8*Main_Screen_Height/667, _sliderview.frame.size.width,30*Main_Screen_Height/667)];
            _rulebtn.titleLabel.textAlignment = NSTextAlignmentCenter;
            _rulebtn.titleLabel.font = [UIFont systemFontOfSize:10*Main_Screen_Height/667];
            [_rulebtn setTitleColor:[UIColor grayColor] forState:BtnNormal];
            [_rulebtn setTitleColor:[UIColor orangeColor] forState:BtnHighlighted];
            [_rulebtn setTitle:@"升级规则" forState:BtnNormal];
            _rulebtn.backgroundColor=[UIColor yellowColor];
            [self.contentView addSubview:_rulebtn];
        }
        
    }
    return self;
}


@end
