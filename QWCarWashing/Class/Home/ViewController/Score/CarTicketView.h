//
//  CarTicketView.h
//  CarWashing
//
//  Created by 时建鹏 on 2017/8/2.
//  Copyright © 2017年 DS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CarTicketView : UIView
@property (weak, nonatomic) IBOutlet UILabel *CardNames;
@property (weak, nonatomic) IBOutlet UILabel *ScoreLabels;

+ (instancetype)carTicketView;

@end
