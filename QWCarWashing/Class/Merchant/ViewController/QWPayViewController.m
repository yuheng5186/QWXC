//
//  QWPayViewController.m
//  QWCarWashing
//
//  Created by apple on 2017/8/15.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "QWPayViewController.h"
#import "AppDelegate.h"

@interface QWPayViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    AppDelegate *myDelegate;
    UITableView *tableview;
    UIButton *qiandao;
    UIButton *qiandao1;
    UIButton *qiandao2;
    
    UILabel *yue;
    
    NSString *yl;
    
    UILabel *yuekoukuan;
    UILabel *body;
    
    int tag;
}

@property (nonatomic, weak) UITableView *Merchantpaytableview;

@end

@implementation QWPayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    myDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self setupview];
    tag = 0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setupview
{
    UIButton *leftButton = [[UIButton alloc]initWithFrame:CGRectMake(0,0,20,20)];
    [leftButton setImage:[UIImage imageNamed:@"baisefanhui"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem= leftItem;
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, QWScreenWidth, QWScreenheight - 20*myDelegate.autoSizeScaleY)];
    tableView.backgroundColor = [UIColor colorWithRed:246/255.f green:246/255.f blue:246/255.f alpha:1.0f];
    _Merchantpaytableview = tableView;
    _Merchantpaytableview.delegate = self;
    _Merchantpaytableview.dataSource = self;
    self.automaticallyAdjustsScrollViewInsets=NO;
    _Merchantpaytableview.separatorStyle = NO;
    _Merchantpaytableview.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_Merchantpaytableview];
    
    UIView *vv = [[UIView alloc]initWithFrame:CGRectMake(0, QWScreenheight - 60*myDelegate.autoSizeScaleY, QWScreenWidth, 60*myDelegate.autoSizeScaleY)];
    vv.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:vv];
    
    UILabel *label33 = [[UILabel alloc]initWithFrame:CGRectMake1(15, 10, 200, 40)];
    label33.text = @"￥54.00";
    label33.textColor = [UIColor colorWithHexString:@"#ff525a"];
    label33.font = [UIFont systemFontOfSize:18*myDelegate.autoSizeScaleX];
    [vv addSubview:label33];
    
    
    
    
    
    UIButton *zf = [UIButton buttonWithType:UIButtonTypeSystem];
    [zf setTitle:@"立即支付" forState:UIControlStateNormal];
    zf.titleLabel.font = [UIFont systemFontOfSize: 16*myDelegate.autoSizeScaleX];
    [zf addTarget:self action:@selector(lijizhifu) forControlEvents:UIControlEventTouchUpInside];
    zf.frame = CGRectMake(QWScreenWidth - 136*myDelegate.autoSizeScaleX, 0,136*myDelegate.autoSizeScaleX, 60*myDelegate.autoSizeScaleY);
    
    [vv addSubview:zf];
    zf.tintColor = [UIColor whiteColor];
    zf.backgroundColor = [UIColor colorWithHexString:@"#ff800a"];
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

-(void)lijizhifu
{
    if(tag == 501)
    {
        UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:nil message:@"你点击了支付宝支付" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
        [alertview show];
    }
    else if(tag == 502)
    {
        UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:nil message:@"你点击了微信支付" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
        [alertview show];
    }
    else
    {
        UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:nil message:@"请选择支付方式" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
        [alertview show];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0)
    {
        return 3;
    }else
    {
        return 2;
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(section == 2)
    {
        return 40*(myDelegate.autoSizeScaleY );
    }
    else if(section == 1)
    {
        return 10*(myDelegate.autoSizeScaleY );
    }
    else
    {
        return 0;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 40*(myDelegate.autoSizeScaleY );
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if(section == 2)
    {
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake1(0, 0, 375, 40)];//创建一个视图
        UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake1(15, 5, 150, 20)];
        headerLabel.font = [UIFont systemFontOfSize:12.0];
        headerLabel.textColor = [UIColor colorWithRed:100/255.f green:100/255.f blue:100/255.f alpha:1.0f];
        headerLabel.text = @"选择支付方式";
        [headerView addSubview:headerLabel];
        CGSize labelSize = [headerLabel.text sizeWithFont:[UIFont systemFontOfSize:12.0] constrainedToSize:CGSizeMake(200, MAXFLOAT) lineBreakMode:NSLineBreakByCharWrapping];
        headerLabel.frame = CGRectMake(15* myDelegate.autoSizeScaleX, 40 * myDelegate.autoSizeScaleY/2-labelSize.height/2, 200, labelSize.height);
        
        return headerView;
    }
    else
    {
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake1(0, 0, 320, 0)];//创建一个视图
        
        
        return headerView;
    }
    
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && indexPath.row == 0)
    {
        static NSString *CellIdentifier = @"cell0";//可复用单元格标识
        [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellIdentifier];
        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        
        else
        {
            //删除cell的所有子视图
            while ([cell.contentView.subviews lastObject] != nil)
            {
                [(UIView*)[cell.contentView.subviews lastObject] removeFromSuperview];
            }
        }

        
        UILabel *label5 = [[UILabel alloc]initWithFrame:CGRectMake1(15, 10, 100, 20)];
        label5.text = @"服务商家";
        label5.font = [UIFont fontWithName:@"Helvetica" size:15 * (myDelegate.autoSizeScaleX)];
        [cell.contentView addSubview:label5];
        
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake1(170, 10, 190, 20)];
        label.textAlignment = NSTextAlignmentRight;
        label.text = @"上海金霞快修店";
        label.textColor = [UIColor colorWithHexString:@"#999999"];
        label.font = [UIFont fontWithName:@"Helvetica" size:14 * (myDelegate.autoSizeScaleX)];
        [cell.contentView addSubview:label];
        
        cell.selectionStyle  = UITableViewCellSelectionStyleNone;
        return cell;
        
    }
    if (indexPath.section == 0 && indexPath.row == 1)
    {
        static NSString *CellIdentifier = @"cell0";//可复用单元格标识
        [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellIdentifier];
        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        
        else
        {
            //删除cell的所有子视图
            while ([cell.contentView.subviews lastObject] != nil)
            {
                [(UIView*)[cell.contentView.subviews lastObject] removeFromSuperview];
            }
        }

        
        UILabel *label5 = [[UILabel alloc]initWithFrame:CGRectMake1(15, 10, 100, 20)];
        label5.text = @"服务项目";
        label5.font = [UIFont fontWithName:@"Helvetica" size:15 * (myDelegate.autoSizeScaleX)];
        [cell.contentView addSubview:label5];
        
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake1(170, 10, 190, 20)];
        label.textAlignment = NSTextAlignmentRight;
        label.text = @"标准洗车-五座轿车";
        label.textColor = [UIColor colorWithHexString:@"#999999"];
        label.font = [UIFont fontWithName:@"Helvetica" size:14 * (myDelegate.autoSizeScaleX)];
        [cell.contentView addSubview:label];
        
        cell.selectionStyle  = UITableViewCellSelectionStyleNone;
        return cell;
        
    }
    if (indexPath.section == 0 && indexPath.row == 2)
    {
        static NSString *CellIdentifier = @"cell0";//可复用单元格标识
        [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellIdentifier];
        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        
        else
        {
            //删除cell的所有子视图
            while ([cell.contentView.subviews lastObject] != nil)
            {
                [(UIView*)[cell.contentView.subviews lastObject] removeFromSuperview];
            }
        }

        
        UILabel *label5 = [[UILabel alloc]initWithFrame:CGRectMake1(15, 10, 100, 20)];
        label5.text = @"订单金额";
        label5.font = [UIFont fontWithName:@"Helvetica" size:15 * (myDelegate.autoSizeScaleX)];
        [cell.contentView addSubview:label5];
        
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake1(170, 10, 190, 20)];
        label.textAlignment = NSTextAlignmentRight;
        label.text = @"￥18.00";
        label.textColor = [UIColor colorWithHexString:@"#ff3645"];
        label.font = [UIFont fontWithName:@"Helvetica" size:14 * (myDelegate.autoSizeScaleX)];
        [cell.contentView addSubview:label];
        
        cell.selectionStyle  = UITableViewCellSelectionStyleNone;
        return cell;
        
    }
    else if (indexPath.section == 2 && indexPath.row == 0)
    {
        static NSString *CellIdentifier = @"cell11";//可复用单元格标识
        [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellIdentifier];
        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        
        else
        {
            //删除cell的所有子视图
            while ([cell.contentView.subviews lastObject] != nil)
            {
                [(UIView*)[cell.contentView.subviews lastObject] removeFromSuperview];
            }
        }
        UILabel *label5 = [[UILabel alloc]initWithFrame:CGRectMake1(50, 10, 100, 20)];
        label5.text = @"支付宝支付";
        label5.font = [UIFont fontWithName:@"Helvetica" size:15 * (myDelegate.autoSizeScaleX)];
        [cell.contentView addSubview:label5];
        
        UIImageView *leftImg = [[UIImageView alloc]init];
        leftImg.frame=CGRectMake1(15,10 ,20 , 20);
        leftImg.image = [UIImage imageNamed:@"zhifubao"];
        [cell.contentView addSubview:leftImg];
        
        qiandao = [UIButton buttonWithType:UIButtonTypeSystem];
        [qiandao setBackgroundImage:[UIImage imageNamed:@"xfjlweixuanzhong"] forState:UIControlStateNormal];
        qiandao.tag = 501;
        [qiandao addTarget:self action:@selector(choose:) forControlEvents:UIControlEventTouchUpInside];
        qiandao.frame = CGRectMake1(287.5+55,11.25 ,17.5 , 17.5);
        
        
        
        //        UIButton * qiandao = [[UIButton alloc] initWithFrame:CGRectMake1(287.5,11.25 ,17.5 , 17.5)];
        //        qiandao.imageView.frame = qiandao.bounds;
        //        qiandao.hidden = NO;
        //        qiandao.imageView.image = [UIImage imageNamed:@"radio_btn_off"];
        [cell.contentView addSubview:qiandao];
        cell.selectionStyle  = UITableViewCellSelectionStyleNone;
        return cell;
        
    }
    else if (indexPath.section == 2 && indexPath.row == 1)
    {
        static NSString *CellIdentifier = @"cell1";//可复用单元格标识
        [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellIdentifier];
        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        
        else
        {
            //删除cell的所有子视图
            while ([cell.contentView.subviews lastObject] != nil)
            {
                [(UIView*)[cell.contentView.subviews lastObject] removeFromSuperview];
            }
        }
        UILabel *label5 = [[UILabel alloc]initWithFrame:CGRectMake1(50, 10, 100, 20)];
        label5.text = @"微信支付";
        label5.font = [UIFont fontWithName:@"Helvetica" size:15 * (myDelegate.autoSizeScaleX)];
        [cell.contentView addSubview:label5];
        
        UIImageView *leftImg = [[UIImageView alloc]init];
        leftImg.frame=CGRectMake1(15,10 ,20 , 20);
        leftImg.image = [UIImage imageNamed:@"weixin"];
        [cell.contentView addSubview:leftImg];
        
        qiandao1 = [UIButton buttonWithType:UIButtonTypeSystem];
        [qiandao1 setBackgroundImage:[UIImage imageNamed:@"xfjlweixuanzhong"] forState:UIControlStateNormal];
        qiandao1.tag = 502;
        [qiandao1 addTarget:self action:@selector(choose:) forControlEvents:UIControlEventTouchUpInside];
        qiandao1.frame = CGRectMake1(287.5+55,11.25 ,17.5 , 17.5);
        [cell.contentView addSubview:qiandao1];
        UIView * separator = [[UIView alloc] initWithFrame:CGRectMake(15 * (myDelegate.autoSizeScaleX), 0, 365 * (myDelegate.autoSizeScaleX), 0.5)];
        separator.backgroundColor = [UIColor colorWithRed:230/255.f green:230/255.f blue:230/255.f alpha:1];
        cell.selectionStyle  = UITableViewCellSelectionStyleNone;
        [cell addSubview:separator];
        
        return cell;
        
    }
    
    
    
    else if(indexPath.section == 1 && indexPath.row == 0)
    {
        static NSString *CellIdentifier = @"cell2";//可复用单元格标识
        [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellIdentifier];
        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        
        else
        {
            //删除cell的所有子视图
            while ([cell.contentView.subviews lastObject] != nil)
            {
                [(UIView*)[cell.contentView.subviews lastObject] removeFromSuperview];
            }
        }
        
        UILabel *label5 = [[UILabel alloc]initWithFrame:CGRectMake1(15, 10, 100, 20)];
        label5.text = @"特惠活动";
        label5.font = [UIFont fontWithName:@"Helvetica" size:15 * (myDelegate.autoSizeScaleX)];
        [cell.contentView addSubview:label5];
        

        
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake1(170, 10, 190, 20)];
        label.textAlignment = NSTextAlignmentRight;
        label.text = @"立减5元";
        label.textColor = [UIColor colorWithHexString:@"#ff3645"];
        label.font = [UIFont fontWithName:@"Helvetica" size:14 * (myDelegate.autoSizeScaleX)];
        [cell.contentView addSubview:label];
        
        
        
        
        cell.selectionStyle  = UITableViewCellSelectionStyleNone;
        
        return cell;
        
    }
    
    else
    {
        static NSString *CellIdentifier = @"cell3";//可复用单元格标识
        [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellIdentifier];
        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        
        else
        {
            //删除cell的所有子视图
            while ([cell.contentView.subviews lastObject] != nil)
            {
                [(UIView*)[cell.contentView.subviews lastObject] removeFromSuperview];
            }
        }
        UILabel *label5 = [[UILabel alloc]initWithFrame:CGRectMake1(15, 10, 100, 20)];
        label5.text = @"实付";
        label5.font = [UIFont fontWithName:@"Helvetica" size:15 * (myDelegate.autoSizeScaleX)];
        [cell.contentView addSubview:label5];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake1(170, 10, 190, 20)];
        label.textAlignment = NSTextAlignmentRight;
        label.text = @"￥18.00";
        label.textColor = [UIColor colorWithHexString:@"#ff3645"];
        label.font = [UIFont fontWithName:@"Helvetica" size:14 * (myDelegate.autoSizeScaleX)];
        [cell.contentView addSubview:label];
        
        UIView * separator = [[UIView alloc] initWithFrame:CGRectMake(15 * (myDelegate.autoSizeScaleX), 0, 365 * (myDelegate.autoSizeScaleX), 0.5)];
        separator.backgroundColor = [UIColor colorWithRed:230/255.f green:230/255.f blue:230/255.f alpha:1];
        cell.selectionStyle  = UITableViewCellSelectionStyleNone;
        [cell addSubview:separator];
        
        cell.selectionStyle  = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
    
    
}

-(void)choose:(UIButton *)b
{
    if(b.tag == 501)
    {
        [qiandao setBackgroundImage:[UIImage imageNamed:@"xfjlxaunzhong"] forState:UIControlStateNormal];
        [qiandao1 setBackgroundImage:[UIImage imageNamed:@"xfjlweixuanzhong"] forState:UIControlStateNormal];
        tag = (int)b.tag;
    }
    else
    {
        [qiandao1 setBackgroundImage:[UIImage imageNamed:@"xfjlxaunzhong"] forState:UIControlStateNormal];
        [qiandao setBackgroundImage:[UIImage imageNamed:@"xfjlweixuanzhong"] forState:UIControlStateNormal];
        tag = (int)b.tag;
    }
    
    
}

CG_INLINE CGRect//注意：这里的代码要放在.m文件最下面的位置
CGRectMake1(CGFloat x, CGFloat y, CGFloat width, CGFloat height)
{
    AppDelegate *myDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    CGRect rect;
    rect.origin.x = x * myDelegate.autoSizeScaleX;
    rect.origin.y = y * myDelegate.autoSizeScaleY;
    rect.size.width = width * myDelegate.autoSizeScaleX;
    rect.size.height = height * myDelegate.autoSizeScaleY;
    return rect;
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
