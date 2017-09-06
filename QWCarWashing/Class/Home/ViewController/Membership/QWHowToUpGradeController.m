//
//  QWHowToUpGradeController.m
//  QWCarWashing
//
//  Created by Wuxinglin on 2017/8/17.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "QWHowToUpGradeController.h"
#import "HYSlider.h"
#import "WayToUpGradeCell.h"
#import "QWEarnScoreController.h"
#import "QWUpdateRuleController.h"
#import "QWMyCarController.h"
#import "QWPersonInfoDetailViewController.h"
@interface QWHowToUpGradeController ()<UITableViewDelegate, UITableViewDataSource,HYSliderDelegate>
{
    MBProgressHUD *HUD;
}
@property (nonatomic, weak) UITableView *wayToEarnScoreView;
@property (nonatomic, strong) NSMutableArray *ScoreData;

@end

static NSString *id_wayToUpCell = @"id_wayToUpCell";


@implementation QWHowToUpGradeController

- (UITableView *)wayToEarnScoreView {
    
    if (!_wayToEarnScoreView) {
        
        UITableView *wayToEarnScoreView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _wayToEarnScoreView = wayToEarnScoreView;
        [self.view addSubview:_wayToEarnScoreView];
    }
    
    return _wayToEarnScoreView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title      = @"升等级";
    [self setupUI];

    self.navigationItem.rightBarButtonItem  = [[UIBarButtonItem alloc]initWithTitle:@"等级规则" style:UIBarButtonItemStyleDone target:self action:@selector(updateButtonClick:)];
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:13],NSFontAttributeName, nil] forState:UIControlStateNormal];
    
}
- (void) updateButtonClick:(id)sender {
    
    QWUpdateRuleController      *updateController   = [[QWUpdateRuleController alloc]init];
    updateController.hidesBottomBarWhenPushed       = YES;
    [self.navigationController pushViewController:updateController animated:YES];

}
- (void)setupUI {
    
    UIView *headContainView = [[UIView alloc] init];
    headContainView.backgroundColor = [UIColor colorFromHex:@"#ffffff"];
    [self.view addSubview:headContainView];
    
    UILabel *gradeLab = [[UILabel alloc] init];
    gradeLab.text = self.currentLevel;
    gradeLab.textColor = [UIColor blackColor];
    gradeLab.font = [UIFont systemFontOfSize:15*Main_Screen_Height/667];
    [self.view addSubview:gradeLab];

    HYSlider *slider = [[HYSlider alloc]initWithFrame:CGRectMake(35, gradeLab.frame.origin.y+gradeLab.frame.size.height+5, QWScreenWidth-46, 9)];
    slider.backgroundColor=RGBACOLOR(230, 230, 230, 1);

    slider.currentValueColor = [UIColor colorFromHex:@"#febb02"];
    slider.maxValue = [self.NextLevelScore integerValue];
    slider.currentSliderValue = [self.CurrentScore integerValue];
    slider.showTextColor = [UIColor colorFromHex:@"#febb02"];
    slider.showTouchView = YES;
    slider.showScrollTextView = YES;
    slider.touchViewColor = [UIColor colorFromHex:@"#febb02"];
    slider.delegate = self;
    [self.view addSubview:slider];
    
    UILabel *maxLab = [[UILabel alloc] init];
    
    maxLab.textColor = [UIColor grayColor];
    maxLab.textAlignment=NSTextAlignmentRight;
    maxLab.font = [UIFont systemFontOfSize:12];
    maxLab.text =self.NextLevelScore;
    [self.view addSubview:maxLab];
    
    

    
    
    UIButton *displayBtn = [[UIButton alloc] init];
    displayBtn.userInteractionEnabled = NO;
    NSString *string = [NSString stringWithFormat:@"%ld积分升级为%@",(long)(([self.NextLevelScore integerValue]- [self.CurrentScore integerValue])),self.nextLevel];
    [displayBtn setTitle:string forState:UIControlStateNormal];
    [displayBtn setTitleColor:[UIColor colorFromHex:@"#999999"] forState:UIControlStateNormal];
    displayBtn.titleLabel.font = [UIFont systemFontOfSize:Main_Screen_Height*14/667];
    [displayBtn setImage:[UIImage imageNamed:@"qw_shengji"] forState:UIControlStateNormal];
    displayBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    [displayBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
    [headContainView addSubview:displayBtn];
    
    //底部
    UIView *containView = [[UIView alloc] init];
    containView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:containView];
    
    UIButton *getMoreBtn = [[UIButton alloc] init];
    [getMoreBtn setTitle:@"如何获得更多积分" forState:UIControlStateNormal];
    [getMoreBtn setTitleColor:[UIColor colorFromHex:@"#4a4a4a"] forState:UIControlStateNormal];
    getMoreBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [getMoreBtn setImage:[UIImage imageNamed:@"qw_huodegengduojifen"] forState:UIControlStateNormal];
    [getMoreBtn addTarget:self action:@selector(didClickGetMoreBtn) forControlEvents:UIControlEventTouchUpInside];
    [containView addSubview:getMoreBtn];
    
    
    
    
    //约束
    [headContainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).mas_offset(64);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(130*Main_Screen_Height/667);
    }];
    
    [gradeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headContainView).mas_offset(Main_Screen_Height*20/667);
        make.centerX.equalTo(headContainView);
    }];
    
    [slider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(gradeLab.mas_bottom).mas_offset(Main_Screen_Height*30/667);
        make.left.equalTo(headContainView).mas_offset(23);
        make.right.equalTo(headContainView).mas_offset(-23);
        make.width.mas_equalTo(QWScreenWidth-46);
        make.height.mas_equalTo(Main_Screen_Height*9/667);
    }];
    [maxLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(slider.mas_bottom).mas_offset(Main_Screen_Height*5/667);
//        make.left.equalTo(headContainView).mas_offset(23);
        make.right.equalTo(slider);
        make.width.mas_equalTo(46);
        make.height.mas_equalTo(Main_Screen_Height*15/667);
    }];
    
    [displayBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(maxLab.mas_bottom).mas_offset(5*Main_Screen_Height/667);
        make.centerX.equalTo(headContainView);
        make.width.mas_equalTo(250);
//        make.bottom.equalTo(headContainView).mas_offset(Main_Screen_Height*10/667);
    }];
    
    [containView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(self.view);
        make.height.mas_equalTo(49*Main_Screen_Height/667);
    }];
    
    [getMoreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(containView);
        make.height.mas_equalTo(40*Main_Screen_Height/667);
        make.width.mas_equalTo(250*Main_Screen_Width/375);
    }];
    
    getMoreBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    [getMoreBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
    
    
    
    self.wayToEarnScoreView.delegate = self;
    self.wayToEarnScoreView.dataSource = self;
    self.wayToEarnScoreView.rowHeight = 90;
    
    [_wayToEarnScoreView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headContainView.mas_bottom);
        make.right.left.equalTo(headContainView);
        make.height.mas_equalTo(Main_Screen_Height - 64 - 130 - 49);
    }];
    
    [self.wayToEarnScoreView registerClass:[WayToUpGradeCell class] forCellReuseIdentifier:id_wayToUpCell];
    
    self.ScoreData = [[NSMutableArray alloc]init];
    
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
                             @"Account_Id":[UdStorage getObjectforKey:@"Account_Id"]
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
                    QWIntegModel *integModel=[[QWIntegModel alloc]initWithDictionary:tempdic error:nil];
                    [self.ScoreData addObject:integModel];
                }
                
                
                [self.wayToEarnScoreView reloadData];
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
    
    return [self.ScoreData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WayToUpGradeCell *wayCell = [tableView dequeueReusableCellWithIdentifier:id_wayToUpCell forIndexPath:indexPath];
    wayCell.selectionStyle=UITableViewCellSelectionStyleNone;
    if (indexPath.row == 0) {
        
        wayCell.iconV.image = [UIImage imageNamed:@"qw_xinyonghuzhuce"];
        wayCell.waysLab.text = @"新用户注册";
        wayCell.wayToLab.text = @"完成手机号绑定注册";
        wayCell.valuesLab.text = @"+20积分";
    }else if (indexPath.row == 1) {
        
        wayCell.iconV.image = [UIImage imageNamed:@"qw_yaoqinghaoyou"];
        wayCell.waysLab.text = @"邀请好友";
        wayCell.wayToLab.text = @"邀请好友并完成注册";
        wayCell.valuesLab.text = @"+200积分";
    }else if (indexPath.row == 2) {
        
        wayCell.iconV.image = [UIImage imageNamed:@"qw_wanshancheliangxinxi"];
        wayCell.waysLab.text = @"完善车辆信息";
        wayCell.wayToLab.text = @"完成车辆绑定,填写车辆信息";
        wayCell.valuesLab.text = @"+50积分";
    }else {
        
        wayCell.iconV.image = [UIImage imageNamed:@"qw_wanshangerenxinxi"];
        wayCell.waysLab.text = @"完善隔个人信息";
        wayCell.wayToLab.text = @"填写个人姓名完善个人信息";
        wayCell.valuesLab.text = @"+20积分";
    }
    if (self.ScoreData.count!=0) {
        wayCell.IntegModel=self.ScoreData[indexPath.row];
        if(((QWIntegModel *)self.ScoreData[indexPath.row]).IsComplete == 1)
        {
            
            [wayCell.goButton setTitle:@"已完成" forState:UIControlStateNormal];
            wayCell.goButton.enabled = NO;
            
        }
        else
        {
            wayCell.goButton.tag = indexPath.row;
            [wayCell.goButton addTarget:self action:@selector(gotoearnScore:) forControlEvents:UIControlEventTouchUpInside];
        }
    }

    
    
    
    return wayCell;
}
-(void)gotoearnScore:(UIButton *)btn
{
    
    QWIntegModel * integmodel=[QWIntegModel new];
    integmodel=[self.ScoreData objectAtIndex:btn.tag];
    if(integmodel.IntegType == 2)
    {
        self.tabBarController.selectedIndex = 4;
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    else if(integmodel.IntegType  == 3)
    {
        QWMyCarController *myCarController                  = [[QWMyCarController alloc]init];
        myCarController.hidesBottomBarWhenPushed            = YES;
        [self.navigationController pushViewController:myCarController animated:YES];
    }
    else if(integmodel.IntegType  == 4)
    {
        
        QWPersonInfoDetailViewController *userInfoController    = [[QWPersonInfoDetailViewController alloc]init];
        userInfoController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:userInfoController animated:YES];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 10;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    QWMyCarController *mycarVC=[[QWMyCarController alloc]init];
//    QWPersonInfoDetailViewController *personinfo=[[QWPersonInfoDetailViewController alloc]init];
//    switch (indexPath.row) {
//        case 2:
//            [self.navigationController pushViewController:mycarVC animated:YES];
//            break;
//        case 3:
//            [self.navigationController pushViewController:personinfo animated:YES];
//            break;
//        case 1:
//            
//            break;
//        default:
//            
//            break;
//    }

}


#pragma mark - 点击底部按钮
- (void)didClickGetMoreBtn {
    
    QWEarnScoreController *earnScoreVC = [[QWEarnScoreController alloc] init];
    earnScoreVC.hidesBottomBarWhenPushed = YES;

    
    
    earnScoreVC.CurrentScore = self.CurrentScore;
    

    [self.navigationController pushViewController:earnScoreVC animated:YES];
}
- (void)HYSlider:(HYSlider *)hySlider didScrollValue:(CGFloat)value
{

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
