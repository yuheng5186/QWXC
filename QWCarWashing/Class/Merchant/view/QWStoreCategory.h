//
//  QWStoreCategory.h
//  QWCarWashing
//
//  Created by apple on 2017/8/15.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CategoryBlock)(NSInteger);

@interface QWStoreCategory : UIView

@property (nonatomic, copy) CategoryBlock categoryBlock;

@property (nonatomic, assign) CGFloat offsetX;

@end
