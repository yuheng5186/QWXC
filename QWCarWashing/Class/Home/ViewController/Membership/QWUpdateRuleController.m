//
//  QWUpdateRuleController.m
//  QWCarWashing
//
//  Created by Wuxinglin on 2017/8/17.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "QWUpdateRuleController.h"

@interface QWUpdateRuleController ()<UIWebViewDelegate>

@end

@implementation QWUpdateRuleController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
 
    self.title      = @"等级规则";
    
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height)];
    webView.opaque = NO;
    webView.delegate = self;
    webView.backgroundColor=RGBACOLOR(239, 239, 239, 1);
    [webView sizeToFit];
    
    [self.view addSubview:webView];
    
    NSURL * url                     = [NSURL URLWithString: @"http://115.159.67.77/dengji.html"];
    NSURLRequest* request           = [NSURLRequest requestWithURL: url];
    
    [webView loadRequest:request];
    
    webView.scrollView.contentInset = UIEdgeInsetsMake (0.0f, 0.0f, 80.0f, 0.0f);
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    
}


- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    
    
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
