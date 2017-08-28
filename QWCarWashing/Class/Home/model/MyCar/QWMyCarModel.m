//
//  QWMyCarModel.m
//  QWCarWashing
//
//  Created by apple on 2017/8/28.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "QWMyCarModel.h"

@implementation QWMyCarModel
//如果不想每一条属性都添加，我们也可以在.m文件中重写方法
+(BOOL)propertyIsOptional:(NSString *)propertyName{
    return  YES;
}
@end
