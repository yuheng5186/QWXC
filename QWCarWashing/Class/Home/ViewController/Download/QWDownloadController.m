//
//  QWDownloadController.m
//  QWCarWashing
//
//  Created by Wuxinglin on 2017/8/16.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "QWDownloadController.h"

@interface QWDownloadController ()<UIAlertViewDelegate>

{
    enum WXScene scene;
    
}
@property (nonatomic, strong) HYActivityView *activityView;
@property (nonatomic, strong) UIImageView *bigImageView;

@end

@implementation QWDownloadController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title  = @"下载金顶洗车";

    self.view.backgroundColor   = [UIColor whiteColor];

    [self resetBabkButton];

    [self setSubView];
}

- (void) resetBabkButton {
    
    UIButton *rightButton = [[UIButton alloc]initWithFrame:CGRectMake(0,0,20,20)];
    [rightButton setImage:[UIImage imageNamed:@"icon_titlebar_arrow"] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(backButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    self.navigationItem.leftBarButtonItem= rightItem;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"fenxiang-1"] scaledToSize:CGSizeMake(20, 20)] style:(UIBarButtonItemStyleDone) target:self action:@selector(shareButtonclick:)];
    
}

- (void) shareButtonclick:(id)sender {

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

- (void) backButtonClick:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}


- (void) setSubView {
    
    UIView *titleView                  = [UIUtil drawLineInView:self.view frame:CGRectMake(0, 0, Main_Screen_Width*300/375, Main_Screen_Height*375/667) color:[UIColor whiteColor]];
    titleView.top                      = Main_Screen_Height*64/375;
    titleView.centerX                  = Main_Screen_Width/2;
    
    UIImageView *logoImageView  = [UIUtil drawCustomImgViewInView:titleView frame:CGRectMake(0, 0, Main_Screen_Width*60/375, Main_Screen_Height*60/667) imageName:@"denglu_icon"];
    logoImageView.top           = Main_Screen_Height*23/667;
    logoImageView.centerX       = titleView.size.width/2;
    
    NSString   *titleString     = @"金顶洗车";
    
    UIFont     *titleFont       = [UIFont boldSystemFontOfSize:15];
    UILabel *titleLabel         = [UIUtil drawLabelInView:titleView frame:CGRectMake(0, 0, Main_Screen_Width*150/375, Main_Screen_Height*30/667) font:titleFont text:titleString isCenter:NO];
    titleLabel.text             = titleString;
    titleLabel.textColor        = [UIColor colorFromHex:@"#4a4a4a"];
    titleLabel.textAlignment    = NSTextAlignmentCenter;
    titleLabel.centerX          = logoImageView.centerX;
    titleLabel.top              = logoImageView.bottom +Main_Screen_Height*12/667;
    
    self.bigImageView   = [UIUtil drawCustomImgViewInView:titleView frame:CGRectMake(0, 0, Main_Screen_Width*160/375, Main_Screen_Height*160/667) imageName:@"WechatIMG54"];
    self.bigImageView.top            = titleLabel.bottom +Main_Screen_Height*28/667;
    self.bigImageView.centerX        = titleView.size.width/2;
    self.bigImageView.userInteractionEnabled    = YES;
    
    UILongPressGestureRecognizer  *tapNewGesture    = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(tapbigImageViewGesture:)];
    tapNewGesture.minimumPressDuration              = 1.0;
    [self.bigImageView addGestureRecognizer:tapNewGesture];
    
    NSString *showString              = @"长按识别二维码";
    UIFont *showStringFont            = [UIFont systemFontOfSize:14];
    UILabel *showLabel          = [UIUtil drawLabelInView:titleView frame:[UIUtil textRect:showString font:showStringFont] font:showStringFont text:showString isCenter:NO];
    showLabel.textColor         = [UIColor colorFromHex:@"#4a4a4a"];
    showLabel.top               = self.bigImageView.bottom +Main_Screen_Height*32/667;
    showLabel.centerX           = self.bigImageView.centerX;
    
}
- (void) tapbigImageViewGesture:(UILongPressGestureRecognizer *)gesture {
    
    if ([gesture state] == UIGestureRecognizerStateBegan) {
        
        CIDetector *detector = [CIDetector detectorOfType:CIDetectorTypeQRCode context:nil options:nil];
        
        //设置数组，放置识别完之后的数据
        NSArray *features = [detector featuresInImage:[CIImage imageWithData:UIImagePNGRepresentation(self.bigImageView.image)]];
        //判断是否有数据（即是否是二维码）
        if (features.count >= 1) {
            //取第一个元素就是二维码所存放的文本信息
            CIQRCodeFeature *feature = features[0];
            NSString *scannedResult = feature.messageString;
            //通过对话框的形式呈现
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"扫描结果"
                                                            message:scannedResult
                                                           delegate:self
                                                  cancelButtonTitle:nil
                                                  otherButtonTitles:@"确定", nil];
            [self.view addSubview:alert];
            [alert show];
        }else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"扫描结果"
                                                            message:@"不是二维码图片"
                                                           delegate:self
                                                  cancelButtonTitle:nil
                                                  otherButtonTitles:@"确定", nil];
            [self.view addSubview:alert];
            [alert show];
        }
    }
    
    
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
