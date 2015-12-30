//
//  SettingViewController.m
//  BakeryDemo
//
//  Created by qianfeng on 15/12/19.
//  Copyright © 2015年 GCJ. All rights reserved.
//

#import "SettingViewController.h"
#import "JWCache.h"

@interface SettingViewController () <UITableViewDataSource,UITableViewDelegate> {
    NSArray *_dataArray;
    UITableView *_tableView;
    CGFloat cache;
}

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataArray = @[@"清理缓存",@"关于我们"];
    cache = [JWCache fileSize];
    [JWCache resetCache];
    [self  createTableView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)createTableView {
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.textLabel.text = _dataArray[indexPath.row];
    cell.textLabel.textColor = [UIColor blueColor];
    // 设置选中风格
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.row) {
        case 0: {
            
            
            NSString *str = [NSString stringWithFormat:@"您清理了%fM缓存",cache];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:str message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            
            [alert show];
            
        }
            
            break;
        case 1: {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"这是一款让吃货喜欢心动的App" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            
            [alert show];
        }
            break;
        default:
            break;
    }
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
