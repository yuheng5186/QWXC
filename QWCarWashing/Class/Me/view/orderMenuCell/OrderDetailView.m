//
//  OrderDetailView.m
//  CarWashing
//
//  Created by 时建鹏 on 2017/8/7.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "OrderDetailView.h"
#import "UIView+AutoSizeToDevice.h"

@implementation OrderDetailView

+ (instancetype)orderDetailView {
    
    return [[NSBundle mainBundle] loadNibNamed:@"OrderDetailView" owner:nil options:nil].lastObject;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    //self.dg_viewAutoSizeToDevice = YES;
    
    
    [self setupUI];
}

- (void)setupUI {
    
   
}

@end
