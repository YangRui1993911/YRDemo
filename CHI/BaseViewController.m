//
//  BaseViewController.m
//  CHI
//
//  Created by qianfeng007 on 15/12/17.
//  Copyright © 2015年 YangRui. All rights reserved.
//

#import "BaseViewController.h"
#import "SettingViewController.h"
@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 40, 40);
    //   [button setTitle:@"关于" forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"settingBtn_Nav"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(pushAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *butttonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = butttonItem;

}
- (void)pushAction:(UIButton *)button {
    SettingViewController *settingView = [SettingViewController new];
    settingView.title = @"关于";
    [self.navigationController pushViewController:settingView animated:YES];
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
