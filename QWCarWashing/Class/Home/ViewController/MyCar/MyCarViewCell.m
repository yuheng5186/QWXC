//
//  MyCarViewCell.m
//  CarWashing
//
//  Created by 时建鹏 on 2017/7/31.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "MyCarViewCell.h"

@implementation MyCarViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
    }
    return self;
}

-(void)setMycarmodel:(QWMyCarModel *)mycarmodel{
    _mycarmodel=mycarmodel;
    self.brandLabel.text=mycarmodel.CarBrand;
    self.shengcDate.text=[NSString stringWithFormat:@"%ld年产",mycarmodel.Manufacture];
    if (mycarmodel.IsDefaultFav==1) {
        self.defaultbz.hidden=NO;
        self.defaultButton.selected = YES;
        
        [self.defaultButton setTitleColor:RGBACOLOR(230, 230, 230, 1) forState:BtnStateSelected];
        
        [self.defaultButton setTitle:@"已默认" forState:UIControlStateNormal];
        
    }else {
        self.defaultbz.hidden=YES;
        self.defaultButton.selected = NO;
        [self.defaultButton setTitleColor:RGBACOLOR(134, 134, 134, 1) forState:BtnNormal];
        
        [self.defaultButton setTitle:@"设置默认" forState:UIControlStateNormal];
        
    }
   

}
- (void)awakeFromNib {
    [super awakeFromNib];
    self.defaultbz.backgroundColor=RGBAA(252, 186, 46, 1);
    self.defaultbz.titleLabel.font=[UIFont systemFontOfSize:10 weight:7];
    self.defaultButton.backgroundColor = [UIColor whiteColor];
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
