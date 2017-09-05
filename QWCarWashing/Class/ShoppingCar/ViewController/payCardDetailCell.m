//
//  payCardDetailCell.m
//  QWCarWashing
//
//  Created by Wuxinglin on 2017/8/18.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "payCardDetailCell.h"

@implementation payCardDetailCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setupUI];
    }
    return self;
}
-(void)setChoosecard:(QWCarModel *)choosecard{
    _choosecard=choosecard;
    self.useCardLabel.text=choosecard.CardName;
    self.timesCardLabel.text=[NSString stringWithFormat:@"可免费洗车%ld次",self.choosecard.CardCount];

}
- (void)setupUI {
    
    UILabel *useCardLabel = [[UILabel alloc] init];
    useCardLabel.text = @"卡使用说明";
    useCardLabel.font = [UIFont systemFontOfSize:14*Main_Screen_Height/667];
    useCardLabel.textColor = [UIColor colorFromHex:@"#4a4a4a"];
    [self.contentView addSubview:useCardLabel];
    
    UILabel *timesCardLabel = [[UILabel alloc] init];
    timesCardLabel.text = @"可免费洗车10次";
    timesCardLabel.textAlignment = NSTextAlignmentRight;
    timesCardLabel.textColor = [UIColor colorFromHex:@"#febb02"];
    timesCardLabel.font = [UIFont systemFontOfSize:13*Main_Screen_Height/667];
    self.timesCardLabel=timesCardLabel;
    [self.contentView addSubview:self.timesCardLabel];
    
    UILabel *brandCardLabel = [[UILabel alloc] init];
    brandCardLabel.text = @"金顶自动洗车可用";
    brandCardLabel.textColor = [UIColor colorFromHex:@"#febb02"];
    brandCardLabel.font = [UIFont systemFontOfSize:13*Main_Screen_Height/667];
    brandCardLabel.textAlignment = NSTextAlignmentRight;
    self.brandCardLabel=brandCardLabel;
    [self.contentView addSubview:self.brandCardLabel];
    
    
    //约束
    [useCardLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.contentView).mas_offset(10*Main_Screen_Height/667);
    }];
    
    [timesCardLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView.top).mas_offset(15*Main_Screen_Height/667);
        make.right.equalTo(self.contentView).mas_offset(-10*Main_Screen_Height/667);
        make.width.mas_equalTo(200*Main_Screen_Height/667);
    }];
    
    [brandCardLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.contentView.bottom).mas_offset(-15*Main_Screen_Height/667);
        make.right.equalTo(self.contentView).mas_offset(-10*Main_Screen_Height/667);
        make.width.mas_equalTo(200*Main_Screen_Height/667);
    }];
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
