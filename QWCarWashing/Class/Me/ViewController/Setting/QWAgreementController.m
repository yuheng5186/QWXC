//
//  QWAgreementController.m
//  QWCarWashing
//
//  Created by Wuxinglin on 2017/8/18.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "QWAgreementController.h"

@interface QWAgreementController ()<UIWebViewDelegate>

@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) UIWebView *webView;

@end

@implementation QWAgreementController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.contentView.top                = Main_Screen_Height*30/667;
    self.contentView.backgroundColor    = [UIColor grayColor];
    self.contentView.height             = self.view.height;
    self.webView                        = [[UIWebView alloc] initWithFrame: self.view.frame];
    //    self.webView.backgroundColor        = [UIColor colorFromHex: @"#111112"];
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
    
//    [self drawTitle: title];
    self.title  = title;
    
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
