//
//  TicketCashView.m
//  CarWashing
//
//  Created by 时建鹏 on 2017/7/31.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "TicketCashView.h"
#import "UIView+AutoSizeToDevice.h"

@implementation TicketCashView


+ (instancetype)ticketCashView {
    
    return [[NSBundle mainBundle] loadNibNamed:@"TicketCashView" owner:nil options:nil].lastObject;
}

- (void)awakeFromNib {
    
    [super awakeFromNib];
    
    self.dg_viewAutoSizeToDevice = YES;
}

@end
