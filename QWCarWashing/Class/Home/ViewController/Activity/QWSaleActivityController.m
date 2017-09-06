//
//  QWSaleActivityController.m
//  QWCarWashing
//
//  Created by Wuxinglin on 2017/8/17.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "QWSaleActivityController.h"
#import "QWUserRightDetailViewController.h"
@interface QWSaleActivityController ()<UITableViewDelegate,UITableViewDataSource>
{
    MBProgressHUD *HUD;
}
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSString *area;
@property (nonatomic, strong) NSMutableArray *CouponListData;
@end

@implementation QWSaleActivityController
-(NSMutableArray *)CouponListData{
    if (_CouponListData==nil) {
        _CouponListData=[NSMutableArray arrayWithCapacity:0];
    }
    return _CouponListData;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title      = @"优惠活动";
    [self createSubView];
     self.area = @"上海市";
    HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HUD.removeFromSuperViewOnHide =YES;
    HUD.mode = MBProgressHUDModeIndeterminate;
    HUD.labelText = @"加载中";
    HUD.minSize = CGSizeMake(132.f, 108.0f);
    [self GetCouponList];

}
#pragma mark- 优惠活动列表
-(void)GetCouponList
{
    NSDictionary *mulDic = @{
                             @"GetCardType":@2,
                             @"Area":self.area
                             };
        [AFNetworkingTool post:mulDic andurl:[NSString stringWithFormat:@"%@Card/GetCardConfigList",Khttp] success:^(NSDictionary *dict, BOOL success) {
            NSLog(@"%@",dict);
        if([[dict objectForKey:@"ResultCode"] isEqualToString:[NSString stringWithFormat:@"%@",@"F000000"]])
        {
            NSArray *arr = [NSArray array];
            arr = [dict objectForKey:@"JsonData"];
            [_CouponListData addObjectsFromArray:arr];
            [self.tableView reloadData];
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
- (void) createSubView {
    self.tableView                  = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, Main_Screen_Width,Main_Screen_Height) style:UITableViewStyleGrouped];
    self.tableView.top              = 0;
    self.tableView.delegate         = self;
    self.tableView.dataSource       = self;
    //    self.tableView.scrollEnabled    = NO;
//    self.tableView.tableFooterView  = [UIView new];
//    self.tableView.tableHeaderView  = [UIView new];
    self.tableView.separatorStyle   = UITableViewCellSeparatorStyleNone;
    //    self.tableView.backgroundColor  = [UIColor blueColor];
    [self.view addSubview:self.tableView];
    
    
    //    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
    //        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    //    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.CouponListData count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 1;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90*Main_Screen_Height/667;
}

- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.01f*Main_Screen_Height/667;
}
-(CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 40.01f*Main_Screen_Height/667;
}
- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *view = [[UIView alloc] init];
    
//    NSString *title     = @"2017-7-23 9:30";
//    UIFont *titleFont   = [UIFont systemFontOfSize:14*Main_Screen_Height/667];
    
//    UILabel *titleLabel     = [UIUtil drawLabelInView:view frame:CGRectMake(0, 0, Main_Screen_Width*150/375, Main_Screen_Height*30/667) font:titleFont text:title isCenter:YES];
    UILabel *titleLabel = [[UILabel alloc] init];
    //titleLabel.centerX  = Main_Screen_Width/2;
    titleLabel.textColor    = [UIColor colorFromHex:@"#999999"];
    titleLabel.text = @"2017-7-23 9:30";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:14*Main_Screen_Height/667];
    [view addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(view);
    }];
    return view;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellStatic = @"cellStatic";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellStatic];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    }
    cell.backgroundColor    = [UIColor whiteColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    UIImageView *backV = [[UIImageView alloc] init];
    [cell.contentView addSubview:backV];
    
    UILabel *titleLab = [[UILabel alloc] init];
    titleLab.font = [UIFont systemFontOfSize:18*Main_Screen_Height/667];
    titleLab.textColor = [UIColor colorFromHex:@"#4a4a4a"];
    [cell.contentView addSubview:titleLab];
    
    UILabel *introLab = [[UILabel alloc] init];
    introLab.font = [UIFont systemFontOfSize:14*Main_Screen_Height/667];
    introLab.textColor = [UIColor colorFromHex:@"#999999"];
    [cell.contentView addSubview:introLab];
    
    UIImageView *markV = [[UIImageView alloc] init];
    markV.image = [UIImage imageNamed:@"dianjitiaozhuan"];
    [cell.contentView addSubview:markV];
    
    [backV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.bottom.left.equalTo(cell.contentView);
    }];
    
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(cell.contentView).mas_offset(28*Main_Screen_Height/667);
        make.top.equalTo(cell.contentView).mas_offset(24*Main_Screen_Height/667);
    }];
    
    [introLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(titleLab);
        make.top.equalTo(titleLab.mas_bottom).mas_offset(12*Main_Screen_Height/667);
    }];
    
    [markV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(introLab);
        make.leading.equalTo(introLab.mas_trailing).mas_offset(20*Main_Screen_Height/667);
    }];
    NSString *ImageURL=[NSString stringWithFormat:@"%@%@",kHTTPImg,[[_CouponListData objectAtIndex:indexPath.section] objectForKey:@"Img"]];
    NSURL *url=[NSURL URLWithString:ImageURL];
    [backV sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"yonghuzhuanxiangditu"]];
    
    titleLab.text = [[_CouponListData objectAtIndex:indexPath.section] objectForKey:@"Description"];
    introLab.text = [NSString stringWithFormat:@"免费获得洗车%@一张",[[_CouponListData objectAtIndex:indexPath.section] objectForKey:@"CardName"]];
//    if (indexPath.section == 0) {
//        
//        backV.image = [UIImage imageNamed:@"xinyonghuu"];
//        titleLab.text = @"新用户注册奖励";
//        introLab.text = @"免费获得洗车体验卡一张";
//    }
//    
//    if (indexPath.section == 1) {
//        backV.image = [UIImage imageNamed:@"huiyuanquanyitu"];
//        titleLab.text = @"金顶会员专享权益";
//        introLab.text = @"平台商家下单洗车可抵扣";
//    }
//    
//    if (indexPath.section == 2) {
//        backV.image = [UIImage imageNamed:@"yonghuzhuanxiangditu"];
//        titleLab.text = @"金顶会员专享";
//        introLab.text = @"平台商家下单洗车可抵扣";
//    }
    
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
     QWUserRightDetailViewController *rightController     = [[QWUserRightDetailViewController alloc]init];
   
    rightController.hidesBottomBarWhenPushed        = YES;
     rightController.ConfigCode                      = [[_CouponListData objectAtIndex:indexPath.section] objectForKey:@"ConfigCode"];
    [self.navigationController pushViewController:rightController animated:YES];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 圆角弧度半径
    CGFloat cornerRadius = 6.f;
    // 设置cell的背景色为透明，如果不设置这个的话，则原来的背景色不会被覆盖
    cell.backgroundColor = UIColor.clearColor;
    
    // 创建一个shapeLayer
    CAShapeLayer *layer = [[CAShapeLayer alloc] init];
    CAShapeLayer *backgroundLayer = [[CAShapeLayer alloc] init]; //显示选中
    // 创建一个可变的图像Path句柄，该路径用于保存绘图信息
    CGMutablePathRef pathRef = CGPathCreateMutable();
    // 获取cell的size
    // 第一个参数,是整个 cell 的 bounds, 第二个参数是距左右两端的距离,第三个参数是距上下两端的距离
    CGRect bounds = CGRectInset(cell.bounds, 10, 0);
    
    // CGRectGetMinY：返回对象顶点坐标
    // CGRectGetMaxY：返回对象底点坐标
    // CGRectGetMinX：返回对象左边缘坐标
    // CGRectGetMaxX：返回对象右边缘坐标
    // CGRectGetMidX: 返回对象中心点的X坐标
    // CGRectGetMidY: 返回对象中心点的Y坐标
    
    // 这里要判断分组列表中的第一行，每组section的第一行，每组section的中间行
    
    // CGPathAddRoundedRect(pathRef, nil, bounds, cornerRadius, cornerRadius);
    if (indexPath.row == 0) {
        // 初始起点为cell的左下角坐标
        CGPathMoveToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMaxY(bounds));
        // 起始坐标为左下角，设为p，（CGRectGetMinX(bounds), CGRectGetMinY(bounds)）为左上角的点，设为p1(x1,y1)，(CGRectGetMidX(bounds), CGRectGetMinY(bounds))为顶部中点的点，设为p2(x2,y2)。然后连接p1和p2为一条直线l1，连接初始点p到p1成一条直线l，则在两条直线相交处绘制弧度为r的圆角。
        CGPathAddArcToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMinY(bounds), CGRectGetMidX(bounds), CGRectGetMinY(bounds), cornerRadius);
        CGPathAddArcToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMinY(bounds), CGRectGetMaxX(bounds), CGRectGetMidY(bounds), cornerRadius);
        // 终点坐标为右下角坐标点，把绘图信息都放到路径中去,根据这些路径就构成了一块区域了
        CGPathAddLineToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMaxY(bounds));
        
    } else if (indexPath.row == [tableView numberOfRowsInSection:indexPath.section]-1) {
        // 初始起点为cell的左上角坐标
        CGPathMoveToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMinY(bounds));
        CGPathAddArcToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMaxY(bounds), CGRectGetMidX(bounds), CGRectGetMaxY(bounds), cornerRadius);
        CGPathAddArcToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMaxY(bounds), CGRectGetMaxX(bounds), CGRectGetMidY(bounds), cornerRadius);
        // 添加一条直线，终点坐标为右下角坐标点并放到路径中去
        CGPathAddLineToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMinY(bounds));
    } else {
        // 添加cell的rectangle信息到path中（不包括圆角）
        CGPathAddRect(pathRef, nil, bounds);
    }
    // 把已经绘制好的可变图像路径赋值给图层，然后图层根据这图像path进行图像渲染render
    layer.path = pathRef;
    backgroundLayer.path = pathRef;
    // 注意：但凡通过Quartz2D中带有creat/copy/retain方法创建出来的值都必须要释放
    CFRelease(pathRef);
    // 按照shape layer的path填充颜色，类似于渲染render
    // layer.fillColor = [UIColor colorWithWhite:1.f alpha:0.8f].CGColor;
    layer.fillColor = [UIColor whiteColor].CGColor;
    
    // view大小与cell一致
    UIView *roundView = [[UIView alloc] initWithFrame:bounds];
    // 添加自定义圆角后的图层到roundView中
    [roundView.layer insertSublayer:layer atIndex:0];
    roundView.backgroundColor = UIColor.clearColor;
    // cell的背景view
    cell.backgroundView = roundView;
    
    // 以上方法存在缺陷当点击cell时还是出现cell方形效果，因此还需要添加以下方法
    // 如果你 cell 已经取消选中状态的话,那以下方法是不需要的.
    UIView *selectedBackgroundView = [[UIView alloc] initWithFrame:bounds];
    backgroundLayer.fillColor = [UIColor cyanColor].CGColor;
    [selectedBackgroundView.layer insertSublayer:backgroundLayer atIndex:0];
    selectedBackgroundView.backgroundColor = UIColor.clearColor;
    cell.selectedBackgroundView = selectedBackgroundView;
    
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
