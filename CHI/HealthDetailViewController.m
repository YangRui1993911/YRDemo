//
//  HealthDetailViewController.m
//  CHI
//
//  Created by qianfeng007 on 15/12/17.
//  Copyright © 2015年 YangRui. All rights reserved.
//

#import "HealthDetailViewController.h"
#import <WebKit/WebKit.h>
@interface HealthDetailViewController ()<UIWebViewDelegate,WKNavigationDelegate>
{
    UIActivityIndicatorView *_activityIndicatorView;
    WKWebView *_webView;
}
@end

@implementation HealthDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self createWKWebVeiw];
}
//这是 UIWebView 的代理
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    if ([[request.URL absoluteString] isEqual:self.urlString]) {
        return YES;
    }
    return NO;
}
//- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
//    NSURLRequest *request = navigationAction.request;
//    NSString *url = [[request URL]absoluteString];
//    if ([url isEqualToString:self.urlString]) {
//        decisionHandler(WKNavigationActionPolicyAllow);
//    }else {
//        decisionHandler(WKNavigationActionPolicyCancel);
//    }
//}
- (void)createWKWebVeiw
{
   
    _webView = [[WKWebView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    
    [self.view addSubview:_webView];
    //NSLog(@"%@",self.urlString);
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.urlString]]];
    
    _webView.allowsBackForwardNavigationGestures = YES;
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
