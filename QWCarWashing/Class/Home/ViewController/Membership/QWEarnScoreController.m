//
//  QWEarnScoreController.m
//  QWCarWashing
//
//  Created by Wuxinglin on 2017/8/17.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "QWEarnScoreController.h"
#import "WayToUpGradeCell.h"
#import "QWScoreDetailController.h"
#import "QWMyCarController.h"
#import "QWPersonInfoDetailViewController.h"
#import "QWIntegModel.h"
#import "QWMyCarController.h"
#import "QWMeViewController.h"
@interface QWEarnScoreController ()<UITableViewDelegate, UITableViewDataSource>
{
    MBProgressHUD *HUD;
}
@property (nonatomic, strong) NSMutableArray *ScoreData;
@property (nonatomic, weak) UIImageView *adverView;

@property (nonatomic, weak) UITableView *earnWayView;

@end

static NSString *id_earnViewCell = @"id_earnViewCell";


@implementation QWEarnScoreController
-(NSMutableArray *)ScoreData{
    if (_ScoreData==nil) {
        _ScoreData=[NSMutableArray arrayWithCapacity:0];
    }
    return _ScoreData;

}
- (UIImageView *)adverView {
    
    if (!_adverView) {
        
        UIImageView *adverView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64, Main_Screen_Width, 100)];
        _adverView = adverView;
        [self.view addSubview:adverView];
    }
    return _adverView;
}


- (UITableView *)earnWayView {
    
    if (!_earnWayView) {
        
        UITableView *earnWayView = [[UITableView alloc] initWithFrame:CGRectMake(0, 164, Main_Screen_Width, Main_Screen_Height - 164) style:UITableViewStyleGrouped];
        _earnWayView = earnWayView;
        [self.view addSubview:_earnWayView];
    }
    return _earnWayView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title           = @"赚积分";
    
    self.navigationItem.rightBarButtonItem  = [[UIBarButtonItem alloc]initWithTitle:@"我的积分" style:UIBarButtonItemStyleDone target:self action:@selector(myScoreButtonClick:)];
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:13],NSFontAttributeName, nil] forState:UIControlStateNormal];
    
    self.adverView.image = [UIImage imageNamed:@"guanggao11"];
    
    self.earnWayView.delegate = self;
    self.earnWayView.dataSource = self;
    self.earnWayView.rowHeight = 90;
    [self.earnWayView registerClass:[WayToUpGradeCell class] forCellReuseIdentifier:id_earnViewCell];
    
    HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HUD.removeFromSuperViewOnHide =YES;
    HUD.mode = MBProgressHUDModeIndeterminate;
    HUD.labelText = @"加载中";
    HUD.minSize = CGSizeMake(132.f, 108.0f);
    [self requestGetScore];
}

-(void)requestGetScore
{
    NSDictionary *mulDic = @{
                             @"Account_Id":[UdStorage getObjectforKey:Userid]
                             };
    
    
    [AFNetworkingTool post:mulDic andurl:[NSString stringWithFormat:@"%@Integral/EarnIntegral",Khttp] success:^(NSDictionary *dict, BOOL success) {
        NSLog(@"%@",dict);
        if([[dict objectForKey:@"ResultCode"] isEqualToString:[NSString stringWithFormat:@"%@",@"F000000"]])
        {
            
            NSArray *arr = [NSArray array];
            arr = [dict objectForKey:@"JsonData"];
            if(arr.count == 0)
            {
                [self.view showInfo:@"暂无数据" autoHidden:YES interval:2];
            }
            else
            {
                for (NSDictionary *tempdic in arr) {
                    QWIntegModel *tempModel=[[QWIntegModel alloc]initWithDictionary:tempdic error:nil];
                     [self.ScoreData addObject:tempModel];
                }
               
                [self.earnWayView reloadData];
                [HUD setHidden:YES];
            }
            
        }
        else
        {
            [self.view showInfo:@"数据请求失败" autoHidden:YES interval:2];
            [self.navigationController popViewControllerAnimated:YES];
        }
        
    } fail:^(NSError *error) {
        [self.view showInfo:@"获取失败" autoHidden:YES interval:2];
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.ScoreData.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WayToUpGradeCell *earnScoreCell = [tableView dequeueReusableCellWithIdentifier:id_earnViewCell forIndexPath:indexPath];
    earnScoreCell.goButton.tag=indexPath.row;
    [earnScoreCell.goButton addTarget:self action:@selector(completeButton:) forControlEvents:BtnTouchUpInside];
    if (indexPath.row == 0) {
        earnScoreCell.iconV.image = [UIImage imageNamed:@"qw_xinyonghuzhuce"];
        earnScoreCell.waysLab.text = @"新用户注册";
        earnScoreCell.wayToLab.text = @"完成手机号绑定注册";
        earnScoreCell.valuesLab.text = @"+20积分";
    }else if (indexPath.row == 1) {
        
        earnScoreCell.iconV.image = [UIImage imageNamed:@"qw_yaoqinghaoyou"];
        earnScoreCell.waysLab.text = @"邀请好友";
        earnScoreCell.wayToLab.text = @"邀请好友并完成注册";
        earnScoreCell.valuesLab.text = @"+200积分";
    }else if (indexPath.row == 2) {
        
        earnScoreCell.iconV.image = [UIImage imageNamed:@"qw_wanshancheliangxinxi"];
        earnScoreCell.waysLab.text = @"完善车辆信息";
        earnScoreCell.wayToLab.text = @"完成车辆绑定,填写车辆信息";
        earnScoreCell.valuesLab.text = @"+50积分";
    }else {
        
        earnScoreCell.iconV.image = [UIImage imageNamed:@"qw_wanshangerenxinxi"];
        earnScoreCell.waysLab.text = @"完善隔个人信息";
        earnScoreCell.wayToLab.text = @"填写个人姓名完善个人信息";
        earnScoreCell.valuesLab.text = @"+20积分";
    }
    if (self.ScoreData.count!=0) {
        earnScoreCell.IntegModel=self.ScoreData[indexPath.row];
        if(((QWIntegModel *)self.ScoreData[indexPath.row]).IsComplete == 1)
        {
            
            [earnScoreCell.goButton setTitle:@"已完成" forState:UIControlStateNormal];
            earnScoreCell.goButton.enabled = NO;
            
        }
        else
        {
            earnScoreCell.goButton.tag = indexPath.row;
            [earnScoreCell.goButton addTarget:self action:@selector(gotoearnScore:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
   
    return earnScoreCell;
}
-(void)gotoearnScore:(UIButton *)btn
{
    
    
//    QWIntegModel * integmodel=[QWIntegModel new];
//    integmodel=[self.ScoreData objectAtIndex:btn.tag];
//    if(integmodel.IntegType == 2)
//    {
//        self.tabBarController.selectedIndex = 4;
//    }
//    else if(integmodel.IntegType  == 3)
//    {
//        QWMyCarController *myCarController                  = [[QWMyCarController alloc]init];
//        myCarController.hidesBottomBarWhenPushed            = YES;
//        [self.navigationController pushViewController:myCarController animated:YES];
//    }
//    else if(integmodel.IntegType  == 4)
//    {
//        QWMeViewController *userInfoController    = [[QWMeViewController alloc]init];
//        userInfoController.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:userInfoController animated:YES];
//    }
}
-(void)completeButton:(UIButton *)btn{
    QWMyCarController *mycarVC=[[QWMyCarController alloc]init];
    QWPersonInfoDetailViewController *personinfo=[[QWPersonInfoDetailViewController alloc]init];
    switch (btn.tag) {
        case 2:
            [self.navigationController pushViewController:mycarVC animated:YES];
            break;
        case 3:
            [self.navigationController pushViewController:personinfo animated:YES];
            break;
        case 1:
            
            break;
        default:
            
            break;
    }

}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 10;
}



- (void)myScoreButtonClick:(id)sender {
    
   
    
    QWScoreDetailController *scoreController = [[QWScoreDetailController alloc] init];
    scoreController.hidesBottomBarWhenPushed = YES;
     scoreController.CurrentScore = self.CurrentScore;
    [self.navigationController pushViewController:scoreController animated:YES];
    
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
