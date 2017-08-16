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
            _sliderview = [[HYSlider alloc]initWithFrame:CGRectMake(15, 66, QWScreenWidth-30,10)];
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
            _integralbtn = [[UIButton alloc] initWithFrame:CGRectMake(_sliderview.frame.origin.x, _sliderview.frame.origin.y+_sliderview.frame.size.height+30, _sliderview.frame.size.width, _sliderview.frame.size.height)];
            [_integralbtn setImage:[UIImage imageNamed:@"shengji"] forState:BtnNormal];
             _integralbtn.titleLabel.font = [UIFont systemFontOfSize:12];
            [_integralbtn setTitle:@"在获取400积分升级为黄金会员" forState:BtnNormal];
           
            
            [self.contentView addSubview:_integralbtn];
        }
        if (!_rulebtn) {
            _rulebtn = [[UIButton alloc] initWithFrame:CGRectMake(_integralbtn.frame.origin.x,  _sliderview.frame.origin.y+_sliderview.frame.size.height+8, _sliderview.frame.size.width, _sliderview.frame.size.height)];
            _rulebtn.titleLabel.textAlignment = NSTextAlignmentLeft;
            _rulebtn.titleLabel.font = [UIFont systemFontOfSize:12];
            
            [_rulebtn setTintColor: [UIColor colorWithHexString:@"#cfcfcf"]];
            [self.contentView addSubview:_rulebtn];
        }
        
    }
    return self;
}
-(void)onThumb:(id)sender{

}
-(void)endThumb:(id)sender{
    
}

@end
