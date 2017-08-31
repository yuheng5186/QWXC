//
//  QWAgreementVC.m
//  QWCarWashing
//
//  Created by Mac WuXinLing on 2017/8/22.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "QWAgreementVC.h"

@interface QWAgreementVC ()<UIWebViewDelegate>

@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) UIWebView *webView;

@property (nonatomic, strong) UILabel *headerLabel;
@end

@implementation QWAgreementVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor   = [UIColor redColor];
    [self createSubView];
}

- (void) backButtonClick:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}


- (void) createSubView {

    UIView *signView                   = [UIUtil drawLineInView:self.view frame:CGRectMake(0, 0, Main_Screen_Width, 64) color:[UIColor yellowColor]];
    signView.top                       = 0;
    
//    UIImage *titleImage                = [UIImage imageNamed:@"ijanbiantiao"];
    UIImageView     *imageView         = [UIUtil drawCustomImgViewInView:signView frame:CGRectMake(0, 0, Main_Screen_Width, 64) imageName:@"ijanbiantiao"];
    imageView.top                      = 0;
    
    UIButton    *backButton            = [UIUtil drawButtonInView:self.view frame:CGRectMake(0, 0, 25, 25) iconName:@"icon_titlebar_arrow" target:self action:@selector(backButtonClick:)];
    backButton.left                    = 10;
    backButton.top                     = 20+9.5;
    
    
    NSString   *headerString     = @"登录";
    UIFont     *headerFont       = [UIFont systemFontOfSize:Main_Screen_Height*20/667];
    self.headerLabel         = [UIUtil drawLabelInView:signView frame:CGRectMake(0, 0, Main_Screen_Width*280/375, Main_Screen_Height*30/667) font:headerFont text:headerString isCenter:NO];
    self.headerLabel.textColor        = [UIColor whiteColor];
    self.headerLabel.textAlignment    = NSTextAlignmentCenter;
    self.headerLabel.centerX          = Main_Screen_Width/2;
    self.headerLabel.top              = 20+9.5;
    
    
    
    self.webView                        = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64, Main_Screen_Width, Main_Screen_Height)];
    self.webView.opaque                 = NO;
    self.webView.delegate               = self;
    
    //    self.webView.scrollView.bounces = NO;
    //    self.webView.scrollView.showsHorizontalScrollIndicator = NO;
    //    self.webView.scrollView.scrollEnabled = NO;
    [self.webView sizeToFit];
    
    
    [self.view addSubview: self.webView];
    
//    [self showBlackLoading];
    
    NSURL * url                     = [NSURL URLWithString: @"http://115.159.97.191/jingding/index.html"];
    NSURLRequest* request           = [NSURLRequest requestWithURL: url];
    
    [self.webView loadRequest:request];
    
    self.webView.scrollView.contentInset = UIEdgeInsetsMake (0.0f, 0.0f, 80.0f, 0.0f);
}

- (void) webViewDidFinishLoad:(UIWebView *) webView
{
    NSString *title = [webView stringByEvaluatingJavaScriptFromString: @"document.title"];
    
    [self drawTitle: title];
    self.headerLabel.text       = title;

//    [self hideBlackLoading];
    
    //    NSInteger height = [[self.webView stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight"] intValue];
    //    self.webView.frame = CGRectMake(0, 0, Main_Screen_Width, height);
    //
    //    NSString *javascript    = [NSString stringWithFormat:@"window.scrollBy(0,%ld)",(long)height];
    //    [self.webView stringByEvaluatingJavaScriptFromString:javascript];
    
    
}

- (void) webView: (UIWebView *) webView didFailLoadWithError: (NSError *) error
{
//    [self hideBlackLoading];
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
