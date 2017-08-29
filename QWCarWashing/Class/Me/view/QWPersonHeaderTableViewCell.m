//
//  QWPersonHeaderTableViewCell.m
//  QWCarWashing
//
//  Created by apple on 2017/8/14.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "QWPersonHeaderTableViewCell.h"

@interface QWPersonHeaderTableViewCell()
@property(nonatomic,strong)UIView *headerBackView;
@property(nonatomic,strong)UIImageView *headerBtn;
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
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
   
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initView];
       NSNotificationCenter * center = [NSNotificationCenter defaultCenter];
       [center addObserver:self selector:@selector(noticeupdateUserName:)  name:@"updatenamesuccess" object:nil];
       [center addObserver:self selector:@selector(noticeupdateUserheadimg:) name:@"updateheadimgsuccess" object:nil];
    }
    return self;
}

//修改昵称通知
-(void)noticeupdateUserName:(NSNotification *)sender{
 NSString *username= [sender.userInfo objectForKey:@"username"];
   
   NSMutableString *phonestr = [[NSMutableString  alloc] initWithString:[UdStorage getObjectforKey:UserPhone]];
   [phonestr replaceCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
   NSString *usernames=[UdStorage getObjectforKey:UserNamer]==nil?phonestr:[UdStorage getObjectforKey:UserNamer];
   _username.text=usernames;
   
}
-(void)noticeupdateUserheadimg:(NSNotification *)sender{
   NSLog(@"%@",[UdStorage getObjectforKey:UserHead]);
 
      [self.headerBtn sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kHTTPImg,[UdStorage getObjectforKey:UserHead]]] placeholderImage:[UIImage imageNamed:@"gerenxinxitou"]];
}
-(void)initView{
   [self.contentView addSubview:self.headerBackView];
   [self.headerBackView addSubview:self.headerBtn];
   [self.headerBackView addSubview:self.username];
   [self.headerBackView addSubview:self.privilegeButton];
   [self.headerBackView addSubview:self.qiandaoButton];
}
-(UIView *)headerBackView{
   if (!_headerBackView) {
      _headerBackView=[[UIView alloc]initWithFrame:CGRectMake(Main_Screen_Width*10/375, 0, QWScreenWidth-Main_Screen_Width*20/375, Main_Screen_Height*110/667)];
      _headerBackView.backgroundColor=[UIColor whiteColor];
      _headerBackView.layer.cornerRadius=10;
   }
   return _headerBackView;
}
-(UIImageView *)headerBtn{
    if (!_headerBtn) {
        _headerBtn = [[UIImageView alloc]initWithFrame:CGRectMake(Main_Screen_Width*20/375, Main_Screen_Height*15/667, Main_Screen_Width*80/375, Main_Screen_Height*80/667)];
       _headerBtn.layer.cornerRadius= _headerBtn.height/2;
       _headerBtn.layer.masksToBounds = YES;
       _headerBtn.contentMode=UIViewContentModeScaleAspectFill;
       _headerBtn.image=[UIImage imageNamed:@"gerenxinxitou"];
       if ([UdStorage getObjectforKey:UserHead]==nil) {
          _headerBtn.image=[UIImage imageNamed:@"gerenxinxitou"];
       }else{
           [_headerBtn sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kHTTPImg,[UdStorage getObjectforKey:UserHead]]] placeholderImage:[UIImage imageNamed:@"gerenxinxitou"]];
       }
      
//       [_headerBtn sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kHTTPImg,[UdStorage getObjectforKey:UserHead]]] placeholderImage:[UIImage imageNamed:@"gerenxinxitou"]];
//        [_headerBtn setBackgroundImage:[UIImage imageNamed:@"gerenxinxitou"] forState:BtnNormal];
       _headerBtn.userInteractionEnabled=YES;
       UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(userInfoDetail:)];
       [_headerBtn addGestureRecognizer:tap];
       
       
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
        _username = [[UILabel alloc]initWithFrame:CGRectMake(self.headerBtn.frame.origin.x+self.headerBtn.frame.size.width+Main_Screen_Height*15/667, (self.headerBtn.frame.origin.y+self.headerBtn.frame.size.height)/4, Main_Screen_Width*200/375, Main_Screen_Height*30/667)];
       if ([UdStorage getObjectforKey:UserHead]==nil) {
          _username.text=@"用户名";
       }else{
          NSMutableString *phonestr = [[NSMutableString  alloc] initWithString:[UdStorage getObjectforKey:UserPhone]];
          [phonestr replaceCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
          NSString *username=[UdStorage getObjectforKey:UserNamer]==nil?phonestr:[UdStorage getObjectforKey:UserNamer];
          _username.text=username;
       }
       
        
        
        
    }
    return _username;
    
}

-(UIButton *)privilegeButton{
    if (!_privilegeButton) {
        _privilegeButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width*80/375, Main_Screen_Height*25/667)];
        [_privilegeButton setTitleColor:[UIColor whiteColor] forState:BtnNormal];
       _privilegeButton.titleLabel.font=[UIFont boldSystemFontOfSize:14];
        [_privilegeButton setTitle:@"个人信息" forState:BtnNormal];
        _privilegeButton.backgroundColor=[UIColor colorWithHexString:@"#ffce36"];
       _privilegeButton.layer.cornerRadius = _privilegeButton.height/2;
       _privilegeButton.top                = _username.bottom +Main_Screen_Height*5/667;
       _privilegeButton.left               = _username.left;
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
        _qiandaoButton = [[UIButton alloc]initWithFrame:CGRectMake(self.privilegeButton.frame.origin.x+self.privilegeButton.frame.size.width+Main_Screen_Width*10/375, self.privilegeButton.frame.origin.y, Main_Screen_Width*80/375, Main_Screen_Height*25/667)];
        [_qiandaoButton setTitleColor:[UIColor whiteColor] forState:BtnNormal];
       _qiandaoButton.titleLabel.font=[UIFont boldSystemFontOfSize:14];
        [_qiandaoButton setTitle:@"每日签到" forState:BtnNormal];
        _qiandaoButton.backgroundColor=[UIColor colorWithHexString:@"#fe8206"];
        _qiandaoButton.layer.cornerRadius= _qiandaoButton.height/2;
       [_qiandaoButton addTarget:self action:@selector(aiandaoOclick:) forControlEvents:BtnTouchUpInside];
        
        
    }
    return _qiandaoButton;
    
}
-(void)aiandaoOclick:(UIButton *)btn{
   if (self.qiandaoClicked) {
      self.qiandaoClicked();
   }
}
#pragma mark - Setters
-(void)setUsermodel:(QWUserInfo *)usermodel{
   _usermodel = usermodel;
   NSMutableString *phonestr = [[NSMutableString  alloc] initWithString:[UdStorage getObjectforKey:UserPhone]];
   [phonestr replaceCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
   NSString *username=[UdStorage getObjectforKey:UserNamer]==nil?phonestr:[UdStorage getObjectforKey:UserNamer];
   self.username.text = username;
 
    [self.headerBtn sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kHTTPImg,[UdStorage getObjectforKey:UserHead]]] placeholderImage:[UIImage imageNamed:@"gerenxinxitou"]];
}



@end
