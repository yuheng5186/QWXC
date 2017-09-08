//
//  QWGuideViewController.m
//  QWCarWashing
//
//  Created by Mac WuXinLing on 2017/8/24.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "QWGuideViewController.h"
#import "AppDelegate.h"
#import "EAIntroView.h"
#import "QWTabBarController.h"
#import "QWLoginVC.h"
@interface QWGuideViewController ()<EAIntroDelegate>

{
    UIButton *_experienceBtn;
    UIButton *_NoExperienceBtn;
    
}

@end

@implementation QWGuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBarHidden = YES;
    [self showIntroWithCrossDissolve];
    
}

- (void)showIntroWithCrossDissolve {
    EAIntroPage *page1       = [EAIntroPage page];
    page1.customView         = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"introducePage_1"]];
    page1.customView.frame   = self.view.bounds;
    
    
    EAIntroPage *page2       = [EAIntroPage page];
    page2.customView         = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"introducePage_2"]];
    page2.customView.frame   = self.view.bounds;
    
    EAIntroPage *page3       = [EAIntroPage page];
    page3.customView         = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"introducePage_3"]];
    page3.customView.frame   = self.view.bounds;
    
    EAIntroPage *page4       = [EAIntroPage page];
    page4.customView         = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"introducePage_4"]];
    page4.customView.frame   = self.view.bounds;
    
    EAIntroView *intro          = [[EAIntroView alloc] initWithFrame:self.view.bounds andPages:@[page1,page2,page3,page4]];
    intro.skipButton.hidden     = YES;
    intro.swipeToExit           = NO;
    intro.pageControlY          = 750;
    //    intro.pageControl.pageIndicatorTintColor = [UIColor colorFromHex:@"#4D4D4D"];
    //    intro.pageControl.currentPageIndicatorTintColor = [UIColor colorFromHex:@"#FFB700"];
    _experienceBtn              = [UIUtil drawDefaultButton:page4.pageView title:@"马上去洗车" target:self action:@selector(experienceButtonClick:)];
    _experienceBtn.bottom       = self.view.bottom-Main_Screen_Height*73/667;
    _experienceBtn.width        = Main_Screen_Width*200/375;
    _experienceBtn.centerX      = Main_Screen_Width/2;
    _experienceBtn.layer.cornerRadius   = _experienceBtn.height/2;
    //    _experienceBtn.hidden       = YES;
    
    
    _NoExperienceBtn              = [UIUtil drawDefaultButton:intro title:@"跳过" target:self action:@selector(experienceButtonClick:)];
    _NoExperienceBtn.titleLabel.font    = [UIFont systemFontOfSize:13];
    _NoExperienceBtn.top          = Main_Screen_Height*30/375;
    _NoExperienceBtn.width        = Main_Screen_Width*60/375;
    _NoExperienceBtn.height       = Main_Screen_Height*20/375;
    
    _NoExperienceBtn.right        = Main_Screen_Width -Main_Screen_Width*12/375;
    _NoExperienceBtn.layer.cornerRadius   = _NoExperienceBtn.height/2;
    
    
    [intro setDelegate:self];
    [intro showInView:self.view animateDuration:0.3];
    
}


- (void)intro:(EAIntroView *)introView pageAppeared:(EAIntroPage *)page withIndex:(NSUInteger)pageIndex{
    if (pageIndex == introView.pages.count-1) {
        //        _experienceBtn.hidden = NO;
        
    }else{
        //        _experienceBtn.hidden = YES;
    }
}

- (void) skipButtonClick:(id)sender {
    
    
}
- (void) experienceButtonClick:(id)sender {
    //    NSString *key = (NSString *)kCFBundleVersionKey;
    //    NSString *currentAppVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"];
    //    [[NSUserDefaults standardUserDefaults]setValue:currentAppVersion forKey:kBDFirstLanchKey];
    //    [[NSUserDefaults standardUserDefaults]synchronize];
    
    
    QWLoginVC *loginControl = [[QWLoginVC alloc]init];
    UINavigationController *nav         = [[UINavigationController alloc]initWithRootViewController:loginControl];
    nav.navigationBar.hidden      = YES;
    
    self.view.window.rootViewController      = nav;
    //    MenuTabBarController *menuTabBarController	= [[MenuTabBarController alloc] init];
    //    [AppDelegate sharedInstance].window.rootViewController =menuTabBarController;
    
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