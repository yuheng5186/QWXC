//
//  QWPayViewController.m
//  QWCarWashing
//
//  Created by apple on 2017/8/15.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "QWPayViewController.h"
//#import "AppDelegate.h"
#import "CashViewController.h"
#import "BusinessPayCell.h"

@interface QWPayViewController ()<UITableViewDelegate, UITableViewDataSource>
//{
//    AppDelegate *myDelegate;
//    UITableView *tableview;
//    UIButton *qiandao;
//    UIButton *qiandao1;
//    UIButton *qiandao2;
//    
//    UILabel *yue;
//    
//    NSString *yl;
//    
//    UILabel *yuekoukuan;
//    UILabel *body;
//    
//    int tag;
//}

@property (nonatomic, weak) UITableView *Merchantpaytableview;

@property (nonatomic, weak) UITableView *payTableView;

@property (nonatomic, strong) NSArray *payNameArray;
@property (nonatomic, strong) NSArray *payImageNameArr;

@property (nonatomic, strong) NSIndexPath *lastPath;

@property (nonatomic, weak) BusinessPayCell *seleCell;

@end

static NSString *payViewCell = @"payTableViewCell";
static NSString *id_paySelectCell = @"id_paySelectCell";

@implementation QWPayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title      = @"支付";
    //myDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    NSArray *payNameArray = @[@"微信支付",@"支付宝支付"];
    NSArray *payImageNameArr = @[@"weixin",@"zhifubao"];
    self.payNameArray = payNameArray;
    self.payImageNameArr = payImageNameArr;
    
    [self setupview];
    //tag = 0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setupview
{
    UITableView *payTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height) style:UITableViewStyleGrouped];
    
    self.payTableView = payTableView;
    payTableView.delegate = self;
    payTableView.dataSource = self;
    payTableView.rowHeight = 50*Main_Screen_Height/667;
    
    [self.view addSubview:payTableView];
    
    [self.payTableView registerClass:[BusinessPayCell class] forCellReuseIdentifier:id_paySelectCell];
    
    //底部支付栏
    UIView *payBottomView = [[UIView alloc] initWithFrame:CGRectMake(0, Main_Screen_Height - 60*Main_Screen_Height/667, Main_Screen_Width, 60*Main_Screen_Height/667)];
    payBottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:payBottomView];
    
    UILabel *bottomPriceLab = [[UILabel alloc] init];
    bottomPriceLab.text = @"¥54.00";
    bottomPriceLab.font = [UIFont systemFontOfSize:18*Main_Screen_Height/667];
    bottomPriceLab.textColor = [UIColor colorFromHex:@"#ff525a"];
    [payBottomView addSubview:bottomPriceLab];
    
    [bottomPriceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(payBottomView).mas_offset(30*Main_Screen_Height/667);
        make.top.equalTo(payBottomView).mas_offset(20*Main_Screen_Height/667);
        
    }];
    
    UIButton *bottomPayButton = [[UIButton alloc] initWithFrame:CGRectMake(Main_Screen_Width - 136*Main_Screen_Height/667, 0, 136*Main_Screen_Height/667, 60*Main_Screen_Height/667)];
    bottomPayButton.backgroundColor = [UIColor colorFromHex:@"#febb02"];
    [bottomPayButton setTitle:@"立即支付" forState:UIControlStateNormal];
    [bottomPayButton setTintColor:[UIColor whiteColor]];
    bottomPayButton.titleLabel.font = [UIFont systemFontOfSize:18*Main_Screen_Height/667];
    
    //方法子
    [bottomPayButton addTarget:self action:@selector(showAlertWithTitle:message:) forControlEvents:UIControlEventTouchUpInside];
    
    [payBottomView addSubview:bottomPayButton];
    
    
    //
    UIButton *leftButton = [[UIButton alloc]initWithFrame:CGRectMake(0,0,20,20)];
    [leftButton setImage:[UIImage imageNamed:@"baisefanhui"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem= leftItem;
    
//    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, QWScreenWidth, QWScreenheight - 20*myDelegate.autoSizeScaleY)];
//    tableView.backgroundColor = [UIColor colorWithRed:246/255.f green:246/255.f blue:246/255.f alpha:1.0f];
//    _Merchantpaytableview = tableView;
//    _Merchantpaytableview.delegate = self;
//    _Merchantpaytableview.dataSource = self;
//    self.automaticallyAdjustsScrollViewInsets=NO;
//    _Merchantpaytableview.separatorStyle = NO;
//    _Merchantpaytableview.showsVerticalScrollIndicator = NO;
//    [self.view addSubview:_Merchantpaytableview];
//    
//    UIView *vv = [[UIView alloc]initWithFrame:CGRectMake(0, QWScreenheight - 60*myDelegate.autoSizeScaleY, QWScreenWidth, 60*myDelegate.autoSizeScaleY)];
//    vv.backgroundColor = [UIColor whiteColor];
//    [self.view addSubview:vv];
//    
//    UILabel *label33 = [[UILabel alloc]initWithFrame:CGRectMake1(15, 10, 200, 40)];
//    label33.text = @"￥54.00";
//    label33.textColor = [UIColor colorWithHexString:@"#ff525a"];
//    label33.font = [UIFont systemFontOfSize:18*myDelegate.autoSizeScaleX];
//    [vv addSubview:label33];
//    
//    
//    
//    
//    
//    UIButton *zf = [UIButton buttonWithType:UIButtonTypeSystem];
//    [zf setTitle:@"立即支付" forState:UIControlStateNormal];
//    zf.titleLabel.font = [UIFont systemFontOfSize: 16*myDelegate.autoSizeScaleX];
//    [zf addTarget:self action:@selector(lijizhifu) forControlEvents:UIControlEventTouchUpInside];
//    zf.frame = CGRectMake(QWScreenWidth - 136*myDelegate.autoSizeScaleX, 0,136*myDelegate.autoSizeScaleX, 60*myDelegate.autoSizeScaleY);
//    
//    [vv addSubview:zf];
//    zf.tintColor = [UIColor whiteColor];
//    zf.backgroundColor = [UIColor colorWithHexString:@"#ff800a"];
}

//方法子
- (void)showAlertWithTitle:(NSString *)title message:(NSString *)message {
    
    if (self.lastPath.row == 0) {
        message = @"金顶洗车想要打开微信";
    }else {
        message = @"金顶洗车想要打开支付宝";
    }
    
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertController addAction:cancelAction];
    
    UIAlertAction *OKAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertController addAction:OKAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
    
}

-(void)back
{
    NSString *message = @"你确定要退出支付界面？";
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    
    
    NSString *cancelButtonTitle = NSLocalizedString(@"取消", nil);
    NSString *otherButtonTitle = NSLocalizedString(@"确定", nil);
    
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelButtonTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
        
    }];
    
    UIAlertAction *otherAction = [UIAlertAction actionWithTitle:otherButtonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }];
    
    
    [alertController addAction:cancelAction];
    [alertController addAction:otherAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
    
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        return 3;
    }
    
    return 2;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *payCell = [tableView dequeueReusableCellWithIdentifier:payViewCell];
    
    payCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
    
    payCell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (indexPath.section == 0 || indexPath.section == 1) {
        payCell.textLabel.text = @"服务商家";
        payCell.detailTextLabel.text = @"上海金雷洗车";
        payCell.textLabel.textColor = [UIColor colorFromHex:@"#4a4a4a"];
        payCell.textLabel.font = [UIFont systemFontOfSize:14*Main_Screen_Height/667];
        payCell.detailTextLabel.font = [UIFont systemFontOfSize:13*Main_Screen_Height/667];
        payCell.detailTextLabel.textColor = [UIColor colorFromHex:@"#999999"];
        
    }else {
        BusinessPayCell *cell = [tableView dequeueReusableCellWithIdentifier:id_paySelectCell forIndexPath:indexPath];
        _seleCell = cell;
        //cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.imageView.image = [UIImage imageNamed:self.payImageNameArr[indexPath.row]];
        cell.textLabel.text = self.payNameArray[indexPath.row];
        cell.textLabel.textColor = [UIColor colorFromHex:@"#4a4a4a"];
        cell.textLabel.font = [UIFont systemFontOfSize:15*Main_Screen_Height/667];
        
        //        UIButton *payWayBtn = [[UIButton alloc] init];
        //        [payWayBtn setImage:[UIImage imageNamed:@"weixuanzhong"] forState:UIControlStateNormal];
        //        [payWayBtn setImage:[UIImage imageNamed:@"xaunzhong"] forState:UIControlStateSelected];
        //        [payCell.contentView addSubview:payWayBtn];
        
        //        [payWayBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        //            make.centerY.equalTo(payCell.contentView);
        //            make.right.equalTo(payCell.contentView).mas_offset(-12);
        //            make.width.mas_equalTo(21);
        //            make.height.mas_equalTo(21);
        //        }];
        
        //单选支付
        NSInteger row = [indexPath row];
        NSInteger oldRow = [self.lastPath row];
        
        if (row == oldRow && self.lastPath != nil) {
            [cell.payWayBtn setBackgroundImage:[UIImage imageNamed:@"xfjlxaunzhong"] forState:UIControlStateNormal];
        }else{
            
            [cell.payWayBtn setBackgroundImage:[UIImage imageNamed:@"xfjlweixuanzhong"] forState:UIControlStateNormal];
        }
        
        return cell;
        
    }
    
    
    
    return payCell;
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
//        //cashVC.providesPresentationContextTransitionStyle = YES;
//        //cashVC.definesPresentationContext = YES;
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
    [self.payTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:2] animated:YES scrollPosition:UITableViewScrollPositionNone];
    if ([_payTableView.delegate respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)]) {
        [_payTableView.delegate tableView:_payTableView didSelectRowAtIndexPath:indexPath];
    }
}

//-(void)lijizhifu
//{
//    if(tag == 501)
//    {
//        UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:nil message:@"你点击了支付宝支付" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
//        [alertview show];
//    }
//    else if(tag == 502)
//    {
//        UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:nil message:@"你点击了微信支付" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
//        [alertview show];
//    }
//    else
//    {
//        UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:nil message:@"请选择支付方式" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
//        [alertview show];
//    }
//}

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    
//    return 3;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    if(section == 0)
//    {
//        return 3;
//    }else
//    {
//        return 2;
//    }
//    
//}

//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    if(section == 2)
//    {
//        return 40*(myDelegate.autoSizeScaleY );
//    }
//    else if(section == 1)
//    {
//        return 10*(myDelegate.autoSizeScaleY );
//    }
//    else
//    {
//        return 0;
//    }
//}
//
//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    
//    return 40*(myDelegate.autoSizeScaleY );
//}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    if(section == 2)
//    {
//        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake1(0, 0, 375, 40)];//创建一个视图
//        UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake1(15, 5, 150, 20)];
//        headerLabel.font = [UIFont systemFontOfSize:12.0];
//        headerLabel.textColor = [UIColor colorWithRed:100/255.f green:100/255.f blue:100/255.f alpha:1.0f];
//        headerLabel.text = @"选择支付方式";
//        [headerView addSubview:headerLabel];
//        CGSize labelSize = [headerLabel.text sizeWithFont:[UIFont systemFontOfSize:12.0] constrainedToSize:CGSizeMake(200, MAXFLOAT) lineBreakMode:NSLineBreakByCharWrapping];
//        headerLabel.frame = CGRectMake(15* myDelegate.autoSizeScaleX, 40 * myDelegate.autoSizeScaleY/2-labelSize.height/2, 200, labelSize.height);
//        
//        return headerView;
//    }
//    else
//    {
//        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake1(0, 0, 320, 0)];//创建一个视图
//        
//        
//        return headerView;
//    }
//    
//}

//
//-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if (indexPath.section == 0 && indexPath.row == 0)
//    {
//        static NSString *CellIdentifier = @"cell0";//可复用单元格标识
//        [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellIdentifier];
//        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
//        
//        if (cell == nil)
//        {
//            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
//        }
//        
//        else
//        {
//            //删除cell的所有子视图
//            while ([cell.contentView.subviews lastObject] != nil)
//            {
//                [(UIView*)[cell.contentView.subviews lastObject] removeFromSuperview];
//            }
//        }
//
//        
//        UILabel *label5 = [[UILabel alloc]initWithFrame:CGRectMake1(15, 10, 100, 20)];
//        label5.text = @"服务商家";
//        label5.font = [UIFont fontWithName:@"Helvetica" size:15 * (myDelegate.autoSizeScaleX)];
//        [cell.contentView addSubview:label5];
//        
//        
//        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake1(170, 10, 190, 20)];
//        label.textAlignment = NSTextAlignmentRight;
//        label.text = @"上海金霞快修店";
//        label.textColor = [UIColor colorWithHexString:@"#999999"];
//        label.font = [UIFont fontWithName:@"Helvetica" size:14 * (myDelegate.autoSizeScaleX)];
//        [cell.contentView addSubview:label];
//        
//        cell.selectionStyle  = UITableViewCellSelectionStyleNone;
//        return cell;
//        
//    }
//    if (indexPath.section == 0 && indexPath.row == 1)
//    {
//        static NSString *CellIdentifier = @"cell0";//可复用单元格标识
//        [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellIdentifier];
//        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
//        
//        if (cell == nil)
//        {
//            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
//        }
//        
//        else
//        {
//            //删除cell的所有子视图
//            while ([cell.contentView.subviews lastObject] != nil)
//            {
//                [(UIView*)[cell.contentView.subviews lastObject] removeFromSuperview];
//            }
//        }
//
//        
//        UILabel *label5 = [[UILabel alloc]initWithFrame:CGRectMake1(15, 10, 100, 20)];
//        label5.text = @"服务项目";
//        label5.font = [UIFont fontWithName:@"Helvetica" size:15 * (myDelegate.autoSizeScaleX)];
//        [cell.contentView addSubview:label5];
//        
//        
//        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake1(170, 10, 190, 20)];
//        label.textAlignment = NSTextAlignmentRight;
//        label.text = @"标准洗车-五座轿车";
//        label.textColor = [UIColor colorWithHexString:@"#999999"];
//        label.font = [UIFont fontWithName:@"Helvetica" size:14 * (myDelegate.autoSizeScaleX)];
//        [cell.contentView addSubview:label];
//        
//        cell.selectionStyle  = UITableViewCellSelectionStyleNone;
//        return cell;
//        
//    }
//    if (indexPath.section == 0 && indexPath.row == 2)
//    {
//        static NSString *CellIdentifier = @"cell0";//可复用单元格标识
//        [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellIdentifier];
//        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
//        
//        if (cell == nil)
//        {
//            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
//        }
//        
//        else
//        {
//            //删除cell的所有子视图
//            while ([cell.contentView.subviews lastObject] != nil)
//            {
//                [(UIView*)[cell.contentView.subviews lastObject] removeFromSuperview];
//            }
//        }
//
//        
//        UILabel *label5 = [[UILabel alloc]initWithFrame:CGRectMake1(15, 10, 100, 20)];
//        label5.text = @"订单金额";
//        label5.font = [UIFont fontWithName:@"Helvetica" size:15 * (myDelegate.autoSizeScaleX)];
//        [cell.contentView addSubview:label5];
//        
//        
//        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake1(170, 10, 190, 20)];
//        label.textAlignment = NSTextAlignmentRight;
//        label.text = @"￥18.00";
//        label.textColor = [UIColor colorWithHexString:@"#ff3645"];
//        label.font = [UIFont fontWithName:@"Helvetica" size:14 * (myDelegate.autoSizeScaleX)];
//        [cell.contentView addSubview:label];
//        
//        cell.selectionStyle  = UITableViewCellSelectionStyleNone;
//        return cell;
//        
//    }
//    else if (indexPath.section == 2 && indexPath.row == 0)
//    {
//        static NSString *CellIdentifier = @"cell11";//可复用单元格标识
//        [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellIdentifier];
//        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
//        
//        if (cell == nil)
//        {
//            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
//        }
//        
//        else
//        {
//            //删除cell的所有子视图
//            while ([cell.contentView.subviews lastObject] != nil)
//            {
//                [(UIView*)[cell.contentView.subviews lastObject] removeFromSuperview];
//            }
//        }
//        UILabel *label5 = [[UILabel alloc]initWithFrame:CGRectMake1(50, 10, 100, 20)];
//        label5.text = @"支付宝支付";
//        label5.font = [UIFont fontWithName:@"Helvetica" size:15 * (myDelegate.autoSizeScaleX)];
//        [cell.contentView addSubview:label5];
//        
//        UIImageView *leftImg = [[UIImageView alloc]init];
//        leftImg.frame=CGRectMake1(15,10 ,20 , 20);
//        leftImg.image = [UIImage imageNamed:@"zhifubao"];
//        [cell.contentView addSubview:leftImg];
//        
//        qiandao = [UIButton buttonWithType:UIButtonTypeSystem];
//        [qiandao setBackgroundImage:[UIImage imageNamed:@"xfjlweixuanzhong"] forState:UIControlStateNormal];
//        qiandao.tag = 501;
//        [qiandao addTarget:self action:@selector(choose:) forControlEvents:UIControlEventTouchUpInside];
//        qiandao.frame = CGRectMake1(287.5+55,11.25 ,17.5 , 17.5);
//        
//        
//        
//        //        UIButton * qiandao = [[UIButton alloc] initWithFrame:CGRectMake1(287.5,11.25 ,17.5 , 17.5)];
//        //        qiandao.imageView.frame = qiandao.bounds;
//        //        qiandao.hidden = NO;
//        //        qiandao.imageView.image = [UIImage imageNamed:@"radio_btn_off"];
//        [cell.contentView addSubview:qiandao];
//        cell.selectionStyle  = UITableViewCellSelectionStyleNone;
//        return cell;
//        
//    }
//    else if (indexPath.section == 2 && indexPath.row == 1)
//    {
//        static NSString *CellIdentifier = @"cell1";//可复用单元格标识
//        [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellIdentifier];
//        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
//        
//        if (cell == nil)
//        {
//            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
//        }
//        
//        else
//        {
//            //删除cell的所有子视图
//            while ([cell.contentView.subviews lastObject] != nil)
//            {
//                [(UIView*)[cell.contentView.subviews lastObject] removeFromSuperview];
//            }
//        }
//        UILabel *label5 = [[UILabel alloc]initWithFrame:CGRectMake1(50, 10, 100, 20)];
//        label5.text = @"微信支付";
//        label5.font = [UIFont fontWithName:@"Helvetica" size:15 * (myDelegate.autoSizeScaleX)];
//        [cell.contentView addSubview:label5];
//        
//        UIImageView *leftImg = [[UIImageView alloc]init];
//        leftImg.frame=CGRectMake1(15,10 ,20 , 20);
//        leftImg.image = [UIImage imageNamed:@"weixin"];
//        [cell.contentView addSubview:leftImg];
//        
//        qiandao1 = [UIButton buttonWithType:UIButtonTypeSystem];
//        [qiandao1 setBackgroundImage:[UIImage imageNamed:@"xfjlweixuanzhong"] forState:UIControlStateNormal];
//        qiandao1.tag = 502;
//        [qiandao1 addTarget:self action:@selector(choose:) forControlEvents:UIControlEventTouchUpInside];
//        qiandao1.frame = CGRectMake1(287.5+55,11.25 ,17.5 , 17.5);
//        [cell.contentView addSubview:qiandao1];
//        UIView * separator = [[UIView alloc] initWithFrame:CGRectMake(15 * (myDelegate.autoSizeScaleX), 0, 365 * (myDelegate.autoSizeScaleX), 0.5)];
//        separator.backgroundColor = [UIColor colorWithRed:230/255.f green:230/255.f blue:230/255.f alpha:1];
//        cell.selectionStyle  = UITableViewCellSelectionStyleNone;
//        [cell addSubview:separator];
//        
//        return cell;
//        
//    }
//    
//    
//    
//    else if(indexPath.section == 1 && indexPath.row == 0)
//    {
//        static NSString *CellIdentifier = @"cell2";//可复用单元格标识
//        [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellIdentifier];
//        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
//        
//        if (cell == nil)
//        {
//            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
//        }
//        
//        else
//        {
//            //删除cell的所有子视图
//            while ([cell.contentView.subviews lastObject] != nil)
//            {
//                [(UIView*)[cell.contentView.subviews lastObject] removeFromSuperview];
//            }
//        }
//        
//        UILabel *label5 = [[UILabel alloc]initWithFrame:CGRectMake1(15, 10, 100, 20)];
//        label5.text = @"特惠活动";
//        label5.font = [UIFont fontWithName:@"Helvetica" size:15 * (myDelegate.autoSizeScaleX)];
//        [cell.contentView addSubview:label5];
//        
//
//        
//        
//        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake1(170, 10, 190, 20)];
//        label.textAlignment = NSTextAlignmentRight;
//        label.text = @"立减5元";
//        label.textColor = [UIColor colorWithHexString:@"#ff3645"];
//        label.font = [UIFont fontWithName:@"Helvetica" size:14 * (myDelegate.autoSizeScaleX)];
//        [cell.contentView addSubview:label];
//        
//        
//        
//        
//        cell.selectionStyle  = UITableViewCellSelectionStyleNone;
//        
//        return cell;
//        
//    }
//    
//    else
//    {
//        static NSString *CellIdentifier = @"cell3";//可复用单元格标识
//        [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellIdentifier];
//        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
//        
//        if (cell == nil)
//        {
//            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
//        }
//        
//        else
//        {
//            //删除cell的所有子视图
//            while ([cell.contentView.subviews lastObject] != nil)
//            {
//                [(UIView*)[cell.contentView.subviews lastObject] removeFromSuperview];
//            }
//        }
//        UILabel *label5 = [[UILabel alloc]initWithFrame:CGRectMake1(15, 10, 100, 20)];
//        label5.text = @"实付";
//        label5.font = [UIFont fontWithName:@"Helvetica" size:15 * (myDelegate.autoSizeScaleX)];
//        [cell.contentView addSubview:label5];
//        
//        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake1(170, 10, 190, 20)];
//        label.textAlignment = NSTextAlignmentRight;
//        label.text = @"￥18.00";
//        label.textColor = [UIColor colorWithHexString:@"#ff3645"];
//        label.font = [UIFont fontWithName:@"Helvetica" size:14 * (myDelegate.autoSizeScaleX)];
//        [cell.contentView addSubview:label];
//        
//        UIView * separator = [[UIView alloc] initWithFrame:CGRectMake(15 * (myDelegate.autoSizeScaleX), 0, 365 * (myDelegate.autoSizeScaleX), 0.5)];
//        separator.backgroundColor = [UIColor colorWithRed:230/255.f green:230/255.f blue:230/255.f alpha:1];
//        cell.selectionStyle  = UITableViewCellSelectionStyleNone;
//        [cell addSubview:separator];
//        
//        cell.selectionStyle  = UITableViewCellSelectionStyleNone;
//        return cell;
//    }
//    
//    
//    
//}
//
//-(void)choose:(UIButton *)b
//{
//    if(b.tag == 501)
//    {
//        [qiandao setBackgroundImage:[UIImage imageNamed:@"xfjlxaunzhong"] forState:UIControlStateNormal];
//        [qiandao1 setBackgroundImage:[UIImage imageNamed:@"xfjlweixuanzhong"] forState:UIControlStateNormal];
//        tag = (int)b.tag;
//    }
//    else
//    {
//        [qiandao1 setBackgroundImage:[UIImage imageNamed:@"xfjlxaunzhong"] forState:UIControlStateNormal];
//        [qiandao setBackgroundImage:[UIImage imageNamed:@"xfjlweixuanzhong"] forState:UIControlStateNormal];
//        tag = (int)b.tag;
//    }
//    
//    
//}
//
//CG_INLINE CGRect//注意：这里的代码要放在.m文件最下面的位置
//CGRectMake1(CGFloat x, CGFloat y, CGFloat width, CGFloat height)
//{
//    AppDelegate *myDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//    CGRect rect;
//    rect.origin.x = x * myDelegate.autoSizeScaleX;
//    rect.origin.y = y * myDelegate.autoSizeScaleY;
//    rect.size.width = width * myDelegate.autoSizeScaleX;
//    rect.size.height = height * myDelegate.autoSizeScaleY;
//    return rect;
//}



@end
