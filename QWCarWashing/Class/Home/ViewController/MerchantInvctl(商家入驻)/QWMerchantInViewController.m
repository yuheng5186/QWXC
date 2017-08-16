//
//  QWMerchantInViewController.m
//  QWCarWashing
//
//  Created by apple on 2017/8/15.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "QWMerchantInViewController.h"
#import "QWMerchantInTableViewCell.h"
@interface QWMerchantInViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableview;

@end

#define QWCellIdentifier_MerchantInTableViewCell @"QWMerchantInTableViewCell"

@implementation QWMerchantInViewController

-(UITableView *)tableview{
    
    if (_tableview==nil) {
        _tableview=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, QWScreenWidth, QWScreenheight)];
//        [_tableview registerClass:[UITableViewCell class] forCellReuseIdentifier:cellstr];
//        [_tableview registerClass:[QWMenuTableViewCell class] forCellReuseIdentifier:QWCellIdentifier_MenuTableViewCell];
        [_tableview registerNib:[UINib nibWithNibName:QWCellIdentifier_MerchantInTableViewCell bundle:[NSBundle mainBundle]] forCellReuseIdentifier:QWCellIdentifier_MerchantInTableViewCell];
        _tableview.delegate=self;
        _tableview.dataSource=self;
        _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableview.backgroundColor=[UIColor colorWithHexString:@"#eaeaea"];
        
    }
    return _tableview;
}
#pragma mark-UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
            return 1;
          }

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
        QWMerchantInTableViewCell *cell2 = [tableView dequeueReusableCellWithIdentifier:QWCellIdentifier_MerchantInTableViewCell forIndexPath:indexPath];
        cell2.selectionStyle = UITableViewCellSelectionStyleNone;
        cell2.backgroundColor=[UIColor whiteColor];
        cell2.contentText.placeholder=@"请填写商家名称";
        return cell2;
        
  
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableview];
    
    self.title  = @"商家入驻";
    [self resetBabkButton];
}


- (void) resetBabkButton {
    
    UIButton *rightButton = [[UIButton alloc]initWithFrame:CGRectMake(0,0,20,20)];
    [rightButton setImage:[UIImage imageNamed:@"icon_titlebar_arrow"] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(backButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    self.navigationItem.leftBarButtonItem= rightItem;
}
- (void) backButtonClick:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
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
