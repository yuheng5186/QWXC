 //
//  QWMcServiceTableViewCell.h
//  QWCarWashing
//
//  Created by apple on 2017/8/15.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QWMerchantModel.h"
@protocol CellDelegate <NSObject>
- (void)ButtonDidSelected:(NSIndexPath *)selectedIndexPath;
@end

@interface QWMcServiceTableViewCell : UITableViewCell



@property(nonatomic,weak)UILabel *Mcservicename;
@property(nonatomic,weak)UILabel *Mcserviceintro;

@property(nonatomic,weak)UILabel *Mccurrentprice;
@property(nonatomic,weak)UILabel *Mcprice;

@property(nonatomic,weak)UIButton *selectbtn;

@property (assign, nonatomic) NSIndexPath *selectedIndexPath;


//-(void)setlayoutCell;


@property(nonatomic,assign) id<CellDelegate> delegate;
@property(nonatomic,strong)QWMerSerListModel *MerSerList;
@end
