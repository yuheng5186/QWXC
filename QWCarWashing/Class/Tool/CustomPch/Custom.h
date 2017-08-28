//
//  Custom.h
//  QWCarWashing
//
//  Created by apple on 2017/8/26.
//  Copyright © 2017年 apple. All rights reserved.
//

#ifndef Custom_h
#define Custom_h


#endif /* Custom_h */

//页面布局
#define QWScreenWidth [UIScreen mainScreen].bounds.size.width
#define QWScreenheight [UIScreen mainScreen].bounds.size.height
#define CGRectOrigin(v)    v.frame.origin
#define CGRectSize(v)      v.frame.size
#define CGRectX(v)         CGRectOrigin(v).x
#define CGRectY(v)         CGRectOrigin(v).y
#define CGRectW(v)         CGRectSize(v).width
#define CGRectH(v)         CGRectSize(v).height
#define CGRectXW(v)         (CGRectSize(v).width+CGRectOrigin(v).x)
#define CGRectYH(v)         (CGRectSize(v).height+CGRectOrigin(v).y)

//空值判断
#define IsNullIsNull(__String) (__String==nil || [__String isEqualToString:@""]|| [__String isEqualToString:@"null"])
#define IsNull(__Text) [__Text isKindOfClass:[NSNull class]]

#define IsEquallString(_Str1,_Str2)  [_Str1 isEqualToString:_Str2]

//颜色和图片
#define MImage(image)  [UIImage imageNamed:(image)]
#define OMImage(image)  [[UIImage imageNamed:(image)]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]//使用原生图片
