//
//  QWMcDeatailTableViewCell.m
//  QWCarWashing
//
//  Created by apple on 2017/8/15.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "QWMcDeatailTableViewCell.h"

@implementation QWMcDeatailTableViewCell
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

#pragma mark-模型赋值
-(void)setMerchantmodels:(QWMerchantModel *)Merchantmodels{
    _Merchantmodels=Merchantmodels;
    self.Mcname.text=Merchantmodels.MerName;
    if(Merchantmodels.ShopType == 1)
    {
       self.Mccat.text = @"洗车服务";
    }
    self.Mcaddress.text=Merchantmodels.MerAddress;
    
    self.Mcscore.text=[NSString stringWithFormat:@"%.2f分",Merchantmodels.Score];
    
   self.McDingdanlabel.text= [NSString stringWithFormat:@"服务%d单",Merchantmodels.ServiceCount];
    NSArray *lab = [Merchantmodels.MerFlag componentsSeparatedByString:@","];
    if (lab.count>1) {
        self.Mctag2.hidden=NO;
        self.Mctag1.text=lab[0];
        self.Mctag2.text=lab[1];
        
    }else{
        self.Mctag1.text=lab[0];
        self.Mctag2.hidden=YES;
    }
    
    
    
}
-(void)setlayoutCell
{
    myDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    UIImageView *imageV1 =[[UIImageView alloc]initWithFrame:CGRectMake1(0,0,30,30)];
    imageV1.opaque = YES;
    imageV1.image = [UIImage imageNamed:@"renzhengbiaoqian"];
    [self.contentView addSubview:imageV1];
    self.McImagecheckView = imageV1;
    
    
    UILabel *namelabel = [[UILabel alloc]initWithFrame:CGRectMake1(20,9, 100, 10)];
    [namelabel setFont:[UIFont fontWithName:@"Helvetica" size:16 * myDelegate.autoSizeScaleX]];
    namelabel.textColor = [UIColor colorWithHexString:@"#4a4a4a"];
    namelabel.text = @"金雷快修店";
    [self.contentView addSubview:namelabel];
    self.Mcname = namelabel;
    
    
    
    CGSize size = [namelabel boundingRectWithSize:CGSizeMake(QWScreenWidth,2000)];
    namelabel.lineBreakMode = NSLineBreakByWordWrapping;
    [namelabel sizeToFit];
    
    
    
    UILabel *catlabel = [[UILabel alloc]initWithFrame:CGRectMake1(220,9, 50, 10)];
    [catlabel setFont:[UIFont fontWithName:@"Helvetica" size:12 * myDelegate.autoSizeScaleX]];
    catlabel.textColor = [UIColor colorWithHexString:@"#868686"];
    catlabel.text = @"美容店";
    catlabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:catlabel];
    self.Mccat = catlabel;
    
    
    
    UILabel *addlabel = [[UILabel alloc]initWithFrame:CGRectMake(20 * myDelegate.autoSizeScaleX, 16* myDelegate.autoSizeScaleY+size.height, 200* myDelegate.autoSizeScaleX, 10* myDelegate.autoSizeScaleY)];
    [addlabel setFont:[UIFont fontWithName:@"Helvetica" size:13 * myDelegate.autoSizeScaleX]];
    addlabel.textColor = [UIColor colorWithHexString:@"#999999"];
    addlabel.text = @"上海市浦东新区金桥路金桥路";
    [self.contentView addSubview:addlabel];
    self.Mcaddress = addlabel;
    
    CGSize sizeaddlabel = [addlabel boundingRectWithSize:CGSizeMake(QWScreenWidth,2000)];
    addlabel.lineBreakMode = NSLineBreakByWordWrapping;
    
    UIImageView *lineImg = [[UIImageView alloc] initWithFrame:CGRectMake1(20, 70, 250, 2)];
    lineImg.image = [self drawLineByImageView:lineImg];
    [self.contentView addSubview:lineImg];
    
    UIImageView *imageV2 =[[UIImageView alloc]initWithFrame:CGRectMake(20 * myDelegate.autoSizeScaleX, self.Mcaddress.frame.origin.y+sizeaddlabel.height+5*myDelegate.autoSizeScaleY, 62* myDelegate.autoSizeScaleX, 10* myDelegate.autoSizeScaleY)];
    imageV2.opaque = YES;
    imageV2.image = [UIImage imageNamed:@"shangjia3xing"];
    [self.contentView addSubview:imageV2];
    self.Mcxingji = imageV2;
    
    UILabel *scorelabel = [[UILabel alloc]initWithFrame:CGRectMake(86 * myDelegate.autoSizeScaleX, self.Mcaddress.frame.origin.y+sizeaddlabel.height, 50* myDelegate.autoSizeScaleX, 21* myDelegate.autoSizeScaleY)];
    [scorelabel setFont:[UIFont fontWithName:@"Helvetica" size:15 * myDelegate.autoSizeScaleX]];
    scorelabel.textColor = [UIColor colorWithHexString:@"#dfdfdf"];
    scorelabel.text = @"4.0分";
    [self.contentView addSubview:scorelabel];
    self.Mcscore = scorelabel;
    
    UILabel *dingdanlabel = [[UILabel alloc]initWithFrame:CGRectMake(150 * myDelegate.autoSizeScaleX, self.Mcaddress.frame.origin.y+sizeaddlabel.height, 89* myDelegate.autoSizeScaleX, 21* myDelegate.autoSizeScaleY)];
    [dingdanlabel setFont:[UIFont fontWithName:@"Helvetica" size:14 * myDelegate.autoSizeScaleX]];
    dingdanlabel.textColor = [UIColor colorWithHexString:@"#dfdfdf"];
    dingdanlabel.text = @"服务236单";
    dingdanlabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:dingdanlabel];
    self.McDingdanlabel = dingdanlabel;
    
    NSArray *number = @[@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9"];
    NSMutableAttributedString *attributeString  = [[NSMutableAttributedString alloc]initWithString:dingdanlabel.text];
    for (int i = 0; i < dingdanlabel.text.length; i ++) {
        //这里的小技巧，每次只截取一个字符的范围
        NSString *a = [dingdanlabel.text substringWithRange:NSMakeRange(i, 1)];
        //判断装有0-9的字符串的数字数组是否包含截取字符串出来的单个字符，从而筛选出符合要求的数字字符的范围NSMakeRange
        if ([number containsObject:a]) {
            [attributeString setAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#ff3645"],NSFontAttributeName:[UIFont systemFontOfSize:14 * myDelegate.autoSizeScaleX]} range:NSMakeRange(i, 1)];
        }
        
    }
    //完成查找数字，最后将带有字体下划线的字符串显示在UILabel上
    self.McDingdanlabel.attributedText = attributeString;
    
    
    UIImageView *imageV3 =[[UIImageView alloc]initWithFrame:CGRectMake(252 * myDelegate.autoSizeScaleX, self.Mcaddress.frame.origin.y+sizeaddlabel.height+1* myDelegate.autoSizeScaleY,18 * myDelegate.autoSizeScaleX,18 * myDelegate.autoSizeScaleY)];
    imageV3.opaque = YES;
    imageV3.image = [UIImage imageNamed:@"dianjitiaozhuan"];
    [self.contentView addSubview:imageV3];
    self.McImagedanhaoView = imageV3;
    
    UILabel *taglabel1 = [[UILabel alloc]initWithFrame:CGRectMake1(20, 80, 60, 15)];
    [taglabel1 setFont:[UIFont fontWithName:@"Helvetica" size:11 * myDelegate.autoSizeScaleX]];
    taglabel1.textColor = [UIColor colorWithHexString:@"#fefefe"];
    taglabel1.text = @"免费检测";
    taglabel1.backgroundColor = [UIColor colorWithHexString:@"#ffa24f"];
    taglabel1.textAlignment = NSTextAlignmentCenter;
    taglabel1.layer.masksToBounds = YES;
    taglabel1.layer.cornerRadius = 7.5*myDelegate.autoSizeScaleY;
    [self.contentView addSubview:taglabel1];
    self.Mctag1 = taglabel1;
    
    UILabel *taglabel2 = [[UILabel alloc]initWithFrame:CGRectMake1(20+60+7, 80, 60, 15)];
    [taglabel2 setFont:[UIFont fontWithName:@"Helvetica" size:11 * myDelegate.autoSizeScaleX]];
    taglabel2.textColor = [UIColor colorWithHexString:@"#fefefe"];
    taglabel2.text = @"质量保障";
    taglabel2.backgroundColor = [UIColor colorWithHexString:@"#ff7556"];
    taglabel2.textAlignment = NSTextAlignmentCenter;
    taglabel2.layer.masksToBounds = YES;
    taglabel2.layer.cornerRadius = 7.5*myDelegate.autoSizeScaleY;[self.contentView addSubview:taglabel2];
    [self.contentView addSubview:taglabel2];
    self.Mctag2 = taglabel2;
    
    UIView *backgroundview = [[UIView alloc]initWithFrame:CGRectMake1(288, 0,87,100)];
    backgroundview.backgroundColor = [UIColor colorWithHexString:@"#ffce36"];
    [self.contentView addSubview:backgroundview];
    
    UIButton *callButton = [[UIButton alloc]initWithFrame:CGRectMake1(31,12.5,25,25)];
    [callButton setImage:[UIImage imageNamed:@"dianhuab"] forState:UIControlStateNormal];
    [backgroundview addSubview:callButton];
    self.callbtn = callButton;
    
    UIButton *collectButton = [[UIButton alloc]initWithFrame:CGRectMake1(31,62.5,25,25)];
    [collectButton setImage:[UIImage imageNamed:@"shoucang1"] forState:BtnNormal];
    [collectButton setImage:[UIImage imageNamed:@"shoucang2"] forState:BtnStateSelected];
    [backgroundview addSubview:collectButton];
    self.collectbtn = collectButton;
    
    
}

- (UIImage *)drawLineByImageView:(UIImageView *)imageView {
    UIGraphicsBeginImageContext(imageView.frame.size);   //开始画线 划线的frame
    [imageView.image drawInRect:CGRectMake(0, 0, imageView.frame.size.width, imageView.frame.size.height)];
    //设置线条终点形状
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    // 5是每个虚线的长度  1是高度
    CGFloat lengths[] = {3,3};
    CGContextRef line = UIGraphicsGetCurrentContext();
    // 设置颜色
    CGContextSetStrokeColorWithColor(line, [UIColor colorWithHexString:@"#e6e6e6"].CGColor);
    
    CGContextSetLineDash(line, 0, lengths, 2);  //画虚线
    CGContextMoveToPoint(line, 0.0, 2.0);    //开始画线
    CGContextAddLineToPoint(line, imageView.frame.size.width, 2.0);
    CGContextStrokePath(line);
    // UIGraphicsGetImageFromCurrentImageContext()返回的就是image
    return UIGraphicsGetImageFromCurrentImageContext();
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
