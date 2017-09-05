//
//  MenuIconCell.m
//  Juxin
//

#import "MenuIconCell.h"

@interface MenuIconCell ()
@property (strong, nonatomic) UIImageView *iconView;
@property (strong, nonatomic) UILabel *titleL, *valueLabel;
@property (strong, nonatomic) UIImageView *vertifyOKImage;
@end
@implementation MenuIconCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        if (!_iconView) {
            _iconView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 7, 24, 24)];
            _iconView.layer.cornerRadius =5;
            _iconView.layer.masksToBounds = YES;
            [self.contentView addSubview:_iconView];
        }
        if (!_titleL) {
            _titleL = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_iconView.frame) + 15, 12, QWScreenWidth/2, 20)];
            _titleL.textAlignment = NSTextAlignmentLeft;
            _titleL.font = [UIFont systemFontOfSize:16];
            _titleL.textColor = kMenuNormalColor;
            
            [self.contentView addSubview:_titleL];
        }
        if (!_valueLabel) {
            _valueLabel = [[UILabel alloc] initWithFrame:CGRectMake(120, 7, QWScreenWidth-(110+15) - 30, 30)];
            _valueLabel.backgroundColor = [UIColor clearColor];
            _valueLabel.font = [UIFont systemFontOfSize:15];
            _valueLabel.textColor = [UIColor colorWithHexString:@"#ffd55e"];
            _valueLabel.textAlignment = NSTextAlignmentRight;
            
            [self.contentView addSubview:_valueLabel];
        }
    }
    return self;
}

- (void)setTitle:(NSString *)title icon:(NSString *)iconName detailtitle:(NSString *)detailtitle{
    _titleL.text = title;
    _iconView.image = [UIImage imageNamed:iconName];
    _valueLabel.text=detailtitle;
    
}


- (void)setTitle:(NSString *)title icon:(NSString *)iconName detailtitle:(NSString *)detailtitle badge:(NSString*)badge
{
    _titleL.text = title;
    _iconView.image = [UIImage imageNamed:iconName];
    _valueLabel.text=detailtitle;
}

- (void)setvalue:(NSString *)value{
    _valueLabel.text = value;
}
- (UIImageView *)vertifyOKImage{
    if (!_vertifyOKImage) {
        _vertifyOKImage = [[UIImageView alloc]initWithFrame:CGRectMake(QWScreenWidth - 30-15 *2, 12, 20, 20)];
        [self.contentView addSubview:_vertifyOKImage];
    }
    return _vertifyOKImage;
}
- (void)setImage:(NSString *)imageName {
    self.vertifyOKImage.image = [UIImage imageNamed:imageName];
}


- (void) setTitleColor :(UIColor *)color{
    _titleL.textColor=color;
}


+ (CGFloat)cellHeight{
    return 50;
}
@end
