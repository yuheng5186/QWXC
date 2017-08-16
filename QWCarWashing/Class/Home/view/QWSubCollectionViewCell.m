//
//  QWSubCollectionViewCell.m
//  QWCarWashing
//
//  Created by apple on 2017/8/14.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "QWSubCollectionViewCell.h"
#define kTweetSendImageCCell_Width floorf((QWScreenWidth - 15*2- 10*3)/4)

#define imageSmailWH (QWScreenWidth*48/750)

#define imageWH (QWScreenWidth*90/750)
#define imageLeft (QWScreenWidth*78/750)
#define imageTop (36*QWScreenWidth/750)
#define laberW 90
#define laberTop (36*QWScreenWidth/750)
#define laberLeft (QWScreenWidth*78/750)
//#define imageWH (32)
//#define imageLeft (30)
//#define imageTop (10)
//#define laberW (70)
//
//#define laberTop (60)
//#define laberLeft (18)

@interface QWSubCollectionViewCell()

@property(nonatomic,strong)UIImageView *imagescell;//图片
@property(nonatomic,strong)UILabel *namecell;//名字
@end
@implementation QWSubCollectionViewCell
//       初始化图片，名字 设置控件的大小
-(id)initWithFrame:(CGRect)frame
{
    WEAKSELF
    self=[super initWithFrame:frame];
    self.backgroundColor = [UIColor whiteColor];
    if (self) {
        if (!_imagescell) {
            self.imagescell=[[UIImageView alloc]init];
            self.imagescell.contentMode = UIViewContentModeScaleAspectFill;
            self.imagescell.layer.cornerRadius=6;
            //            隐藏 边框的圆角
            self.imagescell.layer.masksToBounds=YES;
            [self addSubview:self.imagescell];
         
        
        if (!_namecell) {
            self.namecell=[[UILabel alloc]init];
            self.namecell.textAlignment=NSTextAlignmentCenter;
            self.namecell.font = [UIFont systemFontOfSize:12];
            self.namecell.textColor = [UIColor lightGrayColor];
           
          
            [self addSubview:self.namecell];
        }
    }
    }
    return self;
}

-(void)setImages:(NSString *)myImages andName:(NSString *)names
{
    _imagescell.image=[UIImage imageNamed:myImages];
    _namecell.text=names;
    WEAKSELF
    [_imagescell mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(imageWH, imageWH));
        make.centerX.mas_equalTo(weakSelf.contentView);
        make.top.mas_equalTo(4);
    }];

    [_namecell mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(laberW, 15));
        make.centerX.mas_equalTo(weakSelf.contentView);
        make.top.mas_equalTo(weakSelf.imagescell.mas_bottom).offset(4);
    }];

}
-(void)setSmailImages:(NSString *)myImages andName:(NSString *)names
{
    _imagescell.image=[UIImage imageNamed:myImages];
    _namecell.text=names;
    WEAKSELF
    [_imagescell mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(imageSmailWH, imageSmailWH));
        make.centerX.mas_equalTo(weakSelf.contentView);
        make.top.mas_equalTo(23);
    }];
    [_namecell mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(laberW, 15));
        make.centerX.mas_equalTo(weakSelf.contentView);
        make.top.mas_equalTo(weakSelf.imagescell.mas_bottom).offset(13);
    }];
}
+(CGSize)ccellSize{
    NSLog(@"-----: %lf,%lf",kTweetSendImageCCell_Width,kTweetSendImageCCell_Width);
    return CGSizeMake(kTweetSendImageCCell_Width, kTweetSendImageCCell_Width);
}

@end
