//
//  QWScoreDetailController.m
//  QWCarWashing
//
//  Created by Wuxinglin on 2017/8/17.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "QWScoreDetailController.h"
#import "HQSliderView.h"
#import "HQTableViewCell.h"
#import "QWMembershipController.h"

@interface QWScoreDetailController ()<UITableViewDelegate, UITableViewDataSource, HQSliderViewDelegate>

@property (nonatomic, weak) UITableView *scoreListView;

@property (nonatomic, weak) HQSliderView *sliderView;

@property (nonatomic, weak) UIView *headView;
@property (nonatomic, weak) UIButton *earnButton;
@property (nonatomic, weak) UIButton *exchangeButton;
@property (nonatomic, weak) UILabel *scoreLabel;

/** 记录点击的是第几个Button */
@property (nonatomic, assign) NSInteger scoreTag;

@end

@implementation QWScoreDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupUI];

}

- (UIView *)headView {
    
    if (!_headView) {
        UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, Main_Screen_Width, 135)];
        headView.backgroundColor = [UIColor whiteColor];
        _headView = headView;
        [self.view addSubview:_headView];
    }
    
    return _headView;
}

- (UILabel *)scoreLabel {
    
    if (!_scoreLabel) {
        
        UILabel *scoreLabel = [[UILabel alloc] init];
        scoreLabel.textColor = [UIColor colorFromHex:@"#febb02"];
        scoreLabel.font = [UIFont systemFontOfSize:24];
        _scoreLabel = scoreLabel;
        [self.headView addSubview:_scoreLabel];
    }
    
    return _scoreLabel;
}


- (UIButton *)earnButton {
    
    if (!_earnButton) {
        
        UIButton *earnButton = [[UIButton alloc] init];
        [earnButton setTitle:@"赚积分" forState:UIControlStateNormal];
        [earnButton setTitleColor:[UIColor colorFromHex:@"#4a4a4a"] forState:UIControlStateNormal];
        earnButton.layer.cornerRadius = 17.5;
        earnButton.layer.borderWidth = 1;
        earnButton.layer.borderColor = [UIColor colorFromHex:@"febb02"].CGColor;
        _earnButton = earnButton;
        [self.headView addSubview:_earnButton];
    }
    
    return _earnButton;
}

- (UIButton *)exchangeButton {
    
    if (!_exchangeButton) {
        
        UIButton *exchangeButton = [[UIButton alloc] init];
        [exchangeButton setTitle:@"积分兑换" forState:UIControlStateNormal];
        [exchangeButton setTitleColor:[UIColor colorFromHex:@"#4a4a4a"] forState:UIControlStateNormal];
        exchangeButton.layer.cornerRadius = 17.5;
        exchangeButton.layer.borderWidth = 1;
        exchangeButton.layer.borderColor = [UIColor colorFromHex:@"febb02"].CGColor;
        _exchangeButton = exchangeButton;
        [self.headView addSubview:_exchangeButton];
    }
    
    return _exchangeButton;
}



- (UITableView *)scoreListView {
    
    if (_scoreListView == nil) {
        UITableView *scoreListView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _scoreListView = scoreListView;
        [self.view addSubview:_scoreListView];
    }
    
    return _scoreListView;
}

- (void)setupUI {
    
    [self setupTopSliderView];
    
    self.scoreListView.delegate = self;
    self.scoreListView.dataSource = self;
    self.scoreListView.rowHeight = 60;
    
    self.scoreLabel.text = @"1680";
    
    [self.earnButton addTarget:self action:@selector(didClickEarnScoreBtn) forControlEvents:UIControlEventTouchUpInside];
    
    [self.exchangeButton addTarget:self action:@selector(didExchangeScoreBtn) forControlEvents:UIControlEventTouchUpInside];
    
    //约束
    [_scoreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_headView).mas_offset(33);
        make.centerX.equalTo(_headView);
    }];
    
    [_earnButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_scoreLabel.mas_bottom).mas_offset(25);
        make.left.equalTo(_headView).mas_offset(28);
        make.width.mas_equalTo(130);
        make.height.mas_equalTo(35);
    }];
    
    [_exchangeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_earnButton);
        make.right.equalTo(_headView).mas_offset(-28);
        make.width.mas_equalTo(130);
        make.height.mas_equalTo(35);
    }];
    
    [_scoreListView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_sliderView.mas_bottom);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(Main_Screen_Height - 135 - 108 - 10);
    }];
    
}


#pragma mark - 创建上部的SliderView
- (void)setupTopSliderView {
    
    HQSliderView *sliderView = [[HQSliderView alloc] initWithFrame:CGRectMake(0, 64 + 130 + 10, Main_Screen_Width, 44)];
    _sliderView = sliderView;
    sliderView.titleArr = @[@"全部",@"收入",@"支出"];
    sliderView.delegate = self;
    [self.view addSubview:sliderView];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (self.scoreTag == 0) {
        return 3;
    }else if (self.scoreTag == 1){
        return 6;
    }else{
        return 5;
    }
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HQTableViewCell *scoreCell = [HQTableViewCell tableViewCellWithTableView:tableView];
    
    if (self.scoreTag == 0) {
        
        scoreCell.textLabel.text = [NSString stringWithFormat:@"全部 --- 第%ld行", indexPath.row];
        scoreCell.detailTextLabel.text = @"2010";
        UILabel *scoreLbl = [[UILabel alloc] init];
        scoreLbl.text = @"+4";
        scoreCell.accessoryView = scoreLbl;
    } else if (self.scoreTag == 1) {
        
        scoreCell.textLabel.text = [NSString stringWithFormat:@"待付款 --- 第%ld行", indexPath.row];
    } else{
        
        scoreCell.textLabel.text = [NSString stringWithFormat:@"待评价 --- 第%ld行", indexPath.row];
    }
    
    
    return scoreCell;
}


#pragma mark - HQlisderView的代理
- (void)sliderView:(HQSliderView *)sliderView didClickMenuButton:(UIButton *)button{
    
    self.scoreTag = button.tag;
    [self.scoreListView reloadData];
}


#pragma mark - 点击赚积分按钮和兑换按钮
- (void)didClickEarnScoreBtn {
    
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)didExchangeScoreBtn {
    
    //DSMembershipController *memberVC = [[DSMembershipController alloc] init];
    
    for (UIViewController *controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[QWMembershipController class]]) {
            QWMembershipController *memberVC =(QWMembershipController *)controller;
            [self.navigationController popToViewController:memberVC animated:YES];
        }
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