//
//  GoodsExchangeCell.m
//  CarWashing
//
//  Created by 时建鹏 on 2017/8/14.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "GoodsExchangeCell.h"

@implementation GoodsExchangeCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setupUI];
    }
    
    return self;
}


- (void)setupUI {
    
    UIImageView *backImgV = [[UIImageView alloc] init];
    _backImgV = backImgV;
    backImgV.image = [UIImage imageNamed:@"tiyankaditu"];
    [self.contentView addSubview:backImgV];
    
    UILabel *nameLab = [[UILabel alloc] init];
    _nameLab = nameLab;
    nameLab.textColor = [UIColor colorFromHex:@"#ffffff"];
    nameLab.text = @"体验卡";
    nameLab.font = [UIFont systemFontOfSize:16];
    [backImgV addSubview:nameLab];
    
    UILabel *introLab = [[UILabel alloc] init];
    _introLab = introLab;
    introLab.textColor = [UIColor colorFromHex:@"#ffffff"];
    introLab.text = @"商家洗车自动抵扣";
    introLab.font = [UIFont systemFontOfSize:13];
    [backImgV addSubview:introLab];
    
    UILabel *scoreLab = [[UILabel alloc] init];
    _scoreLab = scoreLab;
    scoreLab.text = @"1000积分";
    scoreLab.textColor = [UIColor colorFromHex:@"#ffffff"];
    scoreLab.font = [UIFont systemFontOfSize:18];
    [backImgV addSubview:scoreLab];
    
    [backImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.contentView).mas_equalTo(20);
        make.right.bottom.equalTo(self.contentView).mas_equalTo(-20);
    }];
    
    [nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backImgV).mas_offset(22);
        make.top.equalTo(backImgV).mas_offset(21);
    }];
    
    [introLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(nameLab);
        make.top.equalTo(nameLab.mas_bottom).mas_offset(10);
    }];
    
    [scoreLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(backImgV).mas_offset(-11);
        make.bottom.equalTo(backImgV).mas_offset(-11);
    }];
    
}



- (void)awakeFromNib {
    [super awakeFromNib];
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    
}

@end
