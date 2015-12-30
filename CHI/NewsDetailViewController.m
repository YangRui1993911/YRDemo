//
//  NewsDetailViewController.m
//  MeiShi
//
//  Created by qianfeng007 on 15/12/16.
//  Copyright © 2015年 YangRui. All rights reserved.
//

#import "NewsDetailViewController.h"
#import <WebKit/WebKit.h>
@interface NewsDetailViewController ()<UIWebViewDelegate>
{
    UIActivityIndicatorView *_activityIndicatorView;
    WKWebView *_webView;
}
@end

@implementation NewsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self createWKWebVeiw];

}
- (void)createWKWebVeiw
{
    _webView = [[WKWebView alloc]initWithFrame:CGRectMake(0, 44, self.view.frame.size.width, self.view.frame.size.height-44)];
    [self.view addSubview:_webView];
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
