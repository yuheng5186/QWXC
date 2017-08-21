//
//  QWChangeNameController.m
//  QWCarWashing
//
//  Created by Mac WuXinLing on 2017/8/22.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "QWChangeNameController.h"

@interface QWChangeNameController ()<UITextFieldDelegate>

@property (nonatomic, strong) UITextField *userNameText;


@end

@implementation QWChangeNameController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title      = @"修改姓名";
     [self createSubView];
    
    self.navigationItem.rightBarButtonItem  = [[UIBarButtonItem alloc]initWithTitle:@"确定" style:UIBarButtonItemStyleDone target:self action:@selector(sureButtonClick:)];
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:13],NSFontAttributeName, nil] forState:UIControlStateNormal];
    
}
- (void) createSubView {
    self.view.backgroundColor       = [UIColor colorFromHex:@"#e6e6e6"];
    UIView *upView                  = [UIUtil drawLineInView:self.view frame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height*60/667) color:[UIColor whiteColor]];
    upView.top                      = Main_Screen_Height*84/667;
    
    self.userNameText                = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width-240, 40)];
    //        self.phoneNumberText.placeholder    = @"输入验证码";
//    self.userNameText.placeholder    = APPDELEGATE.currentUser.userName;
    //    self.userNameText.text           = @"15800781856";
    self.userNameText.delegate       = self;
    self.userNameText.returnKeyType  = UIReturnKeyDone;
    self.userNameText.textAlignment  = NSTextAlignmentLeft;
    self.userNameText.font           = [UIFont systemFontOfSize:16];
    self.userNameText.backgroundColor= [UIColor whiteColor];
    self.userNameText.top            = Main_Screen_Height*10/667;
    self.userNameText.left           = Main_Screen_Width*20/375 ;
    
    [self.userNameText addTarget:self action:@selector(userNameTextChanged:) forControlEvents:UIControlEventEditingChanged];
    [upView addSubview:self.userNameText];
    
}
- (void) userNameTextChanged:(UITextField *)sender {
    
    
    
    
    
}

- (void) sureButtonClick:(id)sender {

    
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
