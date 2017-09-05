//
//  QWMerchantDetailViewController.m
//  QWCarWashing
//
//  Created by apple on 2017/8/15.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "QWMerchantDetailViewController.h"
#import "QWMcDeatailTableViewCell.h"
#import "QWDetailAddressTableViewCell.h"
#import "QWMcServiceTableViewCell.h"
#import "QWMccommentTableViewCell.h"
#import "QWPayViewController.h"
#import "QWAboutStoreViewController.h"

#import "TYAlertController.h"
#import "ShareView.h"
#import "UIView+TYAlertView.h"
#import "TYAlertController+BlurEffects.h"

#import "ShopViewController.h"
#import "QWMerchantModel.h"

#import "JXMapNavigationView.h"


@interface QWMerchantDetailViewController ()<UITableViewDelegate, UITableViewDataSource,UIScrollViewDelegate,CellDelegate, SkipToNaviDelegate>
{
    AppDelegate *myDelegate;
    int collecttag;
    enum WXScene scene;

}

@property (nonatomic, strong) HYActivityView *activityView;


@property (nonatomic, weak) UITableView *McdetailTableView;
@property (nonatomic, strong) UIImageView *detaiImgView;
@property (nonatomic, strong) UIView *detaiview;

@property(nonatomic,strong)NSIndexPath *lastPath;
@property(nonatomic,strong)NSMutableArray *MerchantDetailData;
@property(nonatomic,strong)QWMerchantModel *MerChantmodel;

#pragma mark - map
@property (nonatomic, strong)JXMapNavigationView *mapNavigationView;
@end

@implementation QWMerchantDetailViewController

- (JXMapNavigationView *)mapNavigationView{
    if (_mapNavigationView == nil) {
        _mapNavigationView = [[JXMapNavigationView alloc]init];
    }
    return _mapNavigationView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"商家详情";
    
    myDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    collecttag=0;
    
    NSLog(@"===%@",self.MerCode);
    
    if (!IsNullIsNull(self.MerCode)) {
        [self requestMerchantDetailDataAndMerCode:self.MerCode];
    }else{
        [self setupview];
    }
    
//
    
    
    
    
    
}

#pragma mark-获取商家详情数据
-(void)requestMerchantDetailDataAndMerCode:(NSString *)mercodestr{
  
        [self.MerchantDetailData removeAllObjects];
        
        NSDictionary *mulDic = @{
                                 @"MerCode":mercodestr,
                                 @"Account_Id":[UdStorage getObjectforKey:Userid],
                                 };
    
        [AFNetworkingTool post:mulDic andurl:[NSString stringWithFormat:@"%@MerChant/GetStoreDetail",Khttp] success:^(NSDictionary *dict, BOOL success) {
            
            if([[dict objectForKey:@"ResultCode"] isEqualToString:[NSString stringWithFormat:@"%@",@"F000000"]])
            {
                NSLog(@"===%@==",dict);
                self.MerChantmodel=[[QWMerchantModel alloc]initWithDictionary:[dict objectForKey:@"JsonData"] error:nil];
               
                [self setupview];
            }
            else
            {
                [self.view showInfo:@"商家信息获取失败" autoHidden:YES interval:2];
                [self.navigationController popViewControllerAnimated:YES];
            }
            
            
            
            
        } fail:^(NSError *error) {
            [self.view showInfo:@"获取失败" autoHidden:YES interval:2];
        }];
    

}
-(void)setupview
{
    UIButton *leftButton = [[UIButton alloc]initWithFrame:CGRectMake(0,0,20,20)];
    [leftButton setImage:[UIImage imageNamed:@"baisefanhui"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem= leftItem;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"fenxiang-1"] scaledToSize:CGSizeMake(25, 25)] style:(UIBarButtonItemStyleDone) target:self action:@selector(downloadOnclick:)];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, QWScreenWidth, QWScreenheight - 20*myDelegate.autoSizeScaleY)];
    tableView.backgroundColor = [UIColor colorWithRed:246/255.f green:246/255.f blue:246/255.f alpha:1.0f];
    _McdetailTableView = tableView;
    _McdetailTableView.delegate = self;
    _McdetailTableView.dataSource = self;
    self.automaticallyAdjustsScrollViewInsets=NO;
    _McdetailTableView.separatorStyle = NO;
    _McdetailTableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_McdetailTableView];
    
    _detaiview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, QWScreenWidth, QWScreenWidth/2)];
    _detaiImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, QWScreenWidth, QWScreenWidth/2)];
    _detaiImgView.image = [UIImage imageNamed:@"shangjiadiantu"];
    if (!IsNullIsNull(self.MerChantmodel.Img)) {
        NSString *ImageURL=[NSString stringWithFormat:@"%@%@",kHTTPImg,self.MerChantmodel.Img];
        [_detaiImgView sd_setImageWithURL:[NSURL URLWithString:ImageURL] placeholderImage:[UIImage imageNamed:@"shangjiadingwei"]];
    }
    
    [_detaiview addSubview:_detaiImgView];
    
    _McdetailTableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake1(0, 0, QWScreenWidth, QWScreenWidth/2)];
    _McdetailTableView.tableHeaderView = _detaiview;
    
    UIView *vv = [[UIView alloc]initWithFrame:CGRectMake(0, QWScreenheight - 60*myDelegate.autoSizeScaleY, QWScreenWidth, 60*myDelegate.autoSizeScaleY)];
    vv.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:vv];
    
    UIButton *jiesuan = [UIButton buttonWithType:UIButtonTypeSystem];
    [jiesuan setTitle:@"去结算" forState:UIControlStateNormal];
    jiesuan.titleLabel.font = [UIFont systemFontOfSize: 16*myDelegate.autoSizeScaleX];
    [jiesuan addTarget:self action:@selector(nextjiesuan:) forControlEvents:UIControlEventTouchUpInside];
    jiesuan.frame = CGRectMake(QWScreenWidth - 92*myDelegate.autoSizeScaleX, 0,92*myDelegate.autoSizeScaleX, 60*myDelegate.autoSizeScaleY);
    
    [vv addSubview:jiesuan];
    jiesuan.tintColor = [UIColor whiteColor];
    jiesuan.backgroundColor = [UIColor colorWithHexString:@"#ff800a"];
    
    UILabel *lblPrice = [[UILabel alloc] initWithFrame:CGRectMake1(12, 14, 60, 15)];
    lblPrice.text = @"¥24.00";
    lblPrice.font = [UIFont systemFontOfSize:18*myDelegate.autoSizeScaleX];
    lblPrice.textColor = [UIColor colorWithHexString:@"#ff525a"];
    [vv addSubview:lblPrice];
    
    UILabel *formerPriceLab = [[UILabel alloc] initWithFrame:CGRectMake1(80, 19, 60, 10)];
    formerPriceLab.text = @"¥38.00";
    formerPriceLab.textColor = [UIColor colorWithHexString:@"#999999"];
    formerPriceLab.font = [UIFont systemFontOfSize:13*myDelegate.autoSizeScaleX];
    [vv addSubview:formerPriceLab];
    NSString *textStr = formerPriceLab.text;
    NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:textStr attributes:attribtDic];
    formerPriceLab.attributedText = attribtStr;

    
    UILabel *lblCarType = [[UILabel alloc] initWithFrame:CGRectMake1(12, 37, 200, 10)];
    lblCarType.text = @"标准洗车-五座轿车";
    lblCarType.font = [UIFont systemFontOfSize:13*myDelegate.autoSizeScaleX];
    lblCarType.textColor = [UIColor colorWithHexString:@"#999999"];
    [vv addSubview:lblCarType];
    
    UIButton *serviceBtn = [[UIButton alloc] initWithFrame:CGRectMake1(225, 13, 20, 20)];
    [serviceBtn setImage:[UIImage imageNamed:@"djjdianhua"] forState:UIControlStateNormal];
    [serviceBtn addTarget:self action:@selector(didClickServiceBtn:) forControlEvents:UIControlEventTouchUpInside];
    [vv addSubview:serviceBtn];
    
    UILabel *serviceLabel = [[UILabel alloc] initWithFrame:CGRectMake1(200, 37, 70, 20)];
    serviceLabel.text = @"客服咨询";
    serviceLabel.textAlignment = NSTextAlignmentCenter;
    serviceLabel.font = [UIFont systemFontOfSize:13*myDelegate.autoSizeScaleX];
    serviceLabel.textColor = [UIColor colorWithHexString:@"#999999"];
    [vv addSubview:serviceLabel];

}

//滚动tableview 完毕之后
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    //图片高度
    CGFloat imageHeight = _detaiview.frame.size.height;
    //图片宽度
    CGFloat imageWidth = QWScreenWidth;
    //图片上下偏移量
    CGFloat imageOffsetY = scrollView.contentOffset.y;
//    NSLog(@"图片上下偏移量 imageOffsetY:%f ->",imageOffsetY);
    //上移
    if (imageOffsetY < 0) {
        
        CGFloat totalOffset = imageHeight + ABS(imageOffsetY);
        CGFloat f = totalOffset / imageHeight;
        
        _detaiImgView.frame = CGRectMake(-(imageWidth * f - imageWidth) * 0.5, imageOffsetY, imageWidth * f, totalOffset);
    }
    
    //    //下移
    if (imageOffsetY >= _detaiview.frame.size.height - 64)
    {
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"ijanbiantiao"] forBarMetrics:0];
    }
    else
    {
        [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    }
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 4;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0)
    {
        return 1;
    }else if(section == 1)
    {
        return 1;
        
    }
    else if(section == 2)
    {
        if (self.MerChantmodel.MerSerList.count==0) {
            return 4;
        }else{
        return self.MerChantmodel.MerSerList.count;
        }
    }
    else
    {
        if (self.MerChantmodel.MerSerList.count==0) {
            return 3;
        }else{
            return self.MerChantmodel.MerComList.count;
        }
        
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0 && indexPath.row == 0)
    {
        return 110*(myDelegate.autoSizeScaleY );
    }
    else if(indexPath.section == 1)
    {
        return 80*(myDelegate.autoSizeScaleY );
    }
    else if(indexPath.section == 2)
    {
        return 90*(myDelegate.autoSizeScaleY );
    }
    else
        return 105*(myDelegate.autoSizeScaleY );
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(section == 2)
    {
        return 27.5*(myDelegate.autoSizeScaleY);
    }
    else if(section == 3)
    {
        return 37*(myDelegate.autoSizeScaleY );
    }
    else
        return 0;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if(section == 2)
    {
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake1(0, 0, 375, 27.5)];
        headerView.backgroundColor = [UIColor whiteColor];
        UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake1(15, 5, 150, 20)];
        headerLabel.font = [UIFont systemFontOfSize:14 * myDelegate.autoSizeScaleX];
        headerLabel.textColor = [UIColor colorWithRed:100/255.f green:100/255.f blue:100/255.f alpha:1.0f];
        headerLabel.text = @"消费记录";
        [headerView addSubview:headerLabel];
        CGSize labelSize = [headerLabel.text sizeWithFont:[UIFont systemFontOfSize:14 * myDelegate.autoSizeScaleX] constrainedToSize:CGSizeMake(200, MAXFLOAT) lineBreakMode:NSLineBreakByCharWrapping];
        headerLabel.frame = CGRectMake(15* myDelegate.autoSizeScaleX, 27.5 * myDelegate.autoSizeScaleY/2-labelSize.height/2, 200, labelSize.height);
        
        UIView * separator = [[UIView alloc] initWithFrame:CGRectMake(0, 27, QWScreenWidth, 0.5)];
        separator.backgroundColor = [UIColor colorWithRed:230/255.f green:230/255.f blue:230/255.f alpha:1];
        [headerView addSubview:separator];
        
        return headerView;
    }
    else if(section == 3)
    {
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake1(0, 0, 375, 37)];
        headerView.backgroundColor = [UIColor whiteColor];
        UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake1(15, 5, 150, 20)];
        headerLabel.font = [UIFont systemFontOfSize:14 * myDelegate.autoSizeScaleX];
        headerLabel.textColor = [UIColor colorWithRed:100/255.f green:100/255.f blue:100/255.f alpha:1.0f];
        headerLabel.text = @"评论（58）";
        [headerView addSubview:headerLabel];
        CGSize labelSize = [headerLabel.text sizeWithFont:[UIFont systemFontOfSize:14 * myDelegate.autoSizeScaleX] constrainedToSize:CGSizeMake(200, MAXFLOAT) lineBreakMode:NSLineBreakByCharWrapping];
        headerLabel.frame = CGRectMake(15* myDelegate.autoSizeScaleX, 37 * myDelegate.autoSizeScaleY/2-labelSize.height/2, 200, labelSize.height);
        
        UIView * separator = [[UIView alloc] initWithFrame:CGRectMake(0, 36.5, QWScreenWidth, 0.5)];
        separator.backgroundColor = [UIColor whiteColor];
        [headerView addSubview:separator];
        
        return headerView;
        
        
    }
    else
    {
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake1(0, 0, QWScreenWidth, 0)];//创建一个视图
        
        headerView.backgroundColor=[UIColor greenColor];
        return headerView;
    }
    
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    UIView *footerview=[UIView new];
    footerview.backgroundColor=[UIColor clearColor];
   
    return footerview;

}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;

}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 1)
    {
        static NSString *CellIdentifier=@"Cell";
        [tableView registerClass:[QWDetailAddressTableViewCell class] forCellReuseIdentifier:CellIdentifier];
        QWDetailAddressTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        cell.delegate = self;
        
        if (cell == nil)
        {
            cell = [[QWDetailAddressTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        
        
        [tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
        
       
        [cell setBackgroundColor:[UIColor whiteColor]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSLog(@"%@",self.MerChantmodel);
        if (self.MerChantmodel!=nil) {
            cell.merchantModel=self.MerChantmodel;
        }
        
        return cell;
    }
    else if(indexPath.section == 0)
    {
        static NSString *CellIdentifier=@"Cell0";
        [tableView registerClass:[QWMcDeatailTableViewCell class] forCellReuseIdentifier:CellIdentifier];
        QWMcDeatailTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        
        if (cell == nil)
        {
            cell = [[QWMcDeatailTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        

        if (self.MerChantmodel!=nil) {
            cell.Merchantmodels=self.MerChantmodel;
        }
        
        cell.McImagedanhaoView.userInteractionEnabled = YES;
        //[cell.McImagedanhaoView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clicktiaozhuan:)]];
        [cell.areaBtn addTarget:self action:@selector(clicktiaozhuan:) forControlEvents:UIControlEventTouchUpInside];
        [cell.callbtn addTarget:self action:@selector(didClickServiceBtn:) forControlEvents:UIControlEventTouchUpInside];
//        cell.collectbtn.selected=self.MerChantmodel.IsCollection== 1?YES:NO;
        [cell.collectbtn addTarget:self action:@selector(didClickcollectBtn:) forControlEvents:UIControlEventTouchUpInside];
        cell.collectbtn.tag = indexPath.row;
//        [cell setlayoutCell];
//        cell.collectbtn = !cell.collectbtn;
        //    NSDictionary *dic=[newslist objectAtIndex:indexPath.row];
        //    [cell setUpCellWithDic:dic];
        [cell setBackgroundColor:[UIColor whiteColor]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }
    else if(indexPath.section == 2)
    {
        static NSString *CellIdentifier=@"Cell5";
        [tableView registerClass:[QWMcServiceTableViewCell class] forCellReuseIdentifier:CellIdentifier];
        QWMcServiceTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        
        if (cell == nil)
        {
            cell = [[QWMcServiceTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        
        [cell.selectbtn addTarget:self action:@selector(didClickwhichservice:) forControlEvents:UIControlEventTouchUpInside];
        
        cell.delegate = self;
        cell.selectedIndexPath = indexPath;
        [cell.selectbtn setImage:[UIImage imageNamed:@"xfjlweixuanzhong"] forState:UIControlStateNormal];
   
        
        //当上下拉动的时候，因为cell的复用性，我们需要重新判断一下哪一行是打勾的
        if (_lastPath == indexPath) {
//            cell.accessoryType = UITableViewCellAccessoryCheckmark;
            [cell.selectbtn setImage:[UIImage imageNamed:@"xfjlxaunzhong"] forState:UIControlStateNormal];
            
        }else {
            [cell.selectbtn setImage:[UIImage imageNamed:@"xfjlweixuanzhong"] forState:UIControlStateNormal];
            
        }

        
        [cell setBackgroundColor:[UIColor whiteColor]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIView *separatorview = [[UIView alloc]initWithFrame:CGRectMake(0, 89* myDelegate.autoSizeScaleY,QWScreenWidth,1)];
        separatorview.backgroundColor = [UIColor whiteColor];
        [cell.contentView addSubview:separatorview];
        if (self.MerChantmodel!=nil) {

            QWMerSerListModel *serlistmodel=[[QWMerSerListModel alloc]initWithDictionary:(NSDictionary *)self.MerChantmodel.MerSerList[indexPath.row] error:nil];
            cell.MerSerList=serlistmodel;

        }
        
        
        return cell;
    }
    else
    {
        
        if(indexPath.row<1)
        {
            static NSString *CellIdentifier=@"Cell4";
            [tableView registerClass:[QWMccommentTableViewCell class] forCellReuseIdentifier:CellIdentifier];
            QWMccommentTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
            
            if (cell == nil)
            {
                cell = [[QWMccommentTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            }

            [cell setBackgroundColor:[UIColor whiteColor]];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            UIView *separatorview = [[UIView alloc]initWithFrame:CGRectMake(0, 104 * myDelegate.autoSizeScaleY,QWScreenWidth,1)];
            separatorview.backgroundColor = [UIColor colorWithRed:230/255.f green:230/255.f blue:230/255.f alpha:1.0f];
            [cell.contentView addSubview:separatorview];
            if (self.MerChantmodel==nil) {
                cell.ComList=self.MerChantmodel.MerComList[indexPath.row];
            }
            
            return cell;
            

        }
        else
        
        {
            NSString *CellIdentifier=@"Cell9";
            [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellIdentifier];
            UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
            
            [tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];

            [cell setBackgroundColor:[UIColor clearColor]];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            UIView *separatorview = [[UIView alloc]initWithFrame:CGRectMake(0, 50* myDelegate.autoSizeScaleY,QWScreenWidth,1)];
            separatorview.backgroundColor = [UIColor colorWithRed:230/255.f green:230/255.f blue:230/255.f alpha:1.0f];
            [cell.contentView addSubview:separatorview];
            
            UIView *Deseparatorview = [[UIView alloc]initWithFrame:CGRectMake(0, 50* myDelegate.autoSizeScaleY + 1,QWScreenWidth,cell.contentView.height - 50* myDelegate.autoSizeScaleY -  1)];
            Deseparatorview.backgroundColor = [UIColor colorWithRed:246/255.f green:246/255.f blue:246/255.f alpha:1.0f];
            [cell.contentView addSubview:Deseparatorview];
            
            UIButton *commentBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, QWScreenWidth, 50 * myDelegate.autoSizeScaleY)];
            [commentBtn setTitle:@"查看全部评价（128）" forState:UIControlStateNormal];
            [commentBtn setTitleColor:[UIColor colorWithHexString:@"#3a3a3a"] forState:UIControlStateNormal];
            commentBtn.titleLabel.font = [UIFont systemFontOfSize:14 * myDelegate.autoSizeScaleY];
            commentBtn.backgroundColor = [UIColor whiteColor];
            [cell.contentView addSubview:commentBtn];
            //添加点击事件
            [commentBtn addTarget:self action:@selector(clickCommentButton) forControlEvents:UIControlEventTouchUpInside];
            return cell;
        
        }
        
    }
}
#pragma mark-添加收藏数据
-(void)insertCollectionAndUserid:(NSString *)Useridstr andMerCode:(NSString *)MerCodestr{
    NSDictionary *mulDic = @{
                             @"MerCode":self.MerCode,
                             @"Account_Id":[UdStorage getObjectforKey:@"Account_Id"],
                             };
    NSLog(@"%@",mulDic);
    [AFNetworkingTool post:mulDic andurl:[NSString stringWithFormat:@"%@MerChant/AddFavouriteMerchant",Khttp] success:^(NSDictionary *dict, BOOL success) {
        NSLog(@"%@",dict);
        if([[dict objectForKey:@"ResultCode"] isEqualToString:[NSString stringWithFormat:@"%@",@"F000000"]])
        {
            
//            [self.McdetailTableView reloadData];
//           [self.view showInfo:@"收藏成功" autoHidden:YES interval:1];
        }
        else
        {
            //                [self.view showInfo:@"收藏失败" autoHidden:YES interval:2];
            //                [self.navigationController popViewControllerAnimated:YES];
        }
        
        
        
        
    } fail:^(NSError *error) {
        [self.view showInfo:@"收藏失败" autoHidden:YES interval:1];
    }];

}
#pragma mark - 点击查看全部评价
- (void)clickCommentButton {
    
    ShopViewController *commentVC = [[ShopViewController alloc] init];
    
    commentVC.merchantModel = self.MerChantmodel;
    
    [self.navigationController pushViewController:commentVC animated:YES];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 2)
    {
        //之前选中的，取消选择
        QWMcServiceTableViewCell *celled = [tableView cellForRowAtIndexPath:_lastPath];
        celled.accessoryType = UITableViewCellAccessoryNone;
        [celled.selectbtn setImage:[UIImage imageNamed:@"xfjlweixuanzhong"] forState:UIControlStateNormal];
        celled.delegate = self;
        celled.selectedIndexPath = indexPath;
        //记录当前选中的位置索引
        _lastPath = indexPath;
        //当前选择的打勾
        QWMcServiceTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        //    cell.accessoryType = UITableViewCellAccessoryCheckmark;
        [cell.selectbtn setImage:[UIImage imageNamed:@"xfjlxaunzhong"] forState:UIControlStateNormal];
    }
    
}

- (void)ButtonDidSelected:(NSIndexPath *)selectedIndexPath {
    QWMcServiceTableViewCell *celled = [_McdetailTableView cellForRowAtIndexPath:_lastPath];
    celled.accessoryType = UITableViewCellAccessoryNone;
    [celled.selectbtn setImage:[UIImage imageNamed:@"xfjlweixuanzhong"] forState:UIControlStateNormal];
    celled.delegate = self;
   
    //记录当前选中的位置索引
    _lastPath = selectedIndexPath;
    //当前选择的打勾
    QWMcServiceTableViewCell *cell = [_McdetailTableView cellForRowAtIndexPath:selectedIndexPath];
//    cell.accessoryType = UITableViewCellAccessoryCheckmark;
    [cell.selectbtn setImage:[UIImage imageNamed:@"xfjlxaunzhong"] forState:UIControlStateNormal];
}

-(void)viewWillAppear:(BOOL)animated
{
    //设置导航栏背景图片为一个空的image，这样就透明了
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:2];
    self.lastPath = indexPath;
        [self.McdetailTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:2] animated:YES scrollPosition:UITableViewScrollPositionNone];
        if ([_McdetailTableView.delegate respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)]) {
            [_McdetailTableView.delegate tableView:_McdetailTableView didSelectRowAtIndexPath:indexPath];
        }
    //去掉透明后导航栏下边的黑边
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];

}

- (void)viewWillDisappear:(BOOL)animated{
    
//    //    如果不想让其他页面的导航栏变为透明 需要重置
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"ijanbiantiao"] forBarMetrics:0];
//    [self.navigationController.navigationBar setShadowImage:nil];
}

-(void)back
{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"ijanbiantiao"] forBarMetrics:0];
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)downloadOnclick:(UIButton *)download
{

//    ShareView *shareView = [ShareView createViewFromNib];
//    TYAlertController *alertController = [TYAlertController alertControllerWithAlertView:shareView preferredStyle:TYAlertControllerStyleAlert];
//    
//    [alertController setBlurEffectWithView:self.view];
//    alertController.alertView.width     = Main_Screen_Width;
//    alertController.alertView.height    = Main_Screen_Height*230/667;
//    //    if (Main_Screen_Height == 568) {
//    alertController.alertViewOriginY    = self.view.height- alertController.alertView.height;
//    [self presentViewController:alertController animated:YES completion:nil];
    
    if (!self.activityView) {
        self.activityView = [[HYActivityView alloc]initWithTitle:@"" referView:self.view];
        
        //横屏会变成一行6个, 竖屏无法一行同时显示6个, 会自动使用默认一行4个的设置.
        self.activityView.numberOfButtonPerLine = 6;
        
        ButtonView *bv ;
        
        bv = [[ButtonView alloc]initWithText:@"微信" image:[UIImage imageNamed:@"btn_share_weixin"] handler:^(ButtonView *buttonView){
            NSLog(@"点击微信");
            SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
            req.text                = @"简单文本分享测试";
            req.bText               = YES;
            // 目标场景
            // 发送到聊天界面  WXSceneSession
            // 发送到朋友圈    WXSceneTimeline
            // 发送到微信收藏  WXSceneFavorite
            req.scene               = WXSceneSession;
            [WXApi sendReq:req];
            
        }];
        [self.activityView addButtonView:bv];
        
        bv = [[ButtonView alloc]initWithText:@"微信朋友圈" image:[UIImage imageNamed:@"btn_share_pengyouquan"] handler:^(ButtonView *buttonView){
            NSLog(@"点击微信朋友圈");
            SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
            req.text                = @"简单文本分享测试";
            req.bText               = YES;
            // 目标场景
            // 发送到聊天界面  WXSceneSession
            // 发送到朋友圈    WXSceneTimeline
            // 发送到微信收藏  WXSceneFavorite
            req.scene               = WXSceneTimeline;
            [WXApi sendReq:req];
            
        }];
        [self.activityView addButtonView:bv];
        
    }
    
    [self.activityView show];
    
}

-(void)nextjiesuan:(UIButton *)jiesuan
{
    
    
    NSLog(@"%@",_lastPath);
    
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"ijanbiantiao"] forBarMetrics:0];
    QWPayViewController *detailController = [[QWPayViewController alloc] init];
    detailController.hidesBottomBarWhenPushed       = YES;
    [self.navigationController pushViewController:detailController animated:YES];
}



-(void)didClickServiceBtn:(UIButton *)jiesuan
{
    NSLog(@"点击了客服");
}
#pragma mark-添加收藏按钮
-(void)didClickcollectBtn:(UIButton *)jiesuan
{
 
    NSLog(@"%d",jiesuan.isSelected);
    if(jiesuan.isSelected)
    {
        [jiesuan setSelected:NO];
        [jiesuan setImage:[UIImage imageNamed:@"shoucang1"] forState:BtnNormal];
        
        [self.view showInfo:@"取消收藏" autoHidden:YES];
    }
    else
    {
        [jiesuan setSelected:YES];
        [jiesuan setImage:[UIImage imageNamed:@"shoucang2"] forState:BtnStateSelected];
        
        [self.view showInfo:@"收藏成功" autoHidden:YES];
    }
    
    [self insertCollectionAndUserid:[UdStorage getObjectforKey:Userid] andMerCode:self.MerChantmodel.MerCode];

    
    
    
//    [_McdetailTableView reloadRowsAtIndexPaths:@[
//                                             [NSIndexPath indexPathForRow:jiesuan.tag inSection:0]
//                                             ] withRowAnimation:UITableViewRowAnimationNone];
}

-(void)didClickwhichservice:(UIButton *)selectedbtn
{
    
}

-(void)clicktiaozhuan:(UIGestureRecognizer *)gap
{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"ijanbiantiao"] forBarMetrics:0];
    ShopViewController *detailController = [[ShopViewController alloc] init];
    detailController.merchantModel=self.MerChantmodel;
    detailController.hidesBottomBarWhenPushed       = YES;
    [self.navigationController pushViewController:detailController animated:YES];
}


#pragma mark - QWDetailAddressTableViewCell代理方法
- (void)showMapNavigationView {
    
    [self.mapNavigationView showMapNavigationViewWithtargetLatitude:22.488260 targetLongitute:113.915049 toName:@"中海油华英加油站"];
    [self.view addSubview:_mapNavigationView];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

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

@end
