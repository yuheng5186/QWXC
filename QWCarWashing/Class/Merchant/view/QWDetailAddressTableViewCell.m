//
//  QWDetailAddressTableViewCell.m
//  QWCarWashing
//
//  Created by apple on 2017/8/15.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "QWDetailAddressTableViewCell.h"

@implementation QWDetailAddressTableViewCell
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
    
    UIImageView *imageV =[[UIImageView alloc]initWithFrame:CGRectMake1(12,12,13,13)];
    imageV.opaque = YES;
    imageV.image = [UIImage imageNamed:@"shangjiadingwei"];
    [self.contentView addSubview:imageV];
    self.MczuobiaoImageView = imageV;
    
    
    UILabel *namelabel = [[UILabel alloc]initWithFrame:CGRectMake1(46,14, 200, 10)];
    [namelabel setFont:[UIFont fontWithName:@"Helvetica" size:13 * myDelegate.autoSizeScaleX]];
    namelabel.textColor = [UIColor colorWithHexString:@"#999999"];
    namelabel.text = @"上海市浦东新区金桥路金桥路";
    [self.contentView addSubview:namelabel];
    self.Mcaddress = namelabel;
    
    UIImageView *imageV1 =[[UIImageView alloc]initWithFrame:CGRectMake1(12,14+13+16,13,13)];
    imageV1.opaque = YES;
    imageV1.image = [UIImage imageNamed:@"yingyeshijian"];
    [self.contentView addSubview:imageV1];
    self.MctimeImageView = imageV1;
    
    
    UILabel *tlabel = [[UILabel alloc]initWithFrame:CGRectMake1(46,14+13+16, 200, 10)];
    [tlabel setFont:[UIFont fontWithName:@"Helvetica" size:13 * myDelegate.autoSizeScaleX]];
    tlabel.textColor = [UIColor colorWithHexString:@"#999999"];
    tlabel.text = @"营业时间 : 8:00-20:00";
    [self.contentView addSubview:tlabel];
    self.Mctimelabel = tlabel;
    
    UIView *separatorview = [[UIView alloc]initWithFrame:CGRectMake(0, self.contentView.frame.size.height-10*myDelegate.autoSizeScaleY,self.contentView.frame.size.width,10*myDelegate.autoSizeScaleY)];
    separatorview.backgroundColor = [UIColor colorWithRed:246/255.f green:246/255.f blue:246/255.f alpha:1.0f];
    [self.contentView addSubview:separatorview];
    
//    CGSize size = [namelabel boundingRectWithSize:CGSizeMake(QWScreenWidth,2000)];
//    namelabel.lineBreakMode = NSLineBreakByWordWrapping;
//    [namelabel sizeToFit];
//    
//    
//    
//    UILabel *catlabel = [[UILabel alloc]initWithFrame:CGRectMake1(250,12, 113, 10)];
//    [catlabel setFont:[UIFont fontWithName:@"Helvetica" size:12 * myDelegate.autoSizeScaleX]];
//    catlabel.textColor = [UIColor colorWithHexString:@"#868686"];
//    catlabel.text = @"美容店";
//    catlabel.textAlignment = NSTextAlignmentRight;
//    [self.contentView addSubview:catlabel];
//    self.Mccat = catlabel;
//    
//    CGSize sizecatlabel = [catlabel boundingRectWithSize:CGSizeMake(QWScreenWidth,2000)];
//    catlabel.lineBreakMode = NSLineBreakByWordWrapping;
//    
//    UILabel *addlabel = [[UILabel alloc]initWithFrame:CGRectMake(112 * myDelegate.autoSizeScaleX, 19* myDelegate.autoSizeScaleY+size.height, 200* myDelegate.autoSizeScaleX, 10* myDelegate.autoSizeScaleY)];
//    [addlabel setFont:[UIFont fontWithName:@"Helvetica" size:13 * myDelegate.autoSizeScaleX]];
//    addlabel.textColor = [UIColor colorWithHexString:@"#999999"];
//    addlabel.text = @"上海市浦东新区金桥路金桥路";
//    [self.contentView addSubview:addlabel];
//    self.Mcaddress = addlabel;
//    
//    CGSize sizeaddlabel = [addlabel boundingRectWithSize:CGSizeMake(QWScreenWidth,2000)];
//    addlabel.lineBreakMode = NSLineBreakByWordWrapping;
//    
    UIImageView *imageV3 =[[UIImageView alloc]initWithFrame:CGRectMake1(329 , 12, 14 ,14)];
    imageV3.opaque = YES;
    imageV3.image = [UIImage imageNamed:@"2828daohang"];
    [self.contentView addSubview:imageV3];
    self.McImagelubiaoView = imageV3;
//
    UILabel *julilabel = [[UILabel alloc]initWithFrame:CGRectMake(self.McImagelubiaoView.frame.origin.x -33*myDelegate.autoSizeScaleX ,31*myDelegate.autoSizeScaleY, 80*myDelegate.autoSizeScaleX, 10*myDelegate.autoSizeScaleY)];
    [julilabel setFont:[UIFont fontWithName:@"Helvetica" size:12 * myDelegate.autoSizeScaleX]];
    julilabel.textColor = [UIColor colorWithHexString:@"#868686"];
    julilabel.text = @"1.25km";
    julilabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:julilabel];
    self.Mcrange = julilabel;
    
    UIButton *dao = [[UIButton alloc] initWithFrame:CGRectMake(self.McImagelubiaoView.frame.origin.x - 13*myDelegate.autoSizeScaleX ,48*myDelegate.autoSizeScaleY, 40*myDelegate.autoSizeScaleX, 10*myDelegate.autoSizeScaleY)];
    [dao setTitle:@"导航" forState:UIControlStateNormal];
    dao.titleLabel.font = [UIFont systemFontOfSize: 13 * myDelegate.autoSizeScaleX];
    [dao setTitleColor:[UIColor colorWithHexString:@"#868686"] forState:UIControlStateNormal];
    [self.contentView addSubview:dao];
    self.navigationbtn = dao;
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
