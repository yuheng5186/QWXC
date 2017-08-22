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

@property (nonatomic, weak) UITableView *wayToEarnScoreView;


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
    gradeLab.text = @"白银会员";
    gradeLab.textColor = [UIColor blackColor];
    gradeLab.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:gradeLab];

    HYSlider *slider = [[HYSlider alloc]initWithFrame:CGRectMake(35, gradeLab.frame.origin.y+gradeLab.frame.size.height+5, QWScreenWidth-46, 9)];
    slider.backgroundColor=RGBACOLOR(230, 230, 230, 1);

    slider.currentValueColor = [UIColor orangeColor];
    slider.maxValue = 1000;
    slider.currentSliderValue = 600;
    slider.showTextColor = [UIColor orangeColor];
    slider.showTouchView = YES;
    slider.showScrollTextView = YES;
    slider.touchViewColor = [UIColor orangeColor];
    slider.delegate = self;
    [self.view addSubview:slider];
    UILabel *maxLab = [[UILabel alloc] init];
   
    maxLab.textColor = RGBACOLOR(230, 230, 230, 1);
    maxLab.textAlignment=NSTextAlignmentRight;
    maxLab.font = [UIFont systemFontOfSize:10];
    maxLab.text =[NSString stringWithFormat:@"%d",1000];
    [self.view addSubview:maxLab];
    
    
    UIButton *displayBtn = [[UIButton alloc] init];
    displayBtn.userInteractionEnabled = NO;
    [displayBtn setTitle:@"再获得400积分升级为黄金会员" forState:UIControlStateNormal];
    [displayBtn setTitleColor:[UIColor colorFromHex:@"#999999"] forState:UIControlStateNormal];
    displayBtn.titleLabel.font = [UIFont systemFontOfSize:12];
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
        make.height.mas_equalTo(130);
    }];
    
    [gradeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headContainView).mas_offset(9);
        make.centerX.equalTo(headContainView);
    }];
    
    [slider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(gradeLab.mas_bottom).mas_offset(35);
        make.left.equalTo(headContainView).mas_offset(23);
        make.right.equalTo(headContainView).mas_offset(-23);
        make.width.mas_equalTo(QWScreenWidth-46);
        make.height.mas_equalTo(9);
    }];
    [maxLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(slider.mas_bottom).mas_offset(5);
//        make.left.equalTo(headContainView).mas_offset(23);
        make.right.equalTo(slider);
        make.width.mas_equalTo(46);
        make.height.mas_equalTo(9);
    }];
    
    [displayBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(maxLab.mas_bottom).mas_offset(15);
        make.centerX.equalTo(headContainView);
        make.width.mas_equalTo(250);
    }];
    
    [containView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(self.view);
        make.height.mas_equalTo(49);
    }];
    
    [getMoreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(containView);
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(250);
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
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WayToUpGradeCell *wayCell = [tableView dequeueReusableCellWithIdentifier:id_wayToUpCell forIndexPath:indexPath];
    wayCell.selectionStyle=UITableViewCellSelectionStyleNone;
    wayCell.goButton.tag=indexPath.row;
    [wayCell.goButton addTarget:self action:@selector(completeButton:) forControlEvents:BtnTouchUpInside];
    
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
    
    
    
    
    return wayCell;
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
    
    [self.navigationController pushViewController:earnScoreVC animated:YES];
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
