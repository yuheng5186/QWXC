//
//  MenuIconCell.h
//  Juxin
//

#define kCellIdentifier_MenuIconCell @"MenuIconCell"
#import <UIKit/UIKit.h>

@interface MenuIconCell : UITableViewCell
- (void)setTitle:(NSString *)title icon:(NSString *)iconName detailtitle:(NSString *)detailtitle;

- (void)setImage:(NSString *)imageName;

- (void)setvalue:(NSString *)value;

//WW
- (void)setTitle:(NSString *)title icon:(NSString *)iconName detailtitle:(NSString *)detailtitle badge:(NSString*)badge;
- (void) setTitleColor :(UIColor *)color;

+ (CGFloat)cellHeight;

@end
