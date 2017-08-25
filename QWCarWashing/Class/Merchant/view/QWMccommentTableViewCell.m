//
//  QWMccommentTableViewCell.m
//  QWCarWashing
//
//  Created by apple on 2017/8/15.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "QWMccommentTableViewCell.h"

@implementation QWMccommentTableViewCell
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
-(void)setMerserlist:(QWMerComListModel *)ComList{
    _ComList=ComList;


    self.Username.text=ComList.FromuserName;
    self.comment.text=ComList.CommentContent;
    self.commenttime.text=ComList.CommentDate;
}
-(void)setlayoutCell
{
    myDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    UIImageView *imageV =[[UIImageView alloc]initWithFrame:CGRectMake1(15,15,35,35)];
    imageV.opaque = YES;
    imageV.image = [UIImage imageNamed:@"aiche1"];
    imageV.layer.masksToBounds = YES;
    imageV.layer.cornerRadius = 17.5*myDelegate.autoSizeScaleY;
    [self.contentView addSubview:imageV];
    self.UserImageView = imageV;
    
    
    
    UILabel *namelabel = [[UILabel alloc]initWithFrame:CGRectMake1(65,20, 100, 15)];
    [namelabel setFont:[UIFont fontWithName:@"Helvetica" size:16 * myDelegate.autoSizeScaleX]];
    namelabel.textColor = [UIColor colorWithHexString:@"#4a4a4a"];
    namelabel.text = @"13722223333";
    NSString *tel = [namelabel.text stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
    namelabel.text = tel;
    [self.contentView addSubview:namelabel];
    self.Username = namelabel;
    
    UILabel *commentlab = [[UILabel alloc]initWithFrame:CGRectMake1(65, 60, 260, 10)];
    [commentlab setFont:[UIFont fontWithName:@"Helvetica" size:14 * myDelegate.autoSizeScaleX]];
    commentlab.textColor = [UIColor colorWithHexString:@"#999999"];
    commentlab.text = @"整车泡沫冲洗擦干、轮胎轮轴冲洗清洁、车内吸尘、内饰脚垫等简单除尘";
    [self.contentView addSubview:commentlab];
    self.comment = commentlab;
    
    self.comment.lineBreakMode = NSLineBreakByWordWrapping;
    self.comment.numberOfLines = 0;
    NSString *labelText = commentlab.text;
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:0];//调整行间距
    
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    self.comment.attributedText = attributedString;
    
    [self.comment sizeToFit];
    

    
    UIImageView *imageV2 =[[UIImageView alloc]initWithFrame:CGRectMake1(65, 42.5, 62, 10)];
    imageV2.opaque = YES;
    imageV2.image = [UIImage imageNamed:@"shangjia3xing"];
    [self.contentView addSubview:imageV2];
    self.Mcxingji = imageV2;

    UILabel *timelabel = [[UILabel alloc]initWithFrame:CGRectMake1(200, 25, 163, 10)];
    [timelabel setFont:[UIFont fontWithName:@"Helvetica" size:13 * myDelegate.autoSizeScaleX]];
    timelabel.textColor = [UIColor colorWithHexString:@"#999999"];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init]; //初始化格式器。
    [formatter setDateFormat:@"YYYY-MM-dd hh:mm:ss"];//定义时间为这种格式： YYYY-MM-dd hh:mm:ss 。
    NSString *currentTime = [formatter stringFromDate:[NSDate date]];//将NSDate  ＊对象 转化为 NSString ＊对象。
    timelabel.text = currentTime;
    timelabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:timelabel];
    self.commenttime = timelabel;
    
}

+(NSString*)getCurrentTimes{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    
    //现在时间,你可以输出来看下是什么格式
    
    NSDate *datenow = [NSDate date];
    
    //----------将nsdate按formatter格式转成nsstring
    
    NSString *currentTimeString = [formatter stringFromDate:datenow];
    
    NSLog(@"currentTimeString =  %@",currentTimeString);
    
    return currentTimeString;
    
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
