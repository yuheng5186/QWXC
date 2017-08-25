//
//  QWMcServiceTableViewCell.m
//  QWCarWashing
//
//  Created by apple on 2017/8/15.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "QWMcServiceTableViewCell.h"

@implementation QWMcServiceTableViewCell
{
    AppDelegate *myDelegate;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setlayoutCell];
    }
    return self;
}
-(void)setMerchantmod:(QWMerSerListModel *)MerSerList{
    _MerSerList=MerSerList;
    self.Mcservicename.text=MerSerList.SerName;
    self.Mcserviceintro.text=MerSerList.SerComment;
    
    self.Mcprice.text=[NSString stringWithFormat:@"¥%@",MerSerList.OriginalPrice];
    self.Mccurrentprice.text=[NSString stringWithFormat:@"¥%@",MerSerList.CurrentPrice];

}
-(void)setlayoutCell
{
    myDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];

    UIButton *selButton = [[UIButton alloc]initWithFrame:CGRectMake1(13,24,16,16)];
    
    [self.contentView addSubview:selButton];
    self.selectbtn = selButton;
    
    UILabel *servicenamelabel = [[UILabel alloc]initWithFrame:CGRectMake1(50,24, 200, 10)];
    [servicenamelabel setFont:[UIFont fontWithName:@"Helvetica" size:16 * myDelegate.autoSizeScaleX]];
    servicenamelabel.textColor = [UIColor colorWithHexString:@"#4a4a4a"];
    servicenamelabel.text = @"标准洗车-五座轿车";
    [self.contentView addSubview:servicenamelabel];
    self.Mcservicename = servicenamelabel;
    
    UILabel *serviceintrolab = [[UILabel alloc]initWithFrame:CGRectMake1(50, 47, 260, 10)];
    [serviceintrolab setFont:[UIFont fontWithName:@"Helvetica" size:14 * myDelegate.autoSizeScaleX]];
    serviceintrolab.textColor = [UIColor colorWithHexString:@"#999999"];
    serviceintrolab.text = @"整车泡沫冲洗擦干、轮胎轮轴冲洗清洁、车内吸尘、内饰脚垫等简单除尘";
    [self.contentView addSubview:serviceintrolab];
    self.Mcserviceintro = serviceintrolab;
    
    self.Mcserviceintro.lineBreakMode = NSLineBreakByWordWrapping;
    self.Mcserviceintro.numberOfLines = 0;
    NSString *labelText = serviceintrolab.text;
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    
    [paragraphStyle setLineSpacing:0];//调整行间距
    
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    self.Mcserviceintro.attributedText = attributedString;
    
    [self.Mcserviceintro sizeToFit];
    
    UILabel *price = [[UILabel alloc]initWithFrame:CGRectMake1(280, 25, 80, 15)];
    [price setFont:[UIFont fontWithName:@"Helvetica" size:16 * myDelegate.autoSizeScaleX]];
    price.textColor = [UIColor colorWithHexString:@"#ff3645"];
    price.text = @"￥18.00";
    price.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:price];
    self.Mccurrentprice = price;
    
    
    UILabel *usedprice = [[UILabel alloc]initWithFrame:CGRectMake1(310, 47, 50, 10)];
    [usedprice setFont:[UIFont fontWithName:@"Helvetica" size:14 * myDelegate.autoSizeScaleX]];
    usedprice.textColor = [UIColor colorWithHexString:@"#999999"];
    usedprice.text = @"￥88.00";
    usedprice.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:usedprice];
    self.Mcprice = usedprice;
    
    NSString *textStr = usedprice.text;
    NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:textStr attributes:attribtDic];
    self.Mcprice.attributedText = attribtStr;
}

-(void)changeChoose:(UIButton *)sender
{
    [self.delegate ButtonDidSelected:self.selectedIndexPath];
}

CG_INLINE CGRect
CGRectMake1(CGFloat x, CGFloat y, CGFloat width, CGFloat height)
{
    AppDelegate *myDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    CGRect rect;
    rect.origin.x = x * myDelegate.autoSizeScaleX;
    rect.origin.y = y * myDelegate.autoSizeScaleY;
    rect.size.width = width * myDelegate.autoSizeScaleX;
    rect.size.height = height * myDelegate.autoSizeScaleY;
    return rect;
}


@end
