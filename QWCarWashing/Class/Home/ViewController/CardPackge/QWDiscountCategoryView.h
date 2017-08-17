//
//  QWDiscountCategoryView.h
//  QWCarWashing
//
//  Created by Wuxinglin on 2017/8/16.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CategoryBlock)(NSInteger);

@interface QWDiscountCategoryView : UIView

@property (nonatomic, copy) CategoryBlock categoryBlock;

@property (nonatomic, assign) CGFloat offsetX;

@end
