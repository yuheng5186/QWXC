//
//  DSCarTravellingController.m
//  CarWashing
//
//  Created by Wuxinglin on 2017/7/21.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "DSCarTravellingController.h"
#import "ActivityListCell.h"
#import "DSCarClubDetailController.h"
@interface DSCarTravellingController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView *tableView;

@end

@implementation DSCarTravellingController

- (void) drawContent
{
    self.statusView.hidden      = YES;
    self.navigationView.hidden  = YES;
    self.contentView.top        = 0;
    self.contentView.height     = self.view.height;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView                  = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, QWScreenWidth,QWScreenheight) style:UITableViewStylePlain];
    self.tableView.delegate         = self;
    self.tableView.dataSource       = self;
    self.tableView.top              = 0;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ActivityListCell" bundle:nil] forCellReuseIdentifier:@"ActivityListCell"];
    
    self.tableView.rowHeight        = 200;
    self.tableView.contentInset     = UIEdgeInsetsMake(0, 0, 180, 0);
    [self.contentView addSubview:self.tableView];
    
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

#pragma mark --

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ActivityListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ActivityListCell" forIndexPath:indexPath];
    if (indexPath.row == 0) {
        cell.activityImageView.image    = [UIImage imageNamed:@"faxiantu1"];
        cell.activityTitleLabel.text    = @"开车一看就知道是老司机";
        cell.activityTimeLabel.text     = @"2017-7-28 14:01";
    }else {
    
        cell.activityImageView.image    = [UIImage imageNamed:@"faxiantu"];
        cell.activityTitleLabel.text    = @"法拉利总裁介绍新款V8发动机";
        cell.activityTimeLabel.text     = @"2017-7-28 14:01";
    }
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    DSCarClubDetailController  *detailController    = [[DSCarClubDetailController alloc]init];
    detailController.hidesBottomBarWhenPushed       = YES;
    [self.navigationController pushViewController:detailController animated:YES];
    
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
