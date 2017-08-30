//
//  AppDelegate.m
//  QWCarWashing
//
//  Created by apple on 2017/8/14.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "AppDelegate.h"
#import "QWLoginVC.h"
#import "QWGuideViewController.h"
@interface AppDelegate ()
{
    AppDelegate *myDelegate;
}

//当前屏幕与设计尺寸(iPhone6)宽度比例
@property(nonatomic,assign)CGFloat autoSizeScaleW;
//当前屏幕与设计尺寸(iPhone6)高度比例
@property(nonatomic,assign)CGFloat autoSizeScaleH;
@end
@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
#pragma mark-键盘弹出事件添加
    [IQKeyboardManager sharedManager].enable = YES;
    self.window=[[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor=[UIColor whiteColor];
    [self.window makeKeyAndVisible];
    QWTabBarController *tabbarc=[[QWTabBarController alloc]init];
    tabbarc.tabBar.backgroundColor=[UIColor whiteColor];
    self.window.rootViewController=tabbarc;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    
    
    myDelegate = [[UIApplication sharedApplication] delegate];
    if(QWScreenheight > 568)
    {
        myDelegate.autoSizeScaleX = QWScreenWidth/375;
        myDelegate.autoSizeScaleY = QWScreenheight/667;
    }
    else
    {
        myDelegate.autoSizeScaleX = QWScreenWidth/375;
        myDelegate.autoSizeScaleY = QWScreenheight/667;
    }
#pragma mark-是否已登录
    if (IsNullIsNull([UdStorage getObjectforKey:Userid])) {
//        QWLoginVC *loginControl             = [[QWLoginVC alloc]init];
//        QWNavigationViewController *nav         = [[QWNavigationViewController alloc]initWithRootViewController:loginControl];
//        nav.navigationBar.hidden      = YES;
//        
//        self.window.rootViewController      = nav;
        QWGuideViewController *guideControl = [[QWGuideViewController alloc]init];
        UINavigationController *nav         = [[UINavigationController alloc]initWithRootViewController:guideControl];
        self.window.rootViewController      = nav;
        
    }else{
        QWTabBarController *menuTabBarController              = [[QWTabBarController alloc] init];
        
        menuTabBarController.tabBar.backgroundColor=[UIColor whiteColor];
        self.window.rootViewController      = menuTabBarController;

    }
    
    
    
//    [WXApi registerApp:@"wxcb207ec4f5991a99"];
    [WXApi registerApp:@"wx36260a82ad0e51bb"];


    
    return YES;
    
}
+ (AppDelegate *)sharedInstance {
    return (AppDelegate *)[UIApplication sharedApplication].delegate;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    
    
    return [WXApi handleOpenURL:url delegate:self];
}

- (BOOL) application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    
    
    return [WXApi handleOpenURL:url delegate:self];
}

#pragma mark - ScaleSize
- (void)initAutoScaleSize{
    
    if (QWScreenheight==480) {
        //4s
        _autoSizeScaleW =QWScreenWidth/375;
        _autoSizeScaleH =QWScreenheight/667;
    }else if(QWScreenheight==568) {
        //5
        _autoSizeScaleW =QWScreenWidth/375;
        _autoSizeScaleH =QWScreenheight/667;
    }else if(QWScreenheight==667){
        //6
        _autoSizeScaleW =QWScreenWidth/375;
        _autoSizeScaleH =QWScreenheight/667;
    }else if(QWScreenheight==736){
        //6p
        _autoSizeScaleW =QWScreenWidth/375;
        _autoSizeScaleH =QWScreenheight/667;
    }else{
        _autoSizeScaleW =1;
        _autoSizeScaleH =1;
    }
    
}
- (CGFloat)autoScaleW:(CGFloat)w{
    
    return w * self.autoSizeScaleW;
    
}

- (CGFloat)autoScaleH:(CGFloat)h{
    
    return h * self.autoSizeScaleH;
    
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
