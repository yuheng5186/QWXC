//
//  QWIntegModel.m
//  QWCarWashing
//
//  Created by apple on 2017/9/1.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "QWIntegModel.h"

@implementation QWIntegModel
//如果不想每一条属性都添加，我们也可以在.m文件中重写方法
+(BOOL)propertyIsOptional:(NSString *)propertyName{
    return  YES;
}
@end
