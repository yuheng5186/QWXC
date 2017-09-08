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
#import "QWScoreController.h"
#import "QWIntegModel.h"
#import "QWEarnScoreController.h"
@interface QWScoreDetailController ()<UITableViewDelegate, UITableViewDataSource, HQSliderViewDelegate>

@property (nonatomic, weak) UITableView *scoreListView;

@property (nonatomic, weak) HQSliderView *sliderView;

@property (nonatomic, weak) UIView *headView;
@property (nonatomic, weak) UIButton *earnButton;
@property (nonatomic, weak) UIButton *exchangeButton;
@property (nonatomic, weak) UILabel *scoreLabel;

/** 记录点击的是第几个Button */
@property (nonatomic, assign) NSInteger scoreTag;

@property (nonatomic)NSInteger page;

@property (nonatomic, strong) NSMutableArray *ScoreData;
@property (nonatomic, strong) NSMutableArray *otherarray;

@end

@implementation QWScoreDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title      = @"我的积分";
    self.view.backgroundColor       = [UIColor colorFromHex:@"#fafafa"];
    self.ScoreData = [[NSMutableArray alloc]init];
    self.page = 0;
    [self setupUI];

}

- (UIView *)headView {
    
    if (!_headView) {
        UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, Main_Screen_Width, Main_Screen_Height*175/667)];
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
        scoreLabel.font = [UIFont systemFontOfSize:38*Main_Screen_Height/667];
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
        earnButton.layer.cornerRadius = 20*Main_Screen_Height/667;
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
        exchangeButton.layer.cornerRadius = 20*Main_Screen_Height/667;
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
        scoreListView.backgroundColor   = [UIColor clearColor];
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
    self.scoreListView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    
    [self setupRefresh];
    self.scoreLabel.text =@"0";

    
    if (!IsNullIsNull(self.CurrentScore)) {
        self.scoreLabel.text = self.CurrentScore;

    }
    
    [self.earnButton addTarget:self action:@selector(didClickEarnScoreBtn) forControlEvents:UIControlEventTouchUpInside];
    
    [self.exchangeButton addTarget:self action:@selector(didExchangeScoreBtn) forControlEvents:UIControlEventTouchUpInside];
    
    //约束
    [_scoreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_headView).mas_offset(33*Main_Screen_Height/667);
        make.centerX.equalTo(_headView);
    }];
    
    [_earnButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_scoreLabel.mas_bottom).mas_offset(25*Main_Screen_Height/667);
        make.left.equalTo(_headView).mas_offset(28*Main_Screen_Height/667);
        make.width.mas_equalTo(130*Main_Screen_Height/667);
        make.height.mas_equalTo(40*Main_Screen_Height/667);
    }];
    
    [_exchangeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_earnButton);
        make.right.equalTo(_headView).mas_offset(-28*Main_Screen_Height/667);
        make.width.mas_equalTo(130*Main_Screen_Height/667);
        make.height.mas_equalTo(40*Main_Screen_Height/667);
    }];
    
    [_scoreListView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_sliderView.mas_bottom).mas_offset(1);
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
    
    [_sliderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_headView.mas_bottom).mas_offset(10);
        make.width.mas_equalTo(Main_Screen_Width);
        make.height.mas_equalTo(44*Main_Screen_Height/667);
    }];
    
}


#pragma mark - 创建上部的SliderView
- (void)setupTopSliderView {
    
    HQSliderView *sliderView = [[HQSliderView alloc] initWithFrame:CGRectZero];
    _sliderView = sliderView;
    sliderView.backgroundColor  = [UIColor whiteColor];
    sliderView.titleArr = @[@"全部",@"收入",@"支出"];
    sliderView.delegate = self;
    
    [self.view addSubview:sliderView];
}

-(void)setupRefresh
{
    self.scoreListView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        // 模拟延迟加载数据，因此2秒后才调用（真实开发中，可以移除这段gcd代码）
        
        [self headerRereshing];
        
    }];
    
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    self.scoreListView.mj_header.automaticallyChangeAlpha = YES;
    
    [self.scoreListView.mj_header beginRefreshing];
    
    // 上拉刷新
    self.scoreListView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        // 模拟延迟加载数据，因此2秒后才调用（真实开发中，可以移除这段gcd代码）
        
        [self footerRereshing];
        
    }];
}

- (void)headerRereshing
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [_ScoreData removeAllObjects];
        //
        self.page = 0 ;
        [self setData:[NSString stringWithFormat:@"%ld",(long)self.scoreTag]];
        
    });
}

- (void)footerRereshing
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        
        self.page++;
        _otherarray = [NSMutableArray new];
        [self setDatamore:[NSString stringWithFormat:@"%ld",(long)self.scoreTag]];
        
        
        //
        //
        //
        //
        //        // 刷新表格
        //
        //        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        
    });
}

-(void)setData:(NSString *)IntegWhereabouts
{
    [self.ScoreData removeAllObjects];
    
    NSDictionary *mulDic = @{
                             @"Account_Id":[UdStorage getObjectforKey:@"Account_Id"],
                             @"IntegWhereabouts":IntegWhereabouts,
                             @"PageIndex":@0,
                             @"PageSize":@10
                             };
        [AFNetworkingTool post:mulDic andurl:[NSString stringWithFormat:@"%@Integral/GetIntegralList",Khttp] success:^(NSDictionary *dict, BOOL success) {
            NSLog(@"%@",dict);
        if([[dict objectForKey:@"ResultCode"] isEqualToString:[NSString stringWithFormat:@"%@",@"F000000"]])
        {
            NSArray *arr = [NSArray array];
            arr = [[dict objectForKey:@"JsonData"] objectForKey:@"integList"];
            if(arr.count == 0)
            {
                //                [self.view showInfo:@"暂无更多数据" autoHidden:YES interval:2];
                [self.scoreListView reloadData];
                [self.scoreListView.mj_header endRefreshing];
            }
            else
            {
                for (NSDictionary *tempdic in arr) {
                    QWIntegModel *integmodel=[[QWIntegModel alloc]initWithDictionary:tempdic error:nil];
                    
                    [self.ScoreData addObject:integmodel];
                }
                
                [self.scoreListView reloadData];
                [self.scoreListView.mj_header endRefreshing];
            }
            
        }
        else
        {
            [self.scoreListView showInfo:@"数据请求失败" autoHidden:YES interval:2];
            [self.scoreListView.mj_header endRefreshing];
        }
        
    } fail:^(NSError *error) {
        [self.scoreListView showInfo:@"获取失败" autoHidden:YES interval:2];
        [self.scoreListView.mj_header endRefreshing];
    }];
    
}

-(void)setDatamore:(NSString *)IntegWhereabouts
{
    
    NSDictionary *mulDic = @{
                             @"Account_Id":[UdStorage getObjectforKey:@"Account_Id"],
                             @"IntegWhereabouts":IntegWhereabouts,
                             @"PageIndex":[NSString stringWithFormat:@"%ld",self.page],
                             @"PageSize":@10
                             };
       [AFNetworkingTool post:mulDic andurl:[NSString stringWithFormat:@"%@Integral/GetIntegralList",Khttp] success:^(NSDictionary *dict, BOOL success) {
        
        if([[dict objectForKey:@"ResultCode"] isEqualToString:[NSString stringWithFormat:@"%@",@"F000000"]])
        {
            NSArray *arr = [NSArray array];
            arr = [[dict objectForKey:@"JsonData"] objectForKey:@"integList"];
            if(arr.count == 0)
            {
                [self.scoreListView showInfo:@"暂无更多数据" autoHidden:YES interval:2];
                self.page--;
                [self.scoreListView reloadData];
                [self.scoreListView.mj_footer endRefreshing];
            }
            else
            {
                for (NSDictionary *tempdic in arr) {
                    QWIntegModel *integmodel=[[QWIntegModel alloc]initWithDictionary:tempdic error:nil];
                    
                    [self.ScoreData addObject:integmodel];
                }
               
                [self.scoreListView reloadData];
                [self.scoreListView.mj_footer endRefreshing];
            }
            
        }
        else
        {
            self.page--;
            [self.scoreListView showInfo:@"数据请求失败" autoHidden:YES interval:2];
            [self.scoreListView.mj_footer endRefreshing];
        }
        
    } fail:^(NSError *error) {
        self.page--;
        [self.scoreListView showInfo:@"获取失败" autoHidden:YES interval:2];
        [self.scoreListView.mj_footer endRefreshing];
    }];
    
}




- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return _ScoreData.count;
    
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellStatic = @"cellStatic";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellStatic];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
    }
    cell.backgroundColor            = [UIColor whiteColor];

    UIFont *titleStringFont            = [UIFont systemFontOfSize:15];
    QWIntegModel *integmodel=self.ScoreData[indexPath.row];
    UILabel *titleStringLabel          = [UIUtil drawLabelInView:cell.contentView frame:[UIUtil textRect:integmodel.IntegName font:titleStringFont] font:titleStringFont text:integmodel.IntegName isCenter:NO];
    
    titleStringLabel.textColor         = [UIColor colorFromHex:@"#4a4a4a"];
    titleStringLabel.left              = Main_Screen_Width*13/375;
    titleStringLabel.top               = Main_Screen_Height*10/667;
    
    NSString *timeString              = integmodel.GetIntegralTime;
    UIFont *timeStringFont            = [UIFont systemFontOfSize:15];
    UILabel *timeStringLabel          = [UIUtil drawLabelInView:cell.contentView frame:[UIUtil textRect:timeString font:timeStringFont] font:timeStringFont text:timeString isCenter:NO];
    timeStringLabel.textColor         = [UIColor colorFromHex:@"#999999"];
    timeStringLabel.left              = titleStringLabel.left;
    timeStringLabel.top               = titleStringLabel.bottom +Main_Screen_Height*5/667;
    NSString *contentString;
    if (self.scoreTag==2) {
         contentString              = [NSString stringWithFormat:@"-%ld",(long)integmodel.IntegralNum];
    }else{
        contentString              = [NSString stringWithFormat:@"+%ld",(long)integmodel.IntegralNum];
    
    }
   
    UIFont *contentStringFont            = [UIFont systemFontOfSize:15];
    UILabel *contentStringLabel          = [UIUtil drawLabelInView:cell.contentView frame:[UIUtil textRect:contentString font:contentStringFont] font:contentStringFont text:contentString isCenter:NO];
    contentStringLabel.textColor         = [UIColor colorFromHex:@"febb02"];
    contentStringLabel.right             = Main_Screen_Width -Main_Screen_Width*12/375;
    contentStringLabel.centerY           = 30;
    
    
    
    //    HQTableViewCell *scoreCell = [HQTableViewCell tableViewCellWithTableView:tableView];
    //
    //    if (self.scoreTag == 0) {
    //
    //        scoreCell.textLabel.text = @"每日签到";
    //        scoreCell.detailTextLabel.text = @"2017-07-20";
    //        UILabel *scoreLbl = [[UILabel alloc] init];
    //        scoreLbl.text = @"+4";
    //        scoreCell.accessoryView = scoreLbl;
    //    } else if (self.scoreTag == 1) {
    //
    //        scoreCell.textLabel.text = [NSString stringWithFormat:@"待付款 --- 第%ld行", indexPath.row];
    //    } else{
    //
    //        scoreCell.textLabel.text = [NSString stringWithFormat:@"待评价 --- 第%ld行", indexPath.row];
    //    }
    //
    //
    return cell;
}


#pragma mark - HQlisderView的代理
- (void)sliderView:(HQSliderView *)sliderView didClickMenuButton:(UIButton *)button{
    
    self.scoreTag = button.tag;
    [self.scoreListView.mj_header beginRefreshing];
    //    [self.scoreListView reloadData];
}


#pragma mark - 点击赚积分按钮和兑换按钮
- (void)didClickEarnScoreBtn {
    
//    [self.navigationController popViewControllerAnimated:YES];
    
    // push将控制器压到栈中，栈是先进后出；pop是出栈：即将控制器从栈中取出。
    
    NSArray * a = self.navigationController.viewControllers;
    
    NSMutableArray *arrController = [NSMutableArray arrayWithArray:a];
    
    NSInteger VcCount = arrController.count;
    
    //最后一个vc是自己，(-2)是倒数第二个是上一个控制器。
    
    UIViewController *lastVC = arrController[VcCount - 2];
    
    // 返回到倒数第三个控制器
    
    if([lastVC isKindOfClass:[QWEarnScoreController class]]) {
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }
    
    else
    {
        
        QWEarnScoreController *earnVC = [[QWEarnScoreController alloc]init];
        earnVC.CurrentScore = self.CurrentScore;
        [arrController replaceObjectAtIndex:(VcCount - 1) withObject:earnVC];
        self.navigationController.viewControllers = arrController;
    }
    
}


- (void)didExchangeScoreBtn {
    
    //DSMembershipController *memberVC = [[DSMembershipController alloc] init];
    
    for (UIViewController *controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[QWScoreController class]]) {
            QWScoreController *memberVC =(QWScoreController *)controller;
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