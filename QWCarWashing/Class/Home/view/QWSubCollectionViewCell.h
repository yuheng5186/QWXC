//
//  QWSubCollectionViewCell.h
//  QWCarWashing
//
//  Created by apple on 2017/8/14.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QWSubCollectionViewCell : UICollectionViewCell
-(void)setImages:(NSString *)myImages andName:(NSString *)names;
-(void)setSmailImages:(NSString *)myImages andName:(NSString *)names;

+(CGSize)ccellSize;
@end
