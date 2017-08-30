//
//  QWRechargeDetailController.m
//  QWCarWashing
//
//  Created by Wuxinglin on 2017/8/16.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "QWRechargeDetailController.h"

@interface QWRechargeDetailController ()

@property (nonatomic,weak) UIView *containView;
@property (nonatomic, weak) UILabel *washCarLabel;
@property (nonatomic, weak) UILabel *validityLabel;
@property (nonatomic, weak) UILabel *timesLabel;
@property (nonatomic, weak) UILabel *lineLabel;

@property (nonatomic, weak) UILabel *noticeLabel;
@property (nonatomic, weak) UILabel *noticeLabelOne;
@property (nonatomic, weak) UILabel *noticeLabeTwo;
@property (nonatomic, weak) UILabel *noticeLabeThree;


@end

@implementation QWRechargeDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"详情";
    self.view.backgroundColor   = [UIColor colorFromHex:@"#fafafa"];
    [self setupUI];

}

- (void)setupUI {
    if (self.card!=nil) {
        self.washCarLabel.text =self.card.CardName;
        self.validityLabel.text = [NSString stringWithFormat:@"有效期至%@",self.card.ExpEndDates];
        self.timesLabel.text = [NSString stringWithFormat:@"免费洗车次数%ld次",self.card.CardCount];
    }
    
    [self.washCarLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.containView).mas_offset(20);
        make.left.equalTo(self.containView).mas_offset(10);
    }];
    
    [self.validityLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.washCarLabel);
        make.top.equalTo(self.washCarLabel.mas_bottom).mas_offset(15);
    }];
    
    [self.timesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.washCarLabel);
        make.top.equalTo(self.validityLabel.mas_bottom).mas_offset(15);
    }];
    
    [self.lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(0);
        make.height.mas_equalTo(1);
        make.width.mas_equalTo(self.view);
        make.top.equalTo(self.timesLabel.mas_bottom).mas_offset(15);
    }];
    
    
    [self.noticeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.washCarLabel);
        make.top.equalTo(self.lineLabel.mas_bottom).mas_offset(15);
    }];
    
    [self.noticeLabelOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.washCarLabel);
        make.top.equalTo(self.noticeLabel.mas_bottom).mas_offset(15);
        make.right.equalTo(self.containView).mas_offset(-10);
    }];
    
    [self.noticeLabeTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.washCarLabel);
        make.top.equalTo(self.noticeLabelOne.mas_bottom).mas_offset(15);
    }];
    
    [self.noticeLabeThree mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.washCarLabel);
        make.top.equalTo(self.noticeLabeTwo.mas_bottom).mas_offset(15);
    }];
    
}

- (UIView *)containView {
    
    if (!_containView) {
        UIView *containView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, Main_Screen_Width, 300)];
        containView.backgroundColor = [UIColor whiteColor];
        _containView = containView;
        [self.view addSubview:_containView];
    }
    return _containView;
}

- (UILabel *)washCarLabel {
    
    if (!_washCarLabel) {
        UILabel *washCarLabel = [[UILabel alloc] init];
        washCarLabel.text = @"洗车体验卡";
        washCarLabel.textColor = [UIColor colorFromHex:@"#4a4a4a"];
        washCarLabel.font = [UIFont systemFontOfSize:16];
        _washCarLabel = washCarLabel;
        [self.containView addSubview:_washCarLabel];
    }
    return _washCarLabel;
}

- (UILabel *)validityLabel {
    
    if (!_validityLabel) {
        
        UILabel *validityLabel = [[UILabel alloc] init];
        validityLabel.text = @"有效期至: 2017.8.10";
        validityLabel.textColor = [UIColor colorFromHex:@"#999999"];
        validityLabel.font = [UIFont systemFontOfSize:13];
        _validityLabel = validityLabel;
        [self.containView addSubview:_validityLabel];
    }
    return _validityLabel;
}


- (UILabel *)timesLabel {
    
    if (!_timesLabel) {
        UILabel *timesLabel = [[UILabel alloc] init];
        timesLabel.text = @"免费洗车次数6次";
        timesLabel.textColor = [UIColor colorFromHex:@"#999999"];
        timesLabel.font = [UIFont systemFontOfSize:13];
        _timesLabel = timesLabel;
        [self.containView addSubview:_timesLabel];
    }
    return _timesLabel;
}

- (UILabel *)lineLabel {
    
    if (!_lineLabel) {
        UILabel *lineLabel = [[UILabel alloc] init];
        lineLabel.backgroundColor   = [UIColor colorFromHex:@"#eaeaea"];;
        _lineLabel = lineLabel;
        [self.containView addSubview:_lineLabel];
    }
    return _lineLabel;
}


- (UILabel *)noticeLabel {
    
    if (!_noticeLabel) {
        UILabel *noticeLabel = [[UILabel alloc] init];
        noticeLabel.text = @"使用须知";
        noticeLabel.textColor = [UIColor colorFromHex:@"#4a4a4a"];
        noticeLabel.font = [UIFont systemFontOfSize:16];
        _noticeLabel = noticeLabel;
        [self.containView addSubview:_noticeLabel];
    }
    return _noticeLabel;
}


- (UILabel *)noticeLabelOne {
    
    if (!_noticeLabelOne) {
        UILabel *noticeLabelOne = [[UILabel alloc] init];
        noticeLabelOne.text = @"1、本洗车卡由金顶洗车APP发放,仅限金顶洗车店和与金顶合作商家使用";
        noticeLabelOne.numberOfLines = 0;
        noticeLabelOne.textColor = [UIColor colorFromHex:@"#999999"];
        noticeLabelOne.font = [UIFont systemFontOfSize:13];
        _noticeLabelOne = noticeLabelOne;
        [self.containView addSubview:_noticeLabelOne];
    }
    return _noticeLabelOne;
}

- (UILabel *)noticeLabeTwo {
    
    if (!_noticeLabeTwo) {
        UILabel *noticeLabelTwo = [[UILabel alloc] init];
        noticeLabelTwo.text = @"2、洗车卡不能兑换现金和转增与其他人使用";
        noticeLabelTwo.textColor = [UIColor colorFromHex:@"#999999"];
        noticeLabelTwo.font = [UIFont systemFontOfSize:13];
        _noticeLabeTwo = noticeLabelTwo;
        [self.containView addSubview:_noticeLabeTwo];
    }
    return _noticeLabeTwo;
}

- (UILabel *)noticeLabeThree {
    
    if (!_noticeLabeThree) {
        UILabel *noticeLabeThree = [[UILabel alloc] init];
        noticeLabeThree.text = @"3、有任何问题,可咨询金顶客服";
        noticeLabeThree.textColor = [UIColor colorFromHex:@"#999999"];
        noticeLabeThree.font = [UIFont systemFontOfSize:13];
        _noticeLabeThree = noticeLabeThree;
        [self.containView addSubview:_noticeLabeThree];
    }
    return _noticeLabeThree;
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
