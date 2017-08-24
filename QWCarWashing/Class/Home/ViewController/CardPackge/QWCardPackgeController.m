//
//  QWCardPackgeController.m
//  QWCarWashing
//
//  Created by Wuxinglin on 2017/8/16.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "QWCardPackgeController.h"
#import "QWDiscountCategoryView.h"
#import "QWDiscountController.h"
#import "RechargeCell.h"
#import "QWRechargeDetailController.h"
@interface QWCardPackgeController ()<UITableViewDelegate, UITableViewDataSource>

//@property (nonatomic, weak) UIView *containerView;
//
//@property (nonatomic, weak) UIScrollView *cardScrollView;
//
//@property (nonatomic, weak) DiscountCategoryView *categoryView;
@property (nonatomic, weak) UITextField *activateTF;
@property (nonatomic, weak) UIButton *activateBtn;
@property (nonatomic, weak) UITableView *rechargeView;


@end
static NSString *id_rechargeCell = @"id_rechargeCell";
@implementation QWCardPackgeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title  = @"卡包";

     [self setupUI];
    self.view.backgroundColor=kColorTableBG;
}
- (UITextField *)activateTF {
    
    if (!_activateTF) {
        
        UITextField *activateTF = [[UITextField alloc] init];
        activateTF.backgroundColor = [UIColor whiteColor];
        activateTF.placeholder = @"  请输入激活码";
        activateTF.font = [UIFont systemFontOfSize:Main_Screen_Height*14/667];
        activateTF.textColor = [UIColor colorFromHex:@"#c8c8c8"];
        activateTF.layer.cornerRadius = Main_Screen_Height*20/667;
        activateTF.layer.borderWidth  = 0.5;
        activateTF.layer.borderColor  = [UIColor colorFromHex:@"#c8c8c8"].CGColor;
        activateTF.clipsToBounds = YES;
        _activateTF = activateTF;
        [self.view addSubview:activateTF];
    }
    
    return _activateTF;
}
- (UIButton *)activateBtn {
    
    if (!_activateBtn) {
        
        UIButton *activateBtn = [[UIButton alloc] init];
        [activateBtn setTitle:@"激活卡" forState:UIControlStateNormal];
        activateBtn.backgroundColor = [UIColor colorFromHex:@"#febb02"];
        activateBtn.titleLabel.tintColor = [UIColor colorFromHex:@"#ffffff"];
        activateBtn.titleLabel.font = [UIFont systemFontOfSize:Main_Screen_Height*14/667];
        activateBtn.layer.cornerRadius = Main_Screen_Height*20/667;
        activateBtn.clipsToBounds = YES;
        _activateBtn = activateBtn;
        [self.view addSubview:_activateBtn];
    }
    
    return _activateBtn;
}


- (UITableView *)rechargeView {
    
    if (!_rechargeView) {
        
        UITableView *rechargeView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _rechargeView = rechargeView;
//        _rechargeView.backgroundColor=[UIColor redColor];
        [self.view addSubview:_rechargeView];
    }
    
    return _rechargeView;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self.activateTF resignFirstResponder];
    
    [self.view endEditing:YES];
}
- (void)setupUI {
    
//    [self setupCategoryView];
//    [self setupScrollView];
//    
//    [self addCardChildViewControllers];

    UIView *titleView                  = [UIUtil drawLineInView:self.view frame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height*60/667) color:[UIColor whiteColor]];
    titleView.top                      = 64;
    
    
    [self.activateTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(titleView).mas_offset(Main_Screen_Width*10/375);
        make.top.equalTo(titleView).mas_offset(Main_Screen_Height*10/667);
        make.width.mas_equalTo(Main_Screen_Width*270/375);
        make.height.mas_equalTo(Main_Screen_Height*40/667);
    }];
    
    [self.activateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).mas_equalTo(-Main_Screen_Width*10/375);
        make.top.equalTo(self.view).mas_equalTo(64+Main_Screen_Height*10/667);
        make.width.mas_equalTo(Main_Screen_Width*75/375);
        make.height.mas_equalTo(Main_Screen_Height*40/667);
    }];
    
    
    [self.rechargeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleView.mas_bottom);
        make.left.equalTo(self.view).mas_offset(Main_Screen_Width*37.5/375);
        make.right.equalTo(self.view).mas_offset(-Main_Screen_Width*37.5/375);
        make.height.mas_equalTo(self.view.height);
    }];
    
    self.rechargeView.delegate = self;
    self.rechargeView.dataSource = self;
    self.rechargeView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.rechargeView registerNib:[UINib nibWithNibName:@"RechargeCell" bundle:nil] forCellReuseIdentifier:id_rechargeCell];
    self.rechargeView.rowHeight = Main_Screen_Height*192/667;
    //self.rechargeView.backgroundColor = [UIColor whiteColor];
    
    UIView *blankView = [[UIView alloc] initWithFrame:CGRectMake(_activateTF.frame.origin.x,_activateTF.frame.origin.y,15.0, _activateTF.frame.size.height)];
    _activateTF.leftView = blankView;
    _activateTF.leftViewMode =UITextFieldViewModeAlways;
    

}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    RechargeCell *cell = [tableView dequeueReusableCellWithIdentifier:id_rechargeCell forIndexPath:indexPath];
    cell.backgroundColor = self.view.backgroundColor;
    cell.contentView.backgroundColor = self.view.backgroundColor;
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 10*Main_Screen_Height/667;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPat{
    
//    QWRechargeController *rechargedetailvc=[[QWRechargeController alloc]init];
//    rechargedetailvc.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:rechargedetailvc animated:YES];
    
    QWRechargeDetailController *VC = [[QWRechargeDetailController alloc] init];
    VC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:VC animated:YES];
    
}

//- (void)addCardChildViewControllers{
//    
//    QWDiscountController *discountVC = [[QWDiscountController alloc] init] ;
//    QWRechargeController *rechargeVC = [[QWRechargeController alloc] init];
//    
//    [self addChildViewController:discountVC];
//    [self addChildViewController:rechargeVC];
//    
//    [_containerView addSubview:discountVC.view];
//    [_containerView addSubview:rechargeVC.view];
//    
//    [discountVC didMoveToParentViewController:self];
//    [rechargeVC didMoveToParentViewController:self];
//    
//    [discountVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.leading.equalTo(_containerView);
//        make.size.equalTo(_cardScrollView);
//    }];
//    
//    [rechargeVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(_containerView);
//        make.leading.equalTo(discountVC.view.mas_trailing);
//        make.size.equalTo(_cardScrollView);
//    }];
//    
//}
//
//
//#pragma mark - 设置分类视图
//- (void)setupCategoryView{
//    
//    QWDiscountCategoryView *categoryView = [[QWDiscountCategoryView alloc] initWithFrame:CGRectMake(0, 64, Main_Screen_Width, 44)];
//    
//    _categoryView = categoryView;
//    
//    [self.view addSubview:categoryView];
//    
//    categoryView.categoryBlock = ^(NSInteger index){
//        
//        //修改scrollView的contentOffset
//        [self.cardScrollView setContentOffset:CGPointMake(index * self.cardScrollView.width, 0) animated:YES];
//    };
//}
//
//
//
//#pragma mark - 布局scrollView
//- (void)setupScrollView {
//    
//    
//    
//    UIScrollView *cardScrollView =  [[UIScrollView alloc] init];
//    _cardScrollView = cardScrollView;
//    
//    cardScrollView.delegate = self;
//    cardScrollView.bounces = NO;
//    cardScrollView.pagingEnabled = YES;
//    
//    [self.view addSubview:cardScrollView];
//    
//    [cardScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(_categoryView.mas_bottom);
//        make.leading.trailing.bottom.equalTo(self.view);
//    }];
//    
//    
//    //容器视图
//    UIView *containerView = [[UIView alloc] init];
//    _containerView = containerView;
//    containerView.backgroundColor = [UIColor lightGrayColor];
//    
//    [cardScrollView addSubview:containerView];
//    
//    [containerView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(cardScrollView);
//        make.width.equalTo(cardScrollView).multipliedBy(2);
//        make.height.equalTo(cardScrollView);
//    }];
//    
//}
//
//#pragma mark - scrollView的代理方法
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    
//    if (scrollView.isTracking || scrollView.isDragging || scrollView.isDecelerating) {
//        CGFloat offsetX = scrollView.contentOffset.x / 2;
//        _categoryView.offsetX = offsetX;
//    }
//}



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
