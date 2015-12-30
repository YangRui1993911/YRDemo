//
//  TabBarViewController.m
//  CHI
//
//  Created by qianfeng007 on 15/12/17.
//  Copyright © 2015年 YangRui. All rights reserved.
//

#import "TabBarViewController.h"
#import "BaseViewController.h"
#import "UIView+Common.h"
@interface TabBarViewController ()

@end

@implementation TabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatViewControllers];
    [self createSplashView];
}
- (void)creatViewControllers
{
    NSMutableArray *controllers = [NSMutableArray new];
    NSArray *title = @[@"美味蛋糕",@"美味西饼",@"养生饮食",@"健康知识"];
    NSArray  *titles = @[@"Cake",@"Mousse",@"Health",@"News"];
    for (NSUInteger i = 0; i<titles.count; i++) {
        NSString *name = [NSString stringWithFormat:@"%@ViewController",titles[i]];
        Class cls = NSClassFromString(name);
        BaseViewController *bvc = [[cls alloc]init];
        UIImage *normalImage = [[UIImage imageNamed:[NSString stringWithFormat:@"%@",titles[i]]]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        UIImage *selectedImage = [[UIImage imageNamed:[NSString stringWithFormat:@"%@_1",titles[i]]]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        UITabBarItem *item = [[UITabBarItem alloc]initWithTitle:title[i] image:normalImage selectedImage:selectedImage];
        bvc.tabBarItem = item;
        
        UINavigationController *nc = [[UINavigationController alloc]initWithRootViewController:bvc];
        [controllers addObject:nc];
        nc.navigationBar.backgroundColor = [UIColor colorWithRed:207/256.0 green:133/256.0 blue:153/256.0 alpha:1.0];
        //[nc.navigationBar setBackgroundImage:[UIImage imageNamed:@"cellBackground"] forBarMetrics:UIBarMetricsDefault];
        //self.tabBar.backgroundImage = [UIImage imageNamed:@"tabbarBackground1"];
        [[UITabBar appearance] setBarTintColor:[UIColor colorWithRed:255/256.0  green:193/256.0  blue:193/256.0 alpha:1.0]];

    }
    self.viewControllers = controllers;

}
- (void)createSplashView
{
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, screenWidth(), screenHeight())];
    NSString *splashPath = [[NSBundle mainBundle]pathForResource:@"view@2x" ofType:@"png"];
    imageView.image = [[UIImage alloc]initWithContentsOfFile:splashPath];
    [self.view addSubview:imageView];
    [UIView animateWithDuration:5 animations:^{
        imageView.alpha = 0.0;
    } completion:^(BOOL finished) {
        [imageView removeFromSuperview];
    }];
    
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
