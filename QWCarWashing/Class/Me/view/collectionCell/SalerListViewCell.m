//


#import "SalerListViewCell.h"

@interface SalerListViewCell ()



@end

@implementation SalerListViewCell


- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupUI];
}

#pragma mark-赋值
#pragma mark - Setters
-(void)setMerchantmodel:(QWMerchantModel *)Merchantmodel{
    _Merchantmodel=Merchantmodel;
    NSString *ImageURL=[NSString stringWithFormat:@"%@%@",kHTTPImg,Merchantmodel.Img];
    [self.shopImageView sd_setImageWithURL:[NSURL URLWithString:ImageURL] placeholderImage:[UIImage imageNamed:@"aiche1"]];
    self.shopNameLabel.text=Merchantmodel.MerName;
    if(Merchantmodel.ShopType == 1)
    {
        self.typeShopLabel.text = @"洗车服务";
    }
    
    self.shopAdressLabel.text= [NSString stringWithFormat:@"%.2fkm",Merchantmodel.Distance];
    self.shopAdressLabel.text=Merchantmodel.MerAddress;
    self.shopScore.text=[NSString stringWithFormat:@"%.2f分",Merchantmodel.Score];
    [self.starView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@xing",[[NSString stringWithFormat:@"%.2f",Merchantmodel.Score] substringToIndex:1]]]];
    
    NSArray *lab = [Merchantmodel.MerFlag componentsSeparatedByString:@","];
    if (lab.count>1) {
        self.qualityLabel.hidden=NO;
        self.freeTestLabel.text=lab[0];
        self.qualityLabel.text=lab[1];
        
    }else{
        self.freeTestLabel.text=lab[0];
        self.qualityLabel.hidden=YES;
    }
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
    
    self.kuaixiudian.backgroundColor=[UIColor colorFromHex:@"#bde279" alpha:0.8];
    
    [self.kuaixiudian setTitleColor:[UIColor whiteColor] forState:BtnNormal];
    [self.kuaixiudian setTitle:@"快修店" forState:BtnNormal];
    
    
    
}




- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


@end
