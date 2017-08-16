//
//  QWOrderMenuTableViewCell.m
//  QWCarWashing
//
//  Created by apple on 2017/8/14.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "QWOrderMenuTableViewCell.h"
@interface QWOrderMenuTableViewCell()
@property(nonatomic,strong)UIImageView *orderImage;
@property(nonatomic,strong)UILabel *typename;
@end
@implementation QWOrderMenuTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        [self initView];
    }
    return self;
}
-(void)initView{
    NSArray *titlestr=@[@"订单",@"收藏",@"兑换"];
    NSArray *imagestr=@[@"dingdan",@"shoucang",@"duihuanliwu"];
    for (int i=0; i<3; i++) {
        UIImageView *image= [[UIImageView alloc]initWithFrame:CGRectMake((QWScreenWidth-24*3)/4*(i+1)+24*i, 12, 24, 24)];
        image.tag=i;
        image.contentMode=UIViewContentModeScaleAspectFill;
        image.image=[UIImage imageNamed:imagestr[i]];
        self.orderImage=image;
        [self addSubview:image];
       UILabel *typename = [[UILabel alloc]initWithFrame:CGRectMake(image.frame.origin.x, image.frame.size.height+5, 24, 25)];
        typename.font=[UIFont systemFontOfSize:10];
        typename.text=titlestr[i];
        [self addSubview:typename];
        
    }
}

@end
