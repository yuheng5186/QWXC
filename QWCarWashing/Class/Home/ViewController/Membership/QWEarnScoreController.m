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

@interface QWEarnScoreController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) UIImageView *adverView;

@property (nonatomic, weak) UITableView *earnWayView;

@end

static NSString *id_earnViewCell = @"id_earnViewCell";


@implementation QWEarnScoreController

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
    self.adverView.image = [UIImage imageNamed:@"mendiantese"];
    
    self.earnWayView.delegate = self;
    self.earnWayView.dataSource = self;
    self.earnWayView.rowHeight = 90;
    [self.earnWayView registerClass:[WayToUpGradeCell class] forCellReuseIdentifier:id_earnViewCell];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 4;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WayToUpGradeCell *earnScoreCell = [tableView dequeueReusableCellWithIdentifier:id_earnViewCell forIndexPath:indexPath];
    
    if (indexPath.row == 0) {
        
        earnScoreCell.iconV.image = [UIImage imageNamed:@"xinyonghuzhuce"];
        earnScoreCell.waysLab.text = @"新用户注册";
        earnScoreCell.wayToLab.text = @"完成手机号绑定注册";
        earnScoreCell.valuesLab.text = @"+20积分";
    }else if (indexPath.row == 1) {
        
        earnScoreCell.iconV.image = [UIImage imageNamed:@"yaoqinghaoyou"];
        earnScoreCell.waysLab.text = @"邀请好友";
        earnScoreCell.wayToLab.text = @"邀请好友并完成注册";
        earnScoreCell.valuesLab.text = @"+200积分";
    }else if (indexPath.row == 2) {
        
        earnScoreCell.iconV.image = [UIImage imageNamed:@"wanshancheliangxinxi"];
        earnScoreCell.waysLab.text = @"完善车辆信息";
        earnScoreCell.wayToLab.text = @"完成车辆绑定,填写车辆信息";
        earnScoreCell.valuesLab.text = @"+50积分";
    }else {
        
        earnScoreCell.iconV.image = [UIImage imageNamed:@"wanshangerenxinxi"];
        earnScoreCell.waysLab.text = @"完善隔个人信息";
        earnScoreCell.wayToLab.text = @"填写个人姓名完善个人信息";
        earnScoreCell.valuesLab.text = @"+20积分";
    }
    
    return earnScoreCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 10;
}



- (void)clickMyScoreButton{
    
    QWScoreDetailController *scoreController = [[QWScoreDetailController alloc] init];
    scoreController.hidesBottomBarWhenPushed = YES;
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
