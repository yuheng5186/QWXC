//
//  QWExchangeViewController.m
//  QWCarWashing
//
//  Created by apple on 2017/8/15.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "QWExchangeViewController.h"
#import "QWCardBagModel.h"
@interface QWExchangeViewController ()
{
    UITextField *exchangeTF;
  
        MBProgressHUD *HUD;
 
}
@property (nonatomic, strong) NSMutableArray *CardbagData;
@end

@implementation QWExchangeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"激活";

    [self resetBabkButton];
    
    [self setupUI];
    HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HUD.removeFromSuperViewOnHide =YES;
    HUD.mode = MBProgressHUDModeIndeterminate;
    HUD.labelText = @"加载中";
    HUD.minSize = CGSizeMake(132.f, 108.0f);
    
    _CardbagData = [[NSMutableArray alloc]init];
    [self GetCardbagList];
    
}
-(void)GetCardbagList
{
    NSDictionary *mulDic = @{
                             @"Account_Id":[UdStorage getObjectforKey:@"Account_Id"]
                             };
   
    [AFNetworkingTool post:mulDic andurl:[NSString stringWithFormat:@"%@Card/GetCardInfoList",Khttp] success:^(NSDictionary *dict, BOOL success) {
        
        if([[dict objectForKey:@"ResultCode"] isEqualToString:[NSString stringWithFormat:@"%@",@"F000000"]])
        {
            NSArray *arr = [NSArray array];
            arr = [dict objectForKey:@"JsonData"];
            for(NSDictionary *dic in arr)
            {
                QWCardBagModel *model = [[QWCardBagModel alloc]initWithDictionary:dic error:nil];;
                    [_CardbagData addObject:model];
            }
//            [self.t reloadData];
            [HUD setHidden:YES];
        }
        else
        {
            [self.view showInfo:@"信息获取失败" autoHidden:YES interval:2];
            [self.navigationController popViewControllerAnimated:YES];
        }
    } fail:^(NSError *error) {
        [self.view showInfo:@"获取失败" autoHidden:YES interval:2];
        [self.navigationController popViewControllerAnimated:YES];
        
    }];
    
}
- (void) resetBabkButton {
    UIButton *rightButton = [[UIButton alloc]initWithFrame:CGRectMake(0,0,20,20)];
    [rightButton setImage:[UIImage imageNamed:@"icon_titlebar_arrow"] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(backButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    self.navigationItem.leftBarButtonItem= rightItem;
}
- (void) backButtonClick:(id)sender {

    [self.navigationController popViewControllerAnimated:YES];
}

-(void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden=YES;
}

- (void)setupUI {
    self.view.backgroundColor=[UIColor colorWithHexString:@"#eaeaea"];
    exchangeTF = [[UITextField alloc] init];
    exchangeTF.placeholder = @"请输入激活码";
    exchangeTF.textAlignment = NSTextAlignmentCenter;
    exchangeTF.layer.cornerRadius = 24*Main_Screen_Height/667;
    exchangeTF.keyboardType = UIKeyboardTypeNumberPad;
    exchangeTF.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:exchangeTF];
    
    UIButton *exchangeBtn = [UIUtil drawDefaultButton:self.view title:@"激活" target:self action:@selector(didClickExchangeScoreBtn:)];
    [exchangeBtn setBackgroundColor:RGBACOLOR(252, 186, 44, 1) ];
    
    [exchangeTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).mas_offset(64 + 25*Main_Screen_Height/667);
        make.centerX.equalTo(self.view);
        make.width.mas_equalTo(Main_Screen_Width*351/375);
        make.height.mas_equalTo(48*Main_Screen_Height/667);
    }];
    
    [exchangeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(exchangeTF.mas_bottom).mas_offset(60*Main_Screen_Height/667);
        make.centerX.equalTo(self.view);
        make.width.mas_equalTo(Main_Screen_Width*351/375);
        make.height.mas_equalTo(48*Main_Screen_Height/667);
    }];
    
}

- (void)didClickExchangeScoreBtn:(UIButton *)button {
    
    if(exchangeTF.text.length == 0)
    {
        [self.view showInfo:@"请输入激活码" autoHidden:YES interval:2];
    }
    else
    {
        NSDictionary *mulDic = @{
                                 @"Account_Id":[UdStorage getObjectforKey:Userid],
                                 @"ActivationCode":exchangeTF.text
                                 };
               [AFNetworkingTool post:mulDic andurl:[NSString stringWithFormat:@"%@Card/ActivationCard",Khttp] success:^(NSDictionary *dict, BOOL success) {
                   NSLog(@"%@",dict);
            if([[dict objectForKey:@"ResultCode"] isEqualToString:[NSString stringWithFormat:@"%@",@"F000000"]])
            {
                if([[[dict objectForKey:@"JsonData"] objectForKey:@"Activationstate"] integerValue] == 3)
                {
                    [self.view showInfo:@"对不起，该卡不存在" autoHidden:YES interval:2];
                }
                else if([[[dict objectForKey:@"JsonData"] objectForKey:@"Activationstate"] integerValue] == 1)
                {
                    [self.view showInfo:@"激活成功" autoHidden:YES interval:2];
                    _CardbagData = [[NSMutableArray alloc]init];
                    [self GetCardbagList];
                }
                else if([[[dict objectForKey:@"JsonData"]objectForKey:@"Activationstate"] integerValue] == 2)
                {
                    if([[[dict objectForKey:@"JsonData"] objectForKey:@"CardUseState"] integerValue] == 1)
                    {
                        [self.view showInfo:@"对不起，该卡已被激活" autoHidden:YES interval:2];
                    }
                    else if([[[dict objectForKey:@"JsonData"] objectForKey:@"CardUseState"] integerValue] == 2)
                    {
                        [self.view showInfo:@"对不起，该卡已被使用" autoHidden:YES interval:2];
                    }
                    else{
                        [self.view showInfo:@"对不起，该卡已失效" autoHidden:YES interval:2];
                    }
                    
                    
                }
                else
                {
                    [self.view showInfo:@"激活失败" autoHidden:YES interval:2];
                }
                
                
                
            }
            else
            {
                [self.view showInfo:@"激活失败" autoHidden:YES interval:2];
            }
        } fail:^(NSError *error) {
            [self.view showInfo:@"激活失败" autoHidden:YES interval:2];
            
        }];
        
    }

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self.view endEditing:YES];
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
