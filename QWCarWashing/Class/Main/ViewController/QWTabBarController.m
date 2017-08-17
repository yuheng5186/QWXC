//
//  QWTabBarController.m
//  QWCarWashing
//
//  Created by apple on 2017/8/14.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "QWTabBarController.h"

@interface QWTabBarController ()

@end

@implementation QWTabBarController

//作用：初始化类
+ (void)initialize
{
    NSLog(@"%s",__func__);
    //    UITabBarItem *tabbaritems=[UITabBarItem appearance];
    UITabBarItem *tabbaritems=[UITabBarItem appearanceWhenContainedIn:self, nil];
    //设置tabbartitle的字体颜色
    NSMutableDictionary *textdic=[NSMutableDictionary dictionary];
    //给字典赋值1.
    textdic[NSForegroundColorAttributeName]=[UIColor blackColor];
    textdic[NSFontAttributeName]=[UIFont systemFontOfSize:18 weight:10];
    
    [tabbaritems setTitleTextAttributes:textdic forState:UIControlStateSelected];
    [[UITabBar appearance] setShadowImage:[UIImage new]];
    [[UITabBar appearance] setBackgroundImage:[[UIImage alloc]init]];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    //管理子视图
    [self addsubviewctl];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    for (UIView *views in self.tabBar.subviews)
    {
        if ([views isKindOfClass:NSClassFromString(@"UITabBarButton")])
        {
            //            [views removeFromSuperview];
            
        }
    }
}
#pragma mark-添加子视图控制器
- (void)addsubviewctl
{
    QWHomeViewController *home=[[QWHomeViewController alloc]init];
    
    [self setsubtabbarsyle:home andimg:[UIImage imageNamed:@"zhuye"] andselectimg:[UIImage imageWithRenderingModeorname:@"zhuyec"] andtitle:@"首页" andnavtitle:@"蔷薇爱车"];
    
    
    QWMerchantViewController *Merchant=[[QWMerchantViewController alloc]init];
    [self setsubtabbarsyle:Merchant andimg:[UIImage imageNamed:@"shangjiah"] andselectimg:[UIImage imageWithRenderingModeorname:@"shangjiac"] andtitle:@"商家" andnavtitle:@"商家"];
    
    
    
    QWCarWashViewController *CarWash1=[[QWCarWashViewController alloc]init];
    [self setsubtabbarsyle:CarWash1 andimg:[UIImage imageWithRenderingModeorname:@"saomaxiche"] andselectimg:[UIImage imageWithRenderingModeorname:@"saomaxiche"] andtitle:@"洗车" andnavtitle:@"洗车"];
    
    
    
    QWShoppingCarViewController *ShoppingCar=[[QWShoppingCarViewController alloc]init];
    [self setsubtabbarsyle:ShoppingCar andimg:[UIImage imageNamed:@"goukah"] andselectimg:[UIImage imageWithRenderingModeorname:@"goukac"] andtitle:@"购卡" andnavtitle:@"购卡"];
    
    
    QWMeViewController *me=[[QWMeViewController alloc]init];
    [self setsubtabbarsyle:me andimg:[UIImage imageNamed:@"wodeh"] andselectimg:[UIImage imageWithRenderingModeorname:@"wodec"] andtitle:@"我的" andnavtitle:@"我的"];
    
    
}
#pragma mark-添加子tabbar的样式
- (void)setsubtabbarsyle:(UIViewController *)ctl andimg:(UIImage *)img1 andselectimg:(UIImage *)img2 andtitle:(NSString *)titles andnavtitle:(NSString *)navstr
{
    if ([ctl isKindOfClass:[QWCarWashViewController class]]) {
        ctl.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, -5);
        ctl.tabBarItem.imageInsets = UIEdgeInsetsMake(-20, 0, 20, 0);
        
    }else{
        //    UITabBarItem有两个属性，可以调整title和icon的间距
        ctl.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, -5);
        ctl.tabBarItem.imageInsets = UIEdgeInsetsMake(-2, 0, 2, 0);
        
    }
    ctl.tabBarItem.selectedImage=img2;
    ctl.tabBarItem.image=img1;
    ctl.tabBarItem.title=titles;
    ctl.navigationItem.title=navstr;
    
    
    //添加导航栏
    QWNavigationViewController *qwnav=[[QWNavigationViewController alloc]initWithRootViewController:ctl];
//    qwnav.navigationBar.barStyle=UIBarStyleDefault;
//    [qwnav.navigationBar setBackgroundImage:[UIImage imageNamed:@"ijanbiantiao"] forBarMetrics:UIBarMetricsDefault];
    
//    qwnav.navigationBar.barStyle = UIBaselineAdjustmentNone;
    [qwnav.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:18 weight:10],
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    qwnav.navigationBar.barTintColor =RGBACOLOR(30, 129, 249, 1);
    [self addChildViewController:qwnav];
    
}


@end
