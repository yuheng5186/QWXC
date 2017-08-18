//
//  QWCarWashingActivityViewController.m
//  QWCarWashing
//
//  Created by apple on 2017/8/18.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "QWCarWashingActivityViewController.h"
#import "UIWindow+YzdHUD.h"
@interface QWCarWashingActivityViewController ()
@property(nonatomic,strong) UIView *contentView;
@end

@implementation QWCarWashingActivityViewController

//- (void) drawNavigation {
//    
//    [self drawTitle:];
//}

//- (void) drawContent {
////    self.contentView.top        = self.navigationView.bottom;
////    self.contentView.height     = self.view.height;
//}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.contentView=[[UIView alloc]initWithFrame:CGRectMake(0, 64,QWScreenWidth, QWScreenheight)];

    self.contentView.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1];
    self.contentView.userInteractionEnabled = YES;
    self.title=@"洗车赠送";
    [self.view addSubview:self.contentView];
    [self createSubView];
    [self resetBabkButton];
    //    self.view.backgroundColor=[UIColor redColor];
}
- (void) resetBabkButton {
    
    UIButton *rightButton = [[UIButton alloc]initWithFrame:CGRectMake(0,0,20,20)];
    [rightButton setImage:[UIImage imageNamed:@"icon_titlebar_arrow"] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(backButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    self.navigationItem.leftBarButtonItem= rightItem;
}
- (void) backButtonClick:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) createSubView {
    
    UIView *upView                  = [UIUtil drawLineInView:self.contentView frame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height*200/667) color:[UIColor clearColor]];
    upView.top                      = 0;
    
    UIImage *backgroundImage              = [UIImage imageNamed:@"xichequanmuban"];
    UIImageView *backgroundImageView      = [UIUtil drawCustomImgViewInView:upView frame:CGRectMake(0, 0, Main_Screen_Width-Main_Screen_Width*20/375, backgroundImage.size.height) imageName:@"xichequanmuban"];
    backgroundImageView.top               = Main_Screen_Height*10/667;
    backgroundImageView.centerX           = upView.centerX;
    
    NSString *showString             = @"¥5";
    UIFont    *showFont              = [UIFont boldSystemFontOfSize:30];
    UILabel     *showlabel           = [UIUtil drawLabelInView:upView frame:CGRectMake(0, 0, Main_Screen_Width*80/375, Main_Screen_Height*40/667) font:showFont text:showString isCenter:NO];
    showlabel.textColor              = [UIColor whiteColor];
    showlabel.left                   = Main_Screen_Width*35/375;
    showlabel.centerY                = backgroundImageView.centerY;
    
    NSString *titleString             = @"5元洗车券";
    UIFont    *titleFont              = [UIFont systemFontOfSize:14];
    UILabel     *titleLabel           = [UIUtil drawLabelInView:upView frame:[UIUtil textRect:titleString font:titleFont] font:titleFont text:titleString isCenter:NO];
    titleLabel.textColor              = [UIColor colorFromHex:@"#4a4a4a"];
    titleLabel.left                   = showlabel.right +Main_Screen_Width*15/375;
    titleLabel.top                    = Main_Screen_Height*20/667;
    
    NSString *saleString             = @"抵扣券";
    UIFont    *saleFont              = [UIFont systemFontOfSize:10];
    UILabel     *saleLabel           = [UIUtil drawLabelInView:upView frame:[UIUtil textRect:saleString font:saleFont] font:saleFont text:saleString isCenter:NO];
    saleLabel.textColor              = [UIColor whiteColor];
    saleLabel.backgroundColor        = [UIColor colorWithHex:0xFFB500 alpha:1.0];
    saleLabel.left                   = titleLabel.right +Main_Screen_Width*10/375;
    saleLabel.centerY                = titleLabel.centerY+Main_Screen_Height*2/667;
    
    NSString *contentString             = @"门店洗车可直接抵扣";
    UIFont    *contentFont              = [UIFont systemFontOfSize:12];
    UILabel     *contentLabel           = [UIUtil drawLabelInView:upView frame:[UIUtil textRect:contentString font:contentFont] font:contentFont text:contentString isCenter:NO];
    contentLabel.textColor              = [UIColor colorFromHex:@"#999999"];
    contentLabel.left                   = titleLabel.left;
    contentLabel.top                    = titleLabel.bottom +Main_Screen_Height*5/667;
    
    NSString *timeString             = @"有效期：2017.7.27-2017.8.10";
    UIFont    *timeFont              = [UIFont systemFontOfSize:12];
    UILabel     *timeLabel           = [UIUtil drawLabelInView:upView frame:[UIUtil textRect:timeString font:timeFont] font:timeFont text:timeString isCenter:NO];
    timeLabel.textColor              = [UIColor colorFromHex:@"#999999"];
    timeLabel.left                   = contentLabel.left;
    timeLabel.top                    = contentLabel.bottom +Main_Screen_Height*5/667;
    
    NSString *string        = @"立即领取";
    UIButton    *getButton  = [UIUtil drawDefaultButton:upView title:string target:self action:@selector(getCardButtonClick:)];
    getButton.top           = backgroundImageView.bottom +Main_Screen_Height*30/667;
    getButton.centerX       = Main_Screen_Width/2;
    
    upView.height           = getButton.bottom +Main_Screen_Height*30/667;
    
    UIView *downView                = [UIUtil drawLineInView:self.contentView frame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height*200/667) color:[UIColor whiteColor]];
    downView.top                    = upView.bottom +Main_Screen_Height*10/667;
    
    NSString *useString             = @"使用须知";
    UIFont    *useFont              = [UIFont systemFontOfSize:16];
    UILabel     *uselabel           = [UIUtil drawLabelInView:downView frame:CGRectMake(0, 0, Main_Screen_Width*100/375, Main_Screen_Height*20/667) font:useFont text:useString isCenter:NO];
    uselabel.textColor              = [UIColor colorFromHex:@"#4a4a4a"];
    uselabel.left                   = Main_Screen_Width*10/375;
    uselabel.top                    = Main_Screen_Height*10/667;
    
    NSString *useString1             = @"1. 本代金券由金顶洗车APP开发，仅限金顶洗车店和与金顶合作商家使用";
    UIFont    *useFont1              = [UIFont systemFontOfSize:14];
    UILabel     *uselabel1           = [UIUtil drawLabelInView:downView frame:CGRectMake(0, 0, Main_Screen_Width-Main_Screen_Width*20/375, Main_Screen_Height*40/667) font:useFont1 text:useString1 isCenter:NO];
    uselabel1.textColor              = [UIColor colorFromHex:@"#999999"];
    uselabel1.numberOfLines          = 0;
    uselabel1.centerX                = downView.width/2;
    uselabel1.top                    = uselabel.bottom +Main_Screen_Height*10/667;
    
    NSString *useString2             = @"2. 如果使用代金券购买服务时发生退服务行为，代金券不予退还";
    UIFont    *useFont2              = [UIFont systemFontOfSize:14];
    UILabel     *uselabel2           = [UIUtil drawLabelInView:downView frame:CGRectMake(0, 0, Main_Screen_Width-Main_Screen_Width*20/375, Main_Screen_Height*40/667) font:useFont2 text:useString2 isCenter:NO];
    uselabel2.textColor              = [UIColor colorFromHex:@"#999999"];
    uselabel2.numberOfLines          = 0;
    uselabel2.centerX                = Main_Screen_Width/2;
    uselabel2.top                    = uselabel1.bottom +Main_Screen_Height*5/667;
    
    NSString *useString3             = @"3. 有任何问题，可咨询金顶客服";
    UIFont    *useFont3              = [UIFont systemFontOfSize:14];
    UILabel     *uselabel3           = [UIUtil drawLabelInView:downView frame:CGRectMake(0, 0, Main_Screen_Width-Main_Screen_Width*20/375, Main_Screen_Height*40/667) font:useFont3 text:useString3 isCenter:NO];
    uselabel3.textColor              = [UIColor colorFromHex:@"#999999"];
    uselabel3.numberOfLines          = 0;
    uselabel3.centerX                = Main_Screen_Width/2;
    uselabel3.top                    = uselabel2.bottom +Main_Screen_Height*0/667;
}
- (void) getCardButtonClick:(id)sender {
    
    [self.view.window showHUDWithText:@"恭喜您领取成功，已经放入您的卡券中" Type:ShowPhotoYes Enabled:YES];
    
}


@end
