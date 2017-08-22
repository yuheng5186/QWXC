//
//  QWShareMoneyController.m
//  QWCarWashing
//
//  Created by Wuxinglin on 2017/8/16.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "QWShareMoneyController.h"

#import "TYAlertController.h"
#import "ShareView.h"
#import "UIView+TYAlertView.h"
#import "TYAlertController+BlurEffects.h"

@interface QWShareMoneyController ()

@end

@implementation QWShareMoneyController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title      = @"分享赚钱";
    
    
    NSString   *titleString     = @"推荐得“洗车卡”";
    
    UIFont     *titleFont       = [UIFont boldSystemFontOfSize:25];
    UILabel *titleLabel         = [UIUtil drawLabelInView:self.view frame:CGRectMake(0, 0, Main_Screen_Width*300/375, Main_Screen_Height*60/667) font:titleFont text:titleString isCenter:NO];
    titleLabel.text             = titleString;
    titleLabel.textColor        = [UIColor colorFromHex:@"#545454"];
    titleLabel.textAlignment    = NSTextAlignmentCenter;
    titleLabel.centerX          = self.view.centerX;
    titleLabel.top              = Main_Screen_Height*100/667;
    
    
    NSString *showString              = @"邀请新人完成注册，即可获得价值99元洗车卡";
    UIFont *showStringFont            = [UIFont systemFontOfSize:14];
    UILabel *showLabel          = [UIUtil drawLabelInView:self.view frame:[UIUtil textRect:showString font:showStringFont] font:showStringFont text:showString isCenter:NO];
    showLabel.textColor         = [UIColor colorFromHex:@"#4a4a4a"];
    showLabel.textAlignment     = NSTextAlignmentCenter;
    showLabel.top               = titleLabel.bottom +Main_Screen_Height*14/667;
    showLabel.centerX           = titleLabel.centerX;
    
    UIImage  *getImage             = [UIImage imageNamed:@"efnxiangzhuanqiantu"];
    UIImageView *bigImageView   = [UIUtil drawCustomImgViewInView:self.view frame:CGRectMake(0, 0, getImage.size.width, getImage.size.height) imageName:@"efnxiangzhuanqiantu"];
    bigImageView.top            = showLabel.bottom +Main_Screen_Height*55/667;
    bigImageView.centerX        = self.view.centerX;
    
    //    UIButton    *getMoneyButton = [UIUtil drawDefaultButton:self.contentView title:@"立即邀请，新人可获得99元洗车卡" target:self action:@selector(getMoneyButtonClick:)];
    NSString *string   = @"立即邀请，新人可获得99元洗车卡";
    UIFont  *stringFont = [UIFont systemFontOfSize:16];
    UIButton    *getMoneyButton = [UIUtil drawButtonInView:self.view frame:CGRectMake(0, 0, Main_Screen_Width -Main_Screen_Width*60/375, Main_Screen_Height*40/667) text:string font:stringFont color:[UIColor whiteColor] target:self action:@selector(getMoneyButtonClick:)];
    getMoneyButton.backgroundColor  = [UIColor colorWithHex:0xFFB500 alpha:1.0];
    getMoneyButton.layer.cornerRadius   = 5;
    getMoneyButton.bottom          = Main_Screen_Height -Main_Screen_Height*77/667;
    getMoneyButton.centerX      = self.view.centerX;
}

- (void) getMoneyButtonClick:(id)sender {

    ShareView *shareView = [ShareView createViewFromNib];
    TYAlertController *alertController = [TYAlertController alertControllerWithAlertView:shareView preferredStyle:TYAlertControllerStyleAlert];
    
    [alertController setBlurEffectWithView:self.view];
    alertController.alertView.width     = Main_Screen_Width;
    alertController.alertView.height    = Main_Screen_Height*230/667;
    //    if (Main_Screen_Height == 568) {
    alertController.alertViewOriginY    = self.view.height- alertController.alertView.height;
    [self presentViewController:alertController animated:YES completion:nil];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
