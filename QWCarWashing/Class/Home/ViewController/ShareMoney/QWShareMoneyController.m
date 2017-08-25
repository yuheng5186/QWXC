//
//  QWShareMoneyController.m
//  QWCarWashing
//
//  Created by Wuxinglin on 2017/8/16.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "QWShareMoneyController.h"

#import "TYAlertController.h"
//#import "ShareView.h"
//#import "UIView+TYAlertView.h"
//#import "TYAlertController+BlurEffects.h"
#import "ShareWeChatController.h"

@interface QWShareMoneyController ()

{
    enum WXScene scene;
    
}
@property (nonatomic, strong) HYActivityView *activityView;


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
//    getMoneyButton.backgroundColor  = [UIColor colorWithHex:0xFFB500 alpha:1.0];
    [getMoneyButton setBackgroundImage:[UIImage imageNamed:@"denglujianbiantiao"] forState:BtnNormal];
    getMoneyButton.layer.cornerRadius   = 5;
    getMoneyButton.bottom          = Main_Screen_Height -Main_Screen_Height*77/667;
    getMoneyButton.centerX      = self.view.centerX;
}

- (void) getMoneyButtonClick:(id)sender {

//    ShareWeChatController *shareVC = [[ShareWeChatController alloc] init];
//    
//    shareVC.modalPresentationStyle = UIModalPresentationOverCurrentContext;
//    [self presentViewController:shareVC animated:NO completion:nil];
    
    if (!self.activityView) {
        self.activityView = [[HYActivityView alloc]initWithTitle:@"" referView:self.view];
        
        //横屏会变成一行6个, 竖屏无法一行同时显示6个, 会自动使用默认一行4个的设置.
        self.activityView.numberOfButtonPerLine = 6;
        
        ButtonView *bv ;
        
        bv = [[ButtonView alloc]initWithText:@"微信" image:[UIImage imageNamed:@"btn_share_weixin"] handler:^(ButtonView *buttonView){
            NSLog(@"点击微信");
            SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
            req.text                = @"简单文本分享测试";
            req.bText               = YES;
            // 目标场景
            // 发送到聊天界面  WXSceneSession
            // 发送到朋友圈    WXSceneTimeline
            // 发送到微信收藏  WXSceneFavorite
            req.scene               = WXSceneSession;
            [WXApi sendReq:req];
            
        }];
        [self.activityView addButtonView:bv];
        
        bv = [[ButtonView alloc]initWithText:@"微信朋友圈" image:[UIImage imageNamed:@"btn_share_pengyouquan"] handler:^(ButtonView *buttonView){
            NSLog(@"点击微信朋友圈");
            SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
            req.text                = @"简单文本分享测试";
            req.bText               = YES;
            // 目标场景
            // 发送到聊天界面  WXSceneSession
            // 发送到朋友圈    WXSceneTimeline
            // 发送到微信收藏  WXSceneFavorite
            req.scene               = WXSceneTimeline;
            [WXApi sendReq:req];
            
        }];
        [self.activityView addButtonView:bv];
        
    }
    
    [self.activityView show];
    
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
