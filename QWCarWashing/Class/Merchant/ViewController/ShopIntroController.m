//
//  ShopIntroController.m
//  CarWashing
//
//  Created by 时建鹏 on 2017/7/26.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "ShopIntroController.h"
#import "ShopInfoHeadView.h"



@interface ShopIntroController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) ShopInfoHeadView *infoHeadView;

@property (nonatomic, weak) UITableView *infoTableView;

@end

static NSString *id_infoCell = @"id_infoCell";

@implementation ShopIntroController

- (ShopInfoHeadView *)infoHeadView {
    
    if (!_infoHeadView) {
        ShopInfoHeadView *infoHeadView = [ShopInfoHeadView shopInfoHeadView];
        _infoHeadView = infoHeadView;
        [self.view addSubview:_infoHeadView];
    }
    return _infoHeadView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    self.infoTableView.backgroundColor=kColorTableBG;
    self.infoHeadView.backgroundColor=[UIColor whiteColor];
    self.infoTableView.backgroundColor=kColorTableBG;
    
}

- (void)setupUI {
//    0, 0, Main_Screen_Width,Main_Screen_Height-44*Main_Screen_Height/667-64
    self.infoHeadView.backgroundColor=[UIColor whiteColor];
    self.infoHeadView.frame = CGRectMake(0, 0, Main_Screen_Width, 280*Main_Screen_Height/667);
//    [self.infoHeadView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.view).mas_offset(5);
//        make.width.equalTo(self.view);
//        make.height.mas_equalTo(280*Main_Screen_Height/667);
//    }];
    self.infoHeadView.Merchant=self.merchantModel;
    
    
//
    
    UITableView *infoTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height - 64 - 44*Main_Screen_Height/667) style:UITableViewStylePlain];
    _infoTableView = infoTableView;
    [self.view addSubview:_infoTableView];
    
    infoTableView.delegate = self;
    infoTableView.dataSource = self;
    
    
    infoTableView.tableHeaderView = self.infoHeadView;
    infoTableView.rowHeight = 200*Main_Screen_Height/667;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0;

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    UITableViewCell *infoCell = [tableView dequeueReusableCellWithIdentifier:id_infoCell];
    
    static NSString *cellStatic = @"cellStatic";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellStatic];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
    }
    cell.contentView.backgroundColor=[UIColor whiteColor];
    
    UIImageView *infoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, QWScreenWidth-20, 200*Main_Screen_Height/667-20)];
   
    infoImageView.image = [UIImage imageNamed:@"huodongxiangqingtu"];
    
    if (!IsNullIsNull(self.merchantModel.Img)) {
        NSString *ImageURL=[NSString stringWithFormat:@"%@%@",kHTTPImg,self.merchantModel.Img];
        NSURL *url=[NSURL URLWithString:ImageURL];
        [infoImageView sd_setImageWithURL:url placeholderImage: [UIImage imageNamed:@"huodongxiangqingtu"]];
    }
  
    [cell.contentView addSubview:infoImageView];
    
    

    
    return cell;
}

- (IBAction)skipToMapView:(id)sender {
    
//    BusinessMapController *mapVC = [[BusinessMapController alloc] init];
//    mapVC.hidesBottomBarWhenPushed = YES;
//    
//    [self.navigationController pushViewController:mapVC animated:YES];
    
}



- (IBAction)didClickShopPhone:(id)sender {
    
    NSString *message = @"是否拨打商家电话";
    NSString *title = @"";
    [self showAlertWithTitle:title message:message];
    
}


//方法子
- (void)showAlertWithTitle:(NSString *)title message:(NSString *)message {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertController addAction:cancelAction];
    
    UIAlertAction *OKAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertController addAction:OKAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
    
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
