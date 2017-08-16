//
//  QWPersonHeaderTableViewCell.m
//  QWCarWashing
//
//  Created by apple on 2017/8/14.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "QWPersonHeaderTableViewCell.h"

@interface QWPersonHeaderTableViewCell()
@property(nonatomic,strong)UIButton *headerBtn;
@property(nonatomic,strong)UILabel *username;
@property(nonatomic,strong)UIButton *privilegeButton;
@property(nonatomic,strong)UIButton *qiandaoButton;
@end
@implementation QWPersonHeaderTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
   
//     [self initView];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        [self initView];
    }
    return self;
}

-(void)initView{
    [self addSubview:self.headerBtn];
    [self addSubview:self.username];
    [self addSubview:self.privilegeButton];
    [self addSubview:self.qiandaoButton];
}
-(UIButton *)headerBtn{
    if (!_headerBtn) {
        _headerBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, 10, 80, 80)];
        [_headerBtn setBackgroundImage:[UIImage imageNamed:@"gerenxinxitou"] forState:BtnNormal];
        _headerBtn.layer.cornerRadius = 10;
       [_headerBtn addTarget:self action:@selector(userInfoDetail:) forControlEvents:BtnTouchUpInside];
       
    }
    return _headerBtn;

}
-(void)userInfoDetail:(UIButton *)btn{
   if (self.ImageClicked) {
      self.ImageClicked();
   }
   
   

}
-(UILabel *)username{
    if (!_username) {
        _username = [[UILabel alloc]initWithFrame:CGRectMake(self.headerBtn.frame.origin.x+self.headerBtn.frame.size.width+15, (self.headerBtn.frame.origin.y+self.headerBtn.frame.size.height)/3, 100, 30)];
        _username.text=@"用户名";
        
        
        
    }
    return _username;
    
}
-(UIButton *)privilegeButton{
    if (!_privilegeButton) {
        _privilegeButton = [[UIButton alloc]initWithFrame:CGRectMake(self.username.frame.origin.x, self.username.frame.origin.y+self.username.frame.size.height+18, 60, 15)];
        [_privilegeButton setTitleColor:[UIColor whiteColor] forState:BtnNormal];
       _privilegeButton.titleLabel.font=[UIFont systemFontOfSize:10];
        [_privilegeButton setTitle:@"会员特权" forState:BtnNormal];
        _privilegeButton.backgroundColor=[UIColor colorWithHexString:@"#ffce36"];
       _privilegeButton.layer.cornerRadius=7.5;
       [_privilegeButton addTarget:self action:@selector(privilegeOclick:) forControlEvents:BtnTouchUpInside];
        
        
        
    }
    return _privilegeButton;
    
}
-(void)privilegeOclick:(UIButton *)btn{
   if (self.vipClicked) {
      self.vipClicked();
   }

}
-(UIButton *)qiandaoButton{
    if (!_qiandaoButton) {
        _qiandaoButton = [[UIButton alloc]initWithFrame:CGRectMake(self.privilegeButton.frame.origin.x+self.privilegeButton.frame.size.width+10, self.privilegeButton.frame.origin.y, 60, 15)];
        [_qiandaoButton setTitleColor:[UIColor whiteColor] forState:BtnNormal];
       _qiandaoButton.titleLabel.font=[UIFont systemFontOfSize:10];
        [_qiandaoButton setTitle:@"每日签到" forState:BtnNormal];
        _qiandaoButton.backgroundColor=[UIColor colorWithHexString:@"#fe8206"];
        _qiandaoButton.layer.cornerRadius=7.5;
       [_privilegeButton addTarget:self action:@selector(aiandaoOclick:) forControlEvents:BtnTouchUpInside];
        
        
    }
    return _qiandaoButton;
    
}
-(void)aiandaoOclick:(UIButton *)btn{
   if (self.qiandaoClicked) {
      self.qiandaoClicked();
   }
}
@end
