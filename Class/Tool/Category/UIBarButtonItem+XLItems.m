//
//  UIBarButtonItem+XLItems.m
//  xinlang
//
//  Created by pro on 16/1/8.
//  Copyright (c) 2016年 pro. All rights reserved.
//

#import "UIBarButtonItem+XLItems.h"

@implementation UIBarButtonItem (XLItems)
+ (UIBarButtonItem *)setnavUibarbutonimgname:(NSString *)nomimg andhightimg:(NSString *)Himg Target:(id)targets action:(SEL)actions forControlEvents:(UIControlEvents)controlEventss
{
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
        btn.bounds=CGRectMake(0, 0, 100, 100);
    //    btn.backgroundColor=[UIColor redColor];
    //    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //    btn.backgroundColor=[UIColor whiteColor];
    
    [btn sizeToFit];
//        UIEdgeInsets imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
//        btn.imageEdgeInsets = imageEdgeInsets;
    btn.imageView.contentMode=UIViewContentModeScaleAspectFit;
    [btn setImage:[UIImage imageNamed:nomimg] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:Himg] forState:UIControlStateHighlighted];
    //    btn setTitle:@“” forState: btn [setTitle: forState:UIControlStateNormal];
    [btn addTarget:targets action:actions forControlEvents:controlEventss];
    
    return [[UIBarButtonItem alloc]initWithCustomView:btn];
    
}
+ (UIBarButtonItem *)setUibarbutonimgname:(NSString *)nomimg andhightimg:(NSString *)Himg Target:(id)targets action:(SEL)actions forControlEvents:(UIControlEvents)controlEventss
{
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
//    btn.bounds=CGRectMake(0, 0, 10, 10);
//    btn.backgroundColor=[UIColor redColor];
//    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    btn.backgroundColor=[UIColor whiteColor];
   
    [btn sizeToFit];
//    UIEdgeInsets imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
//    btn.imageEdgeInsets = imageEdgeInsets;
    btn.imageView.contentMode=UIViewContentModeScaleAspectFit;
    [btn setImage:[UIImage imageNamed:nomimg] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:Himg] forState:UIControlStateHighlighted];
//    btn setTitle:@“” forState: btn [setTitle: forState:UIControlStateNormal];
    [btn addTarget:targets action:actions forControlEvents:controlEventss];
    
    return [[UIBarButtonItem alloc]initWithCustomView:btn];
    
}
+ (UIBarButtonItem *)setUibarbutonimgname:(NSString *)nomimg andhightimg:(NSString *)Himg Target:(id)targets action:(SEL)actions forControlEvents:(UIControlEvents)controlEventss andtitlestr:(NSString *)str{

    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
//     btn.backgroundColor=[UIColor redColor];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setTitle:str forState:UIControlStateNormal];
    [btn sizeToFit];
//    [btn setBackgroundImage:[UIImage imageNamed:nomimg] forState:UIControlStateNormal];
//    [btn setBackgroundImage:[UIImage imageNamed:Himg] forState:UIControlStateHighlighted];
    //    btn setTitle:@“” forState: btn [setTitle: forState:UIControlStateNormal];
    [btn addTarget:targets action:actions forControlEvents:controlEventss];
    
    return [[UIBarButtonItem alloc]initWithCustomView:btn];

}
@end
