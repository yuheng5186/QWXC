//
//  UIImage+XLimg.h
//  xinlang
//
//  Created by pro on 16/1/6.
//  Copyright (c) 2016年 pro. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (XLimg)
//instancetype默认会识别当前是哪类或者对象调用，就会转换成对应的类的对象
+ (instancetype)imageWithRenderingModeorname:(NSString *)imgName;
+ (instancetype)imageWithStretchablename:(NSString *)imgname;
@end
