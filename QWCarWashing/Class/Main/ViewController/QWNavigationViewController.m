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
    
    UIBarButtonItem *barbutitem=[UIBarButtonItem appearanceWhenContainedIn:self, nil];
    NSMutableDictionary *attrdic=[NSMutableDictionary dictionary];
    attrdic[NSForegroundColorAttributeName]=[UIColor whiteColor];
    attrdic[NSFontAttributeName]=[UIFont systemFontOfSize:18 weight:10];
    [barbutitem setTintColor:[UIColor whiteColor]];
    //设置模型的字体颜色用富文本
    [barbutitem setTitleTextAttributes:attrdic forState:UIControlStateNormal];
    UINavigationBar *bar=[UINavigationBar appearanceWhenContainedIn:self, nil];
    [bar setTintColor:[UIColor whiteColor]];
}
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count != 0)
    {
        UIBarButtonItem *barbut=[UIBarButtonItem setUibarbutonimgname:@"backselected" andhightimg:@"backselected" Target:self action:@selector(backpop) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *barbutright=[UIBarButtonItem setUibarbutonimgname:@"navigationbar_more" andhightimg:@"navigationbar_more_highlighted" Target:self action:@selector(backroot) forControlEvents:UIControlEventTouchUpInside];
    }
    [super pushViewController:viewController animated:animated];
}
-(void)backpop
{
    [self popViewControllerAnimated:YES];
}
-(void)backroot
{
    [self popToRootViewControllerAnimated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
}
@end
