//
//  QWWashCarTicketController.m
//  QWCarWashing
//
//  Created by Wuxinglin on 2017/8/18.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "QWWashCarTicketController.h"
#import "CarTicketView.h"

@interface QWWashCarTicketController ()

@end

@implementation QWWashCarTicketController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title      = @"体验卡";
    UIView *upView                  = [UIUtil drawLineInView:self.view frame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height*328/667) color:[UIColor colorFromHex:@"#fafafa"]];
    upView.top                      = 64;
    CarTicketView *ticketView = [CarTicketView carTicketView];
    //    ticketView.frame = CGRectMake(37.5*Main_Screen_Height/667, 64 + 25*Main_Screen_Height/667, Main_Screen_Width - 75*Main_Screen_Height/667, 192*Main_Screen_Height/667);
    ticketView.backgroundColor = self.view.backgroundColor;
    
    ticketView.CardNames.text = self.card.CardName;
    ticketView.ScoreLabels.text = [NSString stringWithFormat:@"%ld积分",self.card.Integralnum];
    
    [upView addSubview:ticketView];
    
    UIButton *exchangeButton = [UIUtil drawDefaultButton:upView title:[NSString stringWithFormat:@"%ld积分兑换",self.card.Integralnum] target:self action:@selector(didClickExhangeButton:)];
    
    [ticketView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(upView).mas_offset(25*Main_Screen_Height/667);
        make.left.equalTo(upView).mas_offset(22.5*Main_Screen_Height/667);
        make.right.equalTo(upView).mas_offset(-22.5*Main_Screen_Height/667);
        make.height.mas_equalTo(192*Main_Screen_Height/667);
    }];
    
    [exchangeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ticketView.mas_bottom).mas_offset(50*Main_Screen_Height/667);
        make.centerX.equalTo(upView);
        make.height.mas_equalTo(48*Main_Screen_Height/667);
        make.width.mas_equalTo(350*Main_Screen_Height/667);
    }];
    
    UIView *downView                = [UIUtil drawLineInView:upView frame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height*270/667) color:[UIColor whiteColor]];
    downView.top                    = upView.bottom-64;
    //
    UILabel *noticeLabel = [[UILabel alloc] init];
    noticeLabel.text = @"使用须知";
    noticeLabel.textColor = [UIColor colorFromHex:@"#4a4a4a"];
    noticeLabel.font = [UIFont systemFontOfSize:16*Main_Screen_Height/667];
    [downView addSubview:noticeLabel];
    
    
    UILabel *noticeLabel1 = [[UILabel alloc] init];
    noticeLabel1.text = @"1、此卡仅限清洗汽车外观，不得购买其它服务项目";
    noticeLabel1.textColor = [UIColor colorFromHex:@"#999999"];
    noticeLabel1.font = [UIFont systemFontOfSize:14*Main_Screen_Height/667];
    noticeLabel1.numberOfLines = 0;
    [downView addSubview:noticeLabel1];
    
    
    UILabel *noticeLabel2 = [[UILabel alloc] init];
    noticeLabel2.text = @"2、洗车卡不能兑换现金和转赠与其他人使用";
    noticeLabel2.textColor = [UIColor colorFromHex:@"#999999"];
    noticeLabel2.font = [UIFont systemFontOfSize:14*Main_Screen_Height/667];
    noticeLabel2.numberOfLines = 0;
    [downView addSubview:noticeLabel2];
    
    
    UILabel *noticeLabel3 = [[UILabel alloc] init];
    noticeLabel3.text = @"3、此卡一经售出，概不兑现。不记名，不挂失，不退卡，不补办";
    noticeLabel3.textColor = [UIColor colorFromHex:@"#999999"];
    noticeLabel3.font = [UIFont systemFontOfSize:14*Main_Screen_Height/667];
    noticeLabel3.numberOfLines = 0;
    [downView addSubview:noticeLabel3];
    
    
    UILabel *noticeLabel4 = [[UILabel alloc] init];
    noticeLabel4.text = @"4、此卡可在金顶服务点享受会员优惠待遇，不得与其它优惠同时使用";
    noticeLabel4.textColor = [UIColor colorFromHex:@"#999999"];
    noticeLabel4.font = [UIFont systemFontOfSize:14*Main_Screen_Height/667];
    noticeLabel4.numberOfLines = 0;
    [downView addSubview:noticeLabel4];
    
    
    UILabel *noticeLabel5 = [[UILabel alloc] init];
    noticeLabel5.text = @"5、由青岛金顶汽车服务有限公司保留此卡法律范围内的最终解释权。VIP热线：4006979558";
    noticeLabel5.textColor = [UIColor colorFromHex:@"#999999"];
    noticeLabel5.font = [UIFont systemFontOfSize:14*Main_Screen_Height/667];
    noticeLabel5.numberOfLines = 0;
    [downView addSubview:noticeLabel5];
    
    [noticeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(downView).mas_offset(10*Main_Screen_Height/667);
    }];
    
    [noticeLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(noticeLabel);
        make.top.equalTo(noticeLabel.mas_bottom).mas_offset(10*Main_Screen_Height/667);
        make.right.equalTo(downView).mas_offset(-10*Main_Screen_Height/667);
    }];
    
    [noticeLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(noticeLabel);
        make.top.equalTo(noticeLabel1.mas_bottom).mas_offset(10*Main_Screen_Height/667);
        make.right.equalTo(downView).mas_offset(-10*Main_Screen_Height/667);
    }];
    
    [noticeLabel3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(noticeLabel);
        make.top.equalTo(noticeLabel2.mas_bottom).mas_offset(10*Main_Screen_Height/667);
        make.right.equalTo(downView).mas_offset(-10*Main_Screen_Height/667);
    }];
    
    [noticeLabel4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(noticeLabel);
        make.top.equalTo(noticeLabel3.mas_bottom).mas_offset(10*Main_Screen_Height/667);
        make.right.equalTo(downView).mas_offset(-10*Main_Screen_Height/667);
    }];
    
    [noticeLabel5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(noticeLabel);
        make.top.equalTo(noticeLabel4.mas_bottom).mas_offset(10*Main_Screen_Height/667);
        make.right.equalTo(downView).mas_offset(-10*Main_Screen_Height/667);
    }];
}
- (void)didClickExhangeButton:(UIButton *)button {
    [self requestDetail];
}
#pragma mark-卡片详情
-(void)requestDetail{
    if(self.card.Integralnum > [self.CurrentScore integerValue])
    {
        [self.view showInfo:@"积分不足" autoHidden:YES interval:2];
    }
    else
    {
         NSString *scordstr= [NSString stringWithFormat:@"-%ld积分",self.card.Integralnum];
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"是否确认兑换" message:scordstr preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alertController addAction:cancelAction];
        
        UIAlertAction *OKAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd"];
        NSDate *datenow = [NSDate date];
        NSDate *newDate = [datenow dateByAddingTimeInterval:60 * 60 * 24 * self.card.ExpiredDay];
        
        
        NSDictionary *mulDic = @{
                                 @"Account_Id":[UdStorage getObjectforKey:@"Account_Id"],
                                 @"ConfigCode":[NSString stringWithFormat:@"%ld",self.card.ConfigCode],
                                 @"UseLevel":@1,
                                 @"GetCardType":[NSString stringWithFormat:@"%ld",self.card.GetCardType],
                                 @"Area":self.card.Area,
                                 @"CardCount":[NSString stringWithFormat:@"%ld",self.card.CardCount],
                                 @"CardName":self.card.CardName,
                                 @"CardPrice":[NSString stringWithFormat:@"%@",self.card.CardPrice],
                                 @"CardType":[NSString stringWithFormat:@"%ld",self.card.CardType],
                                 @"Description":self.card.Description,
                                 @"ExpStartDates":[NSString stringWithFormat:@"%@",[formatter stringFromDate:datenow]],
                                 @"ExpEndDates":[NSString stringWithFormat:@"%@",[formatter stringFromDate:newDate]],
                                 @"Integralnum": [NSString stringWithFormat:@"%ld",self.card.Integralnum],
                                 };
        
        
        NSLog(@"%@",mulDic);
        
       
        [AFNetworkingTool post:mulDic andurl:[NSString stringWithFormat:@"%@Card/ReceiveCardInfo",Khttp] success:^(NSDictionary *dict, BOOL success) {
            
            if([[dict objectForKey:@"ResultCode"] isEqualToString:[NSString stringWithFormat:@"%@",@"F000000"]])
            {
                NSInteger score=[[UdStorage getObjectforKey:UserScores] integerValue]-self.card.Integralnum;
                [UdStorage storageObject:[NSString stringWithFormat:@"%ld",score] forKey:UserScores];
                [self.view showInfo:@"兑换成功" autoHidden:YES interval:2];
                NSNotification * notice = [NSNotification notificationWithName:@"updatecard" object:nil userInfo:nil];
                [[NSNotificationCenter defaultCenter]postNotification:notice];
                
            }
            else
            {
                [self.view showInfo:@"兑换失败" autoHidden:YES interval:2];
            }
        } fail:^(NSError *error) {
            [self.view showInfo:@"兑换失败" autoHidden:YES interval:2];
            
        }];
        }];
        [alertController addAction:OKAction];
        [self presentViewController:alertController animated:YES completion:nil];

        
    }


}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
