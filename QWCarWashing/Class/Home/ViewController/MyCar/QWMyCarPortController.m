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

@interface QWMyCarPortController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) UIView *increaseView;

@property (nonatomic, weak) UITableView *carListView;

@property (nonatomic, strong) NSIndexPath *nowPath;
@property (nonatomic, strong) NSMutableArray *CarArray;
@property (nonatomic, strong) NSMutableArray *imageArray;
@end

static NSString *id_carListCell = @"id_carListCell";

@implementation QWMyCarPortController

- (UITableView *)carListView {
    
    if (_carListView == nil) {
        
        UITableView *carListView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, Main_Screen_Width, Main_Screen_Height) ];
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
}

- (void)setupUI {
    
    self.carListView.delegate = self;
    self.carListView.dataSource = self;
    self.carListView.rowHeight = 140;
    [self.carListView registerNib:[UINib nibWithNibName:@"MyCarViewCell" bundle:nil] forCellReuseIdentifier:id_carListCell];
    
    self.carListView.backgroundColor=kColorTableBG;
    UIButton *increaseBtn = [UIUtil drawDefaultButton:self.view title:@"新增车辆" target:self action:@selector(didClickIncreaseButton)];
    
    [increaseBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).mas_offset(10);
        make.height.mas_equalTo(48);
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.view).mas_offset(-25);
    }];
}
#pragma mark-查询爱车列表
-(void)requestMyCarData
{
    [self.CarArray removeAllObjects];
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
                
                [self.CarArray addObject:newcar];
            }
            
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
    carCell.mycarmodel=self.CarArray[indexPath.section];
    carCell.deleteButton.tag=indexPath.section;
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
    
//    UITableViewCell *cell = (UITableViewCell *) [[button superview] superview];
//    
//    NSIndexPath *path = [self.carListView indexPathForCell:cell];
//    
//    //记录当下的indexpath
//    self.nowPath = path;
//    
//    [self.carListView reloadData];
    QWMyCarModel *mycar=[[QWMyCarModel alloc]init];
    mycar=self.CarArray[button.tag];
   
   
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
    
    [AFNetworkingTool post:mulDic andurl:[NSString stringWithFormat:@"%@MyCar/ModifyCarInfo",Khttp] success:^(NSDictionary *dict, BOOL success) {
        NSLog(@"%@",dict);
        if([[dict objectForKey:@"ResultCode"] isEqualToString:[NSString stringWithFormat:@"%@",@"F000000"]])
        {
            [self.view showInfo:@"修改成功" autoHidden:YES interval:2];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
