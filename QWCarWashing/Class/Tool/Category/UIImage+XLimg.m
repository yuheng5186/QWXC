//
//  UIImage+XLimg.m
//  xinlang
//
//  Created by pro on 16/1/6.
//  Copyright (c) 2016年 pro. All rights reserved.
//

#import "UIImage+XLimg.h"

@implementation UIImage (XLimg)
+ (instancetype)imageWithRenderingModeorname:(NSString *)imgName
{
    UIImage *imgs=[UIImage imageNamed:imgName];
    return [imgs imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}
//延伸; 伸展; 可伸缩的
//左拉伸图像
+ (instancetype)imageWithStretchablename:(NSString *)imgname
{
    UIImage *imgs=[UIImage imageNamed:imgname];
    return [imgs stretchableImageWithLeftCapWidth:imgs.size.width*0.5 topCapHeight:imgs.size.height*0.5];
}
@end
