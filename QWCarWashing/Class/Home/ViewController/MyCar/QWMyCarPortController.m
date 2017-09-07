//
//  QWMyCarPortController.m
//  QWCarWashing
//
//  Created by Wuxinglin on 2017/8/17.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "QWMyCarPortController.h"
#import "MyCarViewCell.h"
#import "QWIcreaseCarController.h"
#import "UIScrollView+EmptyDataSet.h"//第三方空白页
@interface QWMyCarPortController ()<UITableViewDataSource, UITableViewDelegate,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>

@property (nonatomic, weak) UIView *increaseView;

@property (nonatomic, weak) UITableView *carListView;
@property (nonatomic, strong) NSIndexPath *nowPath;
@property (nonatomic, strong) NSMutableArray *CarArray;
@property (nonatomic, strong) NSMutableArray *imageArray;
@property (nonatomic, strong)NSMutableArray *mycararray;
@end

static NSString *id_carListCell = @"id_carListCell";

@implementation QWMyCarPortController

- (UITableView *)carListView {
    
    if (_carListView == nil) {
        
        UITableView *carListView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, Main_Screen_Width, Main_Screen_Height - 64 - (48+25+25)*Main_Screen_Height/667) ];
        _carListView = carListView;
        
        [self.view addSubview:_carListView];
    }
    
    return _carListView;
}
- (NSMutableArray *)imageArray {
    if (_imageArray == nil) {
        _imageArray = [NSMutableArray array];
    }
    return _imageArray;
}
-(NSMutableArray *)mycararray{
    if (_mycararray==nil) {
        _mycararray=[NSMutableArray arrayWithCapacity:0];
    }
    return _mycararray;
}
-(NSMutableArray *)CarArray{
    if (_CarArray==nil) {
        _CarArray=[NSMutableArray arrayWithCapacity:0];
    }
    return _CarArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"我的车库";
    
 
    // Do any additional setup after loading the view.
//    [self setupUI];
    [self requestMyCarData];
    NSNotificationCenter * center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(noticeincreaseMyCar:) name:@"increasemycarsuccess" object:nil];
    
  
    self.view.backgroundColor=kColorTableBG;
    
    
    
}
-(void)noticeincreaseMyCar:(NSNotification *)sender{
     [self requestMyCarData];
}

- (void)setupUI {
    
    self.carListView.delegate = self;
    self.carListView.dataSource = self;
    self.carListView.emptyDataSetSource=self;
    self.carListView.emptyDataSetDelegate=self;
    self.carListView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    self.carListView.rowHeight = 150*Main_Screen_Height/667;
    [self.carListView registerNib:[UINib nibWithNibName:@"MyCarViewCell" bundle:nil] forCellReuseIdentifier:id_carListCell];
    
    self.carListView.backgroundColor=kColorTableBG;
    UIButton *increaseBtn = [UIUtil drawDefaultButton:self.view title:@"新增车辆" target:self action:@selector(didClickIncreaseButton)];
    
    [increaseBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(351*Main_Screen_Height/667);
        make.height.mas_equalTo(48*Main_Screen_Height/667);
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.view).mas_offset(-25*Main_Screen_Height/667);    }];
}
#pragma mark-查询爱车列表
-(void)requestMyCarData
{
    [self.CarArray removeAllObjects];
    [self.mycararray removeAllObjects];
    NSDictionary *mulDic = @{
                             @"Account_Id":[UdStorage getObjectforKey:Userid]
                             };
    NSLog(@"查询爱车列表:%@",mulDic);
    [AFNetworkingTool post:mulDic andurl:[NSString stringWithFormat:@"%@MyCar/GetCarList",Khttp] success:^(NSDictionary *dict, BOOL success) {
        
        NSLog(@"==%@==",dict);
        if([[dict objectForKey:@"ResultCode"] isEqualToString:[NSString stringWithFormat:@"%@",@"F000000"]])
        {
            NSArray *arr = [NSArray array];
            arr = [dict objectForKey:@"JsonData"];
         
            for(NSDictionary *dic in arr)
            {
                
                QWMyCarModel *newcar = [[QWMyCarModel alloc]initWithDictionary:dic error:nil];
                if (newcar.IsDefaultFav==1) {
                    
                    [self.mycararray addObject:newcar];
                }else{
                    [self.CarArray addObject:newcar];

                }
                
            }
             NSLog(@"111111%ld====%@",self.CarArray.count,self.CarArray[0]);
            NSIndexSet *indexes = [NSIndexSet indexSetWithIndexesInRange:
                                   NSMakeRange(0,[self.mycararray count])];
            [self.CarArray insertObjects:self.mycararray atIndexes:indexes];
            NSLog(@"222222%ld===%@",self.CarArray.count,self.CarArray[0]);
            
            for (int index = 0; index < [self.CarArray count]; index++) {
                UIImage *image = [UIImage imageNamed:@"aicheditu"];
                [self.imageArray addObject:image];
            }
            
            [self setupUI];
            
            [self.carListView reloadData];
            
        }
        else
        {
            [self.view showInfo:@"获取失败" autoHidden:YES interval:2];
        }
        
        
        
        
    } fail:^(NSError *error) {
        [self.view showInfo:@"获取失败" autoHidden:YES interval:2];
    }];
    
}
#pragma mark - 数据源代理

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.CarArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MyCarViewCell *carCell = [tableView dequeueReusableCellWithIdentifier:id_carListCell];
    
//    if (indexPath.section==0) {
//        for (int i=0; i<self.CarArray.count; i++) {
//            QWMyCarModel * tempmodel=self.CarArray[i];
//            if (tempmodel.IsDefaultFav==1) {
//                carCell.mycarmodel=tempmodel;
//            }
//        }
//        
//    }else{
    if (self.CarArray.count!=0) {
        carCell.mycarmodel=self.CarArray[indexPath.section];
    }
    
//    }
    carCell.defaultButton.tag=indexPath.section;
     carCell.deleteButton.tag = indexPath.section+1000;
    
    
    return carCell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self.navigationController popViewControllerAnimated:YES];
}



-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
   
    UIView *headervie=[UIView new];
    headervie.backgroundColor=[UIColor clearColor];
    return headervie;

}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 10.1f;
}


#pragma mark-修改车辆的默认值
- (IBAction)didClickDefaultButton:(UIButton *)button {
    

    QWMyCarModel *mycar=[[QWMyCarModel alloc]init];
    mycar=self.CarArray[button.tag];
    NSLog(@"%@",mycar.CarBrand);
   
    [self updateCarDefaultAndCarCode:[NSString stringWithFormat:@"%ld",mycar.CarCode] andModifyType:@"2"];
    
}
#pragma mark-修改车辆默认值接口
-(void)updateCarDefaultAndCarCode:(NSString *)carCode andModifyType:(NSString *)ModifyType {
//    [[_mycararray objectAtIndex:button.tag] objectForKey:@"CarCode"]
    NSDictionary *mulDic = @{
                             @"Account_Id":[UdStorage getObjectforKey:Userid],
                             @"CarCode":carCode,
                             @"ModifyType":ModifyType,
                             };
    NSLog(@"%@",mulDic);
    
    [AFNetworkingTool post:mulDic andurl:[NSString stringWithFormat:@"%@MyCar/ModifyCarInfo",Khttp] success:^(NSDictionary *dict, BOOL success) {
        NSLog(@"%@",dict);
        if([[dict objectForKey:@"ResultCode"] isEqualToString:[NSString stringWithFormat:@"%@",@"F000000"]])
        {
            if ([ModifyType isEqualToString:@"2"]) {
                 [self.view showInfo:@"修改成功" autoHidden:YES interval:2];
            }else{
                 [self.view showInfo:@"删除成功" autoHidden:YES interval:2];
            }
           
//            _mycararray = [[NSMutableArray alloc]init];
//            _myDefaultcararray = [[NSMutableArray alloc]init];
            [self requestMyCarData];
//                            [self.carListView reloadData];
            NSNotification * notice = [NSNotification notificationWithName:@"updatemycarsuccess" object:nil userInfo:nil];
            [[NSNotificationCenter defaultCenter]postNotification:notice];
            
        }
        else
        {
            [self.view showInfo:@"修改失败" autoHidden:YES interval:2];
        }
        
    } fail:^(NSError *error) {
        [self.view showInfo:@"修改失败" autoHidden:YES interval:2];
    }];

}
#pragma mark-删除车按钮事件
- (IBAction)didClickDeleteButton:(UIButton *)sender {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"是否删除车辆信息" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertController addAction:cancelAction];
    
    UIAlertAction *OKAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        QWMyCarModel *mycar=[[QWMyCarModel alloc]init];
        mycar=self.CarArray[sender.tag-1000];
        [self updateCarDefaultAndCarCode:[NSString stringWithFormat:@"%ld",mycar.CarCode] andModifyType:@"3"];
        
    }];
    [alertController addAction:OKAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
    
}



#pragma mark - 新增车辆
- (void)didClickIncreaseButton {
    
    QWIcreaseCarController *increaseVC = [[QWIcreaseCarController alloc] init];
    increaseVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:increaseVC animated:YES];
    
}
#pragma mark - 无数据占位
//无数据占位
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView{
    return [UIImage imageNamed:@"cheku_kongbai"];
}

- (CAAnimation *)imageAnimationForEmptyDataSet:(UIScrollView *)scrollView{
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath: @"cheku_kongbai"];
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
    NSString *text = @"小二已在此恭候你多时";
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:13.0f],
                                 NSForegroundColorAttributeName: [UIColor colorFromHex:@"#4a4a4a"]};
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}
//设置占位图空白页的背景色( 图片优先级高于文字)

- (UIColor *)backgroundColorForEmptyDataSet:(UIScrollView *)scrollView {
    return [UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
}
//设置按钮的文本和按钮的背景图片

//- (NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state  {
////    NSLog(@"buttonTitleForEmptyDataSet:点击上传照片");
////    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:17.0f]};
////    return [[NSAttributedString alloc] initWithString:@"点击上传照片" attributes:attributes];
//}
// 返回可以点击的按钮 上面带文字
- (NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state {
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:17.0f]};
    return [[NSAttributedString alloc] initWithString:@"" attributes:attribute];
}


- (UIImage *)buttonImageForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state {
    return [UIImage imageNamed:@"xinzeng"];
}
//是否显示空白页，默认YES
- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView {
    return YES;
}
//是否允许点击，默认YES
- (BOOL)emptyDataSetShouldAllowTouch:(UIScrollView *)scrollView {
    return NO;
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
    return NSLog(@"空白页按钮点击事件");
}
/**
 *  调整垂直位置
 */
- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView
{
    return -64.f;
}
@end
