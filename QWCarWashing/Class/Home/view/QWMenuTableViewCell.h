//
//  QWMenuTableViewCell.h
//  QWCarWashing
//
//  Created by apple on 2017/8/14.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#define QWCellIdentifier_MenuTableViewCell @"QWMenuTableViewCell"

@interface QWMenuTableViewCell : UITableViewCell
@property (nonatomic, strong) NSString *selectTitle;

@property (nonatomic,copy) void(^selecOptionIndexs)(NSInteger index);

- (void) setContentAndImgArr :(NSArray *)arrImage andContentArr :(NSArray *)contentArr;

+ (CGFloat)cellHeight:(NSInteger )contentIndex;

@end
