//
//  UIView+XLFrame.m
//  xinlang
//
//  Created by pro on 16/1/7.
//  Copyright (c) 2016年 pro. All rights reserved.
//

#import "UIView+XLFrame.h"

@implementation UIView (XLFrame)
- (void)setX:(CGFloat)x
{
    CGRect frame=self.frame;
    frame.origin.x=x;
   
    self.frame=frame;
}
- (void)setY:(CGFloat)y
{
    CGRect frame=self.frame;
    frame.origin.y=y;
    
    self.frame=frame;

}
- (void)setHeight:(CGFloat)height
{
    CGRect frame=self.frame;
    frame.size.height=height;
    
    self.frame=frame;
}
- (void)setWidth:(CGFloat)width
{
    CGRect frame=self.frame;
    frame.size.width=width;
    
    self.frame=frame;
}

-(CGFloat)x
{
    return self.frame.origin.x;
}
- (CGFloat)y
{

    return self.frame.origin.y;
}
-(CGFloat)height
{
  return   self.frame.size.height;
}
-(CGFloat)width
{
    return   self.frame.size.width;
}

@end
