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
#import "QWCardBagModel.h"
#import "UIScrollView+EmptyDataSet.h"//第三方空白页
#import "MBProgressHUD.h"
@interface QWCardPackgeController ()<UITableViewDelegate, UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>
{
    MBProgressHUD *HUD;
}
//@property (nonatomic, weak) UIView *containerView;
//
//@property (nonatomic, weak) UIScrollView *cardScrollView;
//
//@property (nonatomic, weak) DiscountCategoryView *categoryView;
@property (nonatomic, weak) UITextField *activateTF;
@property (nonatomic, weak) UIButton *activateBtn;
@property (nonatomic, weak) UITableView *rechargeView;

@property (nonatomic, strong) NSMutableArray *CardbagData;

@end
static NSString *id_rechargeCell = @"id_rechargeCell";
@implementation QWCardPackgeController
-(NSMutableArray *)CardbagData{
    if (_CardbagData==nil) {
        _CardbagData=[NSMutableArray arrayWithCapacity:0];
    }
    return _CardbagData;

}
-(void)viewWillAppear:(BOOL)animated{
     [self GetCardbagList];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title  = @"卡包";

     [self setupUI];
    self.view.backgroundColor=kColorTableBG;
    HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HUD.removeFromSuperViewOnHide =YES;
    HUD.mode = MBProgressHUDModeIndeterminate;
    HUD.labelText = @"加载中";
    HUD.minSize = CGSizeMake(132.f, 108.0f);

   
}

-(void)GetCardbagList
{
    [self.CardbagData removeAllObjects];
    NSDictionary *mulDic = @{
                             @"Account_Id":[UdStorage getObjectforKey:Userid]
                             };
[AFNetworkingTool post:mulDic andurl:[NSString stringWithFormat:@"%@Card/GetCardInfoList",Khttp] success:^(NSDictionary *dict, BOOL success) {
    NSLog(@"%@",dict);
        if([[dict objectForKey:@"ResultCode"] isEqualToString:[NSString stringWithFormat:@"%@",@"F000000"]])
        {
            NSArray *arr = [NSArray array];
            arr = [dict objectForKey:@"JsonData"];
            for(NSDictionary *dic in arr)
            {
                QWCardBagModel *model = [[QWCardBagModel alloc]initWithDictionary:dic error:nil];;

                [self.CardbagData addObject:model];
            }
            [self.rechargeView reloadData];
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
        [activateBtn addTarget:self action:@selector(jihuokapian:) forControlEvents:UIControlEventTouchUpInside];
        _activateBtn = activateBtn;
        [self.view addSubview:_activateBtn];
    }
    
    return _activateBtn;
}
#pragma mark-激活卡查询
-(void)jihuokapian:(UIButton *)btn
{
    
    if(_activateTF.text.length == 0)
    {
        [self.view showInfo:@"请输入激活码" autoHidden:YES interval:2];
    }
    else
    {
        [self requestjihuoCardAndcardName:self.activateTF.text];
    }
    
    
}
#pragma mark-激活卡查询数据
-(void)requestjihuoCardAndcardName:(NSString *)cardName{
    NSDictionary *mulDic = @{
                             @"Account_Id":[UdStorage getObjectforKey:Userid],
                             @"ActivationCode":cardName
                             };
    
    [AFNetworkingTool post:mulDic andurl:[NSString stringWithFormat:@"%@Card/ActivationCard",Khttp] success:^(NSDictionary *dict, BOOL success) {
        
        if([[dict objectForKey:@"ResultCode"] isEqualToString:[NSString stringWithFormat:@"%@",@"F000000"]])
        {
            if([[[dict objectForKey:@"JsonData"] objectForKey:@"Activationstate"] integerValue] == 3)
            {
                [self.view showInfo:@"对不起，该卡不存在" autoHidden:YES interval:2];
            }
            else if([[[dict objectForKey:@"JsonData"] objectForKey:@"Activationstate"] integerValue] == 1)
            {
                [self.view showInfo:@"激活成功" autoHidden:YES interval:2];
               
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



- (UITableView *)rechargeView {
    
    if (!_rechargeView) {
        
        UITableView *rechargeView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _rechargeView = rechargeView;
        _rechargeView.emptyDataSetSource=self;
        _rechargeView.emptyDataSetDelegate=self;
        _rechargeView.showsVerticalScrollIndicator = NO;
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
        make.height.mas_equalTo(Main_Screen_Height - 60*Main_Screen_Height/667 - 64);
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
    
    return self.CardbagData.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    RechargeCell *cell = [tableView dequeueReusableCellWithIdentifier:id_rechargeCell forIndexPath:indexPath];
    cell.backgroundColor = self.view.backgroundColor;
    cell.contentView.backgroundColor = self.view.backgroundColor;
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (self.CardbagData.count!=0) {
        cell.cardBagModel=self.CardbagData[indexPath.section];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 10*Main_Screen_Height/667;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPat{
    QWCardBagModel *card = (QWCardBagModel *)[_CardbagData objectAtIndex:indexPat.section];
    QWRechargeDetailController *rechargeDetailVC = [[QWRechargeDetailController alloc] init];
    rechargeDetailVC.hidesBottomBarWhenPushed = YES;
    if (card!=nil) {
        rechargeDetailVC.card = card;
    }
    [self.navigationController pushViewController:rechargeDetailVC animated:YES];

    
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

#pragma mark - 无数据占位
//无数据占位
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView{
    return [UIImage imageNamed:@"kabao_kongbai"];
}

- (CAAnimation *)imageAnimationForEmptyDataSet:(UIScrollView *)scrollView{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath: @"kabao_kongbai"];
    animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    animation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI_2, 0.0, 0.0,   1.0)];
    animation.duration = 0.25;
    animation.cumulative = YES;
    animation.repeatCount = MAXFLOAT;
    return animation;
}
//设置文字（上图下面的文字，我这个图片默认没有这个文字的）是富文本样式，扩展性很强！

//这个是设置标题文字的
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    NSString *text = @"客官你还没有办理过卡";
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:13.0f],
                                 NSForegroundColorAttributeName: [UIColor colorFromHex:@"#4a4a4a"]};
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}
//设置按钮的文本和按钮的背景图片
- (NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state  {
    //    NSLog(@"buttonTitleForEmptyDataSet:点击上传照片");
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:18.0f],NSForegroundColorAttributeName:[UIColor whiteColor]};
    return [[NSAttributedString alloc] initWithString:@"去购卡" attributes:attributes];
}
#pragma mark-背景图片
//-(UIImage *)buttonBackgroundImageForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state{
//
//    return [UIImage imageNamed:@"mashangxiche-"];
//}
- (UIImage *)buttonImageForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state {
    return [UIImage imageNamed:@"qgouka"];
}
//是否显示空白页，默认YES
- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView {
    return YES;
}
//是否允许点击，默认YES
- (BOOL)emptyDataSetShouldAllowTouch:(UIScrollView *)scrollView {
    return YES;
}
//是否允许滚动，默认NO
- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView {
    return YES;
}
//图片是否要动画效果，默认NO
- (BOOL) emptyDataSetShouldAllowImageViewAnimate:(UIScrollView *)scrollView {
    return YES;
}
//空白页点击事件
- (void)emptyDataSetDidTapView:(UIScrollView *)scrollView {
    NSLog(@"空白页点击事件");
}
//空白页按钮点击事件
- (void)emptyDataSetDidTapButton:(UIScrollView *)scrollView {
    self.tabBarController.selectedIndex = 3;
}
/**
 *  调整垂直位置
 */
- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView
{
    return (-64.f)*Main_Screen_Height/667;
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
