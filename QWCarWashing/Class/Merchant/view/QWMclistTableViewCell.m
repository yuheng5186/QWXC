//
//  QWMclistTableViewCell.m
//  QWCarWashing
//
//  Created by apple on 2017/8/14.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "QWMclistTableViewCell.h"


@implementation QWMclistTableViewCell
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

-(void)setlayoutCell
{
    myDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    UIImageView *imageV =[[UIImageView alloc]initWithFrame:CGRectMake1(12,12,80,80)];
    imageV.opaque = YES;
    imageV.image = [UIImage imageNamed:@"aiche1"];
    [self.contentView addSubview:imageV];
    self.McImageView = imageV;
    
    UIImageView *imageV1 =[[UIImageView alloc]initWithFrame:CGRectMake1(0,0,30,30)];
    imageV1.opaque = YES;
    imageV1.image = [UIImage imageNamed:@"renzhengbiaoqian"];
    [self.McImageView addSubview:imageV1];
    self.McImagecheckView = imageV1;
    
    UILabel *namelabel = [[UILabel alloc]initWithFrame:CGRectMake1(112,12, 100, 10)];
    [namelabel setFont:[UIFont fontWithName:@"Helvetica" size:16 * myDelegate.autoSizeScaleX]];
    namelabel.textColor = [UIColor colorWithHexString:@"#4a4a4a"];
    namelabel.text = @"金雷快修店";
    [self.contentView addSubview:namelabel];
    self.Mcname = namelabel;
    
    
   
    CGSize size = [namelabel boundingRectWithSize:CGSizeMake(QWScreenWidth,2000)];
    namelabel.lineBreakMode = NSLineBreakByWordWrapping;
    [namelabel sizeToFit];
    
    
    
    UILabel *catlabel = [[UILabel alloc]initWithFrame:CGRectMake1(250,12, 113, 10)];
    [catlabel setFont:[UIFont fontWithName:@"Helvetica" size:12 * myDelegate.autoSizeScaleX]];
    catlabel.textColor = [UIColor colorWithHexString:@"#868686"];
    catlabel.text = @"美容店";
    catlabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:catlabel];
    self.Mccat = catlabel;
    
    CGSize sizecatlabel = [catlabel boundingRectWithSize:CGSizeMake(QWScreenWidth,2000)];
    catlabel.lineBreakMode = NSLineBreakByWordWrapping;
    
    UILabel *addlabel = [[UILabel alloc]initWithFrame:CGRectMake(112 * myDelegate.autoSizeScaleX, 19* myDelegate.autoSizeScaleY+size.height, 200* myDelegate.autoSizeScaleX, 10* myDelegate.autoSizeScaleY)];
    [addlabel setFont:[UIFont fontWithName:@"Helvetica" size:13 * myDelegate.autoSizeScaleX]];
    addlabel.textColor = [UIColor colorWithHexString:@"#999999"];
    addlabel.text = @"上海市浦东新区金桥路金桥路";
    [self.contentView addSubview:addlabel];
    self.Mcaddress = addlabel;
    
    CGSize sizeaddlabel = [addlabel boundingRectWithSize:CGSizeMake(QWScreenWidth,2000)];
    addlabel.lineBreakMode = NSLineBreakByWordWrapping;
    
    UIImageView *imageV3 =[[UIImageView alloc]initWithFrame:CGRectMake(320 * myDelegate.autoSizeScaleX, 21* myDelegate.autoSizeScaleY+sizecatlabel.height,10 * myDelegate.autoSizeScaleX,10 * myDelegate.autoSizeScaleY)];
    imageV3.opaque = YES;
    imageV3.image = [UIImage imageNamed:@"juli"];
    [self.contentView addSubview:imageV3];
    self.McImagelubiaoView = imageV3;
    
    UILabel *julilabel = [[UILabel alloc]initWithFrame:CGRectMake(self.McImagelubiaoView.frame.origin.x + self.McImagelubiaoView.frame.size.width + 2 *myDelegate.autoSizeScaleX,self.McImagelubiaoView.frame.origin.y, 40*myDelegate.autoSizeScaleX, 10*myDelegate.autoSizeScaleY)];
    [julilabel setFont:[UIFont fontWithName:@"Helvetica" size:11 * myDelegate.autoSizeScaleX]];
    julilabel.textColor = [UIColor colorWithHexString:@"#868686"];
    julilabel.text = @"1.25km";
    julilabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:julilabel];
    self.Mcrange = julilabel;
    
    UIImageView *lineImg = [[UIImageView alloc] initWithFrame:CGRectMake1(112, 75, 175, 2)];
    lineImg.image = [self drawLineByImageView:lineImg];
    [self.contentView addSubview:lineImg];
    
    UIImageView *imageV2 =[[UIImageView alloc]initWithFrame:CGRectMake(112 * myDelegate.autoSizeScaleX, self.Mcaddress.frame.origin.y+sizeaddlabel.height+5*myDelegate.autoSizeScaleY, 62* myDelegate.autoSizeScaleX, 10* myDelegate.autoSizeScaleY)];
    imageV2.opaque = YES;
    imageV2.image = [UIImage imageNamed:@"shangjia3xing"];
    [self.contentView addSubview:imageV2];
    self.Mcxingji = imageV2;
    
    UILabel *scorelabel = [[UILabel alloc]initWithFrame:CGRectMake(178 * myDelegate.autoSizeScaleX, self.Mcaddress.frame.origin.y+sizeaddlabel.height, 50* myDelegate.autoSizeScaleX, 21* myDelegate.autoSizeScaleY)];
    [scorelabel setFont:[UIFont fontWithName:@"Helvetica" size:15 * myDelegate.autoSizeScaleX]];
    scorelabel.textColor = [UIColor colorWithHexString:@"#dfdfdf"];
    scorelabel.text = @"4.0分";
    [self.contentView addSubview:scorelabel];
    self.Mcscore = scorelabel;
    
    UILabel *taglabel1 = [[UILabel alloc]initWithFrame:CGRectMake1(112, 83, 60, 15)];
    [taglabel1 setFont:[UIFont fontWithName:@"Helvetica" size:11 * myDelegate.autoSizeScaleX]];
    taglabel1.textColor = [UIColor colorWithHexString:@"#fefefe"];
    taglabel1.text = @"免费检测";
    taglabel1.backgroundColor = [UIColor colorWithHexString:@"#ffa24f"];
    taglabel1.textAlignment = NSTextAlignmentCenter;
    taglabel1.layer.masksToBounds = YES;
    taglabel1.layer.cornerRadius = 7.5*myDelegate.autoSizeScaleY;
    [self.contentView addSubview:taglabel1];
    self.Mctag1 = taglabel1;
    
    UILabel *taglabel2 = [[UILabel alloc]initWithFrame:CGRectMake1(112+60+7, 83, 60, 15)];
    [taglabel2 setFont:[UIFont fontWithName:@"Helvetica" size:11 * myDelegate.autoSizeScaleX]];
    taglabel2.textColor = [UIColor colorWithHexString:@"#fefefe"];
    taglabel2.text = @"质量保障";
    taglabel2.backgroundColor = [UIColor colorWithHexString:@"#ff7556"];
    taglabel2.textAlignment = NSTextAlignmentCenter;
    taglabel2.layer.masksToBounds = YES;
    taglabel2.layer.cornerRadius = 7.5*myDelegate.autoSizeScaleY;[self.contentView addSubview:taglabel2];
    [self.contentView addSubview:taglabel2];
    self.Mctag2 = taglabel2;

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
