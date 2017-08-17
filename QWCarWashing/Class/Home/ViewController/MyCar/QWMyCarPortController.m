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
@end

static NSString *id_carListCell = @"id_carListCell";

@implementation QWMyCarPortController

- (UITableView *)carListView {
    
    if (_carListView == nil) {
        
        UITableView *carListView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height) style:UITableViewStyleGrouped];
        _carListView = carListView;
        [self.view addSubview:_carListView];
    }
    
    return _carListView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupUI];

}

- (void)setupUI {
    
    self.carListView.delegate = self;
    self.carListView.dataSource = self;
    self.carListView.rowHeight = 140;
    [self.carListView registerNib:[UINib nibWithNibName:@"MyCarViewCell" bundle:nil] forCellReuseIdentifier:id_carListCell];
    
    
    UIButton *increaseBtn = [UIUtil drawDefaultButton:self.view title:@"新增车辆" target:self action:@selector(didClickIncreaseButton)];
    
    [increaseBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(351);
        make.height.mas_equalTo(48);
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.view).mas_offset(-25);
    }];
}

#pragma mark - 数据源代理

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MyCarViewCell *carCell = [tableView dequeueReusableCellWithIdentifier:id_carListCell];
    
    if (indexPath.section == self.nowPath.section) {
        
        carCell.defaultButton.selected = YES;
        [carCell.defaultButton setTitle:@"已默认" forState:UIControlStateNormal];
        
    }else {
        
        carCell.defaultButton.selected = NO;
        [carCell.defaultButton setTitle:@"设置默认" forState:UIControlStateNormal];
        
    }
    
    
    return carCell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self.navigationController popViewControllerAnimated:YES];
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.1f;
}



- (IBAction)didClickDefaultButton:(id)button {
    
    UITableViewCell *cell = (UITableViewCell *) [[button superview] superview];
    
    NSIndexPath *path = [self.carListView indexPathForCell:cell];
    
    //记录当下的indexpath
    self.nowPath = path;
    
    [self.carListView reloadData];
    
    
}


- (IBAction)didClickDeleteButton:(id)sender {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"是否删除车辆信息" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertController addAction:cancelAction];
    
    UIAlertAction *OKAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
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
