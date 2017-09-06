//
//  QWNavigationViewController.m
//  QWCarWashing
//
//  Created by apple on 2017/8/14.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "QWNavigationViewController.h"

@interface QWNavigationViewController ()<UINavigationControllerDelegate>

@end

@implementation QWNavigationViewController

+(void)initialize
{
    
    UIBarButtonItem *barbutitem=[UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[self]];
    
    NSMutableDictionary *attrdic=[NSMutableDictionary dictionary];
    attrdic[NSForegroundColorAttributeName]=[UIColor whiteColor];
    attrdic[NSFontAttributeName]=[UIFont systemFontOfSize:18 weight:10];
    [barbutitem setTintColor:[UIColor whiteColor]];
    //设置模型的字体颜色用富文本
    [barbutitem setTitleTextAttributes:attrdic forState:UIControlStateNormal];
    UINavigationBar *bar=[UINavigationBar appearanceWhenContainedInInstancesOfClasses:@[self]];
    [bar setBackgroundImage:[UIImage imageNamed:@"ijanbiantiao"] forBarMetrics:UIBarMetricsDefault];
    [bar setTintColor:[UIColor whiteColor]];
}
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
//    if (self.viewControllers.count != 0)
//    {
//        UIBarButtonItem *barbut=[UIBarButtonItem setUibarbutonimgname:@"icon_titlebar_arrow" andhightimg:@"icon_titlebar_arrow" Target:self action:@selector(backpop) forControlEvents:UIControlEventTouchUpInside];
//        
//        [super pushViewController:viewController animated:animated];
//         self.navigationItem.leftBarButtonItem = barbut;
//    }
    [super pushViewController:viewController animated:animated];
}
-(void)backpop
{
    if (self.navigationController.viewControllers.count>1) {
        [self popViewControllerAnimated:YES];
    }else{
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
}
-(void)backroot
{
    [self popToRootViewControllerAnimated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
}
@end
