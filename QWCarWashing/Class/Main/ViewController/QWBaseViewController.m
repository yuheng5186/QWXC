//
//  QWBaseViewController.m
//  QWCarWashing
//
//  Created by Wuxinglin on 2017/8/16.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "QWBaseViewController.h"
#define DefaultBtnTag 9001
#define DefaultNavLeftBtnTag 9002
#define DefaultNavRightBtnTag 9003
#define DefaultNavTitleLblTag 9004

@interface QWBaseViewController ()

@end

@implementation QWBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self resetBabkButton];
    self.view.backgroundColor   = [UIColor whiteColor];
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


- (UILabel *)drawTitle:(NSString *)title
{
    UIColor *color = [UIColor colorWithHex:0xffffff alpha:1.0];//[UIColor colorWithRed:99/255.0 green:99/255.0 blue:99/255.0 alpha:1];
    
    return [self drawTitle: title Color: color];
}

- (UILabel *)drawTitle:(NSString *)title Color: (UIColor *) color
{
    [[self.navigationView viewWithTag:DefaultNavTitleLblTag] removeFromSuperview];
    UILabel *lbl = [UIUtil drawLabelInView:self.navigationView frame:CGRectMake(self.navigationView.frame.size.width/5, 0, self.navigationView.frame.size.width*3/5, self.navigationView.frame.size.height) font:[UIFont boldSystemFontOfSize:18] text:title isCenter:YES color: color];
    lbl.tag = DefaultNavTitleLblTag;
    return lbl;
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
