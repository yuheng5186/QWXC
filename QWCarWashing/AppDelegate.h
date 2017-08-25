//
//  AppDelegate.h
//  QWCarWashing
//
//  Created by apple on 2017/8/14.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QWUserInfo.h"
#import "WXApi.h"


@interface AppDelegate : UIResponder <UIApplicationDelegate,WXApiDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) QWUserInfo *currentUser;
@property float autoSizeScaleX;
@property float autoSizeScaleY;
- (CGFloat)autoScaleW:(CGFloat)w;

- (CGFloat)autoScaleH:(CGFloat)h;
- (void)initAutoScaleSize;
+ (AppDelegate *)sharedInstance;
@end

