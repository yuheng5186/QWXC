//
//  QWDiscountDetailController.m
//  QWCarWashing
//
//  Created by Wuxinglin on 2017/8/16.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "QWDiscountDetailController.h"
#import "DiscountDetailView.h"

@interface QWDiscountDetailController ()

@property (nonatomic, weak) DiscountDetailView *detailView;

@end

@implementation QWDiscountDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.detailView.frame = CGRectMake(0, 64, Main_Screen_Width, 400);
    
}

- (DiscountDetailView *)detailView {
    
    if (_detailView == nil) {
        
        DiscountDetailView *detailView = [DiscountDetailView discountDetailView];
        
        _detailView = detailView;
        [self.view addSubview:_detailView];
    }
    return _detailView;
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
