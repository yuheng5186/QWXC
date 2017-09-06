//
//  QWAddShopController.m
//  QWCarWashing
//
//  Created by Wuxinglin on 2017/8/16.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "QWAddShopController.h"
#import "QWMerchantInViewController.h"
@interface QWAddShopController ()

@property (strong, nonatomic) UIScrollView *scrollView;

@end

@implementation QWAddShopController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   
    self.title  = @"商家入驻";
    [self createSubView];

}

- (void) createSubView {
    self.scrollView                         = [[UIScrollView alloc] initWithFrame:CGRectMake(self.view.frame.origin.x, 0, self.view.size.width, self.view.size.height)];
    self.scrollView.backgroundColor         = [UIColor whiteColor];
    self.scrollView.contentSize             = CGSizeMake(self.view.size.width, self.view.size.height*1.2);
    [self.scrollView flashScrollIndicators];
    self.scrollView.directionalLockEnabled  = YES;
    [self.view addSubview:self.scrollView];
    
    
    UIImageView *adImageView    = [UIUtil drawCustomImgViewInView:self.scrollView frame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height) imageName:@"shangjiaruzhutu"];
//    adImageView.contentMode=UIViewContentModeScaleAspectFill;
    adImageView.centerX         = Main_Screen_Width/2;
    adImageView.top             = Main_Screen_Height*0/667;
    
    
    NSString *string                = @"马上入住，立即赚钱";
    UIFont  *stringFont             = [UIFont systemFontOfSize:16];
    UIButton    *getMoneyButton     = [UIUtil drawButtonInView:self.scrollView frame:CGRectMake(0, 0, Main_Screen_Width -Main_Screen_Width*60/375, Main_Screen_Height*40/667) text:string font:stringFont color:[UIColor whiteColor] target:self action:@selector(getShopMoneyButtonClick:)];
    getMoneyButton.backgroundColor  = [UIColor colorWithHex:0xFFB500 alpha:1.0];
    getMoneyButton.layer.cornerRadius   = 5;
    getMoneyButton.bottom           = adImageView.bottom -Main_Screen_Height*15/667;
    getMoneyButton.centerX          = self.view.centerX;
    
    self.scrollView.contentSize             = CGSizeMake(self.view.size.width, self.view.size.height +getMoneyButton.height*1.2);
    
}
- (void) getShopMoneyButtonClick:(id)sender {
    QWMerchantInViewController *addMerchantController      = [[QWMerchantInViewController alloc]init];
    addMerchantController.hidesBottomBarWhenPushed      = YES;
    [self.navigationController pushViewController:addMerchantController animated:YES];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
