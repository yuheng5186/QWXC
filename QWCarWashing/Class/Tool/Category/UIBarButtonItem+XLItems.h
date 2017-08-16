//
//  UIBarButtonItem+XLItems.h
//  xinlang
//
//  Created by pro on 16/1/8.
//  Copyright (c) 2016年 pro. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (XLItems)
+ (UIBarButtonItem *)setUibarbutonimgname:(NSString *)nomimg andhightimg:(NSString *)Himg Target:(id)targets action:(SEL)actions forControlEvents:(UIControlEvents)controlEventss;
+ (UIBarButtonItem *)setUibarbutonimgname:(NSString *)nomimg andhightimg:(NSString *)Himg Target:(id)targets action:(SEL)actions forControlEvents:(UIControlEvents)controlEventss andtitlestr:(NSString *)str;
+ (UIBarButtonItem *)setnavUibarbutonimgname:(NSString *)nomimg andhightimg:(NSString *)Himg Target:(id)targets action:(SEL)actions forControlEvents:(UIControlEvents)controlEventss;
@end
