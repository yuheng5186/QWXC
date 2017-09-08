//
//  QWPayPurchaseCardController.m
//  QWCarWashing
//
//  Created by Wuxinglin on 2017/8/18.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "QWPayPurchaseCardController.h"
#import "payCardDetailCell.h"
#import "CashViewController.h"

#import "BusinessPayCell.h"

@interface QWPayPurchaseCardController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) UITableView *payCardView;

@property (nonatomic, strong) NSArray *payNameArray;
@property (nonatomic, strong) NSArray *payImageNameArr;

@property (nonatomic, strong) NSIndexPath *lastPath;
@property (nonatomic, weak) BusinessPayCell *seleCell;

@end

static NSString *id_payCardViewCell = @"id_payCardViewCell";
static NSString *id_payDetailCell = @"id_payDetailCell";
static NSString *id_businessPaycell = @"id_businessPaycell";


@implementation QWPayPurchaseCardController

- (UITableView *)payCardView {
    if (!_payCardView) {
        UITableView *payCardView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height)];
        self.payCardView = payCardView;
        self.payCardView.backgroundColor    = [UIColor colorFromHex:@"#fafafa"];
        [self.view addSubview:payCardView];
    }
    return _payCardView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"购卡支付";
    
    NSArray *payNameArray = @[@"微信支付",@"支付宝支付"];
    NSArray *payImageNameArr = @[@"weixin",@"zhifubao"];
    self.payNameArray = payNameArray;
    self.payImageNameArr = payImageNameArr;
    
    [self setupUI];
    if ([self.payCardView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.payCardView setSeparatorInset:UIEdgeInsetsZero];
    }

    
}

- (void)setupUI {
    
    
    self.payCardView.delegate = self;
    self.payCardView.dataSource = self;
    
    //[tableview registerClass:[UITableViewCell class] forCellReuseIdentifier:id_payCardViewCell];
    [self.payCardView registerClass:[payCardDetailCell class] forCellReuseIdentifier:id_payDetailCell];
    
    [self.payCardView registerClass:[BusinessPayCell class] forCellReuseIdentifier:id_businessPaycell];
    
    
    
    
    //底部支付栏
    UIView *payBottomView = [[UIView alloc] initWithFrame:CGRectMake(0, Main_Screen_Height - 60*Main_Screen_Height/667, Main_Screen_Width, 60*Main_Screen_Height/667)];
    payBottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:payBottomView];
    
    UILabel *bottomPriceLab = [[UILabel alloc] init];
    bottomPriceLab.text = @"¥54.00";
    if (self.choosecard!=nil) {
        bottomPriceLab.text =[NSString stringWithFormat:@"¥%@",self.choosecard.CardPrice];
    }
    bottomPriceLab.font = [UIFont systemFontOfSize:18*Main_Screen_Height/667];
    bottomPriceLab.textColor = [UIColor colorFromHex:@"#ff525a"];
    [payBottomView addSubview:bottomPriceLab];
    
    [bottomPriceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(payBottomView);
        make.left.equalTo(payBottomView).mas_offset(30*Main_Screen_Height/667);
    }];
    
    UIButton *bottomPayButton = [[UIButton alloc] initWithFrame:CGRectMake(Main_Screen_Width - 136*Main_Screen_Height/667, 0, 136*Main_Screen_Height/667, 60*Main_Screen_Height/667)];
    bottomPayButton.backgroundColor = [UIColor colorFromHex:@"#febb02"];
    [bottomPayButton setTitle:@"立即付款" forState:UIControlStateNormal];
    bottomPayButton.titleLabel.font = [UIFont systemFontOfSize:18*Main_Screen_Height/667];
    [bottomPayButton setTintColor:[UIColor whiteColor]];
    
    //方法子
    [bottomPayButton addTarget:self action:@selector(lijizhifu) forControlEvents:UIControlEventTouchUpInside];
    
    [payBottomView addSubview:bottomPayButton];
}


//方法子
//- (void)showAlertWithTitle:(NSString *)title message:(NSString *)message {
//    
//    if (self.lastPath.row == 0) {
//        message = @"金顶洗车想要打开微信";
//    }else {
//        message = @"金顶洗车想要打开支付宝";
//    }
//    
//    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:message preferredStyle:UIAlertControllerStyleAlert];
//    
//    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        
//    }];
//    [alertController addAction:cancelAction];
//    
//    UIAlertAction *OKAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        
//    }];
//    [alertController addAction:OKAction];
//    
//    [self presentViewController:alertController animated:YES completion:nil];
//    
//}
#pragma mark-购卡支付
-(void)lijizhifu
{
    NSDictionary *mulDic = @{
                             @"Account_Id":[UdStorage getObjectforKey:Userid],
                             @"ConfigCode":[NSString stringWithFormat:@"%ld",self.choosecard.ConfigCode]
                             };
    
        [AFNetworkingTool post:mulDic andurl:[NSString stringWithFormat:@"%@Payment/PurchasePayment",Khttp] success:^(NSDictionary *dict, BOOL success) {
        
        if([[dict objectForKey:@"ResultCode"] isEqualToString:[NSString stringWithFormat:@"%@",@"F000000"]])
        {
            NSDictionary *di = [NSDictionary dictionary];
            di = [dict objectForKey:@"JsonData"];
            
            NSMutableString *stamp = [di objectForKey:@"timestamp"];
            //调起微信支付
            PayReq *req= [[PayReq alloc] init];
            req.partnerId
            = [dict objectForKey:@"partnerid"];
            req.prepayId
            = [dict objectForKey:@"prepayid"];
            req.nonceStr
            = [dict objectForKey:@"noncestr"];
            req.timeStamp
            = stamp.intValue;
            req.package
            = [dict objectForKey:@"packag"];
            req.sign = [dict objectForKey:@"sign"];
            BOOL result = [WXApi sendReq:req];
            
            NSLog(@"-=-=-=-=-%d", result);
            //日志输出
            NSLog(@"appid=%@\npartid=%@\nprepayid=%@\nnoncestr=%@\ntimestamp=%ld\npackage=%@\nsign=%@",[di
                                                                                                        objectForKey:@"appid"],req.partnerId,req.prepayId,req.nonceStr,(long)req.timeStamp,req.package,req.sign
                  );
            
        }
        else
        {
            
            [self.view showInfo:@"信息获取失败,请检查网络" autoHidden:YES interval:2];
            
        }
        
        
        
        
    } fail:^(NSError *error) {
        
        [self.view showInfo:@"信息获取失败,请检查网络" autoHidden:YES interval:2];
    }];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        return 3;
    }
    
    return 2;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0 && indexPath.row == 1) {
        return 67*Main_Screen_Height/667;
    }
    
    return 50*Main_Screen_Height/667;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellStatic = @"cellStatic";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellStatic];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.textColor = [UIColor colorFromHex:@"#4a4a4a"];
    cell.textLabel.font = [UIFont systemFontOfSize:14*Main_Screen_Height/667];
    cell.textLabel.text  = @"卡名称";
    cell.detailTextLabel.text = @"洗车月卡";
    if (self.choosecard!=nil) {
        cell.detailTextLabel.text=self.choosecard.CardName;
    }
    if (indexPath.section == 0 && indexPath.row == 1) {
        
        payCardDetailCell *payCell = [tableView dequeueReusableCellWithIdentifier:id_payDetailCell];

        if (self.choosecard!=nil) {
            payCell.choosecard=self.choosecard;
        }
        
        payCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return payCell;
    }
    if (indexPath.section == 0 && indexPath.row == 2){
        cell.textLabel.text  = @"有效期";
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd"];
        NSDate *datenow = [NSDate date];
        
        NSDate *newDate = [datenow dateByAddingTimeInterval:60 * 60 * 24 * self.choosecard.ExpiredDay];
        cell.detailTextLabel.text = [NSString stringWithFormat:@"即日起至%@",[formatter stringFromDate:newDate]];
        
        cell.detailTextLabel.textColor = [UIColor colorFromHex:@"#febb02"];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:13*Main_Screen_Height/667];
    
    }
    if (indexPath.section == 2) {
        
        BusinessPayCell *paycell = [tableView dequeueReusableCellWithIdentifier:id_businessPaycell forIndexPath:indexPath];
        _seleCell = paycell;
        
        paycell.imageView.image = [UIImage imageNamed:self.payImageNameArr[indexPath.row]];
        paycell.textLabel.text = self.payNameArray[indexPath.row];
        paycell.textLabel.textColor = [UIColor colorFromHex:@"#4a4a4a"];
        paycell.textLabel.font = [UIFont systemFontOfSize:15*Main_Screen_Height/667];
         [paycell.payWayBtn setBackgroundImage:[UIImage imageNamed:@"xfjlweixuanzhong"] forState:UIControlStateNormal];
        NSInteger row = [indexPath row];
        NSInteger oldRow = [self.lastPath row];
       
        if (row == oldRow && self.lastPath != nil) {
            [paycell.payWayBtn setBackgroundImage:[UIImage imageNamed:@"xfjlxaunzhong"] forState:UIControlStateNormal];
        }else{
            
            [paycell.payWayBtn setBackgroundImage:[UIImage imageNamed:@"xfjlweixuanzhong"] forState:UIControlStateNormal];
        }
        
        return paycell;
    }
    if (indexPath.section == 1 && indexPath.row == 0) {
        
        cell.textLabel.text  = @"特惠活动";
       
        cell.detailTextLabel.text = [NSString stringWithFormat:@"立减%.2f元",self.choosecard.DiscountPrice];
        
        cell.detailTextLabel.textColor = [UIColor colorFromHex:@"#febb02"];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:13*Main_Screen_Height/667];
        
        return cell;
    }
    else if (indexPath.section == 1 && indexPath.row == 1) {
        
        cell.textLabel.text  = @"实付";
        cell.detailTextLabel.text = [NSString stringWithFormat:@"￥%@元",self.choosecard.CardPrice];
        
        cell.detailTextLabel.textColor = [UIColor colorFromHex:@"#ff3645"];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:13*Main_Screen_Height/667];
        
        return cell;
    }
   
    
    
    cell.detailTextLabel.textColor = [UIColor colorFromHex:@"#febb02"];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:13*Main_Screen_Height/667];
    
    
    return cell;
}


//- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
//    
//    if (indexPath.section == 1 && indexPath.row == 0 ) {
//        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//    }
//}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if (section == 0 || section == 1) {
        return nil;
    }
    
    UILabel *wayLabel = [[UILabel alloc] init];
    wayLabel.text = @"  请选择支付方式";
    wayLabel.textColor = [UIColor colorFromHex:@"#4a4a4a"];
    wayLabel.font = [UIFont systemFontOfSize:14*Main_Screen_Height/667];
    
    
    return wayLabel;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    if (section == 2) {
        return 30*Main_Screen_Height/667;
    }
    
    return 10*Main_Screen_Height/667;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10*Main_Screen_Height/667;
}
#pragma mark - 点击cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    if (indexPath.section == 1 && indexPath.row == 0) {
//        
//        CashViewController *cashVC = [[CashViewController alloc] init];
//        
//        cashVC.modalPresentationStyle = UIModalPresentationOverCurrentContext;
//        [self presentViewController:cashVC animated:NO completion:nil];
//    }
    
    
    if (indexPath.section == 2) {
        
        NSInteger newRow = [indexPath row];
        NSInteger oldRow = (self.lastPath != nil)?[self.lastPath row]:-1;
        
        if (newRow != oldRow) {
            self.seleCell = [tableView cellForRowAtIndexPath:indexPath];
            
            [self.seleCell.payWayBtn setBackgroundImage:[UIImage imageNamed:@"xfjlxaunzhong"] forState:UIControlStateNormal];
            
            self.seleCell = [tableView cellForRowAtIndexPath:self.lastPath];
            
            [self.seleCell.payWayBtn setBackgroundImage:[UIImage imageNamed:@"xfjlweixuanzhong"] forState:UIControlStateNormal];
            
            self.lastPath = indexPath;
            
        }
    }
}


- (void)viewWillAppear:(BOOL)animated {
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:2];
    [self.payCardView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:2] animated:YES scrollPosition:UITableViewScrollPositionNone];
    if ([_payCardView.delegate respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)]) {
        [_payCardView.delegate tableView:_payCardView didSelectRowAtIndexPath:indexPath];
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
