//


#import "SalerListViewCell.h"

@interface SalerListViewCell ()



@end

@implementation SalerListViewCell


- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupUI];
}


- (void)setupUI {
    
    self.shopAdressLabel.textColor = [UIColor colorWithHexString:@"#999999"];
    self.separateLine.backgroundColor = [UIColor colorWithHexString:@"#e6e6e6"];
    
    self.freeTestLabel.layer.cornerRadius = 7.5;
    self.freeTestLabel.clipsToBounds = YES;
    self.freeTestLabel.backgroundColor = [UIColor colorWithHexString:@"#ff2a4f"];
    self.qualityLabel.layer.cornerRadius = 7.5;
    self.qualityLabel.clipsToBounds = YES;
    self.qualityLabel.backgroundColor = [UIColor colorWithHexString:@"#ff7556"];
    
    self.typeShopLabel.textColor = [UIColor colorWithHexString:@"#868686"];
    self.distanceLabel.textColor = [UIColor colorWithHexString:@"#868686"];
    
}




- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


@end
