//
//  QWOrderTableViewCell.m
//  QWCarWashing
//
//  Created by biti on 2017/8/14.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "QWOrderTableViewCell.h"


#define kTop 12

#define kLeftPads (QWScreenWidth-ImageWH*3)/4
#define ImageWH     30
#define HeaderSpan     ( QWScreenWidth - ImageWH *3 )/4

#define LaberWH     30
#define HeaderSpanLaber     (QWScreenWidth - LaberWH *3 )/4
#define kPaddingW (QWScreenWidth - ImageWH *3- kLeftPads*2)/2
@interface QWOrderTableViewCell ()
@property (nonatomic, strong) UIImageView *oneImage, *twoImage, *threeImage;
@property (nonatomic, strong) UILabel *oneLabel, *twoLabel, *threeLabel;
@end

@implementation QWOrderTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
   
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

        self.selectionStyle = UITableViewCellSelectionStyleNone;
        if (!_oneImage) {
            _oneImage = [[UIImageView alloc]initWithFrame:CGRectMake(kLeftPads, kTop, ImageWH, ImageWH)];
            _oneImage.userInteractionEnabled = YES;
            _oneImage.contentMode = UIViewContentModeScaleAspectFill;
            _oneImage.image= [UIImage imageNamed:@"dingdan"];
            [_oneImage addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(oneImageTap:)]];
           
            
            [self addSubview:_oneImage];
        }
        if (!_twoImage) {
            _twoImage = [[UIImageView alloc]initWithFrame:CGRectMake(kLeftPads + ImageWH+kPaddingW , kTop, ImageWH, ImageWH)];
            _twoImage.userInteractionEnabled = YES;
            _twoImage.image= [UIImage imageNamed:@"shoucang"];
            _twoImage.contentMode = UIViewContentModeScaleAspectFill;
            
            [_twoImage addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(twoImageTap:)]];
            [self addSubview:_twoImage];
        }
        if (!_threeImage) {
            _threeImage = [[UIImageView alloc]initWithFrame:CGRectMake(kLeftPads + ImageWH *2+kPaddingW *2 , kTop, ImageWH, ImageWH)];
            _threeImage.userInteractionEnabled = YES;
            _threeImage.image= [UIImage imageNamed:@"duihuanliwu"];
            
            _threeImage.contentMode = UIViewContentModeScaleAspectFill;
            [_threeImage addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(threeImageTap:)]];
            [self addSubview:_threeImage];
        }
        if (!_oneLabel) {
            _oneLabel = [[UILabel alloc]initWithFrame:CGRectMake(kLeftPads, CGRectGetMaxY(_oneImage.frame) +7, LaberWH, 20)];
            _oneLabel.textColor = [UIColor colorWithHexString:@"#999999"];
            _oneLabel.font = [UIFont systemFontOfSize:12];
            _oneLabel.text= @"订单";
            _oneLabel.textAlignment =NSTextAlignmentCenter;
           
            [self addSubview:_oneLabel];
        }
        if (!_twoLabel) {
            _twoLabel = [[UILabel alloc]initWithFrame:CGRectMake(kLeftPads + ImageWH+kPaddingW , CGRectGetMaxY(_oneImage.frame) +7, LaberWH, 20)];
            _twoLabel.textColor = [UIColor colorWithHexString:@"#999999"];
            _twoLabel.font = [UIFont systemFontOfSize:12];
            _twoLabel.text= @"收藏";
            _twoLabel.textAlignment =NSTextAlignmentCenter;
            
            [self addSubview:_twoLabel];
        }
        if (!_threeLabel) {
            _threeLabel = [[UILabel alloc]initWithFrame:CGRectMake(kLeftPads + ImageWH *2+kPaddingW *2, CGRectGetMaxY(_oneImage.frame) +7, LaberWH, 20)];
            _threeLabel.textColor = [UIColor colorWithHexString:@"#999999"];
            _threeLabel.font = [UIFont systemFontOfSize:12];
            _threeLabel.text= @"激活";
            _threeLabel.textAlignment =NSTextAlignmentCenter;
            [self addSubview:_threeLabel];
            
        }
    }
    return self;
}
- (void)threeImageTap:(UITapGestureRecognizer *)tap{
    if (self.threeClicked) {
        self.threeClicked();
    }
}
- (void)twoImageTap:(UITapGestureRecognizer *)tap{
    if (self.twoClicked) {
        self.twoClicked();
    }
}
- (void)oneImageTap:(UITapGestureRecognizer *)tap{
    if (self.oneClicked) {
        self.oneClicked();
    }
}
+ (CGFloat)cellHeight{
    return 75;
}
@end



