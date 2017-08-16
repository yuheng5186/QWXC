//
//  DSSegmentView.h

//


#import <UIKit/UIKit.h>

typedef void(^CategoryBlock)(NSInteger);

@interface DSSegmentView : UIView

@property (nonatomic, copy) CategoryBlock categoryBlock;
@property (nonatomic, assign) CGFloat offsetX;

@end
