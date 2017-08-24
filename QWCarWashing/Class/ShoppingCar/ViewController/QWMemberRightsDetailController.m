//
//  QWMemberRightsDetailController.m
//  QWCarWashing
//
//  Created by Mac WuXinLing on 2017/8/23.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "QWMemberRightsDetailController.h"

@interface QWMemberRightsDetailController ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation QWMemberRightsDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title      = @"特权详情";
     [self setupUI];
}

- (void)setupUI {
    
    UIImageView *cardImgV = [[UIImageView alloc] init];
    cardImgV.image = [UIImage imageNamed:@"bg_card"];
    [self.view addSubview:cardImgV];
    
    UILabel *cardNameLab = [[UILabel alloc] init];
    cardNameLab.text = @"体验卡";
    cardNameLab.font = [UIFont systemFontOfSize:18*Main_Screen_Height/667];
    [cardImgV addSubview:cardNameLab];
    
    UILabel *introLab = [[UILabel alloc] init];
    introLab.text = @"扫码洗车服务中使用";
    introLab.font = [UIFont systemFontOfSize:13*Main_Screen_Height/667];
    [cardImgV addSubview:introLab];
    
    UILabel *invalidLab = [[UILabel alloc] init];
    invalidLab.text = @"截止日期：2017-8-10";
    invalidLab.textColor = [UIColor colorFromHex:@"#999999"];
    invalidLab.font = [UIFont systemFontOfSize:13*Main_Screen_Height/667];
    [cardImgV addSubview:invalidLab];
    
    UILabel *brandLab = [[UILabel alloc] init];
    brandLab.text = @"";
    brandLab.font = [UIFont systemFontOfSize:11];
    [cardImgV addSubview:brandLab];
    
    UIButton *getBtn = [UIUtil drawDefaultButton:self.view title:@"立即领取" target:self action:@selector(didClickGetBtn)];
    
    UIButton *checkCardBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [checkCardBtn setTitle:@"查看卡包" forState:UIControlStateNormal];
    [checkCardBtn setTitleColor:[UIColor colorFromHex:@"#999999"] forState:UIControlStateNormal];
    checkCardBtn.titleLabel.font = [UIFont systemFontOfSize:13*Main_Screen_Height/667];
    [checkCardBtn setImage:[UIImage imageNamed:@"chakandaijinquan-jiantou"] forState:UIControlStateNormal];
    checkCardBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -150*Main_Screen_Height/667);
    [checkCardBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -50*Main_Screen_Height/667, 0, 0)];
    
    [checkCardBtn addTarget:self action:@selector(didClickCheckCardBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:checkCardBtn];
    
    
    //约束
    [cardImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).mas_offset(64 + 10*Main_Screen_Height/667);
        make.left.equalTo(self.view).mas_offset(37.5*Main_Screen_Height/667);
        make.right.equalTo(self.view).mas_offset(-37.5*Main_Screen_Height/667);
        make.height.mas_equalTo(192*Main_Screen_Height/667);
    }];
    
    [cardNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(cardImgV).mas_offset(20*Main_Screen_Height/667);
        make.left.equalTo(cardImgV).mas_offset(20*Main_Screen_Height/667);
    }];
    
    [brandLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(cardNameLab);
        make.leading.equalTo(cardNameLab.mas_trailing).mas_offset(5*Main_Screen_Height/667);
    }];
    
    [introLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(cardNameLab.mas_bottom).mas_offset(10*Main_Screen_Height/667);
        make.leading.equalTo(cardNameLab);
    }];
    
    [invalidLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(cardNameLab);
        make.bottom.equalTo(cardImgV).mas_offset(-18*Main_Screen_Height/667);
    }];
    
    [getBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(cardImgV.mas_bottom).mas_offset(15*Main_Screen_Height/667);
        make.centerX.equalTo(self.view);
        make.width.mas_equalTo(351*Main_Screen_Height/667);
        make.height.mas_equalTo(48*Main_Screen_Height/667);
    }];
    
    [checkCardBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(getBtn.mas_bottom);
        make.centerX.equalTo(self.view);
        make.height.mas_equalTo(45*Main_Screen_Height/667);
        make.width.mas_equalTo(100*Main_Screen_Height/667);
    }];
    
    UITableView *noticeView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    //noticeView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:noticeView];
    
    [noticeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(checkCardBtn.mas_bottom);
        make.bottom.equalTo(self.view);
        make.width.mas_equalTo(Main_Screen_Width);
    }];
    noticeView.delegate = self;
    noticeView.dataSource = self;
    noticeView.estimatedRowHeight = 80;
    noticeView.rowHeight = UITableViewAutomaticDimension;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *id_noticeCell = @"id_noticeCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:id_noticeCell];
    
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:id_noticeCell];
    //    UILabel *titleLab = [[UILabel alloc] init];
    //    titleLab.textColor = [UIColor colorFromHex:@"#4a4a4a"];
    //    titleLab.font = [UIFont systemFontOfSize:14];
    //    [cell.contentView addSubview:titleLab];
    //
    //    UILabel *infosLab = [[UILabel alloc] init];
    //    infosLab.textColor = [UIColor colorFromHex:@"#999999"];
    //    infosLab.font = [UIFont systemFontOfSize:13];
    //    infosLab.numberOfLines = 0;
    //    [cell.contentView addSubview:infosLab];
    //
    //    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.top.equalTo(cell.contentView).mas_offset(15);
    //        make.left.equalTo(cell.contentView).mas_offset(12);
    //    }];
    
    if (indexPath.section == 0) {
        
        UILabel *titleLab = [[UILabel alloc] init];
        titleLab.textColor = [UIColor colorFromHex:@"#4a4a4a"];
        titleLab.font = [UIFont systemFontOfSize:14*Main_Screen_Height/667];
        [cell.contentView addSubview:titleLab];
        
        UILabel *infosLab = [[UILabel alloc] init];
        infosLab.textColor = [UIColor colorFromHex:@"#999999"];
        infosLab.font = [UIFont systemFontOfSize:13*Main_Screen_Height/667];
        infosLab.numberOfLines = 0;
        titleLab.text = @"特权介绍";
        infosLab.text = @"白银会员每月可领取10元代金券，不可以和其他优惠活动叠加使用";
        [cell.contentView addSubview:infosLab];
        
        [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(cell.contentView).mas_offset(8*Main_Screen_Height/667);
            make.left.equalTo(cell.contentView).mas_offset(12*Main_Screen_Height/667);
        }];
        
        [infosLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(titleLab.mas_bottom).mas_offset(8*Main_Screen_Height/667);
            make.leading.equalTo(titleLab);
            make.right.equalTo(cell.contentView).mas_offset(-12*Main_Screen_Height/667);
            make.bottom.equalTo(cell.contentView).mas_offset(-8*Main_Screen_Height/667);
        }];
        
        
    }else if (indexPath.section == 1) {
        UILabel *titleLab = [[UILabel alloc] init];
        titleLab.textColor = [UIColor colorFromHex:@"#4a4a4a"];
        titleLab.font = [UIFont systemFontOfSize:14*Main_Screen_Height/667];
        [cell.contentView addSubview:titleLab];
        
        UILabel *infosLab = [[UILabel alloc] init];
        infosLab.textColor = [UIColor colorFromHex:@"#999999"];
        infosLab.font = [UIFont systemFontOfSize:13*Main_Screen_Height/667];
        infosLab.numberOfLines = 0;
        titleLab.text = @"领取对象";
        infosLab.text = @"白银会员";
        [cell.contentView addSubview:infosLab];
        
        [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(cell.contentView).mas_offset(8*Main_Screen_Height/667);
            make.left.equalTo(cell.contentView).mas_offset(12*Main_Screen_Height/667);
        }];
        
        [infosLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(titleLab.mas_bottom).mas_offset(8*Main_Screen_Height/667);
            make.leading.equalTo(titleLab);
            make.right.equalTo(cell.contentView).mas_offset(-12*Main_Screen_Height/667);
            make.bottom.equalTo(cell.contentView).mas_offset(-8*Main_Screen_Height/667);
        }];
        
        
    }else {
        UILabel *titleLab = [[UILabel alloc] init];
        titleLab.textColor = [UIColor colorFromHex:@"#4a4a4a"];
        titleLab.font = [UIFont systemFontOfSize:14*Main_Screen_Height/667];
        [cell.contentView addSubview:titleLab];
        
        UILabel *infosLab = [[UILabel alloc] init];
        infosLab.textColor = [UIColor colorFromHex:@"#999999"];
        infosLab.font = [UIFont systemFontOfSize:13*Main_Screen_Height/667];
        infosLab.numberOfLines = 0;
        [cell.contentView addSubview:infosLab];
        
        [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(cell.contentView).mas_offset(8*Main_Screen_Height/667);
            make.left.equalTo(cell.contentView).mas_offset(12*Main_Screen_Height/667);
        }];
        
        [infosLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(titleLab.mas_bottom).mas_offset(8*Main_Screen_Height/667);
            make.leading.equalTo(titleLab);
            make.right.equalTo(cell.contentView).mas_offset(-12*Main_Screen_Height/667);
        }];
        
        UILabel *infosLab2 = [[UILabel alloc] init];
        infosLab2.textColor = [UIColor colorFromHex:@"#999999"];
        infosLab2.font = [UIFont systemFontOfSize:13*Main_Screen_Height/667];
        infosLab2.numberOfLines = 0;
        [cell.contentView addSubview:infosLab2];
        
        UILabel *infosLab3 = [[UILabel alloc] init];
        infosLab3.textColor = [UIColor colorFromHex:@"#999999"];
        infosLab3.font = [UIFont systemFontOfSize:13*Main_Screen_Height/667];
        infosLab3.numberOfLines = 0;
        [cell.contentView addSubview:infosLab3];
        
        titleLab.text = @"使用须知";
        infosLab.text = @"1、本代金券由金顶洗车APP开发，仅限金顶洗车店和与金顶合作商家使用";
        infosLab2.text = @"2、如果代金券购买服务时发生了退服务行为，代金券不予退还";
        infosLab3.text = @"3、有任何问题，可咨询金顶客服";
        
        [infosLab2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(infosLab.mas_bottom).mas_offset(8*Main_Screen_Height/667);
            make.leading.equalTo(infosLab);
            make.right.equalTo(cell.contentView).mas_offset(-12*Main_Screen_Height/667);
        }];
        
        [infosLab3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(infosLab2.mas_bottom).mas_offset(8*Main_Screen_Height/667);
            make.leading.equalTo(infosLab2);
            make.right.equalTo(cell.contentView).mas_offset(-12*Main_Screen_Height/667);
            make.bottom.equalTo(cell.contentView).mas_offset(-8*Main_Screen_Height/667);
        }];
        
        
        
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}



#pragma mark -
- (void)didClickGetBtn {
    
}

- (void)didClickCheckCardBtn {
    
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
